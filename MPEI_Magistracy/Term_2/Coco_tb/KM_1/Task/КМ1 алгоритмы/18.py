def get_set_bits_count(number: int) -> int:
    """
    Count the number of set bits in a 32 bit integer
    """
    if number < 0:
        raise ValueError("the value of input must be positive")
    result = 0
    while number:
        if number % 2 == 1:
            result += 1
        number = number >> 1
    return result
