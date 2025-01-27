.data
src:     .space 40             # Space for the source rod stack (10 integers)
aux:     .space 40             # Space for the auxiliary rod stack (10 integers)
dest:    .space 40             # Space for the destination rod stack (10 integers)
numDisks: .word 3              # Number of disks
topSrc:  .word -1              # Top pointer for the source stack
topAux:  .word -1              # Top pointer for the auxiliary stack
topDest: .word -1              # Top pointer for the destination stack

# Messages for printing moves
moveMsg: .asciiz "Move disk "

.text
.globl main

main:
    # Load the number of disks
    lw $t0, numDisks

    # Initialize source stack with disks in decreasing order
    li $t1, 1                 # Initialize disk number
init_src_stack:
    bgt $t1, $t0, setup_done  # Exit loop when disk number > numDisks
    jal push_src              # Push disk onto source rod
    addi $t1, $t1, 1          # Increment disk number
    j init_src_stack

setup_done:
    # Calculate the total number of moves: 2^numDisks - 1
    li $v0, 2                 # Prepare for exponentiation
    move $a0, $t0             # numDisks as exponent
    syscall                   # MIPS syscall for pow
    addi $v0, $v0, -1         # Subtract 1 for total number of moves

    # Main loop to execute the moves
    li $t2, 1                 # Initialize move counter
move_loop:
    bgt $t2, $v0, end_loop    # Exit loop after all moves

    # Determine which move to make based on i % 3
    rem $t3, $t2, 3           # $t3 = i % 3
    beq $t3, 1, move_src_dest
    beq $t3, 2, move_src_aux
    beq $t3, 0, move_aux_dest

    addi $t2, $t2, 1          # Increment move counter
    j move_loop

move_src_dest:
    jal move_disks_src_dest   # Call move function for src -> dest
    j move_loop

move_src_aux:
    jal move_disks_src_aux    # Call move function for src -> aux
    j move_loop

move_aux_dest:
    jal move_disks_aux_dest   # Call move function for aux -> dest
    j move_loop

end_loop:
    li $v0, 10                # Exit the program
    syscall

# Stack operations for each rod

# Push disk onto source rod
push_src:
    lw $t1, topSrc            # Load topSrc pointer
    addi $t1, $t1, 1          # Increment top pointer
    sw $t1, topSrc            # Update topSrc
    sll $t2, $t1, 2           # Calculate offset (top * 4)
    add $t3, $t2, $0          # Move disk number into $t3
    sw $t3, src($t2)          # Push disk onto src
    jr $ra                    # Return to caller

# Move disk from src to dest
move_disks_src_dest:
    jal pop_src               # Pop top of src
    move $a0, $v0             # Store popped disk in $a0
    jal push_dest             # Push disk onto dest
    move $a1, $a0             # Move disk to $a1 for printing
    li $v0, 4
    la $a0, moveMsg           # Print "Move disk "
    syscall
    li $v0, 1
    syscall                   # Print disk number
    jr $ra

# Pop disk from source rod
pop_src:
    lw $t1, topSrc            # Load topSrc pointer
    blez $t1, empty_stack     # Check if stack is empty
    sll $t2, $t1, 2           # Calculate offset (top * 4)
    lw $v0, src($t2)          # Pop top disk from src
    addi $t1, $t1, -1         # Decrement top pointer
    sw $t1, topSrc            # Update topSrc
    jr $ra

empty_stack:
    li $v0, -1                # Return -1 if stack is empty
    jr $ra
