import sys

input = sys.stdin.readline

n = int(input())

string = ""
for _ in range(n):
    inp = input().strip()

    if inp == "Z":
        string += "0"
    else:
        string += "1"

length = len(string)
output = 0

o = 0
for i in range(len(string) - 1, -1, -1):
    if string[i] == "1":
        output += 2 ** o
    o += 1

print(output)
