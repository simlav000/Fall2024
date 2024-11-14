class Node:
    def __init__(self):
        self.count = 0
        self.children = [None] * 26

def insert(root, query):
    c = ord(query[-1]) - ord('a')
    query = query[:-1]

    if root.children[c] is None:
        root.children[c] = Node()

    ans = root.children[c].count
    root.children[c].count += 1

    if not query:
        return ans

    return insert(root.children[c], query)

num_queries = int(input())
root = Node()

for _ in range(num_queries):
    query = input()[::-1]
    print(insert(root, query))

