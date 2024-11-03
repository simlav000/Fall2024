import sys

input = sys.stdin.readline

n = int(input())

books = []

for _ in range(n):
    books.append(int(input()))

books = sorted(books, reverse=True)

total = sum(books)

discount = 0
if len(books) <= 2:
    print(total)
else:
    for i in range(2, len(books), 3):
        discount += books[i]

    print(total - discount)
