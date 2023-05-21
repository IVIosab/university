.data
fin: .asciiz " Enter f: "
yin: .asciiz " Enter y: "
zin: .asciiz " Enter z: "
qin: .asciiz " Enter q: "
ans: .asciiz "\ x = (y * z^2) /f - q =  : "
.text
li $v0 ,4
la $a0 , fin
syscall
li $v0 ,5
syscall
move $t1 ,$v0 # $t1 = f
li $v0 ,4
la $a0 , yin
syscall
li $v0 ,5
syscall
move $t2 ,$v0 # $t2 = y
li $v0 ,4
la $a0 , zin
syscall
li $v0 ,5
syscall
move $t3 ,$v0 # $t3 = z
li $v0 ,4
la $a0 , qin
syscall
li $v0 ,5
syscall
move $t4 ,$v0 # $t4 = q

##(y ? z2 )/f ? q

mul $t3 , $t3 , $t3 # t3 = z^2
mul $t5 , $t3 , $t2 # t5 = z^2 * y
div $t5 , $t5 , $t1
sub $t5 , $t5 , $t4

li $v0 ,4
la $a0 , ans
syscall
li $v0 ,1
move $a0 ,$t5
syscall
li $v0 ,10
syscall
