############ COMP 273, Fall 2024, Assignment 4, Tower of Hanoi - non-recursive ###########
# Student ID: 261 051 325
# Name: Simon Lavoie

.data
AlgorithmType:	.word 0		# TODO: Which Algorithm to run!
				# 0 Recursive
				# 1 Non-recursive
	
# TODO: add any variables here you if you need

# TODO END
.text

main:
    # read the integer n from the standard input
	jal readInt
	# now $v0 contains the number of disk n
    # check for which algorithm is set to use: Recursive or non-recursive.
    la $t0 AlgorithmType
	lw $t0 ($t0)
	beq $t0 0 TOH_Recursive
	beq $t0 1 TOH_Nonrecursive

    # exit if the algorithm number is out of range
	li $v0 10 
    syscall	

TOH_Recursive:
# TODO:
#       Use a recursive algorithm described in the assignment document to print the solution steps. Make sure you follow the output format.
# Set the first breakpoint to measure cache performance and instruction count for the recursive method at the first instruction of this label




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
