import sys
import re

input = sys.stdin.readline
print = sys.stdout.write

def count_stones(g: str) -> int:
    return g.count('o')

def play_game(g: str, dp: dict) -> int:
    if g in dp:
        return dp[g]

    dots = count_stones(g)

    # Check for "-o...o-" where "..." is any number of o's
    match = re.search(r'-o+o-', g)
    if match:
        # Jump the last 'o' over to the left
        left_new = g[:match.start()] + 'o--' + g[match.start() + 3:]
        right_new = g[:match.end() - 3] + '--o' + g[match.end():]

        dots = min(play_game(left_new, dp), play_game(right_new, dp))

    # Check for "oo-"
    if "oo-" in g:
        dots = min(dots, play_game(re.sub(r"oo-", r"--o", g, count=1), dp))

    # Check for "-oo"
    if "-oo" in g:
        dots = min(dots, play_game(re.sub(r"-oo", r"o--", g, count=1), dp))

    dp[g] = dots
    return dots

n = int(input())

for _ in range(n):
    game = input().strip()
    dp = {}
    print(str(play_game(game, dp)) + "\n")
