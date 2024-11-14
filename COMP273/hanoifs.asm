    .data
Alice:   .asciiz "Alice "
Bob:     .asciiz "Bob "
Charlie: .asciiz "Charlie "
Moved:   .asciiz "moved disk "
From:    .asciiz " from "
To:      .asciiz " to "

# Save a buffer to concatenate the above strings into to print the move
move_buffer .space 100

    .text
    .globl main

    # Observations:
    # Disk n is always being moved, always have access to disk number.
    # First delegating task is always Charlie's
    # Second delegating task is always Bob's
    # Base case task is always Alice's

main:
    jal hanoi_rec


    # Hanoi function has inputs:
    # n: number of disks on the tower
    # source: Peg on which all disks start
    # target: Desired location to move all disks
    # auxiliary: Some third peg
hanoi_rec:
    # Always save 4 arguments and $ra
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)    # $a0 == n
    sw $a1, 8($sp)    # $a1 == source
    sw $a2, 12($sp)   # $a2 == target
    sw $a3, 16($sp)   # $a3 == aux

    li $t0, 1
    bne $a0, $t0, delegate

    # Here we actually move disk from source to target
    # Save aux and use $a3 to store Alice's name (her turn to move disk) 
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a3, 4($sp)
    la $a3, Alice
    jal concat_string




delegate:
    subi $a0, $a0, 1
    jal hanoi_rec


print_move:


concat_string:
    la $t0, move_buffer
    # Copy each character into the move_buffer
concat_loop:
    # Load mover's name into $t1
    lb $t1, 0($a3)
    beq $t1, $0, concat_done
    sb $t1, 0($t0)
    addi $a3, $a3, 1
    addi $t0, $t0, 1
    j concat_loop

