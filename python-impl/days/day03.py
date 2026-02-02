def part1(lines: list[str]):
    joltage = 0
    for line in lines:
        jolts = list(map(int, line))
        size_of_jolts = len(jolts)
        first_digit = -1
        index_of_first_digit = -1
        for index in range(size_of_jolts - 1):
            if jolts[index] > first_digit:
                first_digit = jolts[index]
                index_of_first_digit = index

        second_digit = -1
        for index in range(index_of_first_digit + 1, size_of_jolts):
            if jolts[index] > second_digit:
                second_digit = jolts[index]
        number = first_digit * 10 + second_digit
        joltage += number
    return joltage


def test_part1():
    input_data = """987654321111111
811111111111119
234234234234278
818181911112111"""
    lines = input_data.strip().split("\n")
    result = part1(lines)
    assert result == 357, f"Expected 357, got {result}"
    print(f"Part 1 passed: {result}")


if __name__ == "__main__":
    test_part1()
    print("All tests passed!")
