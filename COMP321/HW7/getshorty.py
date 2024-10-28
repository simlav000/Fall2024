from math import log, exp
import heapq
# Turn this "maximum product" problem into a
# "minimum sum/shortest path" problem by taking
# the negative log of the edge factors
import sys

input = sys.stdin.readline

def dijkstra(G, n):
    start = 0
    end = n - 1
    dists = [float('inf') for _ in range(n)]
    dists[start] = 0

    pq = [(start, 0)]

    while pq:
        u, dist = heapq.heappop(pq)

        if u == end:
            return exp(-dist)

        if dist > dists[u]:
            continue

        for v, f in G[u]:
            # f < 1 -> log(f) < 0 so we are increasing distance
            newdist = dist - log(f)

            if newdist < dists[v]:
                dists[v] = newdist
                heapq.heappush(pq, (v, newdist))

    # Should never return Impossible if input is legit
    return exp(-dists[end]) if dists[end] < float('inf') else 'Impossible'

n, m = map(int, input().split())

while (n, m) != (0, 0):
    # Adjacency list representation
    G = dict()
    for _ in range(m):
        u, v, f = input().split()
        u, v, f = int(u), int(v), float(f)
        # Treat each corridor as two directed edges (u, v) & (v, u)
        if u not in G:
            G[u] = [(v, f)]
        else:
            G[u].append((v, f))
        if v not in G:
            G[v] = [(u, f)]
        else:
            G[v].append((u, f))

    print(f"{dijkstra(G, n):.4f}")

    n, m = map(int, input().split())
