const std = @import("std");


pub fn part1(_: std.mem.Allocator, _: [][]const u8) !void{
    
}

pub fn part2(_: std.mem.Allocator, _: [][]const u8) !void{
    
}


test "part1 output test" {
    const allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const input  =
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
    const part1_output = try part1(allocator, input);
    std.testing.expectEqual(part1_output, 3);
    
}