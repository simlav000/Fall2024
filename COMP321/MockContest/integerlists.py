import sys

input = sys.stdin.readline
print = sys.stdout.write

n = int(input())

for _ in range(n):
    p = input().strip()
    _ = input()
    arr = input()

    try:
        arr = list(map(int, arr[1:-2].strip().split(",")))

    except:
        arr = arr[1:-2].strip().split(",")
    reversed = False
    start = 0
    stop = len(arr) - 1
    for c in p:
        if c == "R":
            reversed = not reversed
            continue
        if reversed:
            stop -= 1
            continue
        start += 1

    if start > stop:
        print("error" + "\n")
        continue
    arr = arr[start: stop + 1]
    if reversed:
        arr.reverse()

    answer = "["
    for a in arr:
        answer += str(a) + ","

    answer = answer[:-1]
    answer += "]"
    print(answer + "\n")
