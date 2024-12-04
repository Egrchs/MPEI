import math
from collections.abc import Callable


def intersection(function: Callable[[float], float], x0: float, x1: float) -> float:
    """
    function is the f we want to find its root
    x0 and x1 are two random starting points
    """
    x_n: float = x0
    x_n1: float = x1
    while True:
        if x_n == x_n1 or function(x_n1) == function(x_n):
            raise ZeroDivisionError("float division by zero, could not find root")
        x_n2: float = x_n1 - (
            function(x_n1) / ((function(x_n1) - function(x_n)) / (x_n1 - x_n))
        )
        if abs(x_n2 - x_n1) < 10**-5:
            return x_n2
        x_n = x_n1
        x_n1 = x_n2
