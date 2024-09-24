import sys

input = sys.stdin.readline

def println(inp):
    sys.stdout.write(str(inp) + "\n")

case_count = 1
for n in (sys.stdin):
    tools = []
    for _ in range(int(n)):
        tools.append(int(input()))

    m = int(input())

    nums = []
    for _ in range(m):
        nums.append(int(input()))

    println(f"Case {case_count}:")
    case_count += 1
    for sum in nums:
        best = 69E69
        answer = 696969
        for i in range(len(tools)):
            for j in range(i + 1, len(tools)):
                thesum = tools[i] + tools[j]
                if abs(thesum - sum) < best:
                    best = abs(thesum - sum)
                    answer = thesum

        output = f"Closest sum to {sum} is {answer}."
        println(output)



