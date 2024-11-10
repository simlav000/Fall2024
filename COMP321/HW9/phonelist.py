import sys

input = sys.stdin.readline



class Node:

    def __init__(self, v):
        self.value = v
        self.children = []

    def add_node(self, number, i):
        if i == len(number) - 1:
            self.children.append(Node([number[i], "NO"]))
            return "YES"

        for child in self.children:
            if child.value[0] == number[i]:
                if child.value[1] == "NO":
                    return "NO"
                return(child.add_node(number, i + 1))

        self.children.append(Node([number[i], None]))
        return(self.children[-1].add_node(number, i+1))




num_cases = int(input())

for _ in range(num_cases):
    root = Node(["", None])
    numbers = []
    decisions = []

    num_phone = int(input())
    for _ in range(num_phone):
        numbers.append(input().strip())

    for number in sorted(numbers, key=len):
        decisions.append(root.add_node(number, 0))

    if "NO" in decisions:
        print("NO")
    else:
        print("YES")
