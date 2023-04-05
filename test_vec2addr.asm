.text

li $t0, 50
    
# addr = fn_vec2addr(Vec(50, 50))
sw $t0, 0($sp) 
subi, $sp, $sp, 4
sw $t0, 0($sp)
subi, $sp, $sp, 4
jal fn_vec2addr
addi, $sp, $sp, 4
lw $t0, 0($sp)

# display[addr] = red
lw $t1, ADDR_DSPL
add $t1, $t1, $t0
li $t3, 0x00ff0000
sw $t3, 0($t1)

# print_double(addr)
li $v0, 1
addi $a0, $t0, 0
syscall
li $v0, 4
la $a0, NEWLINE
syscall
