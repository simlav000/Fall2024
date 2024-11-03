import sys

input = sys.stdin.readline

n = int(input())

arr = list(map(int, input().split()))

num_map = dict()

min_len = len(arr)

for i in range(len(arr)):
    lang = arr[i]
    if lang in num_map:
        min_len = min(min_len, i - num_map[lang])

    num_map[lang] = i


print(min_len)
