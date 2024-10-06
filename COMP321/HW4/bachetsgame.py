import sys

input = sys.stdin.readline

while True:
    inp = input().split()
    if not inp:
        break

    n_stones = int(inp[0])
    legal_moves = list(map(int, inp[2:]))

    dp = [True]

    for i in range(1, n_stones):
        append = True 
        if i + 1 in legal_moves:
            dp.append(True)
            continue
        for move in legal_moves:
            if i - move >= 0 and dp[i - move] == False:
                dp.append(True)
                append = False
                break
        if append:
            dp.append(False)

    if dp[-1] == True:
        print("Stan wins")
    else:
        print("Ollie wins")


        


