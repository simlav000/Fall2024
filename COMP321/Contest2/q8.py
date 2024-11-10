import sys

input = sys.stdin.readline


def add_directed(s, t, adj):
    """ adds t to s's adj list"""
    if s not in adj:
        adj[s] = [t]
    else:
        if t not in adj[s]:
            adj[s].append(t)


adj_matrix = []

n = int(input())

while n != -1:
    for _ in range(n)

    n = int(input())
    adj_matrix = []
