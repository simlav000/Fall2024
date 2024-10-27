import sys

input = sys.stdin.readline
print = sys.stdout.write

# Minimum spanning tree algorithn:
# Use disjoint set data structure. Each edge starts as its own disjoint set.
# Sort edges by increasing weight and connect cheapest edges together using 
# union operation. Finish when find(u) = find(v) for all (u,v) in E of G.

class Disjointset:

    def __init__(self, n):
        self.rep = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.rep[x] != x:
            self.rep[x] = self.find(self.rep[x])
        return self.rep[x]

    def union(self, x, y):
        rootx = self.find(x)
        rooty = self.find(y)

        if rootx != rooty:
            if self.rank[rootx] > self.rank[rooty]:
                self.rep[rooty] = rootx
            elif self.rank[rootx] < self.rank[rooty]:
                self.rep[rootx] = rooty
            else:
                self.rep[rooty] = rootx
                self.rank[rootx] += 1

n, m = map(int, input().split())

while (n, m) != (0, 0):

    E = []
    ds = Disjointset(n)
    for _ in range(m):
        E.append(tuple(map(int, input().split())))

    # Cannot span G if G is disconnected
    if m < n - 1:
        print("Impossible\n")
        n, m = map(int, input().split())
        continue

    # Sort by increasing weight
    E.sort(key=lambda x: x[2])

    total = 0
    minset = []
    for u, v, w in E:
        if ds.find(u) != ds.find(v):
            ds.union(u, v)
            total += w
            minset.append((min(u, v), max(u, v)))

    if len(minset) == n - 1:
            minset.sort()
            print(f"{total}\n")
            for u, v in minset:
                print(f"{u} {v}\n")
    else:
        print("Impossible\n")

    n, m = map(int, input().split())



