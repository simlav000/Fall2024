    .data
Step:    .asciiz "Step "
Colon:   .asciiz ": "
Move:    .asciiz "move disk "
From:    .asciiz " from "
To:      .asciiz " to "
Newline: .asciiz "\n"

    .text
    .globl main

main:
    li $s0, 10000       # Counter for steps
    li $a0, 777         # Disk number
    li $a1, 'C'         # Source peg
    li $a2, '/'         # Target peg
    jal print_move

    # Exit program
    li $v0, 10
    syscall


# Print string saved in $a0
print_string:
    li $v0, 4
    syscall
    jr $ra

# Print integer saved in $a0
print_int:
    li $v0, 1
    syscall
    jr $ra

# Print character saved in $a0
print_char:
    li $v0, 11
    syscall
    jr $ra
