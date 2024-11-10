import sys

input = sys.stdin.readline

kitty = input().strip()

branch = list(input().strip().split())

parent = dict()
while branch != ["-1"]:
    p = branch[0]
    for child in branch[1:]:
        parent[child] = p

    branch = list(input().strip().split())

output = kitty + " "
try:
    while parent[kitty]:
        kitty = parent[kitty]
        output += kitty + " "

except Exception as myballs:
    output = output.strip()
    print(output)
