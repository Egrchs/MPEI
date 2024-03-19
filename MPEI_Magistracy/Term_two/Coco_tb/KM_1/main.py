def hamming_distance(string1: str, string2: str) -> int:
    assert  type(string1) is  str, 'введенные данные  не являются строкой '
    assert  type(string2) is  str, 'введенные данные  не являются строкой '
    assert  len(string2)==len(string1), 'длина строк не совпадает'

    count = 0

    for char1, char2 in zip(string1, string2):
        if char1 != char2:
            count += 1
    assert count!=0,  'все элементы совпадают'
    assert count!=len(string1), 'все элементы не совпадают'
    return count
