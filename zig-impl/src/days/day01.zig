const std = @import("std");
const utils = @import("./../utils/utils.zig");

pub fn part1(allocator: std.mem.Allocator, lines: [][]const u8) !i64 {
    _ = allocator;
    var tracker: i32 = 50;
    var password: i32 = 0;
    for (lines) |line| {
        if (line.len == 0) continue;
        const direction = line[0];
        const rotations = try std.fmt.parseInt(i32, line[1..], 10);
        switch (direction) {
            'R' => tracker = @mod(tracker + rotations, 100),
            'L' => tracker = @mod(tracker - rotations, 100),
            else => {},
        }
        if (tracker == 0) {
            password += 1;
        }
    }
    return password;
}

pub fn part2(allocator: std.mem.Allocator, lines: [][]const u8) !i64 {
    _ = allocator;
    var dial: i32 = 50;
    var password: i32 = 0;
    for (lines) |line| {
        // std.debug.print("\n Instruction:{s} Dial:{} Password:{}", .{ line, dial, password });
        if (line.len == 0) continue;
        const direction = line[0];
        const rotations = try std.fmt.parseInt(i32, line[1..], 10);
        switch (direction) {
            'R' => {
                password += @divTrunc(dial + rotations, 100);
                dial = @mod(dial + rotations, 100);
            },
            'L' => {
                const new_dial = @mod(dial - rotations, 100);
                if (dial == 0) {
                    password += @divFloor(rotations, 100);
                } else if (rotations > dial) {
                    password += @divFloor((rotations - dial - 1), 100) + 1;
                    if (new_dial == 0) {
                        password += 1;
                    }
                } else if (dial - rotations == 0) {
                    password += 1;
                }
                dial = new_dial;
            },
            else => {},
        }
    }
    return password;
}

test "part1 output test" {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    const input =
        \\L68
        \\L30
        \\R48
        \\L5
        \\R60
        \\L55
        \\L1
        \\L99
        \\R14
        \\L82
    ;
    var lines = try utils.parseLines(allocator, input);
    defer lines.deinit(allocator);

    const result = try part1(allocator, lines.items);
    try std.testing.expectEqual(3, result);
}

test "part2 output test" {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    const input =
        \\L68
        \\L30
        \\R48
        \\L5
        \\R60
        \\L55
        \\L1
        \\L99
        \\R14
        \\L82
    ;
    var lines = try utils.parseLines(allocator, input);
    defer lines.deinit(allocator);

    const result = try part2(allocator, lines.items);
    try std.testing.expectEqual(6, result);
}
