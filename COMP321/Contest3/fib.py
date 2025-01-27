import sys

input = sys.stdin.readline

n = int(input())

fibs = [0, 1]

while True:
    next = fibs[-1] + fibs[-2]
    if next > n:
        break

    fibs.append(next)

sum = n
components = []
for i in range(len(fibs) - 1, 0, -1):
    if sum >= fibs[i]:
        components.append(fibs[i])
        sum -= fibs[i]

for fib in reversed(components):
    print(fib, end=" ")
