import sys

input = sys.stdin.readline

n = int(input())

costs = map(int, input().split())

costs = sorted(costs, reverse=True)

answer = 0

for i in range(2, len(costs), 3):
    answer += costs[i]

print(answer)

