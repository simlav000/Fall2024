        .data
menu:   .asciiz "Commands (encrypt, decrypt, quit): "
msg:    .asciiz "Enter text to encrypt (upper case letters only and maximum of 500 characters): "
keymsg: .asciiz "Enter key (upper case letters only and maximum of 50 characters): "
ncrypt: .asciiz "Encrypted text: "
dcrypt: .asciiz "Decrypted text: "

input:  .space 500       # Reserve 500 bytes for input string
key:    .space 50        # Reserve 50 bytes for input key
        .text
        .globl main

main:
	# Display prompt message
	li $v0, 4
	la $a0, menu 
	syscall

        # Read single character
        li $v0, 12
        syscall

        # Move character to $t0
        move $t0, $v0
	
        # Process input
        li $t1 'e'
        li $t2 'd'
        li $t3 'q'

        # quit if $t0 == q
        beq $t0, $t3, quit
        beq $t0, $t1, encrypt
        beq $t0, $t2, decrypt



        li $s1, 0           # Initialize index to zero 
        j main


getinput:
        # Print "Enter text to encrpt
        li $v0 4
        la $a0, msg
        syscall

	# Take user input
        li $v0, 8           # System call for reading a string
        la $a0, input       # Load address of input
        li $a1, 500         # Maximum number of bytes to read
        syscall

getkey:
        # Print "Enter text to decypt
        li $v0, 8
        la $a0, key
        li $a1, 50
        syscall

encrypt:
        # Print "Encrypted text: "
        li $v0 4
        la $a0 ncrypt
        syscall

        # Print input text
        la $a0 input
        syscall

        j main

decrypt:
        # Print "Decrypted text: "
        li $v0 4
        la $a0 dcrypt
        syscall

        # Print input text
        la $a0 input
        syscall

        j main

loopstring:
        lb $t1, 0($t0)      # buffer[0]
        beq $t1, 10, quit

        # Print character
        li   $v0, 11        # System call for printing a character
        move $a0, $t1       # Move the character to $a0
        syscall
        li   $a0, 10        # Newline character
        syscall

        addi $t0, $t0, 1
        j loopstring

quit:
        li $v0, 10
        syscall
