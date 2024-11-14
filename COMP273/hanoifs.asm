    .data

# Save a buffer to concatenate the above strings into to print the move
move_buffer .space 100

    .text
    .globl main

    # Observations:
    # Disk n is always being moved, always have access to disk number.
    # First delegating task is always Charlie's
    # Second delegating task is always Bob's
    # Base case task is always Alice's



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

