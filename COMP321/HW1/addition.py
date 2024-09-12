def eval(line):
    nums = line.split("+")
    print(int(nums[0]) + int(nums[1]))

N = int(input())
for _ in range(N):
    line = input()
    if line != "P=NP":
        eval(line)

