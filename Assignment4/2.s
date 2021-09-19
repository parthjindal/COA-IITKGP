#	Assignment : 4
#	Group No.: 24
# 	Members: Pranav Rajput(19CS30036), Parth Jindal(19CS30031)
#	Semester: Autumn, 2021
#	Question: 2
#	Description: Program to print sorted array using recursive sort function

    .data

array:                  # space allocation for an array of 10 integers (4*10 = 40 bytes)
    .space 40

input_prompt:
    .asciiz "Enter the array elements:\n"

output_msg:
    .asciiz "Sorted array:\n"

newline:
    .asciiz "\n"

space:
    .asciiz " "

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
exit:
    lw $ra, -4($fp)     # restore ra
    move $sp, $fp       # restore stack pointer
    lw $fp, 0($sp)      # restore frame pointer
    addi $sp, 8         # pop return address
    
    jr $ra
recursive_sort:

    move $t0, $a0       # s0: base address of a

    # save arguments(left,right) to stack for recursive call
    # note: no need to store base address as that get's restored from s0
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
