####################################################
# Conditional Statemements in High-Level Languages #
####################################################

################
# if-else in C #
################

# if (condition) clause;
# if (condition) {
#   clause1;
# }
# else {
#   clause2
# }

# Can rewrite this with "goto"
#   if (condition) goto L1;
#   clause2
#   goto L2
# L1: clause1
# l2:

################################
# Conditional Branches in MIPS #
################################

# Branch if EQual: beq reg1, reg2, label
beq $s1 $s2 label; go to label if $s1 == $s2

# Branch if Not Equal: bne reg1, reg2, label
bne $s1 $s2 label; go to label if $s1 != $s2

########################
# Unconditional Branch #
########################

# Jump instructions: Jump directly to label (like goto)
j label

# Example:
# if (i == j) {
#   f = g + h;
# } else {
#   f = g - h;
# }

# Assuming $s1 stores i, $s2 stores j, $s3 stores g and $s4 stores h
# Let $s5 be f
    beq $s1, $s2, True
    sub $s5, $s3, $s4
    j Exit
True: add $s5, $s3, $s4
Exit: 

###########################
# Switch Statement in HLL #
###########################

# switch (k) {
#   case 0: f = i+j; break;
#   case 1: f = g+h; break;
#   case 2: f = g-h; break;
#   case 3: f = i-j; break;
#}

# These can be rewritten as if-else
# if      (k == 0) f = i+j;
# else if (k == 1) f = g+h;
# else if (k == 2) f = g-h;
# else if (k == 3) f = i-j;

# So we know how to do it in assembly

    bne $s5, $0 L1       ; if k != 0, branch to L1
    add $s0, $s3, $s4    ; if k == 0, f = i + j
    j Exit               
L1: addi $t0, $s5, -1    ; Set $t0 = k - 1
    bne $t0, $0, L2      ; if k != 0 (i.e. if k was not 1), branch to L2
    add $s0, $s1, $s3    ; if k was 1, (now 0), f = g + h
    j Exit
L2: addi $t0, $s5, -2    ; and so on
    bne $t0, $0, L3
    sub $s0, $s1, $s2
    j Exit
L3: addi $t0, $s5, -3
    bne $t0, $0, Exit'
    sub $s0, $s3, $s4
Exit:

#########
# Loops #
#########

# Loops, at the end of the day, boil down to keeping track of some condition,
# and repeating some body until the condition is no longer met. The condition
# must terminate, and it tends to be something along the lines of something
# slowly approaching equality with some held value.

# Consider C's do-while loop which executes the body once, tests some condition,
# and continues executing the body until the condition is no longer met.

# do {
#   sum = sum + i;
#   i = i + 1;
# } while ( i != N );

# This can be rewritten using goto in C
# Loop: sum = sum + i;
#       i = i + 1;
# if (i != N )
#   goto Loop;

Loop: add  $s3, $s3, $s1   ; sum = sum + i
      addi $s1, $s1, 1     ; i = i + 1
      bne  $s1, $s2, Loop  ; Loop back around if i != N


################
# Inequalities #
################

# Syntax:
    slt reg1, reg2, reg3
    ; Compares reg2 and reg3
    ; place the result {0, 1} in reg1
    ; Does this by subtracting reg3 from reg2 and testing the sign of the result
    ; Comes from "Set on Less Than (SLT)" from ALU

# Four combinations of slt and beq/bne for {>, <, =>. <=}
    # Less than (<):
    slt $t0, $s0, $s1  ; if $s0 < $s1, $t0 = 1
    bne $t0, $0,  Less ; if $t0 != 0 then we know it's less

    # Greater than or equal to (>=):
    slt $t0, $s0, $s1  ; if $s0 < $s1, $t0 = 1
    beq $t0, $0,  Geq  ; if $t0 == 0, then it's greater than or equal

    # Greater than (>):
    slt $t0, $s1, $s0  ; if $s1 < $s0, $t0 = 1
    bne $t1, $0,  Gtr  ; if $t0 != 0 then greater (swapped less version)

    # Less than or equal to (>=):
    slt $t0, $s1, $s0  ; if $s1 < $s0, $t0 = 1
    beq $t0, $0,  Geq  ; if $t0 == 0, then it's less than or equal

    # Thankfully, MARS translates pseudo-instructions into MIPS instructions
    blt ; branch less than
    bgt ; branch greater than
    ble ; branch less than or equal
    bge ; branch greater than or euqal

##############################
# Immediates in Inequalities #
##############################

# Syntax:
    slti  result source immediate
    sltiu result source immediate
    # Result = 1 if source < immediate, 0 otherwise
    # Immediate version of slt

