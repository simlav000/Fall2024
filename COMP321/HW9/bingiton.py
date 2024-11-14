import sys

input = sys.stdin.readline


class Node:

    def __init__(self, v):
        self.value = v
        self.children = []

    def add_node(self, query, i):
        if i == len(query) - 1:
            if len(self.children) == 0:
                self.children.append(Node(query[i]))
                return 0
            else:
                return 1

        for child in self.children:
            if child.value == query[i]:
                return (child.add_node(query, i + 1))

        self.children.append(Node(query[i]))
        return (self.children[-1].add_node(query, i + 1))


num_queries = int(input())

total = 0
root = Node("")
for _ in range(num_queries):
    query = input().strip()
    total += root.add_node(query, 0)
