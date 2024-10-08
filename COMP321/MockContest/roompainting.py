import sys

input = sys.stdin.readline
print = sys.stdout.write

n, m = map(int, input().split())

sizes = []
for _ in range(n):
    sizes.append(int(input()))

sizes = sorted(sizes)

waste = 0

req = []
for _ in range(m):
    req.append(int(input()))

req = sorted(req)

last_used = 0

for i in range(len(req)):
    while sizes[last_used] < req[i]:
        last_used += 1
    waste += sizes[last_used] - req[i] 

print(str(waste) + "\n")

