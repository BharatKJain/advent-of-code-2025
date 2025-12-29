const std = @import("std");

fn is_mirror_pattern(text: []const u8) bool {
    const length_of_text = text.len;

    if (@mod(length_of_text, 2) == 1) return false;

    const mid_index = @divTrunc(length_of_text, 2);

    for (0..mid_index) |index| {
        if (text[index] != text[mid_index + index]) {
            return false;
        }
    }

    return true;
}

fn parse_comma_separated_values(allocator: std.mem.Allocator, text: []const u8) !std.ArrayList([2]i64) {
    var values: std.ArrayList([2]i64) = try std.ArrayList([2]i64).initCapacity(allocator, 10000);
    var iter = std.mem.tokenizeAny(u8, text, ",");
    while (iter.next()) |token| {
        var split_range = std.mem.splitSequence(u8, token, "-");
        var range_counter: usize = 0;
        var range = [2]i64{ 0, 0 };
        while (split_range.next()) |value| {
            if (range_counter > 1) {
                break;
            }
            range[range_counter] = try std.fmt.parseInt(i64, value, 10);
            range_counter += 1;
        }
        try values.append(allocator, range);
    }
    return values;
}

pub fn part1(allocator: std.mem.Allocator, lines: [][]const u8) !i64 {
    var sum_of_invalid_numbers: i64 = 0;
    const ranges = try parse_comma_separated_values(allocator, lines[0]);
    // std.debug.print("Got the data!! {}", .{ranges});
    for (ranges.items) |range| {
        if (range[0] > range[1]) {
            return error.InvalidRange;
        }
        const min_num = range[0];
        const max_num = range[1];
        var counter = min_num;
        while (counter < (max_num + 1)) {
            var buf: [256]u8 = undefined;
            const counter_str = try std.fmt.bufPrint(&buf, "{}", .{counter});
            if (is_mirror_pattern(counter_str)) {
                // std.debug.print("\nRange: {d}:{d} Detected:{s}", .{ range[0], range[1], counter_str });
                sum_of_invalid_numbers += counter;
            }
            counter += 1;
        }
    }
    return sum_of_invalid_numbers;
}

pub fn part2(allocator: std.mem.Allocator, lines: [][]const u8) !i64 {
    var sum_of_invalid_numbers: i64 = 0;
    const ranges = try parse_comma_separated_values(allocator, lines[0]);
    for (ranges.items) |range| {
        if (range[0] > range[1]) {
            return error.InvalidRange;
        }
        const min_num = range[0];
        const max_num = range[1];
        var counter = min_num;
        while (counter < (max_num + 1)) {
            var buf: [256]u8 = undefined;
            const counter_str = try std.fmt.bufPrint(&buf, "{}", .{counter});
            const counter_str_length = @as(u64, counter_str.len);

            if (counter_str_length < 2) {
                counter += 1;
                continue;
            }

            var counter_buf: [1024 * 100]u8 = undefined;
            const double_ranges_string = try std.fmt.bufPrint(&counter_buf, "{s}{s}", .{ counter_str[1..], counter_str[0..(counter_str_length - 1)] });
            const string_exists = std.mem.indexOf(u8, double_ranges_string, counter_str);
            if (string_exists != null) {
                sum_of_invalid_numbers += counter;
            }
            counter += 1;
        }
    }

    return sum_of_invalid_numbers;
}

test "part1 output test" {
    const allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const input =
        \\11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    ;
    const part1_output = try part1(allocator, input);
    std.testing.expectEqual(part1_output, 3);
}
