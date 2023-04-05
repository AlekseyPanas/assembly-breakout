.text

li $t0, 0xff000000
li $t1, -2

li $v0, 1
sra $a0, $t0, 24
syscall
