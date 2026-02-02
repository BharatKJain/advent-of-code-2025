def is_mirror_pattern(text: str) -> bool:
    length_of_text = len(text)
    
    if length_of_text % 2 == 1:
        return False
    
    mid_index = length_of_text // 2
    
    for index in range(mid_index):
        if text[index] != text[mid_index + index]:
            return False
    
    return True


def parse_comma_separated_values(text: str) -> list[tuple[int, int]]:
    values = []
    tokens = text.split(',')
    
    for token in tokens:
        parts = token.split('-')
        if len(parts) >= 2:
            range_vals = (int(parts[0]), int(parts[1]))
            values.append(range_vals)
    
    return values


def part1(lines: list[str]) -> int:
    sum_of_invalid_numbers = 0
    ranges = parse_comma_separated_values(lines[0])
    
    for min_num, max_num in ranges:
        if min_num > max_num:
            raise ValueError("Invalid range")
        
        for counter in range(min_num, max_num + 1):
            counter_str = str(counter)
            if is_mirror_pattern(counter_str):
                sum_of_invalid_numbers += counter
    
    return sum_of_invalid_numbers


def part2(lines: list[str]) -> int:
    sum_of_invalid_numbers = 0
    ranges = parse_comma_separated_values(lines[0])
    
    for min_num, max_num in ranges:
        if min_num > max_num:
            raise ValueError("Invalid range")
        
        for counter in range(min_num, max_num + 1):
            counter_str = str(counter)
            counter_str_length = len(counter_str)
            
            if counter_str_length < 2:
                continue
            
            double_ranges_string = counter_str[1:] + counter_str[:-1]
            
            if counter_str in double_ranges_string:
                sum_of_invalid_numbers += counter
    
    return sum_of_invalid_numbers
