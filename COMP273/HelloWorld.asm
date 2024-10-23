# Hello World in MIPS Assembly
        .data #Data segment
msg:    .asciiz "Hello World!\n"

        .text
main:
        la $a0, msg # Load address of msg into register $a0
        li $v0, 4   # Tell the OS to use library 4 (print a string)
        syscall     # Call the library function

        li $v0, 10  # Library 10 (exit program)
        syscall     # Die