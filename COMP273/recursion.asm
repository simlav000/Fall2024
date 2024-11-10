    # Now that we know about the stack, we can do a recursion.
    # The idea is to save the information about the function 
    # directly to the stack before calling the function again.
    # The following is an implementation of the classic factorial.

    .data
    .text
    .globl main

main:
    li $a0, 4
    jal factorial

    move $a0, $v0
    li $v0, 1
    syscall

    j exit


factorial:
    addi $sp, $sp, -8            # Make space on the stack for
    sw $ra, 4($sp)               # storing the caller's address
    sw $a0, 0($sp)               # and storing the argument (n)

    li $v0, 1
    beq $a0, $0, fact_end       # Base case: n = 1, n! = 1

    addi $a0, $a0, -1            # Next recursive call is on n - 1
    jal factorial

    lw $a0, 0($sp)
    mul $v0, $a0, $v0

fact_end:
    lw $ra, 4($sp)               # Get address (after recursion or caller)
    addi $sp, $sp, 8             # Prepare stack for next value

    jr $ra

exit:
    li $v0, 10
    syscall
