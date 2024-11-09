#########################
# Functions in Assembly #
#########################

# As we have seen, we can add labels to blocks of code to support jumping to
# this block. In Assembly, we call functions "subroutines", and we perform
# execution of functions by using the "jal" and "jr" operations.

    .data
hw:   .asciiz "Hello World!"
gw:  .asciiz "Goodbye World!"

    .text
    .globl main

main:
    # Load address of hw into $a0 (Argument register)
    # We have access to four $a registers {$a0, $a1, $a2, $a3}
    # If a function should return something, it should use the two $v registers
    # {$v0, $v1}
    la $a0, hw

    # jal (jump and link): Links the address of the next line into the $ra 
    # register. Allows us to print_string and continue from there.
    jal print_string

    # If four arguments is not enough for our function, we can use the stack.
    # If a subroutine (like print_string) needs to jump to some other subroutine
    # using jal, then the $ra would be overwritten. In such a case, we would
    # also use the stack.

    #################
    # Memory Layout #
    #################

    # 0x00000000
    #     |     /-----------\
    #     |     |   text    | -> Where instructions are stored (.text)
    #     |     |-----------|
    #     |     |   data    | -> Statically allocated variables (.data)
    #     v     |-----------|
    #           |   heap    | -> Dynamically declared variables (malloc(), new)
    #           |-----------|
    #           |           |
    #           |   free    |
    #           |   space   |
    #           |           |
    #     ^     |-----------|
    #     |     |   stack   | -> Space for local variables in registers & 
    #     |     \-----------/    procedure calls
    # 0xffffffff

    # * This is only for demonstraction that shows that the stack base is at the 
    #   largest memory address available for user programs. However, in reality,
    #   the base of the stack is at a (fixed) MIPS address 0x7fffffff which is the 
    #   last location in the part of user memory. The remaining memory space is 
    #   reserved for the kernel.

    # Unlike the heap, which grows in no particular order, the stack is 
    # organized from "bottom" (largest memory address 0x7fffffff) to "top"
    # (smaller addresses).

    # The stack is used to support subroutines. The $sp ($29) register is 
    # the dedicated "Stack Pointer", which points to the top of the stack.
    # The elements on the stack are words.

    # Pushing to the stack:
    # To push to the stack, know that $sp is pointing to the current top.
    # We must manually move the stack pointer to the next free space (having
    # smaller address). Thus, we do:

    addi $sp, $sp, -4 # Move stack pointer up

    # Then, say we want to store the variable 4 on the stack
    li $s0, 4         # Load the integer 4 into $s0
    sw $s0, 0($sp)    # Store the contents of $s0 at the top of the stack.

    # We can pop from the stack by simply doing the opposite
    lw $s0, 0($sp)    # Load word stored at top of stack
    addi $sp, $sp, 4  # Move stack pointer back down


    ################
    # Nested Calls #
    ################

    # If you are writing a subroutine that relies on yet another subroutine,
    # we should try to uphold the following convention:
    #    - Before you jump (jal), push the current contents of $ra on the stack
    #      (Save the address of the first subroutine's caller.)
    #    - Once the secondary subroutine is finished, pop the return address
    #      you just stored on the stack into $ra before you jump back (jr).


    #************************#
    #* Register Conventions *#
    #************************#

    ###################
    # Saved Registers #
    ###################

    # Each of the $s0, $s1, ... registers are meant to be saved across
    # subroutine calls. If you absolutely must used them in a subroutine,
    # ensure that they are restored to their previous state before returning.
    # This can be done by pushing their current contents onto the stack before
    # using them, then popping the contents of the stack back off into them
    # before returning.

    # * Similarly, the $sp stack pointer ought to be pointing to the same
    #   item once the subroutine is finished. The same goes for $ra, until
    #   the next jal call.

    #######################
    # Temporary Registers #
    #######################

    # Each of the $t0, $t1, ... registers are temporary, and thus are not 
    # guaranteed to be left in their original state when calling a subroutine.
    # As the caller, if you want to save your temporary registers, you should
    # push their contents onto the stack yourself and retrieve them after the 
    # subroutine, as subroutines ought to return with the stack in its 
    # original state.

    # * Similarly, the $a0-$a3 and $v0-$v1 registers are not necessarily
    #   preserved across subroutines.


    # For an example that uses most of what we have learned, consider the 
    # problem of needing a function which takes an arbitrary number of inputs
    # and adds them together. We do not have enough of the four argument 
    # registers ($a0-$a3) so we must use the stack. We would design our
    # subroutine such that the last argument pushed onto the stack is the
    # number of arguments the subroutine must process.

    # Want to compute 3 + 2 + 1
    li $t0, 3
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    li $t0, 2
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    li $t0, 1
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    # Lastly, push number of arguments for sum_n to process
    li $t0, 3
    addi $sp, $sp, -4
    sw $t0, 0($sp)

    jal sum_n

    # Exit program
    la $a0, gw
    jal print_string
    li $v0, 10
    syscall


sum_n:
    lw $t0, 0($sp)    # Load the number of arguments we need to sum over
    addi $sp, $sp, 4  # Move the stack pointer down to the next argument

    li $t1, 0         # Initialize total sum

    sum_loop:
        beqz $t0, sum_done  # If n == 0, done.
        subi $t0, $t0, 1    # Decrement n otherwise.
        lw $t2, 0($sp)      # Load next argument
        addi $sp, $sp, 4    # Adjust stack pointer
        add $t1, $t1, $t2   # Add to the total
        j sum_loop

    sum_done:
        move $a0, $t1
        jal print_int

print_int:
    # To use print_int it is assumed the user moved their int into $a0
    li $v0, 1
    syscall

    jr $ra

print_string:
    # Print the contents of $a0, assuming $a0 is a string.
    move $t0, $a0     # Take the argument $a0 and store it in $t0
	li $v0, 4
	move $a0, $t0     # Use $a0 as argument to the printing syscall
	syscall

    # jr (jump register): Jump to address stored in register
    # $ra (return address): Links to the line that issued the 
    # last "jal" command. Allows us to jump back to caller.
    jr $ra

