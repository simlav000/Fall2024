from collections import deque

def generate_primes(min_val, max_val):
    if max_val < 2 or min_val > max_val:
        return []

    sieve = [True] * (max_val + 1)
    sieve[0] = sieve[1] = False

    # Use Sieve of Eratosthenes
    for i in range(2, int(max_val**0.5) + 1):
        if sieve[i]:
            for j in range(i * i, max_val + 1, i):
                sieve[j] = False

    return [x for x in range(min_val, max_val + 1) if sieve[x]]

def differ_by_1_digit(a, b):
    str_a, str_b = str(a), str(b)
    return sum(1 for x, y in zip(str_a, str_b) if x != y) == 1

def build_graph(ps):
    G = {prime: [] for prime in ps}

    for i in range(len(ps)):
        for j in range(i + 1, len(ps)):
            if differ_by_1_digit(ps[i], ps[j]):
                G[ps[i]].append(ps[j])
                G[ps[j]].append(ps[i])

    return G

def bfs_shortest_path(graph, start, end):
    if start == end:
        return 0
    queue = deque([(start, 0)])
    visited = set()
    visited.add(start)

    while queue:
        current, cost = queue.popleft()

        for neighbor in graph[current]:
            if neighbor == end:
                return cost + 1
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, cost + 1))

    return "Impossible"

# print(G)

n = int(input())
ps = generate_primes(1000, 9999)
G = build_graph(ps)
for _ in range(n):
    s, t = map(int, input().split())
    print(bfs_shortest_path(G, s, t))

