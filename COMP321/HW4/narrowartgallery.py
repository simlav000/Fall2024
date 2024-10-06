import sys

INF = 1000000

input = sys.stdin.readline

def f(k, r):
    return min(f_recursive(k, r, 0), f_recursive(k, r, 1))

def f_recursive(k, r, c):
    if k == 0:
        return 0
    if r < 0:
        return INF

    if dp[k][r][c] is not None:
        return dp[k][r][c]

    room_value = gallery[r][c]
    dp[k][r][c] = min(f_recursive(k - 1, r - 1, c) + room_value, f(k, r - 1))
    return dp[k][r][c]

def narrow_art_gallery():
    N, K = map(int, input().split())

    while (N, K) != (0, 0):
        global gallery, dp

        dp = [[[None for _ in range(2)] for _ in range(N)] for _ in range(K + 1)]
        gallery = []

        total_value = 0
        for i in range(N):
            row = list(map(int, input().split()))
            gallery.append(row)
            total_value += sum(row)

        print(total_value - f(K, N - 1))
        N, K = map(int, input().split())

narrow_art_gallery()
