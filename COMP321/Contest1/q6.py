
n, c, k = map(int, input().split())

socks = map(int, input().split())

socks = sorted(socks)

mini = socks[0]

result = 1
count = c

for i in range(len(socks)):
    if socks[i] - mini > k or count == 0:
        result += 1
        count = c
        mini = socks[i]
    count -= 1

print(result)
