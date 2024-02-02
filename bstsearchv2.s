.data
data: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
size: .word 10
input: .asciiz "Enter a number 1-10: "
notFMsg: .asciiz "The integer was not found in the data.\n"
foundMsg: .asciiz "The integer was found at index "

.text
.globl main
main:
    li $v0, 4
    la $a0, input
    syscall
    li $v0, 5
    syscall
    move $t0, $v0 # Load the input value into $t0

    la $t1, data
    lw $t2, size
    lw $t3, size

    li $t4, 0

bstloop:
    bge $t4, $t3, intNot

    add $t5, $t4, $t3
    sra $t5, $t5, 1
    sll $t6, $t5, 2
    add $t7, $t1, $t6
    lw $t8, ($t7)

    beq $t0, $t8, found

    blt $t0, $t8, Sleft
    bgt $t0, $t8, Sright

Sleft:
    sub $t3, $t5, 1
    j bstloop

Sright:
    addi $t4, $t5, 1
    j bstloop

found:
    li $v0, 4
    la $a0, foundMsg
    syscall
    move $a0, $t5
    li $v0, 1
    syscall
    j end_program

intNot:
    li $v0, 4
    la $a0, notFMsg
    syscall

end_program:
    li $v0, 10
    syscall
