.data

SAVE_FILE: .asciiz "./save.txt"
BUF: .byte 65:100

.text

li $v0, 13
la $a0, SAVE_FILE
li $a1, 1
syscall
addi $a0, $v0, 0
li $v0, 15
la $a1, BUF
li $a2 50
syscall



