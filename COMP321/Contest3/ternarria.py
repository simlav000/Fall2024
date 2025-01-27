import sys

input = sys.stdin.readline

n = int(input())


def make_pow_3(max):
    powers = [1]
    value = 1
    while value < max:
        value = powers[-1]*3
        powers.append(value)
    return powers


pows_of_3 = [1, 3, 9, 27, 81, 243, 729, 2187, 6561, 19683, 59049, 177147, 531441, 1594323,
             4782969, 14348907, 43046721, 129140163, 387420489, 1162261467, 3486784401, 10460353203]


def find_closest(k):
    closest = float('inf')
    for pow in pows_of_3:
        diff = abs(k - pow)
        if diff <= closest:
            closest = diff
        else:
            return pow//3


for _ in range(n):
    left_pan = []
    right_pan = []

    weight = int(input())

    while weight != 0:
        closest = find_closest(abs(weight))

        if weight > 0:
            right_pan.append(closest)
            weight -= closest

        else:
            left_pan.append(closest)
            weight += closest

    left_print = "left pan: "
    right_print = "right pan: "
    for l in left_pan:
        left_print += str(l) + " "
    for r in right_pan:
        right_print += str(r) + " "

    print(left_print)
    print(right_print)
    print()
