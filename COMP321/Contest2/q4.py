import sys

input = sys.stdin.readline


def print_arr(arr):
    for i in range(len(arr)):
        if i < len(arr) - 1:
            print(f"{arr[i]} ", end="")
        else:
            print(f"{arr[i]}", end="\n")


l = list(map(int, input().split()))

i = 0
while l != [1, 2, 3, 4, 5]:
    if i == 4:
        i = 0

    if l[i] > l[i+1]:
        temp = l[i]
        l[i] = l[i + 1]
        l[i+1] = temp
        print_arr(l)

    i += 1
