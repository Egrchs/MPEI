"""Lower-Upper (LU) Decomposition.

Reference:
- https://en.wikipedia.org/wiki/LU_decomposition
"""
from __future__ import annotations

import numpy as np
import numpy.typing as NDArray
from numpy import float64


def lower_upper_decomposition(
    table: NDArray[float64],
) -> tuple[NDArray[float64], NDArray[float64]]:
    # Table that contains our data
    # Table has to be a square array so we need to check first
    rows, columns = np.shape(table)
    if rows != columns:
        raise ValueError(
            f"'table' has to be of square shaped array but got a {rows}x{columns} "
            + f"array:\n{table}"
        )
    lower = np.zeros((rows, columns))
    upper = np.zeros((rows, columns))
    for i in range(columns):
        for j in range(i):
            total = 0
            for k in range(j):
                total += lower[i][k] * upper[k][j]
            lower[i][j] = (table[i][j] - total) / upper[j][j]
        lower[i][i] = 1
        for j in range(i, columns):
            total = 0
            for k in range(i):
                total += lower[i][k] * upper[k][j]
            upper[i][j] = table[i][j] - total
    return lower, upper
