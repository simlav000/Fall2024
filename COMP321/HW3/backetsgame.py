n_stones = 20

legal_moves = {1, 3, 8}


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


    


