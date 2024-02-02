.data
user_prompt: .asciiz "Enter the value of n: "
output_message: .asciiz "The Fibonacci sequence up to n: "
newline: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, user_prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0 

    li $t1, 0  # Initialize F(0)
    li $t2, 1  # Initialize F(1)

    li $v0, 4
    la $a0, output_message
    syscall

    beqz $t0, skip_fib

fib_loop:
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 11
    li $a0, ' '
    syscall

    move $t3, $t2
    add $t2, $t2, $t1
    move $t1, $t3

    addi $t0, $t0, -1
    bnez $t0, fib_loop

skip_fib:
    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10
    syscall
