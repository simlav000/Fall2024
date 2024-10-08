import sys
import numpy as np

input = sys.stdin.readline
print = sys.stdout.write

n = int(input())

for i in range(n):
    length = int(input())
    v1 = list(map(int, input().split()))
    v2 = list(map(int, input().split()))

    v1 = sorted(v1)
    v2 = sorted(v2, reverse=True)

    v1 = np.array(v1)
    v2 = np.array(v2)

    dot_p = np.dot(v1, v2)

    print(f"Case #{i + 1}: {dot_p}" + "\n")
