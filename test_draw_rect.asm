.text

li $t0, 30
li $t1, 10
li $t2, 60
li $t3, 50
li $t4, 0x00aa11ff

# erase(Rect(purple, Vec(30, 10), Vec(60, 50)))
sw $t4, 0($sp)
subi $sp, $sp, 4
sw $t0, 0($sp)
subi $sp, $sp, 4
sw $t1, 0($sp)
subi $sp, $sp, 4
sw $t2, 0($sp)
subi $sp, $sp, 4
sw $t3, 0($sp)
subi $sp, $sp, 4
jal fn_draw_rect
