import sys
input = sys.stdin.readline

num_flips = int(input())

file1 = int(input(), 2)
file2 = int(input(), 2)

if num_flips % 2 == 0 and file1 == file2:
    print("Deletion succeeded")

else:
    bit_length = file1.bit_length()
    mask = (1 << bit_length) - 1
    inverted = ~file1 & mask
    if inverted == file2:
        print("Deletion succeeded")
    else:
        print("Deletion failed")
