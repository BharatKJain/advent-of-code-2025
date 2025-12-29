pub const input = @import("input.zig");

// Re-export commonly used functions
pub const readFile = input.readFile;
pub const readLinesFromStdin = input.readLinesFromStdin;
pub const readLinesFromFile = input.readLinesFromFile;
pub const parseLines = input.parseLines;
pub const readNumbersFromFile = input.readNumbersFromFile;
pub const freeLines = input.freeLines;
