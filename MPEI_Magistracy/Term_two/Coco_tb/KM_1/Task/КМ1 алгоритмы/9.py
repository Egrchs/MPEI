def hamming_distance(string1: str, string2: str) -> int:
    """Calculate the Hamming distance between two equal length strings
    In information theory, the Hamming distance between two strings of equal
    length is the number of positions at which the corresponding symbols are
    different. https://en.wikipedia.org/wiki/Hamming_distance

    Args:
        string1 (str): Sequence 1
        string2 (str): Sequence 2

    Returns:
        int: Hamming distance
    """
    if len(string1) != len(string2):
        raise ValueError("String lengths must match!")

    count = 0

    for char1, char2 in zip(string1, string2):
        if char1 != char2:
            count += 1

    return count
