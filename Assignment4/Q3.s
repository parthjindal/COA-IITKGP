#	Assignment : 4
#	Group No.: 24
# 	Members: Pranav Rajput(19CS30036), Parth Jindal(19CS30031)
#	Semester: Autumn, 2021
#	Question: 2
#	Description: Program to recursively sort an array and recursively search for an element 
#   Note: The array is 0-indexed
    .data

array:                  # space allocation for an array of 10 integers (4*10 = 40 bytes)
    .space 40

input_prompt:
    .asciiz "Enter the array elements:\n"

output_msg:
    .asciiz "\nSorted array:\n"

input_prompt2:
    .asciiz "Enter n (element to be searched): "

newline:
    .asciiz "\n"

found_msg:
    .asciiz " is FOUND in the array at index "

not_found_msg:
    .asciiz " is NOT FOUND in the array\n"

space:
    .asciiz " "

end_line:
    .asciiz " .\n"

    .text
    .globl main

main:
    move $s0, $ra   # save return address to push later after initializing stack frame
    jal initStack   # initialize stack

    move $a0, $s0   # $a0 = $ra
    jal pushToStack # push ra to stack

    la $a0, input_prompt    # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall

    la $t0, array       # loading address of array into temporary register
    li $t1, 0           # loop counter(i) = 0

input_loop:             # loop to input the value of array

    addi $t1, $t1, 1    # incrementing loop counter i++

    li $v0, 5           # setting v0 to 5 to input integer  
    syscall             # system call

    move $t2, $v0       # moving read value(array[i]) to temporary register
    sw $t2, 0($t0)      # array[i] = input_value ; storing value in t1 at address in t0

    add $t0, $t0, 4     # incrementing t0 by 4 bytes so that it can point at position of next element

    blt $t1, 10, input_loop # branch to input_loop if t1(i) < 10
    
    la $a0, array       # moving address of array into a0 (parameter 1)
    li $a1, 0           # l = 0 (parameter 2)
    li $a2, 9           # r = 9 (parameter 3)
    jal recursive_sort
PL:   
    la $a0, output_msg  # loading address of string to a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string

    la $a0, array       # laoding array address
    jal printArray      # printing sorted array

    la $a0, newline     # loading address of string into a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string

search_section:

    la $a0, input_prompt2    # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall

    li $v0, 5
    syscall             # read n (element to be searched)
    move $s5, $v0

    la $a0, array       # loading array address into a1
    li $a1, 0           # start =  0
    li $a2, 9           # end = 9
    move $a3, $s5       # load key (n) into a3

    jal recursive_search
    move $s0, $v0       # moving index to s0

    move $a0, $s5
    li $v0, 1           # print n (key)
    syscall

    beq $s0, -1, if_not_found

    la $a0, found_msg       # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall 

    move $a0, $s0           # move answer to a0
    li $v0, 1               # printing index
    syscall

    la $a0, newline         # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall 

exit:
    lw $ra, -4($fp)     # restore ra
    move $sp, $fp       # restore stack pointer
    lw $fp, 0($sp)      # restore frame pointer
    addi $sp, 4         # pop return address
    
    jr $ra

if_not_found:
    la $a0, not_found_msg   # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall

    j exit



recursive_sort:

    move $t0, $a0       # s0: base address of a

    # save arguments(left,right) to stack for recursive call
    # note: no need to store base address as that gets restored from s0
    # total: 24 bytes stored on stack
    move $a0, $ra       # $a0 = $ra
    jal pushToStack     # push ra to stack

    move $a0, $a1
    jal pushToStack     # push left to stack

    move $a0, $a2
    jal pushToStack     # push right to stack

    move $a0, $s0       # push callee save register s0
    jal pushToStack     # 

    move $a0, $s1       # push callee save register s1
    jal pushToStack     
    
    move $a0, $s2       # push callee save register s2
    jal pushToStack     

    move $s0, $t0       # base address
    move $s1, $a1       # l = left
    move $s2, $a2       # r = right

    outer_while:
        bge $s1, $s2, L3     # if (l >= r, break)
        
        while1:
            lw  $t0, 12($sp)        # t0 = right
            bge $s1, $t0, while2    # (l >= right, break)
            sll $t2, $s1, 2         # t2 = l * 4
            add $t2, $t2, $s0       # t2 = &a[l]
            lw  $t3, 0($t2)         # t3 = a[l]
            
            lw  $t0, 16($sp)        # t0 = p
            sll $t2, $t0, 2         # t2 = p * 4
            add $t2, $t2, $s0       # t2 = &a[p]
            lw  $t4, 0($t2)         # t4 = a[p]
    
            bgt $t3, $t4  while2    # a[l] > a[p], break
            addi $s1, 1             # l++
        
            j while1
        
        while2:
            lw  $t0, 16($sp)        # t0 = left
            ble $s2, $t0, L1        # (r <= left, break)
            sll $t2, $s2, 2         # t2 = r * 4
            add $t2, $t2, $s0       # t2 = &a[r]
            lw  $t3, 0($t2)         # t3 = a[r]
            
            lw  $t0, 16($sp)        # t0 = p
            sll $t2, $t0, 2         # t2 = p * 4
            add $t2, $t2, $s0       # t2 = &a[p]
            lw  $t4, 0($t2)         # t4 = a[p]

            blt $t3, $t4, L1        # a[r] < a[p], break
            addi $s2, -1            # r--
        
            j while2
        L1:
            blt $s1, $s2, L2        # if l < r , goto L2

            lw  $t0, 16($sp)        # t0 = p 
            sll $t0, $t0, 2         # t0 = p * 4
            add $t0, $t0, $s0       # t0 = &a[p]

            sll $t1, $s2, 2         # t1 = r * 4
            add $t1, $t1, $s0       # t1 = &a[r]

            move $a0, $t0           # load argument 1 
            move $a1, $t1           # load argument 2
            jal SWAP                # swap(array[p], array[r])

            move $a0, $s0           # arg1 = &a[0]
            lw   $a1, 16($sp)       # arg2 = left
            addi $a2, $s2, -1       # arg3 = r-1
            jal recursive_sort      

            move $a0, $s0           # arg1 = &a[0]
            addi $a1, $s2, 1        # arg2 = r + 1
            lw   $a2, 12($sp)       # arg3 = right
            jal recursive_sort

            j L3                    # cleanup stack and restore save registers
        L2:
            sll $t0, $s1, 2         # t0 = l * 4 
            add $t0, $t0, $s0       # t0 = &a[l]

            sll  $t1, $s2, 2        # t1 = r * 4 
            add  $t1, $t1, $s0      # t1 = &a[r]

            move $a0, $t0           # arg1 = &a[l]           
            move $a1, $t1           # arg2 = &a[r]
            jal SWAP                # swap(a[l], a[r])

        j outer_while
    L3:
        lw $ra, 20($sp)
        lw $s0, 8($sp)
        lw $s1, 4($sp)
        lw $s2, 0($sp)
        addi $sp, $sp, 24
        jr $ra

initStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $fp, 0($sp)       # save frame pointer
    move $fp, $sp        # set frame pointer to stack pointer
    jr $ra              # return

pushToStack:
    addi $sp, $sp, -4   # decrement stack pointer by 4
    sw $a0, 0($sp)      # push a0 onto stack
    jr $ra              # return

SWAP:
    lw $t0, 0($a0)      # temp1 = a
    lw $t1, 0($a1)       # temp2 = b

    sw $t0, 0($a1)       # b = temp1
    sw $t1, 0($a0)       # a = temp2

    jr $ra
printArray:
    li $t0, 0           # i = 0
    move $t1, $a0       # moving base address of array into t1
for_loop:
    lw $t2, ($t1)       # loading value at address t1 into t2 (a[i])

    li $v0, 1           # setting v0 to 1 for print_int
    move $a0, $t2       # moving t2(a[i]) into a0
    syscall             # system call to print_int

    addi $t0, $t0, 1    # i++
    addi $t1, $t1, 4    # shifting pointer to a[i + 1] for next iteration

    la $a0, space       # loading address of string space
    li $v0, 4           
    syscall             # system call to print_string

    blt $t0, 10, for_loop   # if i < 10 keep looping 

    la $a0, newline     # loading address of string newline
    li $v0, 4           
    syscall             # system call to print_string

    jr $ra              # jumping back to initial address

recursive_search:


    move $t0, $a0       # s0: base address of a

    # save arguments(start,end,array,key) to stack for recursive call
    # note: no need to store base address and key as that gets restored from s0
    # total: 28 bytes stored on stack
    move $a0, $ra       # $a0 = $ra
    jal pushToStack     # push ra to stack

    move $a0, $a1
    jal pushToStack     # push start to stack

    move $a0, $a2
    jal pushToStack     # push end to stack

    move $a0, $s0       # push callee save register s0
    jal pushToStack     

    move $a0, $s1       # push callee save register s1
    jal pushToStack     
    
    move $a0, $s2       # push callee save register s2
    jal pushToStack

    move $a0, $s3       # push callee save register s3
    jal pushToStack

    move $s0, $t0       # base address 

    move $s1, $a1
    sll $s1, $s1, 1
    add $s1, $s1, $a2 
    li $t0, 3
    div $s1, $t0
    mflo $s1            # mid1 = (2*start + end)/3

    move $s2, $a2
    sll $s2, $s2, 1
    add $s2, $s2, $a1
    li $t0, 3
    div $s2, $t0
    mflo $s2            # mid2 = (start + 2*end)/3

    move $s3, $a3       # s3 = key

    while:
        lw $a1, 20($sp)
        lw $a2, 16($sp)
        bgt $a1, $a2, key_not_found      # if start > end break

        # setting params for recursive call
        # some parameters will be changed acc, to conditions
        move $a0, $s0                   # a0 = &array[0]
        # a1 = start (already setup)
        # ar = end (already setup)
        move $a3, $s3                   # a3 = key

        move $t0, $s1
        sll $t0, $t0, 2
        add $t0, $t0, $s0               # t0 = & array[mid1]
        lw $t0, ($t0)

        move $t1, $s2
        sll $t1, $t1, 2
        add $t1, $t1, $s0               # t1 = & array[mid2]
        lw $t1, ($t1)

        bne $t0, $s3, c1                # if key != a[mid1] go to c1
            # if key == a[mid1]
            move $v0, $s1               # v0 = mid1
            j function_end              # return v0

        c1:
        bne $t1, $s3, c2                # if key != a[mid2] go to c3
            # if key == a[mid2]
            move $v0, $s2               # v0 = mid2
            j function_end              # return v0

        c2:
        bge $s3, $t0, c3                # if key >= a[mid1] go to c3
            # if key < a[mid1]
            addi $a2, $s1, -1           # end' = mid1 - 1
            j rec_call                  # make recursive call 

        c3:
        ble $s3, $t1, c4                # if key <= a[mid2] go to c4
            # if key > a[mid2]
            addi $a1, $s2, 1            # start' = mid2 + 1
            j rec_call                  # recursive call

        c4:
            # a[mid1] < key < a[mid2]
            addi $a1, $s1, 1            # start' = mid1 + 1
            addi $a2, $s2, -1           # end' = mid2 - 1

        rec_call:               # make recursive call
            jal recursive_search
            j function_end      # jump to function end

        j while     # keep looping

    key_not_found:
    li $v0, -1  # if not found, return -1

    function_end:
        # reloading values from stack
        lw $ra, 24($sp)
        lw $a1, 20($sp)
        lw $a2, 16($sp)
        lw $s0, 12($sp)
        lw $s1, 8($sp)
        lw $s2, 4($sp)
        lw $s3, 0($sp)
        # deallocation
        addi $sp, $sp, 28
        #return to callee
        jr $ra
