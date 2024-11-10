import sys
from collections import deque

input = sys.stdin.readline

chunks = int(input())


def t_add(tup1, tup2):
    return tuple(map(lambda x, y: x + y, tup1, tup2))


def add_directed(s, t, adj):
    """ adds t to s's adj list"""
    if s not in adj:
        adj[s] = [t]
    else:
        if t not in adj[s]:
            adj[s].append(t)


def bfs(dest, adj):
    if dest == (0, 0):
        return 0

    q = deque([(0, 0)])

    colors = dict()
    dists = dict()

    for k in adj.keys():
        colors[k] = False
        dists[k] = 0

    colors[(0, 0)] = True

    while len(q) > 0:
        current = q.popleft()
        for neighbour in adj[current]:
            if neighbour == dest:
                return dists[current] + 1
            if not colors[neighbour]:
                colors[neighbour] = True
                q.append(neighbour)
                dists[neighbour] = dists[current] + 1


cardinal = {
    "N": (0, 1),
    "S": (0, -1),
    "E": (1, 0),
    "W": (-1, 0)
}

for _ in range(chunks):
    _ = input()

    adj = dict()
    current = (0, 0)
    steps = int(input())
    for i in range(steps):
        move = input().strip()
        next = t_add(current, cardinal[move])
        add_directed(current, next, adj)
        add_directed(next, current, adj)
        current = next

    output = bfs(current, adj)
    print(output)
