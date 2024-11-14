############ COMP 273, Fall 2024, Assignment 4, Tower of Hanoi - non-recursive ###########
# Student ID: 261 051 325
# Name: Simon Lavoie

    .data
Step:          .asciiz "Step "
Colon:         .asciiz ": "
Move:         .asciiz "move disk "
From:          .asciiz " from "
To:            .asciiz " to "
Newline:       .asciiz "\n"
AlgorithmType: .word 0
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

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    addi $sp, $sp, 20

    jr $ra




delegate:
    subi $a0, $a0, 1

    # Temp to store target
    move $t0, $a2

    # target becomes auxiliary
    move $a2, $a3

    # auxiliary becomes target
    move $a3, $t0

    # MOVE(n-1, source, aux, target)
    jal TOH_Recursive

    # Actually move disk
    jal print_move

    # Temp to store target
    move $t0, $a3

    # third argument becomes source
    move $a3, $a1

    # first argument becomes aux
    move $a1, $a2

    # second argument becomes target
    move $a2, $t0

    # MOVE(n-1, aux, target, source)
    jal TOH_Recursive



# TODO END
# Set the second breakpoint to measure cache performance and instruction count for the recursive method at the following line

li $v0, 10	# exit the program
syscall


TOH_Nonrecursive:
# TODO: Use a non-recursive algorithm to print the solution steps. Make sure you follow the output format.
# Set the first breakpoint to measure cache performance and instruction count for the non-recursive method at the first instruction of this label




# TODO END
# Set the second breakpoint to measure cache performance and instruction count for the non-recursive method at the following line
li $v0, 10	# exit the program
syscall




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
