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
    move $s0, $ra   # save return address to push later after initializing stack frame
    jal initStack   # initialize stack

    move $a0, $s0   # $a0 = $ra
    jal pushToStack # push ra to stack

    li $v0, 4           
    la $a0, prompt1 # print prompt1
    syscall

    li $v0, 5       # read n
    syscall        
    move $a0, $v0   # save n in $a1
    jal pushToStack # push n onto stack

    li $v0, 5       # read a
    syscall
    move $a0, $v0   # save a in $a2
    jal pushToStack # push a onto stack

    li $v0, 5       # read r
    syscall
    move $a0, $v0   # save r in $a3
    jal pushToStack # push r onto stack
    

    # compute product of m and n
    lw $t0, -8($fp)     # n
    mult $t0, $t0 
    mflo $t0            # store product in $t0 = n * n

    move $a0, $t0       # save product in $a0 call mallocInStack
    jal mallocInStack 
    move $s0, $v0        # save address of array A in $s0

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

    lw $a0, -8($fp)
    addi $a0, $a0, -1    # a0 = n - 1    
    mult $a0, $a0
    mflo $a0             # a0 = (n-1)^2
    jal mallocInStack    # malloc 

    move $a0, $s0       # a0 = &array[0]
    move $a1, $v0       # a1 = &submatrix[0]
    lw $a2, -8($fp)     # a2 = n
    li $a3, 0           # column skip
    jal generateSubMatrix

    lw $a0, -8($fp)     # n
    addi $a0, $a0, -1   # n-1
    lw $a1, 0($sp)      # base address of array
    jal printMatrix     # call to function printMatrix

    li $v0, 4          
    la $a0, newline      # print newline
    syscall

    lw $a0, -8($fp)
    addi $a0, $a0, -1   # a0 = n-1
    mult $a0, $a0
    mflo $a0            # a0 = (n-1)^2
    sll $a0, $a0, 2
    add $sp, $sp, $a0   # deallocating 

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

popFromStack:
    lw $v0, 0($sp) 

recursive_Det:
    li $v0, 0 
    jr $ra

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

generateSubMatrix:
    # a0 = &array[0]
    # a1 = &submatrix[0]
    # a2 = n 
    # a3 = column_skip

    li $t0, 1       # i = 1 
    li $t1, 0       # j = 0

    asloop1:
        asloop2:

            addi $t2, $t0, -1   # i' = i - 1
            move $t3, $t1       # j' = j

            beq $t1, $a3, counterplus   # if j = column_skip jump to counterplus

            blt $t1, $a3, assignval 
            addi $t3, $t3, -1           # j'-- if j > column_skip
            
            assignval:

            mult $t0, $a2               
            mflo $t4                    # t4 = n*i 
            add $t4, $t4, $t1           # t4 = n*i + j
            sll $t4, $t4, 2             
            add $t4, $t4, $a0           # t4 = &array[i][j]
            lw $t4, 0($t4)              # t4 = array[i][j]       
            
            addi $t5, $a2, -1
            mult $t2, $t5               
            mflo $t5                    # t4 = (n-1)*i' 
            add $t5, $t5, $t3           # t4 = (n-1)*i' + j'
            sll $t5, $t5, 2             
            add $t5, $t5, $a1           # t5 = &submatrix[i'][j']
    
            sw $t4, 0($t5)              # submatrix[i'][j'] = array[i][j]

            # lw $a0, ($t5)
            # li $v0, 1
            # syscall

            counterplus:

            addi $t1, $t1, 1            # j++
            blt $t1, $a2, asloop2       # if j < n loop
        
        addi $t0, $t0, 1                # i++
        blt $t0, $a2, asloop1           # if i < n loop

    jr $ra
