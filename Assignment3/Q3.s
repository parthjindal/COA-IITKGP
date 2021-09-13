# Program to Compute an Array A of GP Series with initial value a and common ratio r, Print the array and take the transpose of the array
# Author: Parth Jindal, Pranav Rajput
# Date: 14/09/2021
# Assignment: Lab-3
#-------------------------------------------------------------------------------
	.globl  main

	.data

# program output text constants
prompt1:
	.asciiz "Enter four positive integers m, n, a and r: \n"
prompt2:
    .asciiz "Array A (GP) with initial value a and common ratio r:\n"
prompt3:
	.asciiz "Transpose of Matrix A: \n"
newline:
    .asciiz "\n"
space:
    .asciiz " "
    .text

    .globl  main

main:
    move $s0 $ra    # save return address to push later after initializing stack frame
    jal initStack   # initialize stack

    move $a0 $s0    # $a0 = $ra
    jal pushToStack # push ra to stack

    li $v0, 4           
    la $a0, prompt1 # print prompt1
    syscall

    li $v0, 5
    syscall         # read m 
    move $a0 $v0    # save m in $a0
    jal pushToStack # push m onto stack

    li $v0, 5       # read n
    syscall        
    move $a0 $v0    # save n in $a1
    jal pushToStack # push n onto stack

    li $v0, 5       # read a
    syscall
    move $a0 $v0    # save a in $a2
    jal pushToStack # push a onto stack

    li $v0, 5       # read r
    syscall
    move $a0 $v0    # save r in $a3
    jal pushToStack # push r onto stack
    

    # compute product of m and n
    lw $t0, -8($fp)     # m
    lw $t1, -12($fp)    # n
    mult $t0, $t1 
    mflo $t0            # store product in $t0 = m * n

    move $a0, $t0       # save product in $a0 call mallocInStack
    jal mallocInStack 
    move $s0 $v0        # save address of array A in $s0

    # fill array in row major fashion with a geometric progression of 
    # initial value a and common ratio r
    lw $t0, -8($fp)     # m
    lw $t1, -12($fp)    # n
    mult $t0, $t1       # compute product of m and n
    mflo $t0

    li $t2, 0           # i = 0 (iterator
    lw $t3, -16($fp)    # $t3 = a
    lw $t4, -20($fp)    # $t4 = r

# loop to fill array in row major fashion with a geometric progression of 
# initial value a and common ratio r
for:
    beq $t2, $t0, end # if i == m * n, break
    sll $t1, $t2, 2   # i * 4
    sub $t5, $s0, $t1 # $t5 = address of array[i] 
    sw $t3, 0($t5)    # array[i] = a*r^i
    mult $t3, $t4     # a * r
    mflo $t3          # a = a * r
    addi $t2, $t2, 1  # i = i + 1
    j for
# end loop
end: 
    li $v0, 4         
    la $a0, prompt2 # print prompt2
    syscall

    lw $a0, -8($fp)     # m
    lw $a1, -12($fp)    # n
    move $a2, $s0       # base address of array
    jal printMatrix     # print matrix

    lw $t0, -8($fp)     # m
    lw $t1, -12($fp)    # n
    mult $t0, $t1       # compute product of m and n
    mflo $t0            

    move $a0, $t0       # save product n * m in $a0 call mallocInStack
    jal mallocInStack   # allocate memory for transpose array
    move $s1 $v0        # save address of transpose array B in $s1

    # transpose of matrix
    lw $a0 , -8($fp)    # m
    lw $a1, -12($fp)    # n
    move $a2, $s0       # base address of array A
    move $a3, $s1       # base address of transpose array B
    jal transposeMatrix # transpose matrix A and store in B

    li $v0, 4          
    la $a0 newline      # print newline
    syscall

    li $v0, 4
    la $a0, prompt3    # print prompt3
    syscall

    lw $a0, -12($fp)    # n
    lw $a1, -8($fp)     # m
    move $a2, $s1       # base address of array B
    jal printMatrix     # print matrix B

    lw $ra, -4($fp)     # restore ra
    move $sp, $fp       # restore stack pointer
    lw $fp,  0($sp)     # restore frame pointer
    addi $sp, 4         # pop return address
    jr $ra              # return

initStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $fp 0($sp)       # save frame pointer
    move $fp $sp        # set frame pointer to stack pointer
    jr $ra              # return

pushToStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $a0, 0($sp)      # push a0 onto stack
    jr $ra              # return

mallocInStack:
    sll $t0, $a0, 2     # $t0 = 4 * $a0
    move $v0  $sp       # $v0 = $sp
    sub $sp, $sp, $t0   # $sp = $sp - $t0
    addi $v0, $v0, -4   # $v0 = $v0 - 4
    jr $ra              # return

printMatrix:
    li $t0, 0 # i = 0 
    li $t1, 0 # j = 0
    # print matrix in row major fashion with newline after each row
    move $t5 $a0        # store m in $t5

for2:
    beq $t0, $t5, end2  # if i == m break
    mult $t0, $a1       # i * n
    mflo $t2            # $t2 = i * n
for1:
    beq $t1, $a1, end1  # if j == n break
    add $t3, $t2, $t1   # $t3 = i * n + j
    sll $t3, $t3, 2     # $t3 = 4 * $t3
    sub $t4, $a2, $t3   # base address of array - (i * n + j)*4
    lw  $t3, 0($t4)     # load array[i * n + j]
    
    li  $v0 , 1         # print array[i * n + j]
    move $a0, $t3       
    syscall

    li $v0, 4
    la $a0, space       # print space
    syscall

    addi $t1, $t1, 1   # j = j + 1
    j for1             # jump to for1
end1:
    li $v0, 4          # print newline
    la $a0 newline      
    syscall
    
    addi $t0, 1        # i = i + 1
    li  $t1, 0         # j = 0
    j for2             # jump to for2
end2: 
    jr $ra             # return

transposeMatrix:
    li $t0, 0 # i = 0 
    li $t1, 0 # j = 0
for3:
    beq $t0, $a0, end3  # if i == m break
    mult $t0, $a1       # i * n
    mflo $t2            # $t2 = i * n
for4:
    beq $t1, $a1, end4  # if j == n break
    add $t3, $t2, $t1   # i * n + j
    sll $t3, $t3, 2     # (i * n + j) * 4
    sub $t4, $a2, $t3   # base address of array - (i * n + j)*4
    lw  $t3, 0($t4)     # load array[i * n + j] into $t6

    mult $t1, $a0       # j * m
    mflo $t4            # $t4 = j * m
    add  $t4, $t4, $t0  # j * m + i
    sll  $t4, $t4, 2    # (j * m + i) * 4
    sub  $t4, $a3, $t4  # base address of transpose - (j * m + i)*4
    sw   $t3, 0($t4)    # store array[i * n + j] into transpose[j * m + i]

    addi $t1, $t1, 1    # j = j + 1
    j for4              # jump to for1
end4:
    addi $t0, $t0, 1    # i = i + 1
    li  $t1, 0          # j = 0
    j for3              # jump to for2
end3:
    jr $ra              # return
