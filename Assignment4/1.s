# Program to Compute an Array A and it's determinant of GP Series with initial value a and common ratio r, Print the array and determinant
# Author: Parth Jindal, Pranav Rajput
# Date: 18/09/2021
# Assignment: Lab-4
#-------------------------------------------------------------------------------

	.data

# program output text constants
prompt1:
	.asciiz "Enter three positive integers n, a and r: \n"
prompt2:
    .asciiz "Array A (GP) with initial value a and common ratio r:\n"
prompt3:
    .asciiz "Final determinant of matrix A is: "    
newline:
    .asciiz "\n"
space:
    .asciiz " "
    .text

    .globl  main

main:
    move $s0, $ra    # save return address to push later after initializing stack frame
    jal initStack   # initialize stack

    move $a0, $s0    # $a0 = $ra
    jal pushToStack # push ra to stack

    li $v0, 4           
    la $a0, prompt1 # print prompt1
    syscall

    li $v0, 5       # read n
    syscall        
    move $a0, $v0    # save n in $a1
    jal pushToStack # push n onto stack

    li $v0, 5       # read a
    syscall
    move $a0, $v0    # save a in $a2
    jal pushToStack # push a onto stack

    li $v0, 5       # read r
    syscall
    move $a0, $v0    # save r in $a3
    jal pushToStack # push r onto stack
    

    # compute product of m and n
    lw $t0, -8($fp)     # n
    mult $t0, $t0 
    mflo $t0            # store product in $t0 = n * n

    move $a0, $t0       # save product in $a0 call mallocInStack
    jal mallocInStack 
    move $s0 $v0        # save address of array A in $s0

    # fill array in row major fashion with a geometric progression of 
    # initial value a and common ratio r
    lw $t0, -8($fp)     # n
    mult $t0, $t0       # compute product n*n
    mflo $t0

    li $t2, 0           # i = 0 (iterator)
    lw $t3, -12($fp)    # $t3 = a
    lw $t4, -16($fp)    # $t4 = r

# loop to fill array in row major fashion with a geometric progression of 
# initial value a and common ratio r
for:
    beq $t2, $t0, end # if i == n * n, break
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
    la $a0, prompt2     # print prompt2
    syscall

    lw $a0, -8($fp)     # n
    move $a1, $s0       # base address of array
    jal printMatrix     # call to function printMatrix

    li $v0, 4          
    la $a0, newline      # print newline
    syscall

    lw $a0, -8($fp)     # n
    move $a1, $s0       # base address of array
    jal recursive_Det   # call to function recursive_Det

    move $t0, $v0       # moving value returned by det (v0) to t0  

    li $v0, 4
    la $a0, prompt3     # print prompt3
    syscall

    li $v0, 1
    move $a0, $t0       # printing determinant of matrix
    syscall

    li $v0, 4          
    la $a0, newline      # print newline
    syscall

exit:
    lw $ra, -4($fp)     # restore ra
    move $sp, $fp       # restore stack pointer
    lw $fp, 0($sp)      # restore frame pointer
    addi $sp, 4         # pop return address
    
    jr $ra
    # li $v0, 10          # setting v0 to 10 for exit function
    # syscall             # system call to exit function



initStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $fp, 0($sp)       # save frame pointer
    move $fp, $sp        # set frame pointer to stack pointer
    jr $ra              # return

pushToStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $a0, 0($sp)      # push a0 onto stack
    jr $ra              # return

mallocInStack:
    sll $t0, $a0, 2     # $t0 = 4 * $a0
    move $v0, $sp       # $v0 = $sp
    sub $sp, $sp, $t0   # $sp = $sp - $t0
    addi $v0, $v0, -4   # $v0 = $v0 - 4
    jr $ra              # return

printMatrix:
    li $t0, 0 # i = 0 
    li $t1, 0 # j = 0
    # print matrix in row major fashion with newline after each row
    move $t5, $a0        # store n in $t5

for2:
    beq $t0, $t5, end2  # if i == n break
    mult $t0, $t5       # i * n
    mflo $t2            # $t2 = i * n
for1:
    beq $t1, $t5, end1  # if j == n break
    add $t3, $t2, $t1   # $t3 = i * n + j

    sll $t3, $t3, 2     # $t3 = 4 * $t3
    sub $t4, $a1, $t3   # base address of array - (i * n + j)*4
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
    la $a0, newline      
    syscall
    
    addi $t0, 1        # i = i + 1
    li $t1, 0          # j = 0
    j for2             # jump to for2
end2: 
    jr $ra             # return

recursive_Det:          # recursive function to calculate determinant of matrix via laplace method

    jal pushToStack     # pushing original n to stack

    move $t0, $a0       # moving n into t0

    move $a0, $a1       # moving address of array into a0
    jal pushToStack     # pushing address of array into stack

    move $t1, $a1       # moving address of array into t1

    move $a0, $ra       # moving return address into a0
    jal pushToStack     # pushing return address (initial state into stack)

   # jr $ra              # returning to next statement from call point

    bne $t0, 1, L1      # if n != 1 jump to L1

    lw $v0, ($t1)       # load value of a[0][0] into return register v0
    addi $sp, $sp, 12   # popping elements
    jr $ra              # jumping back to caller

L1:
    li $t2, 0           # j = 0
    li $t3, 1           # sign = 1

outer_loop:
    move $a0, $t2
    jal pushToStack     # pushing i onto stack

    move $a0, $v0
    jal pushToStack     # pushing v0 onto stack

    move $a0, $t2       # param1 = i

    lw $t0, ($sp)       # param2 = n
    move $a1, $t0     

    lw $a2, -8($sp)     # param3 = &array[0][0]

    addi $t0, $t0, -1   # t0 = n - 1
    mult $t0, $t0
    mflo $t0            # t0 = (n-1)*(n-1)
    jal mallocInStack   
    move $a3, $v0       # param3: empty n-1 *n-1 array address into a2       

    jal sub_matrix      # calling submatrix
    move $a1, $v0       # moving address of submatrix into a1

    addi $t0, $t0, -1   # t0 = n - 1
    mult $t0, $t0
    mflo $t0            # t0 = (n-1)*(n-1)
    sll $t0, $t0, 2     # t0 = 4*t0
    add $sp, $sp, $t0   # dealllocating space for submatrix

    lw $a0, ($sp)       # loading n into $a0

    jal recursive_Det   # recursive call  
    move $t0, $v0       # moving returned value into t0

    lw $t2, -12($sp)    # loading i from stack
    lw $v0, -16($sp)    # loading v0 from stack 
    addi $sp, $sp, 4    # pop

    andi $t1, $t2, 1    # t1 = i & 1
    beq $t1, 0, L2      # if i is even jump to L2
    sub $t0, $zero, $t0 # M[0, i] = -M[0, i]

L2:
    add $t0, $t0, $zero     # M[0, i] = +M[0, i]

    sll $t1, $t2, 2         # i = i * 4
    lw $t3, -4($sp)         # loading address of array from stack into t3
    add $t3, $t3, $t1      # pointing to A[0][i]

    lw $t3, ($t3)           # moving value at address in t3(A[0][i]) into t3
    mult $t0, $t3           # (-1)^j*M[0, i]*A[0][i]
    mflo $t0             

    add $v0, $v0, $t0       # adding (-1)^j*M[0, i]*A[0][i] into existing value

    addi $t2, $t2, 1        # i++ 

    lw $t0, 0($sp)          # loading n from stack

    blt $t2, $t0, outer_loop    # if i < n keep looping

    # return 
    lw $ra, -8($sp)
    addi $sp, $sp, 12   # popping elements
    jr $ra              # jumping back to caller


sub_matrix:
    #   a0 = column_skip
    #   a1 = n
    #   a2 = &array[0]
    #   a3 = &submatrix[0]
    li $t0, 1 # i = 1 (skipping first row for sub-matrix)
    li $t1, 0 # j = 0
for3:
    beq $t0, $a1, end3  # if i == n break
    mult $t0, $a1       # i * n
    mflo $t2            # $t2 = i * n
for4:
    beq $t1, $a0, end4  # if j == column_skip break
    beq $t1, $a1, end4  # if j == n break
    add $t3, $t2, $t1   # i * n + j
    sll $t3, $t3, 2     # (i * n + j) * 4
    sub $t4, $a2, $t3   # base address of array - (i * n + j)*4
    lw  $t3, 0($t4)     # load array[i * n + j] into $t6

    addi $t4, $t0, -1   # t4 = i - 1
    move $t5, $t1       # t5 = j
    blt $t1, $a0, L4    # if j < column_skip goto L4
    addi $t5, $t5, -1   # t5 = j - 1
L4:
    mult $t4, $a1       # t4 = (i-1)*n
    mflo $t4            # 
    add $t5, $t5, $t4   # t5 = (i-1)*n + j
    sll $t5, $t5, 2     # t5 = t5*4
    add $t5, $a3, $t5   # t5 = &subm[i-1][j']
    sw $t3, 0($t5)      # subm[i-1][j'] = array[i][j]

    addi $t1, $t1, 1    # j = j + 1
    j for4              # jump to for1
end4:
    addi $t0, $t0, 1    # i = i + 1
    li  $t1, 0          # j = 0
    j for3              # jump to for2
end3:
    move $v0, $a3       #
    jr $ra              # return
