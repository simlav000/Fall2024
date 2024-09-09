import sys

input = sys.stdin.readline
print = sys.stdout.write

n = int(input())
buses = sorted(map(int, input().split()))

output = "" 
i = 0

while i < n:
    start = i
    while i + 1 < n and buses[i + 1] == buses[i] + 1:
        i += 1
    
    if i - start >= 2:
        output += f"{buses[start]}-{buses[i]} "
    else:
        for j in range(start, i + 1):
            output += f"{buses[j]} "
    
    i += 1

output = output.strip()
print(output + "\n")

