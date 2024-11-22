import sys
import math

input = sys.stdin.readline

def dist(p1, p2):
    return math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)

# From cross product
def orientation(p, q, r):
    val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
    return 0 if val == 0 else (1 if val > 0 else -1)

# Andrew's monotone chain algorithm
def convex_hull(points):
    points = sorted(points)
    if len(points) <= 1:
        return points

    lower = []
    for p in points:
        while len(lower) >= 2 and orientation(lower[-2], lower[-1], p) <= 0:
            lower.pop()
        lower.append(p)

    upper = []
    for p in reversed(points):
        while len(upper) >= 2 and orientation(upper[-2], upper[-1], p) <= 0:
            upper.pop()
        upper.append(p)

    return lower[:-1] + upper[:-1]

def farthest_pair(hull):
    n = len(hull)
    if n == 2:
        return dist(hull[0], hull[1])
    
    max_dist = 0
    j = 1
    for i in range(n):
        while True:
            current_dist = dist(hull[i], hull[j])
            next_j = (j + 1) % n
            next_dist = dist(hull[i], hull[next_j])
            if next_dist > current_dist:
                j = next_j
            else:
                break
        max_dist = max(max_dist, dist(hull[i], hull[j]))
    return max_dist

c = int(input())

coords = []
for _ in range(c):
    coords.append(tuple(map(int, input().split())))

hull = convex_hull(coords)
result = farthest_pair(hull)
print(f"{result:.6f}")
