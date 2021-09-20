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
    

    # compute product of n and n
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

    lw $a0, -8($fp)      # n
    addi $a0, $a0, -1    # a0 = n - 1    
    mult $a0, $a0
    mflo $a0             # a0 = (n-1)^2
    jal mallocInStack    # malloc 

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
    # a0 = &array[0]
    # a1 = n

    move $t0, $a0       # temporary save to t0 to empty a0

    move $a0, $ra
    jal pushToStack     # saving return address on stack

    move $a0, $s0
    jal pushToStack     # callee save register s0

    move $a0, $s1
    jal pushToStack     # callee save register s1

    move $s0, $t0       # s0 = &a[0][0]
    move $s1, $a1       # s1 = n    

    li $t0, 0           # j = 0
    li $v0, 0           # det(A) = 0

    addi $t1, $s1, -1   # t1 = n - 1
    mult $t1, $t1
    mflo $t1            # t1 = (n - 1)^2
    move $a0, $t1       # a0 = (n - 1)^2
    jal mallocInStack   # allocating space for submatrix
    move $t6, $v0       # moving base address of submatrix array into t5

    bne $s1, 1, ifor    # if n != 1 jump to ifor

    lw $v0, ($s0)       # v0 : det(A) = a[0][0] if n==1

    lw $ra, 8($sp)
    lw $s0, 4($sp)
    lw $s1, 0($sp)

    addi $sp, $sp, 12   # deallocating
    jr $ra              # return 

    ifor:

        move $a0, $t0
        jal pushToStack             # saving j into stack

        move $a0, $v0
        jal pushToStack             # saving intermediate det(A) into stack

        move $a0, $s0               # &array[0]
        move $a1, $t6               # &submatrix[0][0]
        move $a2, $t0               # column skip = j 
        jal generateSubMatrix       # submatrix generation


        move $a0, $t6               # t6 = &submatrix[0][0] 
        addi $a1, $s1, -1           # n' = n - 1
        jal recursive_Det           # recursive(subarray,n-1)
        move $t1, $v0               # moving Det(B) into t0


        lw $t0, 4($sp)              # t0 = j from stack
        lw $v0, ($sp)               # loading intermediate (v0) det(A) from stack
        addi $sp, $sp, 8            # deallocating space alloted to v0 and t0 

        andi $t2, $t0, 1            # t2 = j & 1

        beq $t2, 0, LL1             # if j is even , jump to LL1
        sub $t1, $zero, $t1             # det(B) = - det(B) if j is odd

        LL1:
        
        move $t2, $t0               # t2 = j
        sll $t2, $t2, 2             # t2 *= 4
        sub $t2, $s0, $t2           # t2 = &a[0][j]
        lw $t2, 0($t2)              # t2 = a[0][j]

        mult $t1, $t2               
        mflo $t1                    # t1 = (-1)^j . A[0][j] . det(B) 
        add $v0, $v0, $t1           # det(A) += t1

        lw $t5, ($sp)               # loading base address of submatrix array from stack    

        addi $t0, $t0, 1           # j++
        blt $t0, $s1, ifor         # if j < n , loop

    end_of_rec:
        addi $s0, $s0, -1       # s0 = n - 1
        mult $s0, $s0           
        mflo $s0                # s0 = (n - 1)^2
        sll $s0, $s0, 2         # s0 *= 4
        add $sp, $sp, $s0       # deallocating space for submatrix

        lw $ra, 8($sp)
        lw $s0, 4($sp)
        lw $s1, 0($sp)
        addi $sp, $sp, 12   # deallocating
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
            sub $t4, $a0, $t4           # t4 = &array[i][j]
            lw $t4, 0($t4)              # t4 = array[i][j]       
            
            addi $t5, $a2, -1           
            mult $t2, $t5               
            mflo $t5                    # t5 = (n-1)*i' 
            add $t5, $t5, $t3           # t5 = (n-1)*i' + j'
            sll $t5, $t5, 2             
            sub $t5, $a1, $t5           # t5 = &submatrix[i'][j']
    
            sw $t4, 0($t5)              # submatrix[i'][j'] = array[i][j]

            # lw $a0, ($t5)
            # li $v0, 1
            # syscall

            counterplus:

            addi $t1, $t1, 1            # j++
            blt $t1, $a2, asloop2       # if j < n loop
        
        addi $t0, $t0, 1                # i++
        li $t1, 0                       # j = 0
        blt $t0, $a2, asloop1           # if i < n loop

    jr $ra
