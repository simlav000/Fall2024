import sys

input = sys.stdin.readline

cols, rungs = map(int, input().split())

shifts = []
for _ in range(rungs):
    shifts.append(int(input()) - 1)

final = [0] * cols
for index in range(cols):
    current = index
    for rung in shifts:
        if rung == current:
            current += 1
        elif rung == current - 1:
            current -= 1

    final[current] = index

for thing in final:
    print(thing + 1)
