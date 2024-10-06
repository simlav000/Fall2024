import sys
from math import sqrt

print = sys.stdout.write

for line in sys.stdin:
    n, l, w = map(int, line.split())

    sprinklers = []
    w_over_2 = (w / 2)

    for _ in range(n):
        x, r = map(int, input().split())
        if 2 * r > w:  
            d = sqrt(r**2 - w_over_2**2)
            sprinklers.append((x - d, x + d))

    sorted_sprinklers = sorted(sprinklers, key=lambda s: (s[0], -s[1]))

    coverage_end = 0
    count = 0
    i = 0

    while coverage_end < l:
        furthest = -1

        # Find the sprinkler that covers the current gap and extends furthest
        while i < len(sorted_sprinklers) and sorted_sprinklers[i][0] <= coverage_end:
            furthest = max(furthest, sorted_sprinklers[i][1])
            i += 1

        # If no sprinkler can extend the coverage, give up
        if furthest == -1:
            print(str(-1) + "\n")
            break

        count += 1
        coverage_end = furthest

        # If we've covered the entire lawn, done 
        if coverage_end >= l:
            print(str(count) + "\n")
            break
