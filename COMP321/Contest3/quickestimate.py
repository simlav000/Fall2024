import sys

input = sys.stdin.readline

k = int(input())

for _ in range(k):
    print(len(input()) - 1)
