const std = @import("std");
const BUFFER_SIZE = 2;
const MAX_LINES = 10;

pub const LinesData = struct {
    buffer: []u8,
    lines: [][]const u8,
};

pub fn readLinesFromStdin(allocator: std.mem.Allocator) !std.ArrayList([]const u8) {
    var lines = try std.ArrayList([]const u8).initCapacity(allocator, MAX_LINES);
    var stdin_buffer: [BUFFER_SIZE]u8 = undefined;
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);

    while (true) {
        const line = try stdin_reader.interface.takeDelimiterExclusive('\n');
        if (std.mem.eql(u8, line, "")) {
            break;
        }
        try lines.append(allocator, line);
    }

    return lines;
}

pub fn readFile(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    const file = std.fs.cwd().openFile(path, .{}) catch |err| switch (err) {
        error.FileNotFound => {
            std.debug.print("Input file not found: {s}\n", .{path});
            return err;
        },
        else => return err,
    };
    defer file.close();

    const file_size = try file.getEndPos();
    const contents = try allocator.alloc(u8, file_size);
    _ = try file.readAll(contents);
    return contents;
}

pub fn readLinesFromFile(allocator: std.mem.Allocator, path: []const u8) !LinesData {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    // Limit file size to avoid OOM on massive files (e.g., 100MB here).
    // Adjust based on requirements or use std.math.maxInt(usize) for no limit.
    const max_size = 100 * 1024 * 1024;
    const file_content = try file.readToEndAlloc(allocator, max_size);
    errdefer allocator.free(file_content);

    var lines = try std.ArrayList([]const u8).initCapacity(allocator, 1000);
    errdefer lines.deinit(allocator);

    var it = std.mem.splitScalar(u8, file_content, '\n');
    while (it.next()) |line| {
        try lines.append(allocator, line);
    }

    const lines_slice = try lines.toOwnedSlice(allocator);

    return LinesData{
        .buffer = file_content,
        .lines = lines_slice,
    };
}

pub fn freeLines(allocator: std.mem.Allocator, lines_data: LinesData) void {
    allocator.free(lines_data.buffer);
    allocator.free(lines_data.lines);
}

pub fn parseLines(allocator: std.mem.Allocator, input: []const u8) !std.ArrayList([]const u8) {
    var lines: std.ArrayList([]const u8) = .empty;
    errdefer lines.deinit(allocator);
    var it = std.mem.splitScalar(u8, input, '\n');
    while (it.next()) |line| {
        try lines.append(allocator, line);
    }
    return lines;
}

pub fn readNumbersFromFile(allocator: std.mem.Allocator, path: []const u8) ![]i32 {
    const contents = try readFile(allocator, path);
    defer allocator.free(contents);

    var numbers: std.ArrayList(i32) = .empty;
    errdefer numbers.deinit(allocator);
    var it = std.mem.splitScalar(u8, std.mem.trim(u8, contents, "\n"), '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue;
        const num = try std.fmt.parseInt(i32, std.mem.trim(u8, line, " \t\n"), 10);
        try numbers.append(allocator, num);
    }

    return numbers.toOwnedSlice(allocator);
}
