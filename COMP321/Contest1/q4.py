import sys

input = sys.stdin.readline

pivotable = dict()


def merge(left, right):
    sorted = []
    i1 = 0
    i2 = 0
    right_inserted = False
    while i1 < len(left) and i2 < len(right):
        v1 = left[i1]
        v2 = right[i2]

        if v1[0] < v2[0]:
            if right_inserted:
                pivotable[v1[1]] = False
            sorted.append(v1)
            i1 += 1
        elif v1[0] == v2[0]:
            sorted.append(v1)
            i1 += 1
            pivotable[v1[1]] = False

        else:
            right_inserted = True
            pivotable[v1[1]] = False
            pivotable[v2[1]] = False
            sorted.append(v2)
            i2 += 1

    if i1 < len(left):
        for item in left[i1:]:
            pivotable[item[1]] = False
            sorted.append(item)

    if i2 < len(right):
        last_memorized = (None, None)
        for item in right[i2:]:
            sorted.append(item)
            if last_memorized[0] == item[0]:
                pivotable[last_memorized[1]] = False
            last_memorized = item

    return sorted


def mergesort(arr):
    if len(arr) == 1:
        return arr
    mid = len(arr) // 2

    left = arr[:mid]
    right = arr[mid:]

    leftsorted = mergesort(left)
    rightsorted = mergesort(right)

    return merge(leftsorted, rightsorted)


n = int(input())
arr = list(map(int, input().split()))

new = []
for i in range(len(arr)):
    new.append((arr[i], i))

for index, item in enumerate(arr):
    pivotable[index] = True


mergesort(new)

count = 0

for key, val in pivotable.items():
    if val is True:
        count += 1
print(count)
