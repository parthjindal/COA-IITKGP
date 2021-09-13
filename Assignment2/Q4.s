# Program to find if a given number is a perfect number or not
# Author: Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
# Date: 01/09/2021
# Assignment: Lab-2
#-------------------------------------------------------------------------------------------------------
	.globl  main

	.data

# program output text constants
prompt:
	.asciiz "Enter a positive number: "
eprompt:
	.asciiz "Error, Input less than zero"
result1:
    .asciiz "Entered number is a perfect number"
result2:
    .asciiz "Entered number is not a perfect number"
newline:
    .asciiz "\n"

    .text
main:
	li	$v0, 4          # issue prompt
    la	$a0, prompt
    syscall	

    li	$v0, 5          # get a from user
    syscall
    move	$s0, $v0

    ble	$s0, $zero, error # sanity check for a <= 0
    li  $s1, 0 # sum of divisors set to zero
    li  $s2, 0 # i = 0
for:
    addi $s2, $s2, 1 # i = i + 1
    bge $s2, $s0, endfor # if i >= a, break
    rem $s3 , $s0, $s2 # remainder
    bne $s3, $zero, for # if remainder is not zero, then continue
    add $s1, $s1, $s2 # sum = sum + i    
    j for
endfor:
    beq $s1, $s0, perfect # if sum == a, then a is a perfect number
    li $v0, 4
    la $a0, result2       # else a is not a perfect number
    syscall               # print "Entered number is not a perfect number"

    li $v0, 10            # exit
    syscall
perfect:
    li $v0, 4             # print "Entered number is a perfect number"
    la $a0, result1       
    syscall 

    li $v0, 10            # exit 
    syscall
error:
	li	$v0, 4          # issue prompt
	la	$a0, eprompt    # error prompt when input is less than equal to zero
	syscall

	li	$v0, 10         # exit
	syscall
