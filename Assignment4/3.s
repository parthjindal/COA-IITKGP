#	Assignment : 4
#	Group No.: 24
# 	Members: Pranav Rajput(19CS30036), Parth Jindal(19CS30031)
#	Semester: Autumn, 2021
#	Question: 3
#	Description: Program to implement recursive search in an sorted array

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
    move $s0, $ra    # save return address to push later after initializing stack frame
    jal initStack   # initialize stack

    move $a0, $s0    # $a0 = $ra
    jal pushToStack # push ra to stack

    la $a0, input_prompt # loading address of string into a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall

    la $t0, array       # loading address of array into temporary register
    li $t1, 0           # loop counter(i) = 0

input_loop:         # loop to input the value of array

    addi $t1, $t1, 1 # incrementing loop counter i++

    li $v0, 5       # setting v0 to 5 to input integer  
    syscall         # system call

    move $t2, $v0   # moving read value(array[i]) to temporary register
    sw $t2, 0($t0)   # array[i] = input_value ; storing value in t1 at address in t0

    add $t0, $t0, 4 # incrementing t0 by 4 bytes so that it can point at position of next element

    blt $t1, 10, input_loop # branch to input_loop if t1(i) < 10
    
    la $a0, array       # moving address of array into a0 (parameter 1)
    li $a1, 0           # l = 0 (parameter 2)
    li $a2, 9           # r = 9 (parameter 3)
    jal recursive_sort  
    
    la $a0, output_msg  # loading address of string to a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string

    la $a0, array       # laoding array address
    jal printArray      # printing sorted array

    la $a0, newline     # loading address of string into a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string

exit:
    li $v0, 10      # exit 
    syscall         # system call for exit

recursive_sort:

    jal pushToStack # push &array[0] into stack

    move $a0, $ra
    jal pushToStack # Push return address into stack

    move $t0, $a1   # l = left
    move $t1, $a2   # r = right
    move $t2, $a1   # p = left

    move $a0, $a1
    jal pushToStack # push left into stack

    move $a0, $a2
    jal pushToStack # push right into stack

    lw $a0, 0($sp)  # a0 = &array[0]

    outer_while:
        bge $t0, $t1, L3    # ( l >= r then break )

        move $t3, $t2       # t3 = p
        sll $t3, $t3, 2     # t3 *= 4 
        add $t3, $t3, $a0   # t3 = &array[p]

        while1: 
            bge $t0, $a2, L1    # if l >=right break

            move $t4, $t0       # t4 = l
            sll $t4, $t4, 2     # t4 *= 4 
            add $t4, $t4, $a0   # t4 = array[l]
            lw $t4, ($t4)       # t4 = array[l]

            lw $t5, ($t3)       # t5 = arrray[p]

            bgt $t4, $t5, L1    # if array[l] > array[p] break

            addi $t0, $t0, 1    # l++ ;
            j while1

        while2:
            ble $t1, $a1, L1    # if r <= left break

            move $t4, $t1       # t4 = r
            sll $t4, $t4, 2     # t4 *= 4 
            add $t4, $t4, $a0   # t4 = array[r]
            lw $t4, ($t4)       # t4 = array[r]

            lw $t5, ($t3)       # t5 = arrray[p]

            bgt $t4, $t5, L1    # if array[l] > array[p] break

            addi $t1, $t1, -1
            j while2

        L1:

        L2:

        j outer_while
    L3:
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
    lw $t0, ($a0)
    lw $t1, ($a1)

    sw $t0, ($a1)
    sw $t1, ($a0)

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
