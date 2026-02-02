def part1(lines: list[str]) -> int:
    tracker = 50
    password = 0

    for line in lines:
        if len(line) == 0:
            continue

        direction = line[0]
        rotations = int(line[1:])

        if direction == "R":
            tracker = (tracker + rotations) % 100
        elif direction == "L":
            tracker = (tracker - rotations) % 100

        if tracker == 0:
            password += 1

    return password


def part2(lines: list[str]) -> int:
    dial = 50
    password = 0

    for line in lines:
        if len(line) == 0:
            continue

        direction = line[0]
        rotations = int(line[1:])

        if direction == "R":
            password += (dial + rotations) // 100
            dial = (dial + rotations) % 100
        elif direction == "L":
            new_dial = (dial - rotations) % 100

            if dial == 0:
                password += rotations // 100
            elif rotations > dial:
                password += ((rotations - dial - 1) // 100) + 1
                if new_dial == 0:
                    password += 1
            elif dial - rotations == 0:
                password += 1

    return password


def test_part1():
    input_data = """L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"""
    lines = input_data.strip().split("\n")
    result = part1(lines)
    assert result == 3, f"Expected 3, got {result}"
    print(f"Part 1 test passed: {result}")


def test_part2():
    input_data = """L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"""
    lines = input_data.strip().split("\n")
    result = part2(lines)
    assert result == 6, f"Expected 6, got {result}"
    print(f"Part 2 test passed: {result}")


if __name__ == "__main__":
    test_part1()
    test_part2()
    print("All tests passed!")
