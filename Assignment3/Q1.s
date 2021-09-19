#	Assignment : 3
#	Group No.: 24
# 	Members: Pranav Rajput(19CS30036), Parth Jindal(19CS30031)
#	Semester: Autumn, 2021
#	Question: 2
#	Description: Program to Compute Product of 2 numbers via Booth's Multiplication Algorithm

    .data

prompt1:
    .asciiz "Enter first number:"

prompt2:
    .asciiz "Enter second number:"

output_msg:
    .asciiz "The product of the two numbers is: "

newline:
    .asciiz "\n"

error_msg:
    .asciiz "Error: Overflow, input should be 16-bit unsigned integer\n"

    .text
    .globl main

main:

    # input first number 
    la $a0, prompt1     # storing address of string in a0 
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # syscall to print_string

    li $v0, 5           # setting v0 to 5 for read_int
    syscall             # syscall to read_int

    move $s0, $v0       # storing inputted value(a) from v0 to s0

    #input 2nd number
    la $a0, prompt2     # storing address of string in a0  
    li $v0, 4           # setting v0 to 4 for print_string
    syscall             # syscall to print_string

    li $v0, 5           # setting v0 to 5 for read_int
    syscall             # syscall to read_int

    move $s1, $v0       # storing inputted value(a) from v0 to s0

    # sanity check 
    # -2^15 <= x <= 2^15 -1 ( 16 bit unsigned integer )

    li $t0, -32768
    li $t1, 32767

    bgt $s0, $t1, error_prog    # if a > 2^15 - 1 give error (jump to error_prog)
    blt $s0, $t0, error_prog    # if a < -2^15 give error (jump to error_prog)

    bgt $s1, $t1, error_prog    # if b > 2^15 - 1 give error (jump to error_prog)
    blt $s1, $t0, error_prog    # if b < -2^15 give error (jump to error_prog)

    move $a0, $s0               # moving s0(a) to a0 (parameter for function call)
    move $a1, $s1               # moving s1(b) to a1 (parameter for function call)

    jal multiply_booth          # jumping to multiply booth (parameters: a,b)

    move $t0, $v0               # moving returned value in v0 (a*b) to t0

    # printing message: "the product of two numbers is:"
    la $a0, output_msg          # storing string address in a0 register
    li $v0, 4                   # setting v0 to 4 for print_string
    syscall                     # system call to print_string

    # printing value of a*b
    move $a0, $t0               # moving t0 ( a*b ) into $a0
    li $v0, 1                   # setting v0 to 1 for print_int
    syscall                     # system call to print_int

    la $a0, newline             # storing string address in a0 register
    li $v0, 4                   # setting v0 to 4 for print_string
    syscall                     # system call to print_string

    exit:

    li $v0, 10  # loading v0 with 10 to call exit function
    syscall     # system call to exit function


error_prog:
    la $a0, error_msg       # loading address of string into a0
    li $v0, 4               # loading v0 with 4 to set for print_string
    j exit                  # unconditional jump to exit


multiply_booth:
    li $t0, 16               # t0(count) = 16
    li $t1, 0                # t1(Q-1) = 0 for initial case
    move $v0, $a1            # v0 (ans) = b initialization

    sll $a0, $a0, 16         # a = a*2^16 left shift by 16 bytes

rec:
    andi $t2, $v0, 1                 # t stores LSB as (a & 1) = first digit of a in binary representation
    beq $t1, $t2, right_shift        # if q0 = q-1 ( 00 or 11 then shift) branch to right_shift
    beq $t1, 1, add_mul              # if q0q-1 = 01 then branch to add_mul
    beq $t1, 0, sub_mul              # if q0q-1 = 10 then branch to sub_mul

right_shift:
    move $t1, $t2           # move value of q0 to q-1 (in general qi+1 to qi)
    sra $v0, $v0, 1         # arithmetic right shift 
    addi $t0, $t0, -1       # count = count - 1
    # the next LSB is calculated at the top of rec

    bgt $t0, 0, rec             # if t0 (count) > 0 jump to rec

    jr $ra                  # jump to return address in ra 

add_mul:
    add $v0, $v0, $a0   # ans = ans + a
    j right_shift       # jump to right_shift

sub_mul:
    sub $v0, $v0, $a0   # ans = ans - a
    j right_shift       # jump to right_shift
