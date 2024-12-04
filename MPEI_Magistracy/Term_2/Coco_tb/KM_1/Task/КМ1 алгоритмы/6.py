# Implementing Newton Raphson method in Python
# Author: Syed Haseeb Shah (github.com/QuantumNovice)
# The Newton-Raphson method (also known as Newton's method) is a way to
# quickly find a good approximation for the root of a real-valued function
from __future__ import annotations

from decimal import Decimal
from math import *

from sympy import diff


def newton_raphson(
    func: str, a: float | Decimal, precision: float = 10**-10
) -> float:
    """Finds root from the point 'a' onwards by Newton-Raphson method
    >>> newton_raphson("sin(x)", 2)
    3.1415926536808043
    """
    x = a
    while True:
        x = Decimal(x) - (Decimal(eval(func)) / Decimal(eval(str(diff(func)))))
        # This number dictates the accuracy of the answer
        if abs(eval(func)) < precision:
            return float(x)
