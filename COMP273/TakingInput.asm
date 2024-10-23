        .data
prompt:  .asciiz "Enter a number\n"
message: .asciiz "The number is: "

buffer: .space 500       # Reserve 500 bytes for input string

        .text
        .globl main

main:
	# Display prompt message
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Take user input
        li $v0, 8        # System call for reading a string
        la $a0, buffer   # Load address of buffer
        li $a1, 500      # Maximum number of bytes to read
        syscall

        li $v0, 4        # System call for printing a string
        la $a0, buffer   # Load the address of the buffer again
        syscall
