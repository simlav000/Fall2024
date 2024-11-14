    .data
Step:    .asciiz "Step "
Colon:   .asciiz ": "
Move:    .asciiz "move disk "
From:    .asciiz " from "
To:      .asciiz " to "

move_buffer: .space 100       # Allocate space for concatenation
temp_char:   .space 1         # Temporary space for a single character

    .text
    .globl main

main:
    li $s0, 1
    jal print_move


    # Exit program
    li $v0, 10
    syscall

print_move: 
    # Inputs:
    #    $a0 == n
    #    $a1 == source
    #    $a2 == target
    #    $a3 == Mover name
    # Uses:
    #    $s0 == counter
    # Prints:
    # Step {counter}: move disk {n} from {source} to {target}

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    la $s1, move_buffer      # Initialize $s1 to start of move_buffer

    # Concat "Step "
    la $a0, Step
    jal concat_string


    # Concat current step number
    lw $a0, $s0
    jal int_to_string
    la $a0, temp_char
    jal concat_string

    # Concat ": "
    la $a0, Colon
    jal concat_string

    # Concatenate "move disk "
    la $a0, Move
    jal concat_string

    # Convert integer (disk number) to string and concatenate
    lw $a0, 1                # Disk number 1
    jal int_to_string
    la $a0, temp_char        # Point to the single character result
    jal concat_string

    # Concatenate " from "
    la $a0, From
    jal concat_string

    li $t0, 'A'
    sb $t0, temp_char
    la $a0, temp_char
    jal concat_string

    la $a0, To
    jal concat_string

    li $t0, 'B'
    sb $t0, temp_char
    la $a0, temp_char
    jal concat_string

    li $t0 '\n'
    sb $t0, temp_char
    la $a0 temp_char
    jal concat_string

    # Print the result
    la $a0, move_buffer
    jal print_string

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


# Convert integer (1-15) into a single-character string
# Stores the character in temp_char and returns
int_to_string:
    li $t1, 10
    la $v0, temp_char         # Set $v0 to address of temp_char

    # Check if 0-9
    blt $a0, $t1, convert_to_digit

    # If 10-15, convert to 'A'-'F'
    addi $t2, $a0, 55         # ASCII A = 65, so 10 + 55 = 'A'
    j store_hex_char

convert_to_digit:
    addi $t2, $a0, 48         # Convert to ASCII '0'-'9'

store_hex_char:
    sb $t2, 0($v0)            # Store single character in temp_char
    jr $ra                     # Return

# Concatenate string pointed to by $a0 into move_buffer
# Maintains $s1 as current end of move_buffer
concat_string:
concat_loop:
    lb $t1, 0($a0)            # Load a byte from source string
    beq $t1, $zero, concat_done # Stop at null terminator
    sb $t1, 0($s1)            # Store the byte in move_buffer
    addi $a0, $a0, 1          # Move to next byte in source
    addi $s1, $s1, 1          # Move to next position in buffer
    j concat_loop

concat_done:
    jr $ra                    # Return to caller

# Print the concatenated string in move_buffer
print_string:
    li $v0, 4                 # Syscall for print string
    syscall
    jr $ra                    # Return to caller
