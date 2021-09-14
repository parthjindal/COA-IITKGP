#	Assignment : 3
#	Group No.: 24
# 	Members: Pranav Rajput(19CS30036), Parth Jindal(19CS30031)
#	Semester: Autumn, 2021
#	Question: 2
#	Description: Program to print kth largest number in an array

    .data

array:                  # space allocation for an array of 10 integers (4*10 = 40 bytes)
    .space 40

input_prompt:
    .asciiz "Enter k: "

error_msg:
    .asciiz "Error: k exceeds index bounds\n"

output_msg:
    .asciiz "th largest number = "

newline:
    .asciiz "\n"

    .text
    .globl main

main:

    la $t0, array       # loading address of array into temporary register
    li $t1, 0           # loop counter(i)

    
    input_loop:         # loop to input the value of array

        addi $t1, $t1, 1 # incrementing loop counter i++

        li $v0, 5       # setting v0 to 5 to input integer  
        syscall         # system call

        move $t2, $v0   # moving read value(array[i]) to temporary register
        sw $t2, ($t0)   # array[i] = input_value ; storing value in t1 at address in t0

        add $t0, $t0, 4 # incrementing t0 by 4 bytes so that it can point at position of next element

        blt $t1, 10, input_loop # branch to input_loop if t1(i) < 10

    
    la $a0, input_prompt # loading address of string into a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall

    li $v0, 5           # setting v0 to 5 for read_int
    syscall             # system call

    move $t1, $v0       # moving inputted value(k) into t1 register

    move $a0, $t1       # moving k into a0 
    li $v0, 1           # setting v0 to 1 for print_int
    syscall             # system call to print_int

    la $a0, output_msg  # loading address of string to a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string
    

    move $a0, $t0       # moving address of array into a0 (parameter 1)
    move $a1, $t1       # moving value of t1(k) into a1 (parameter 2)
    jal find_k_largest

    move $a0, $v0       # loading return value(ans) into a0 
    li $v0, 1           # setting v0 to 1 for print_int
    syscall             # system call to print_int

    la $a0, newline     # loading address of string into a0
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # system call to print_string

    exit:
        li $v0, 10      # exit 
        syscall         # system call for exit

error_section:
    la $a0, error_prompt    # loading address of string into a0
    li $v0, 4               # setting v0 to 4 for print_string
    syscall                 # system call to print_string

    j exit                  # unconditional jump to exit

find_k_largest:

    addi $sp, $sp, -12  # creating space for saving values because of nested call
    sw $ra, 8($sp)      # saving return address in stack
    sw $a0, 4($sp)      # saving array address in stack
    sw $a1, 0($sp)      # saving value of k in stack

    bgt $a1, 10, error_section # if k > 10 branch to error section 

    jal sort_array      # jump to sort_array while saving return address as the next executible line

    lw $ra, 8($sp)      # loading return address saved in stack
    lw $a0, 4($sp)      # loading array address saved in stack
    lw $a1, 0($sp)      # loading value of k saved in stack
    addi $sp, $sp, 12   # releasing space that was for saving values b

    li $t0, 10          # t0 = 10
    move $t1, $a1       # t1 = k
    sub $t0, $t0, $t1   # t0 = 10 - k
    sll $t0, $t0, 2     # t0 = 4*(10-k) 
    
    move $t1, $a0       # moving address of array into t1
    add $t1, $t1, $t0   # t1 pointing to array[10-k]

    lw $v0, ($t0)    # moving the value of Kth largest element into v0 (return value)
    jr $ra             # jumping to original return address



sort_array:

    move $t0, $a0      # moving value of a0(*array) to t0(A[])
    li $t1, 1          # j = 1

    outer_loop:
        lw $t2, 4($t0)      # temp = A[j] (initially A[1])
        addi $t3, $t2, -1   # i = j - 1
        move $t4, $t0       # moving t0: address of A[i] (initially A[j -1] ) to t4

        inner_loop:
            blt $t3, 0, move_out        # break if i < 0
            lw $t5, ($t4)               # loading A[i] into t4
            ble $t5, $t2, move_out    # break if A[i] <= temp

            lw $t5, ($t4)               # loading value of address at t4( A[i] ) into t5
            sw $t5, 4($t4)              # A[i+1] = A[i]

            addi $t3, $t3, -1           # i = i - 1
            addi $t4, $t4, -4           # moving pointer to A[i - 1]

            b inner_loop                # branch to inner_loop

        move_out:
        sw $t2, 4($t4)                  # A[i + 1] = temp

        addi $t0, $t0, 4                # pointer to A[j] to A[j + 1] now
        addi $t1, $t1, 1                # j = j + 1
        
        blt $t1, 10, outer_loop         # if j < 10 branch to outer_loop

    jr $ra                              # jump to return address





