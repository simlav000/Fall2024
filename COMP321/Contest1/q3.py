import sys

input = sys.stdin.readline

ops = input().strip()

pos = [1, 0, 0]


def A():
    in0 = pos[0]
    in1 = pos[1]
    pos[0] = in1
    pos[1] = in0


def B():
    in1 = pos[1]
    in2 = pos[2]
    pos[1] = in2
    pos[2] = in1


def C():
    in0 = pos[0]
    in2 = pos[2]
    pos[0] = in2
    pos[2] = in0


for c in ops:
    if c == "A":
        A()
    if c == "B":
        B()
    if c == "C":
        C()


for i in range(len(pos)):
    if pos[i] == 1:
        print(i + 1)
