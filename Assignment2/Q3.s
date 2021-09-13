# Brief: Program to find if a given number is a prime number or not
# Author: Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
# Date: 01/09/2021
# Assignment: Lab-2
#-------------------------------------------------------------------------------

	.globl  main

	.data

# program output text constants
prompt:
	.asciiz "Enter a positive integer greater than equals to 10: "
eprompt:
	.asciiz "Error, Input < 10"
result1:
    .asciiz "Entered number is a Prime number"
result2:
    .asciiz "Entered number is a Composite number"
newline:
    .asciiz "\n"

    .text
main:
	li	$v0, 4          # issue prompt
    la	$a0, prompt     # load prompt string address into $a0
    syscall	

    li	$v0, 5          # get a from user
    syscall
    move	$s0, $v0    # save a in $s0

    li  $t0, 10         # check if a is greater than 10
    blt	$s0, $t0, error # sanity check for a < 10
    li  $s1, 2          # s1 = 2
loop:
    mult $s1, $s1               # calculating i*i
    mfhi $t0	                # storing the higher 32 bits of i*i in t0 register
    mflo $t1	                # storing the lower 32 bits of i*i in t1 register
    bne $t0, $zero, prime       # if i*i > a, break  
    bgt $t1, $s0, prime         # if i*i > a, break
    rem $s2 , $s0, $s1          # remainder
    beq $s2, $zero, composite   # if remainder is not zero, then continue  
    addi $s1, $s1, 1            # i = i + 1
    j loop                      # else, go to for loop
composite:
    li	$v0, 4          # issue prompt
    la	$a0, result2    # print "Entered number is not a Prime number"
    syscall

    li	$v0, 10         # exit
    syscall
prime:
    li $v0, 4             # issue prompt    
    la $a0, result1       # print "Entered number is a Prime number"
    syscall               

    li $v0, 10            # exit
    syscall
error:
	li	$v0, 4          # issue prompt
	la	$a0, eprompt    # error prompt when input is less than zero
	syscall

	li	$v0, 10         # exit
	syscall
