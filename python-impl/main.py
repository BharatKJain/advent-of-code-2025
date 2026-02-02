#!/usr/bin/env python3
import sys
from pathlib import Path


def read_lines_from_file(file_path: str) -> list[str]:
    """Read lines from input file."""
    with open(file_path, 'r') as f:
        return [line.rstrip('\n') for line in f.readlines()]


def run_day_and_part(day: int, part: int, input_path: str) -> int:
    """Execute the solution for a specific day and part."""
    lines = read_lines_from_file(input_path)
    
    if day == 1:
        from days import day01
        return day01.part1(lines) if part == 1 else day01.part2(lines)
    elif day == 2:
        from days import day02
        return day02.part1(lines) if part == 1 else day02.part2(lines)
    elif day == 3:
        from days import day03
        return day03.part1(lines) if part == 1 else day03.part2(lines)
    # elif day == 4:
    #     from days import day04
    #     return day04.part1(lines) if part == 1 else day04.part2(lines)
    # elif day == 5:
    #     from days import day05
    #     return day05.part1(lines) if part == 1 else day05.part2(lines)
    # elif day == 6:
    #     from days import day06
    #     return day06.part1(lines) if part == 1 else day06.part2(lines)
    # elif day == 7:
    #     from days import day07
    #     return day07.part1(lines) if part == 1 else day07.part2(lines)
    # elif day == 8:
    #     from days import day08
    #     return day08.part1(lines) if part == 1 else day08.part2(lines)
    # elif day == 9:
    #     from days import day09
    #     return day09.part1(lines) if part == 1 else day09.part2(lines)
    # elif day == 10:
    #     from days import day10
    #     return day10.part1(lines) if part == 1 else day10.part2(lines)
    # elif day == 11:
    #     from days import day11
    #     return day11.part1(lines) if part == 1 else day11.part2(lines)
    # elif day == 12:
    #     from days import day12
    #     return day12.part1(lines) if part == 1 else day12.part2(lines)
    else:
        raise ValueError(f"Day {day} not implemented")


def main():
    """Main entry point for the Advent of Code solutions."""
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <day> [part]")
        print(f"Example: {sys.argv[0]} 1 1")
        sys.exit(1)
    
    try:
        day = int(sys.argv[1])
    except ValueError:
        print(f"Invalid day number: {sys.argv[1]}")
        sys.exit(1)
    
    part = 1
    if len(sys.argv) >= 3:
        try:
            part = int(sys.argv[2])
        except ValueError:
            print(f"Invalid part number: {sys.argv[2]}")
            sys.exit(1)
    
    if day < 1 or day > 12:
        print("Day must be between 1 and 12")
        sys.exit(1)
    
    if part not in (1, 2):
        print("Part must be either 1 or 2")
        sys.exit(1)
    
    input_path = f"inputs/day{day:02d}.txt"
    
    try:
        result = run_day_and_part(day, part, input_path)
        print(f"Result: {result}")
    except FileNotFoundError:
        print(f"Error: Input file not found: {input_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
