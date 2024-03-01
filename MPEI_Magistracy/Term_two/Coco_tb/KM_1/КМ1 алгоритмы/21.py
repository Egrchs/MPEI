"""
Return an image of 16 generations of one-dimensional cellular automata based on a given
ruleset number
https://mathworld.wolfram.com/ElementaryCellularAutomaton.html
"""

from __future__ import annotations

from PIL import Image

# Define the first generation of cells
# fmt: off
CELLS = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
# fmt: on


def format_ruleset(ruleset: int) -> list[int]:
    return [int(c) for c in f"{ruleset:08}"[:8]]


def new_generation(cells: list[list[int]], rule: list[int], time: int) -> list[int]:
    population = len(cells[0])  # 31
    next_generation = []
    for i in range(population):
        # Get the neighbors of each cell
        # Handle neighbours outside bounds by using 0 as their value
        left_neighbor = 0 if i == 0 else cells[time][i - 1]
        right_neighbor = 0 if i == population - 1 else cells[time][i + 1]
        # Define a new cell and add it to the new generation
        situation = 7 - int(f"{left_neighbor}{cells[time][i]}{right_neighbor}", 2)
        next_generation.append(rule[situation])
    return next_generation


def generate_image(cells: list[list[int]]) -> Image.Image:
    """
    Convert the cells into a greyscale PIL.Image.Image and return it to the caller.
    """
    # Create the output image
    img = Image.new("RGB", (len(cells[0]), len(cells)))
    pixels = img.load()
    # Generates image
    for w in range(img.width):
        for h in range(img.height):
            color = 255 - int(255 * cells[h][w])
            pixels[w, h] = (color, color, color)
    return img
