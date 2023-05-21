.data
fin: .asciiz "Fibonacci numbers : "
sep: .asciiz " "

.text 
li $t0, 8
li $t1, 0
li $t2, 0
li $t3, 1

li $v0,4
la $a0, fin
syscall
li $v0,1
move $a0,$t2
syscall
li $v0,4
la $a0, sep
syscall
li $v0,1
move $a0,$t3
syscall
li $v0,4
la $a0, sep
syscall

loop: beq $t1, $t0, end # if t1 == 10 we are done
add $t4, $t3, $t2
move $t2, $t3
move $t3, $t4
li $v0,1
move $a0,$t4
syscall
li $v0,4
la $a0, sep
syscall
addi $t1, $t1, 1 # add 1 to t1
j loop # jump back to the top
end:
li $v0,10
syscall

