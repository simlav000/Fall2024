import sys

input = sys.stdin.readline

num_cases = int(input())
num_phone = int(input())


class Node:

    def __init__(self, v):
        self.value = v
        self.children = []

    def add_node(self, number, i):
        for child in self.children:
            if child.v[0] == number[i]:
                if child.value[1] == "NO":
                    return "NO"
                if i == len(number) - 2:
                    self.child.value[1] = "NO"
                    return "YES"
                return child.add_node(number, i+1)
        self.children.append(Node((number[i], None)))
        self.children[-1].add_node(number, i+1)
        return "YES"


for _ in range(num_cases):
    root = Node(("", None))

    for _ in range(num_phone):
        number = input().strip()

        print(root.add_node(number, 0))
