# Author: Simon Lavoie (simon.lavoie@mail.mcgill.ca)
# Student Id: 261 051 325

        .data
menu:   .asciiz "Commands (encrypt, decrypt, CommonChar, quit): "
emsg:   .asciiz "Enter text to encrypt (upper case letters only and maximum of 500 characters): "
dmsg:   .asciiz "Enter text to decrypt (upper case letters only and maximum of 500 characters): "
cmsg:   .asciiz "Enter text (upper case letters only): "
keymsg: .asciiz "Enter key (upper case letters only and maximum of 50 characters): "
ncrypt: .asciiz "Encrypted text: "
dcrypt: .asciiz "Decrypted text: "

# For counting the most common character
letter_counts: .space 104       # 26 letters * 4 bytes = 104 bytes

input:  .space 500       # Reserve 500 bytes for input string
key:    .space 50        # Reserve 50 bytes for input key
        .text
        .globl main

main:
	# Display prompt message
	li $v0, 4
	la $a0, menu 
	syscall

        # Read single character (e, d, q)
        li $v0, 12
        syscall

        # Move character to $t0
        move $t0, $v0
	
        # Print newline
        li $v0, 11
        la $a0, 10
        syscall

        # Process input
        li $t1 'e'
        li $t2 'd'
        li $t3 'q'
        li $t4 'c'

        beq $t0, $t3, quit
        beq $t0, $t1, encrypt
        beq $t0, $t2, decrypt
        beq $t0, $t4, commonchar

        j main

encrypt:
        # Print "Enter text to encrypt
        li $v0 4
        la $a0, emsg
        syscall

        # We save permanently in $s0 the address of the encrypt label
        # so that we know whether to encrypt, decrypt or count
        # the message. $s0 will basically be an address to the
        # encrypt/decrypt/countchar label used for branching.
        la $s0, encrypt

        # The subsequent taking input text and input key is general
        # to encrypt or decrypt so we jump to a subroutine which does
        # this for both cases. 
        jal get_input

        # Print "Encrypted text: "
        li $v0, 4
        la $a0, ncrypt
        syscall

        j loopstring

decrypt:
        # Print "Enter text to decrypt"
        li $v0, 4
        la $a0, dmsg
        syscall

        # Same as in encrypt, we save in $s0 the address of the
        # decrypt label to know to negate the key before applying it.
        la $s0, decrypt

        jal get_input

        # Print "Decrypted text: "
        li $v0 4
        la $a0 dcrypt
        syscall

        j loopstring

commonchar:
        # Print "Enter text: "
        li $v0, 4
        la $a0, cmsg
        syscall

        # This method does not require a key so we just take input here
        li $v0, 8
        la $a0, input
        li $a1, 500
        syscall

        move $t0, $a0       # Store address of input text in $t0

        # Store address of commonchar label to know not to encrypt/decrypt.
        la $s0, commonchar

        j loopstring

get_input:
	# Take user input
        li $v0, 8           # System call for reading a string
        la $a0, input       # Load address of input
        li $a1, 500         # Maximum number of bytes to read
        syscall

        move $t0, $a0       # Store address of input text in $t0

        # Print "Enter key: " 
        li $v0 4
        la $a0, keymsg
        syscall

        # Take in key input
        li $v0, 8
        la $a0, key
        li $a1, 50
        syscall

        move $t1, $a0       # Store address of key in $t1

        jr $ra

loopstring:
        # At this point:
        # $s0 : encrypt/decrypt/countchar label used as a three-state boolean
        # $t0 : Text to encrypt/decrypt/count
        # $t1 : Key (If encrypt/decrypt)
        # $t3 will be used to store the characters of the input as we iterate
        # $t4 will be used to hold the current character of the key
        # $t5 will be used to hold the current index within the key

        li $t5, 0           # Initialize index = 0

next_char:
        lb $t3, 0($t0)      # Load character from input text
        beqz $t3, end       # Loop until null character is found


        sub $t3, $t3, 'A'   # Convert input char to 0-25 range (A=0, ..., Z=25)

        # If $s0 stores commonchar address, skip the encryption/decryption
        # process and jump to counting the current character.
        la $t6, commonchar
        beq $s0, $t6, countchar

        # Compute address of the current key character
        add $t6, $t1, $t5
        lb $t4, 0($t6)      # Load character from key

        sub $t4, $t4, 'A'   # Convert key to 0-25 range as well

        # If key has invalid character (newline / null-terminator)
        # We reset it by setting index to zero
        move $a0, $t4
        la $a1, reset_key
        jal check_range

        # If input character is out of range 0-25, it was space or punctuation.
        # print it and move on to the next character.
        move $a0, $t3
        la $a1, justprint
        jal check_range

        # If $s0 stores the decrypt address, we know to decrypt so jump
        # to the code that negates the key before we actually apply it
        la $t6, decrypt
        beq $s0, $t6, negate_key

apply_key:
        # Add key offset for encryption, key is negative if decrypting
        add $t3, $t3, $t4   # Apply key to input char

        # Handle case where result is negative when decrypting
        blt $t3, $0, fix_negative

print_result:
        rem $t3, $t3, 26    # Loop back mod 26
        add $t3, $t3, 'A'   # Convert back to ASCII

        # Print character
        li   $v0, 11
        move $a0, $t3
        syscall

        # Move to next character in the input text
        addi $t0, $t0, 1

        # Update key index
        addi $t5, $t5, 1

        j next_char

continue:
        addi $t0, $t0, 1
        j next_char

justprint:
        # Used for when spaces or punctuation appear. Print the 
        # character and increment the character as well as key index.

        addi $t3, $t3, 'A'   # Convert back to ASCII

        # Print the character without applying key
        li $v0, 11
        move $a0, $t3
        syscall

        addi $t0, $t0, 1     # Update input text index
        addi $t5, $t5, 1     # Update key index

        j next_char

reset_key:
        # Set key index back to zero
        li $t5, 0
        j next_char

negate_key:
        # If we are decrypting, simply negate the key
        # to subtract the offset instead of adding it
        sub $t4, $0, $t4
        j apply_key

fix_negative:
        # In the case where subtracting the key value
        # leads to a negative result, loop back mod 26
        addi $t3, $t3, 26
        j print_result

countchar:
        # $t0 contains entire input
        # $t1 contains key (not used so can be overwritten)
        # $s0 contains label of encrypt/decrypt/count, can't be overwritten
        # $t3 contains current character in int representation (0-25 range)
        # $t4 - $t6 will be used as temp registers to move data around
        # $t7 contains most frequent character thus far

        # No need to count characters outside (0-25) range
        la $a1, continue
        move $a0, $t3
        jal check_range

        # Left-shift twice to multiply by 4 to get address of index $t3
        sll $t3, $t3, 2

        # Load address of count array
        la $t1, letter_counts
        add $t5, $t1, $t3    # Get address of letter_counts[i]

        lw $t4, 0($t5)       # Load the current value at letter_counts[$t3] into $t4
        addi $t4, $t4, 1     # Increment the value by 1
        sw $t4, 0($t5)       # Store the updated value back at letter_counts[$t3]

        # Move to next character in the input text
        addi $t0, $t0, 1

        j next_char


check_range:
        # Don't count characters outside (0-25) range. Either print them
        # (in decrypt/encrypt) case or skip them.
        # $a0: Character to test
        # $a1: Address to return to (Either justprint/continue)
        blt $a0, 0, out_of_range
        bgt $a0, 25, out_of_range

        jr $ra

out_of_range:
        jr $a1

end:
        # If we are doing commonchar operation, jump to findhighest
        # After having loaded index i = 0 to begin looping.
        li $t0, 0             # To store current max
        li $t3, 0             # To store index in array
        la $t1, letter_counts # Array of character counts ([0, ..., 0])
        la $t6, commonchar
        beq $s0, $t6, findhighest

        # Print newline character after encrypted/decrypted text
        li $v0, 11
        la $a0, 10
        syscall

        j main

findhighest:
        add $t5, $t1, $t3

        lw $t4, 0($t5)

        # If $t3 indexes letter at array[26], out of bounds
        bgt $t3, 100, printcount
        bgt $t4, $t0, newmax

        # Otherwise
        addi $t3, $t3, 4
        j findhighest

newmax:
        # Swap $t0 with the new highest count, $t7 with character index
        move $t0, $t4
        move $t7, $t3

        # Increment index
        addi $t3, $t3, 4
        j findhighest

printcount:
        # Convert $t7 from index in array to character
        srl $t7, $t7, 2        # Right-shift 2 bits (divide by 4)
        addi $t7, $t7, 'A'     # Convert back to ASCII

        li $v0, 11
        move $a0, $t7
        syscall

        la $a0, 10
        syscall

        jal reset_counts

        j main

reset_counts:
        # Reset letter counts for new input.
        li $t0, 0             # Initialize index to 0
        la $t1, letter_counts # Load base address of letter_counts

reset_loop:
        bge  $t0, 26, reset_end  # Loop through 26 characters (A-Z)
        sw   $0, 0($t1)      # Store 0 in the current index
        addi $t1, $t1, 4      # Move to the next element (4 bytes for each int)
        addi $t0, $t0, 1      # Increment index
        j reset_loop

reset_end:
        jr $ra

quit:
        li $v0, 10
        syscall
