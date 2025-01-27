import sys
from math import sqrt

input = sys.stdin.readline

# Minimum spanning tree algorithn:
# Use disjoint set data structure. Each edge starts as its own disjoint set.
# Sort edges by increasing weight and connect cheapest edges together using
# union operation. Finish when find(u) = find(v) for all (u,v) in E of G.


class Disjointset:

    def __init__(self, n):
        self.rep = list(range(n))
        self.rank = [0] * n
        self.size = n

    def find(self, x):
        if self.rep[x] != x:
            self.rep[x] = self.find(self.rep[x])
        return self.rep[x]

    def get_sets(self):
        children = dict()

        for i in range(self.size):
            bigrep = self.find(i)
            if bigrep not in children:
                children[bigrep] = [i]
            else:
                children[bigrep].append(i)

        return children

    def string(self):
        print(self.rep)

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


def euc_dist(x1, y1, x2, y2):
    return sqrt((x1 - x2)**2 + (y1 - y2)**2)


def check_touch(sens1, sens2):
    dist = euc_dist(sens1[0], sens1[1], sens2[0], sens2[1])
    rad_sum = sens1[2] + sens2[2]
    if dist > rad_sum:
        return False
    return True


n_sensors = int(input())


sensors = []

for i in range(n_sensors):
    sensors.append(list(map(int, input().split())))

for i in range(1, n_sensors + 1):
    dsj = Disjointset(i)
    for s1 in range(i):
        for s2 in range(s1 + 1, i):
            if check_touch(sensors[s1], sensors[s2]):
                dsj.union(s1, s2)

    groups = dsj.get_sets()

    for group in groups.values():
        crossesLeft = False
        crossesRight = False
        for si in range(len(group)):
            s = sensors[group[si]]
            if s[0] - s[2] < 0:
                crossesLeft = True
            if s[0] + s[2] > 200:
                crossesRight = True

        if crossesLeft and crossesRight:
            print(i - 1)
            exit()
