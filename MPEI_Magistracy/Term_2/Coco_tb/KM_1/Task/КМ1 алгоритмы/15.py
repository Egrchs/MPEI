# https://www.tutorialspoint.com/python3/bitwise_operators_example.htm


def binary_xor(a: int, b: int) -> str:
    """
    Take in 2 integers, convert them to binary,
    return a binary number that is the
    result of a binary xor operation on the integers provided.
    """
    if a < 0 or b < 0:
        raise ValueError("the value of both inputs must be positive")

    a_binary = str(bin(a))[2:]  # remove the leading "0b"
    b_binary = str(bin(b))[2:]  # remove the leading "0b"

    max_len = max(len(a_binary), len(b_binary))

    return "0b" + "".join(
        str(int(char_a != char_b))
        for char_a, char_b in zip(a_binary.zfill(max_len), b_binary.zfill(max_len))
    )
