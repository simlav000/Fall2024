def toposort(G, n):
    in_degree = [0] * n
    for u in range(n):
        for v, _ in G[u]:
            in_degree[v] += 1

    q = deque([u for u in range(n) if in_degree[u] == 0])
    order = []

    while q:
        u = q.popleft()
        order.append(u)
        for v, _ in G[u]:
            in_degree[v] -= 1
            if in_degree[v] == 0:
                q.append(v)

    if len(order) == n:
        return order
    # Should never return an empty list if input is kosher
    return []

