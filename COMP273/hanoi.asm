############ COMP 273, Fall 2024, Assignment 4, Tower of Hanoi - non-recursive ###########
# Student ID: 261 051 325
# Name: Simon Lavoie

    .data
Step:          .asciiz "Step "
Colon:         .asciiz ": "
Move:          .asciiz "move disk "
From:          .asciiz " from "
To:            .asciiz " to "
Newline:       .asciiz "\n"

AlgorithmType: .word 1
		# 0 Recursive
		# 1 Non-recursive
    .text
    .globl main

main:
    # read the integer n from the standard input
    jal readInt
    # now $v0 contains the number of disk n

    # check for which algorithm is set to use: Recursive or non-recursive.
    la $t0 AlgorithmType
    lw $t0, 0($t0)

    # Initialize arguments to TOH
    move $a0, $v0
    li $a1, 'A'
    li $a2, 'C'
    li $a3, 'B'

    # Use $s0 as the step counter.
    li $s0, 1

    beq $t0 0 TOH_Recursive
    beq $t0 1 TOH_Nonrecursive

    # exit if the algorithm number is out of range
    li $v0 10 
    syscall


TOH_Recursive:
    jal hanoi_rec

    li $v0 10
    syscall

hanoi_rec:
    # Inputs:
    #    $a0: n
    #    $a1: source
    #    $a2: target
    #    $a3: auxiliary
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $a3, 16($sp)

    # Branch if not base case
    li $t0, 1
    bne $a0, $t0, delegate

    # base case: n == 1

    # Here we actually move disk from source to target
    jal print_move
    addi $s0, $s0, 1

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    addi $sp, $sp, 20

    jr $ra

delegate:
    subi $a0, $a0, 1

    move $t0, $a2    # Store target in temp register
    move $a2, $a3    # Move target to aux
    move $a3, $t0    # Set new target

    # MOVE(n-1, source, aux, target)
    jal hanoi_rec

    # Resore function state from above recursion
    #lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    #addi $sp, $sp, 20

    # Actually move disk, increment step
    jal print_move
    addi $s0, $s0, 1

    # Prepare for second recursive call
    subi $a0, $a0, 1
    move $t0, $a1
    move $a1, $a3
    move $a3, $t0


    # MOVE(n-1, aux, target, source)
    jal hanoi_rec

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    addi $sp, $sp, 20

    jr $ra



# TODO END
# Set the second breakpoint to measure cache performance and instruction count for the recursive method at the following line

li $v0, 10	# exit the program
syscall


TOH_Nonrecursive:
    # Uses the "Binary solution". Can read about it here:
    # https://en.wikipedia.org/wiki/Tower_of_Hanoi#Iterative_solution
    # Can watch an amazing explanation here:
    # https://www.youtube.com/watch?v=2SUvWfNJSsM
    # Input:
    #    $a0 = n
    #    $a1 = source
    #    $a2 = target
    #    $a3 = auxiliary
    # Calculate totalMoves = 2^n - 1
    li $s1, 1                # $s1 = 1
    sllv $s1, $s1, $a0       # $s1 = 2^n
    sub $s1, $s1, 1          # $s1 = 2^n - 1

    # Loop through each move
    li $t1, 1                # $t1 = m (start with move 1)

hanoi_loop:
    # Check if m <= totalMoves
    bgt $t1, $s1, end_hanoi  # If m > totalMoves, exit loop

    move $a0, $t1
    jal count_trailing_zeros # Get the disk number
    move $t2, $v0            # $t2 = disk (return value)

    # Calculate source = (m & (m - 1)) % 3
    sub $t3, $t1, 1          # $t3 = m - 1
    and $t4, $t1, $t3        # $t4 = m & (m - 1)
    div $t4, $t4, 3          # $t4 = (m & (m - 1)) / 3
    mfhi $t5                 # Get remainder (source peg)

    # Calculate destination = ((m | (m - 1)) + 1) % 3
    sub $t3, $t1, 1          # $t3 = m - 1
    or $t6, $t1, $t3         # $t6 = m | (m - 1)
    addi $t6, $t6, 1         # $t6 = (m | (m - 1)) + 1
    div $t6, $t6, 3          # $t6 = ((m | (m - 1)) + 1) / 3
    mfhi $t7                 # Get remainder (destination peg)

    move $a0, $t5
    jal get_peg
    move $a1, $v0

    move $a0, $t7
    jal get_peg
    move $a2, $v0

    move $a0, $t2

    jal print_move


    addi $t1, $t1, 1
    addi $s0, $s0, 1

    j hanoi_loop

end_hanoi:
    li $v0, 10	# exit the program
    syscall

# TODO END
# Set the second breakpoint to measure cache performance and instruction count for the non-recursive method at the following line

# TODO: your functions here

print_move: 
    # Input:
    #    $a0: n
    #    $a1: source
    #    $a2: target
    # Uses:
    #    $s0: counter
    # Print "Step {counter}: move disk {n} from {source} to {target}"
    
    # Save $ra on stack
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    # Store $a0 as we will be overwriting it in calls to subroutines
    sw $a0, 4($sp)

    # Store n somewhere else since we still do need to print it
    move $t0, $a0

    # Print "Step "
    la $a0, Step
    jal printStr

    # Print counter
    move $a0, $s0
    jal printInt

    # Print ": move disk "
    la $a0, Colon
    jal printStr
    la $a0, Move
    jal printStr

    # Print disk number
    move $a0, $t0
    jal printInt

    # Print " from {source} to {target}\n"
    la $a0, From
    jal printStr
    move $a0, $a1
    jal printChar
    la $a0, To
    jal printStr
    move $a0, $a2
    jal printChar
    la $a0, Newline
    jal printStr

    # Restore $ra and return
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

count_trailing_zeros:
    li      $v0, 0              # Initialize the count to 0
    beqz    $a0, done           # If the input is zero, return 0
loop:
    andi    $t0, $a0, 1         # Check if the least significant bit is 0 (i.e., is $a0 even?)
    beqz    $t0, increment      # If it's even, proceed to increment the count
    j       done                # If it's odd, done
increment:
    addi    $v0, $v0, 1         # Increment the trailing zero count
    srl     $a0, $a0, 1         # Right shift $a0 by 1 (dividing by 2)
    j       loop                # Repeat the loop

done:
    # Return with the result in $v0
    addi $v0, $v0, 1
    jr      $ra

# Helper function to map integers 0, 1, 2 to 'A', 'B', 'C'
# Input:
#    $a0: integer (0, 1, or 2)
# Output:
#    $v0: character ('A', 'B', or 'C')
get_peg:
    # Compare the input with 0, 1, and 2 and set $v0 accordingly
    li      $t0, 0          # Load 0
    beq     $a0, $t0, peg_A # If $a0 == 0, jump to peg_A

    li      $t0, 1          # Load 1
    beq     $a0, $t0, peg_B # If $a0 == 1, jump to peg_B

    li      $t0, 2          # Load 2
    beq     $a0, $t0, peg_C # If $a0 == 2, jump to peg_C

    jr      $ra             # Return if not 0, 1, or 2 (shouldn't happen)

peg_A:
    li      $v0, 'A'        # Set $v0 to ASCII value of 'A'
    jr      $ra             # Return

peg_B:
    li      $v0, 'B'        # Set $v0 to ASCII value of 'B'
    jr      $ra             # Return

peg_C:
    li      $v0, 'C'        # Set $v0 to ASCII value of 'C'
    jr      $ra             # Return
# TODO END


########### Helper functions for IO ###########

# read an integer
# int readInt()
readInt:
	li $v0, 5
	syscall
	jr $ra
	
# print an integer
# printInt(int n)
printInt:
	li $v0, 1
	syscall
	jr $ra

# print a character
# printChar(char c)
printChar:
	li $v0, 11
	syscall
	jr $ra
	
# print a null-ended string
# printStr(char *s)
printStr:
	li $v0, 4
	syscall
	jr $ra
