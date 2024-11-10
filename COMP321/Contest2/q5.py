import sys

input = sys.stdin.readline

line = input().strip()
line_sticky = input().strip()

counts = dict()

for char in line:
    if char not in counts:
        counts[char] = -1

    else:
        counts[char] -= 1

for char in line_sticky:
    if char in counts:
        counts[char] += 1

output = ""
for k, v in counts.items():
    if v > 0:
        output += k

print(output)
