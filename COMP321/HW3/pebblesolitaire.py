import sys
import re

input = sys.stdin.readline
print = sys.stdout.write

def count_stones(g: str) -> int:
    return len([pebble for pebble in g if pebble == "o"]) 

def play_game(g: str, dp: dict) -> int:
    if g in dp:
        return dp[g]

    pebble = count_stones(g)

    for i in range(len(g) - 2):
        if g[i] == 'o' and g[i+1] == 'o' and g[i+2] == '-':
            new_g = g[:i] + '--o' + g[i+3:]

            pebble = min(pebble, play_game(new_g, dp))

    for i in range(len(g) - 2):
        if g[i] == '-' and g[i+1] == 'o' and g[i+2] == 'o':
            new_g = g[:i] + 'o--' + g[i+3:]

            pebble = min(pebble, play_game(new_g, dp))

    dp[g] = pebble
    return pebble

n = int(input())

for _ in range(n):
    game = input().strip()
    dp = {}
    print(str(play_game(game, dp)) + "\n")
