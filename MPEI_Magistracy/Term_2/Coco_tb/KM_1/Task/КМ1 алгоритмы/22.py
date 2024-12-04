"""
Heap's algorithm returns the list of all permutations possible from a list.
It minimizes movement by generating each permutation from the previous one
by swapping only two elements.
More information:
https://en.wikipedia.org/wiki/Heap%27s_algorithm.
"""


def heaps(arr: list) -> list:
    """
    Pure python implementation of the Heap's algorithm (recursive version),
    returning all permutations of a list.
    """

    if len(arr) <= 1:
        return [tuple(arr)]

    res = []

    def generate(k: int, arr: list):
        if k == 1:
            res.append(tuple(arr[:]))
            return

        generate(k - 1, arr)

        for i in range(k - 1):
            if k % 2 == 0:  # k is even
                arr[i], arr[k - 1] = arr[k - 1], arr[i]
            else:  # k is odd
                arr[0], arr[k - 1] = arr[k - 1], arr[0]
            generate(k - 1, arr)

    generate(len(arr), arr)
    return res
