
from main import *
def test_one():
    assert hamming_distance('hello','world') == 4 

def test_two():
    assert hamming_distance('motor','spirit') == 1

def test_three():
    assert hamming_distance('cover','volan') == 4

def test_four():
    assert hamming_distance('sorry','worry') == 1

def test_five():
    assert hamming_distance('dogs','cats') == 2
