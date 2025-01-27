import sys
from math import sqrt

input = sys.stdin.readline

x0, y0, others = map(int, input().split())


def euc_dist(x1, y1, x2, y2):
    return sqrt((x1 - x2)**2 + (y1 - y2)**2)


circs = []
for _ in range(others):
    circs.append(list(map(int, input().split())))

dists = []
for c in circs:
    dists.append(euc_dist(x0, y0, c[0], c[1]) - c[2])

dists = sorted(dists)
if dists[2] < 0:
    print(0)
else:
    print(int(dists[2]))
