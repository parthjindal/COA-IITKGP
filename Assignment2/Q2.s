# Program to find the GCD of two non negative integers
# Author: Parth Jindal, Pranav Rajput
# Date: 01/09/2021
# Assignment: Lab-2
#-------------------------------------------------------------------------------
	.globl  main

	.data

# program output text constants
prompt1:
	.asciiz "Enter the first positive number: "
prompt2:
    .asciiz "Enter the second positive number: "
prompt3:
	.asciiz "Error, Input less than zero"
result:
    .asciiz "GCD of the two integers is: "
newline:
    .asciiz "\n"

    .text
main:
	li	$v0, 4          # issue prompt
    la	$a0, prompt1    # load prompt1's address
    syscall	

    li	$v0, 5          # get a from user
    syscall
    move	$s0, $v0

    li	$v0, 4          # issue prompt
    la	$a0, prompt2
    syscall

    li	$v0, 5          # get b from user
    syscall
    move	$s1, $v0

    blt	$s0, $zero, error # sanity check for a < 0
    blt	$s1, $zero, error # sanity check for b < 0

GCD:
    bne	$s0, $zero,  L1  # if a != 0, then go to L1
	move $s0, $s1        # if a == 0, then s0 = b and go to done
	j done
L1:
    beq	$s1, $zero, done # if b == 0, then we are finished, go to done
    ble	$s0, $s1, L2     # if a <= b, then go to L2 
    sub	$s0, $s0, $s1    # if a > b, then a = a - b
	j	L1               # go back to L1
L2:
    sub $s1, $s1, $s0    # if b >= a, then b = b - a
    j	L1               # go back to L1
done:
    li	$v0, 4           # issue prompt
	la	$a0, result      # print result string
	syscall              

	li $v0, 1			# print integer result stored in s0
	move $a0, $s0
	syscall
	
	li	$v0, 10         # exit
	syscall
error:
	li	$v0, 4          # issue prompt
	la	$a0, prompt3    # error prompt when input is less than zero
	syscall

	li	$v0, 10         # exit
	syscall
