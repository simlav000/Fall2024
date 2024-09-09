import sys
input = sys.stdin.readline
print = sys.stdout.write

lines = []
for i in range(5): # 5 rows
    unprocessed_line = input()

    j = 0
    line = []
    while j < len(unprocessed_line) - 1:
        temp = ""
        temp += unprocessed_line[j:j+3]
        line.append(temp)

        j = j + 4
    lines.append(line)

decision_tree = {
    "  *": "1",
    "* *": "4",
    "***": {
        "*  " : {
            "***" : {
                "  *" : "5",
                "* *" : "6"
            }
        },
        "* *" : {
            "* *" : "0",
            "***" : {
                "* *" : "8",
                "  *" : "9"
            }
        },
        "  *" : {
            "***" : {
                "*  ": "2",
                "  *": "3"
            },
            "  *" : "7"
        }
    }
}

display = ""

for row in range(len(lines[0])):
    try:
        column = 0
        answer = decision_tree[lines[column][row]]
        while isinstance(answer, dict):
            column += 1
            answer = answer[lines[column][row]]
    except KeyError as e:
        print("BOOM!!" + "\n")
        exit()

    display += answer


code = int(display)
if code % 6 == 0:
    print("BEER!!" + "\n")
else:
    print("BOOM!!" + "\n")

