import sys
from math import sin, cos, radians, sqrt

input = sys.stdin.readline

def dist(p1, p2):
    return sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)

def update_pos(current_loc, move, orientation):
    if move[0] == "fd":
        x = current_loc[0] + int(move[1]) * cos(radians(orientation))
        y = current_loc[1] + int(move[1]) * sin(radians(orientation))
    elif move[0] == "bw":
        x = current_loc[0] - int(move[1]) * cos(radians(orientation))
        y = current_loc[1] - int(move[1]) * sin(radians(orientation))
    else:
        raise ValueError(f"Invalid move type: {move[0]}")

    return (x, y)

def reorient(orientation, move):
    if move[0] == 'lt':
        orientation = (orientation + int(move[1])) % 360
    elif move[0] == 'rt':
        orientation = (orientation - int(move[1])) % 360
    else:
        raise ValueError(f"Invalid move type: {move[0]}")

    return orientation

num_cases = int(input())

for _ in range(num_cases):
    num_moves = int(input())

    current_loc = (0, 0)
    orientation = 0
    for _ in range(num_moves):
        move = list(input().strip().split())
        if move[0] in ["lt", "rt"]:
            orientation = reorient(orientation, move)
        elif move[0] in ["fd", "bw"]:
            current_loc = update_pos(current_loc, move, orientation)
        else:
            raise ValueError(f"Invalid command: {move[0]}")

    print(round(dist((0, 0), current_loc)))
