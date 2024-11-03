import sys

input = sys.stdin.readline

total, solved = map(int, input().split())

avg1, avg2 = map(int, input().split())

answer = (avg1 * total - solved*avg2) / (total - solved)

if answer > 100 or answer < 0:
    print("impossible")

else:
    print(f"{answer}")
