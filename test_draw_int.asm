.text

li $t0, 10
li $t1, 80
li $t2, 999999999

# draw_int(Vec(10, 80), 56)
sw $t0, 0($sp)
subi $sp, $sp, 4
sw $t1, 0($sp)
subi $sp, $sp, 4
sw $t2, 0($sp)
subi $sp, $sp, 4
jal fn_draw_int
