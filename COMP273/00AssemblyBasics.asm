; Assembly basics:

; Assembly Variables: Registers

; /------------------------------------------------------\
; | Register | Name   | Used for                         |
; |----------|--------|----------------------------------|
; | 0        | zero   | Always returns 0                 | *
; | 1        | at     | Reserved for use by assembler    | 
; | 2-3      | v0, v1 | Value returned by subroutine     | *
; | 4-7      | a0-a3  | First few params for subroutine  | *
; | 8-15     | t0-t7  | Temporary: Can use w/out saving  | *
; | 16-23    | s0-s7  | If used, must save on stack      | *
; | 24-25    | t8, t9 | Temporary: Can use w/out saving  | *
; | 26, 27   | k0, k1 | Used by interrupt / trap handler |
; | 28       | gp     | A global pointer                 |
; | 29       | sp     | Stack pointer                    |
; | 30       | s8/fp  | Frame pointer                    |
; | 31       | ra     | Subroutine return address        | *
; \------------------------------------------------------/
;   * Focusing on these

; Operations:

; /-----------------------------------------------------------------------\
; | Instruction             |  Example               |  Meaning           |
; |-------------------------|------------------------|--------------------|
; | load word               | lw    $s1, $s2         | $s1 = $s2          |
; | load constant           | li    $s1, 4           | $s1 = 4            |
; | load address            | la    $s1, $s2         | $s1 = &$s2         |
; | add                     | add   $s1, $s2, $s3    | $s1 = $s2 + $s3    |
; | subtract                | sub   $s1, $s2, $s3    | $s1 = $s2 - $s3    |
; | add immediate           | addi  $s1, $s2, 100    | $s1 = $s2 + 100    |
; | add unsigned            | addu  $s1, $s2, $s3    | $s1 = $s2 + $s3    |
; | subtract unsigned       | subu  $s1, $s2, $s3    | $s1 = $s2 - $s3    |
; | add immediate unsigned  | addiu $s1, $s2, 100    | $s1 = $s2 + 100    |
; | multiply                | mult  $s2, $s3         | Hi, Lo = $s2 * $s3 |
; | multiply unsigned       | multu $s2, $s3         | Hi, Lo = $s2 * $s3 |
; |                         |                        |                    |
; | divide                  | div   $s2, $s3         | Lo = $s2 / $ s3    |
; |                         |                        | Hi = $s2 mod $s3   |
; |                         |                        |                    |
; | divide unsigned         | divu  $s2, $s3         | Lo = $s2 / $ s3    |
; |                         |                        | Hi = $s2 mod $s3   |
; | move from Hi            | mfhi  $s1              | $s1 = Hi           |
; | move from Lo            | mflo  $s1              | $s1 = Lo           |
; \-----------------------------------------------------------------------/
;    * There is no subi, just do addi $s0 $s1 -10 instead

; Setting variables

; load-immediate the constant 4 into $s1
li $s1 4
; li takes two clock cycles to executej

; We can use the zero register to store in $t1 the result of 0 + $t2.
add $t1, $0, $t2 
; This effectively loads the contents of $t2 into $t1 in one clock cycle

; We can also use the zero register to negate a number
sub $t1, $0, $t2
; Alternatively, we can use NOR to negate a number
nor $5 $5 $0
; Note that the ALU doesn't have the "NOT" operation, but the "NOR" operation
; can be used for such purposes.
; MIPS assembly provides NOT pseudo-instruction, but the assembler will convert
; it to the true NOR with $0 instruction

; Data Transfer Instructions
; MIPS arithmetic instructions only operate on registers
; We use data transfer instructions to transfer data between registers and 
; memory. We need to specify:
    ; Register: (0 - 31)
    ; Memory address: more difficult

; Memory Addresses
; Memory is a linear array of bytes
; Each byte in the memory has its own unique address.
; We can access the content by supplying the address.
; The processor can read or write the content of the memory;

; Memory Address Syntax: Offset(AddReg)
; AddrReg: A register which contains a pointer to a memory location
; Offset: A numerical offset in bytes (optional)
; e.g.:
8 ($t0) 
; Specifies the memory address 8 bytes away from $t0
; Can use this for modelling an array

; Say we have some C-style array as follows:
; int arr[8] = {56, 26, 88, 45, -45, 77, 98, 13}

; Assuming $s0 has address 0x1000

0 ($s0) # 0x1000, to access arr[0]
4 ($s0) # 0x1004, to access arr[1]

# Data Transfer: From Memory to Register
# Load instruction syntax: lw DstReg, Offset(AddrReg)
    # lw: Load a Word

# e.g:
lw $t0, 8($s0)
# load one word from memory at address stored 8 bytes away and store it in $t0

# Store instruction syntax: sw DataReg, Offset(AddrReg)
    # sw: Store a Word

# e.g.:
sw $t0, 4($s0)
# store one word (32 bits) to memory address $s0 + 4 (arr[1])

# Say we want to do A[12] = h + A[8];
# Assuming h is stored in $s0 and the base address of A is in $s1
lw $s2, 32($s1)   # Load A[8] into $s2
add $s3, $s0, $s2 # $s3 = $s0 + $s2
sw $s3, 48($s1)   # Store result in A[12]


