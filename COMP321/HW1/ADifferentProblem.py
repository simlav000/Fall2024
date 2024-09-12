import sys

sys.set_int_max_str_digits(0)


for line in sys.stdin:
    a, b = map(int, line.split(" "))
    print(abs(a - b))
