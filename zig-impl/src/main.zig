const std = @import("std");
const days = @import("./days/days.zig");
const utils = @import("./utils/utils.zig");
const advent_of_code_2025 = @import("advent_of_code_2025");

pub fn main() !void {
    // input with each line from stdin
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s}<day> [part]\n", .{args[0]});
        std.debug.print("Example: {s} 1 1\n", .{args[0]});
        return;
    }

    const day = std.fmt.parseInt(u8, args[1], 10) catch {
        std.debug.print("Invalid day number: {s}\n", .{args[1]});
        return;
    };

    const part = if (args.len >= 3)
        std.fmt.parseInt(u8, args[2], 10) catch {
            std.debug.print("Invalid part number: {s}\n", .{args[2]});
            return;
        }
    else
        1;

    if (day < 1 or day > 12) {
        std.debug.print("Day must be between 1 and 12\n", .{});
        return;
    }

    if (part != 1 and part != 2) {
        std.debug.print("Part must be either 1 and 2\n", .{});
        return;
    }

    // Take input from stdin
    var buf: [32]u8 = undefined;
    const input_path = try std.fmt.bufPrint(&buf, "src/inputs/day{:0>2}.txt", .{day});
    // Run the day with part
    const result = try run_day_and_part(allocator, day, part, input_path);
    std.debug.print("Result: {}\n", .{result});
}

fn run_day_and_part(allocator: std.mem.Allocator, day: u8, part: u8, input_path: []const u8) !i64 {
    const lines_data = utils.readLinesFromFile(allocator, input_path) catch |err| {
        std.debug.print("Error reading input file: {}\n", .{err});
        return err;
    };
    defer utils.freeLines(allocator, lines_data);

    return switch (day) {
        1 => if (part == 1) days.day01.part1(allocator, lines_data.lines) else days.day01.part2(allocator, lines_data.lines),
        2 => if (part == 1) days.day02.part1(allocator, lines_data.lines) else days.day02.part2(allocator, lines_data.lines),
        // 3 => if (part == 1) days.day03.part1(allocator, lines_data.lines) else days.day03.part2(allocator, lines_data.lines),
        // 4 => if (part == 1) days.day04.part1(allocator, lines_data.lines) else days.day04.part2(allocator, lines_data.lines),
        // 5 => if (part == 1) days.day05.part1(allocator, lines_data.lines) else days.day05.part2(allocator, lines_data.lines),
        // 6 => if (part == 1) days.day06.part1(allocator, lines_data.lines) else days.day06.part2(allocator, lines_data.lines),
        // 7 => if (part == 1) days.day07.part1(allocator, lines_data.lines) else days.day07.part2(allocator, lines_data.lines),
        // 8 => if (part == 1) days.day08.part1(allocator, lines_data.lines) else days.day08.part2(allocator, lines_data.lines),
        // 9 => if (part == 1) days.day09.part1(allocator, lines_data.lines) else days.day09.part2(allocator, lines_data.lines),
        // 10 => if (part == 1) days.day10.part1(allocator, lines_data.lines) else days.day10.part2(allocator, lines_data.lines),
        // 11 => if (part == 1) days.day11.part1(allocator, lines_data.lines) else days.day11.part2(allocator, lines_data.lines),
        // 12 => if (part == 1) days.day12.part1(allocator, lines_data.lines) else days.day12.part2(allocator, lines_data.lines),
        else => unreachable,
    };
}
