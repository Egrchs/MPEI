# Information on binary shifts:
# https://docs.python.org/3/library/stdtypes.html#bitwise-operations-on-integer-types
# https://www.interviewcake.com/concept/java/bit-shift


def logical_left_shift(number: int, shift_amount: int) -> str:
    """
    Take in 2 positive integers.
    'number' is the integer to be logically left shifted 'shift_amount' times.
    i.e. (number << shift_amount)
    Return the shifted binary representation.
    """
    if number < 0 or shift_amount < 0:
        raise ValueError("both inputs must be positive integers")

    binary_number = str(bin(number))
    binary_number += "0" * shift_amount
    return binary_number


def logical_right_shift(number: int, shift_amount: int) -> str:
    """
    Take in positive 2 integers.
    'number' is the integer to be logically right shifted 'shift_amount' times.
    i.e. (number >>> shift_amount)
    Return the shifted binary representation.
    """
    if number < 0 or shift_amount < 0:
        raise ValueError("both inputs must be positive integers")

    binary_number = str(bin(number))[2:]
    if shift_amount >= len(binary_number):
        return "0b0"
    shifted_binary_number = binary_number[: len(binary_number) - shift_amount]
    return "0b" + shifted_binary_number


def arithmetic_right_shift(number: int, shift_amount: int) -> str:
    """
    Take in 2 integers.
    'number' is the integer to be arithmetically right shifted 'shift_amount' times.
    i.e. (number >> shift_amount)
    Return the shifted binary representation.
    """
    if number >= 0:  # Get binary representation of positive number
        binary_number = "0" + str(bin(number)).strip("-")[2:]
    else:  # Get binary (2's complement) representation of negative number
        binary_number_length = len(bin(number)[3:])  # Find 2's complement of number
        binary_number = bin(abs(number) - (1 << binary_number_length))[3:]
        binary_number = (
            "1" + "0" * (binary_number_length - len(binary_number)) + binary_number
        )

    if shift_amount >= len(binary_number):
        return "0b" + binary_number[0] * len(binary_number)
    return (
        "0b"
        + binary_number[0] * shift_amount
        + binary_number[: len(binary_number) - shift_amount]
    )
