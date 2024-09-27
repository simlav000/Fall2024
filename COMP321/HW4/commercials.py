import sys

input = sys.stdin.readline
#print = sys.stdout.write

n, cost = map(int, input().split())

slots = list(map(int, input().split()))

profits = 0
biggest = 0

for slot in slots:
    profits += slot - cost
    if profits > biggest:
        biggest = profits
    if profits < 0:
        profits = 0

print(str(biggest) + "\n")

