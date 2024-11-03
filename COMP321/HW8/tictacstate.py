import sys

input = sys.stdin.readline

# input: 1  001 001 110  111 111 111
# Game state
# o | x | x
# ----------
# o | x | o
# ----------
# x |   | o

# x or o bits
# 0 | 1 | 1
# ----------
# 1 | 0 | 0
# ----------
# 1 | 0 | 0

# Played bits
# 1 | 1 | 1
# ----------
# 1 | 1 | 1
# ----------
# 1 | 1 | 1


def who_wins(game_binary):
    # Extract the most significant bit
    x_turn = (game_binary & 0b1_000_000_000_000_000_000) >> 18
    # print(f"x_turn: {x_turn}")

    # Extract the next 9 bits
    is_x = (game_binary & 0b0_111_111_111_000_000_000) >> 9
    # Print as a 9-bit binary
    # print(f"is_x: {format(is_x, '09b')}")

    is_played = game_binary & 0b0_000_000_000_111_111_111
    # print(f"is_played: {format(is_played, '09b')}")

    top_row = 0b000_000_111
    mid_row = 0b000_111_000
    btm_row = 0b111_000_000

    lft_col = 0b001_001_001
    mid_col = 0b010_010_010
    rgt_col = 0b100_100_100

    dn_diag = 0b100_010_001
    up_diag = 0b001_010_100

    ecks = is_x & is_played
    owhe = ~is_x & is_played

    if (
        ecks & top_row == top_row or
        ecks & mid_row == mid_row or
        ecks & btm_row == btm_row or
        ecks & lft_col == lft_col or
        ecks & mid_col == mid_col or
        ecks & rgt_col == rgt_col or
        ecks & dn_diag == dn_diag or
            ecks & up_diag == up_diag):

        print("X wins")

    elif (
        owhe & top_row == top_row or
        owhe & mid_row == mid_row or
        owhe & btm_row == btm_row or
        owhe & lft_col == lft_col or
        owhe & mid_col == mid_col or
        owhe & rgt_col == rgt_col or
        owhe & dn_diag == dn_diag or
            owhe & up_diag == up_diag):

        print("O wins")

    # Make it so that a game that hasnt already ended but isn't fully
    # played is considered "In progress".
    else:
        if is_played != 0b111_111_111:
            print("In progress")
        else:
            print("Cat's")


n = int(input())

for _ in range(n):
    game_octal = input()
    game_decimal = int(game_octal, 8)
    who_wins(game_decimal)
