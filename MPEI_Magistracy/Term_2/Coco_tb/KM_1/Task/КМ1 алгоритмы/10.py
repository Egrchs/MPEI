"""Newton's Method."""

# Newton's Method - https://en.wikipedia.org/wiki/Newton%27s_method
from collections.abc import Callable

RealFunc = Callable[[float], float]  # type alias for a real -> real function


# function is the f(x) and derivative is the f'(x)
def newton(
    function: RealFunc,
    derivative: RealFunc,
    starting_int: int,
) -> float:
    prev_guess = float(starting_int)
    while True:
        try:
            next_guess = prev_guess - function(prev_guess) / derivative(prev_guess)
        except ZeroDivisionError:
            raise ZeroDivisionError("Could not find root") from None
        if abs(prev_guess - next_guess) < 10**-5:
            return next_guess
        prev_guess = next_guess
