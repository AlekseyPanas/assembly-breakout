.text
.globl main

main:
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 50
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 60
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 40
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 30
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 30
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 50
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall


    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 30
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 40
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall


    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 40
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 40
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 50
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall
    
    
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 40
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 30
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall
    
    
    
    
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 20
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 30
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall
    
    
    
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 5
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 15
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 5
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 0
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 20
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_rect_collide
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    
    li $v0, 1
    addi $a0, $t1, 0
    syscall

j END_PROG


# Return 1 if rects collide, else 0
fn_rect_collide: # (Vec r1_tl, Vec r1_wh, Vec r2_tl, Vec r2_wh) -> int
    # t0 = r1.x
    # t1 = r1.w
    # t2 = r1.y
    # t3 = r1.h
    # t4 = r2.x
    # t5 = r2.w
    # t6 = r2.y 
    # t7 = r2.h
    addi $sp, $sp, 4
    lw $t7, 0($sp)
    addi $sp, $sp, 4
    lw $t5, 0($sp)
    addi $sp, $sp, 4
    lw $t6, 0($sp)
    addi $sp, $sp, 4
    lw $t4, 0($sp)
    addi $sp, $sp, 4
    lw $t3, 0($sp)
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    addi $sp, $sp, 4
    lw $t2, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)
    
    # t1 = r1.x + r1.w
    add $t1, $t0, $t1
    # t3 = r1.y + r1.h
    add $t3, $t2, $t3
    # t5 = r2.x + r2.w
    add $t5, $t4, $t5
    # t7 = r2.y + r2.h
    add $t7, $t6, $t7
    
    # s7 = ( (t4 <= t1 <= t5 || t4 <= t0 <= t5) && (t6 <= t2 <= t7 || t6 <= t3 <= t7) )
    sle $t8, $t1, $t5 # // t8 = t1 <= t5 
    sle $t9, $t4, $t1 # // t9 = t4 <= t1
    and $t8, $t8, $t9 # // t8 = t4 <= t1 <= t5
    sle $t9, $t0, $t5 # // t9 = t0 <= t5
    sle $s0, $t4, $t0 # // s0 = t4 <= t0
    and $t9, $t9, $s0 # // t9 = t4 <= t0 <= t5
    or $t8, $t8, $t9 # // t8 = t4 <= t1 <= t5 || t4 <= t0 <= t5
    sle $t9, $t6, $t2 # // t9 = t6 <= t2
    sle $s0, $t2, $t7 # // s0 = t2 <= t7
    and $t9, $t9, $s0 # // t9 = t6 <= t2 <= t7
    sle $s0, $t6, $t3 # // s0 = t6 <= t3
    sle $s1, $t3, $t7 # // s1 = t3 <= t7
    and $s0, $s0,$s1 # // s0 = t6 <= t3 <= t7
    or $t9, $t9, $s0 # // t9 = t6 <= t2 <= t7 || t6 <= t3 <= t7
    and $s7, $t8, $t9 # // s7 = (t4 <= t1 <= t5 || t4 <= t0 <= t5) && (t6 <= t2 <= t7 || t6 <= t3 <= t7)
    
    # // Swap rectangles. We need to check both ways, otherwise case where r2 inside r1 returns false
    # t0 <=> t4
    addi $t8, $t0, 0
    addi $t0, $t4, 0
    addi $t4, $t8, 0
    # t1 <=> t5
    addi $t8, $t1, 0
    addi $t1, $t5, 0
    addi $t5, $t8, 0
    # t2 <=> t6
    addi $t8, $t2, 0
    addi $t2, $t6, 0
    addi $t6, $t8, 0
    # t3 <=> t7
    addi $t8, $t3, 0
    addi $t3, $t7, 0
    addi $t7, $t8, 0
    
    # s6 = ( (t4 <= t1 <= t5 || t4 <= t0 <= t5) && (t6 <= t2 <= t7 || t6 <= t3 <= t7) )
    sle $t8, $t1, $t5 # // t8 = t1 <= t5 
    sle $t9, $t4, $t1 # // t9 = t4 <= t1
    and $t8, $t8, $t9 # // t8 = t4 <= t1 <= t5
    sle $t9, $t0, $t5 # // t9 = t0 <= t5
    sle $s0, $t4, $t0 # // s0 = t4 <= t0
    and $t9, $t9, $s0 # // t9 = t4 <= t0 <= t5
    or $t8, $t8, $t9 # // t8 = t4 <= t1 <= t5 || t4 <= t0 <= t5
    sle $t9, $t6, $t2 # // t9 = t6 <= t2
    sle $s0, $t2, $t7 # // s0 = t2 <= t7
    and $t9, $t9, $s0 # // t9 = t6 <= t2 <= t7
    sle $s0, $t6, $t3 # // s0 = t6 <= t3
    sle $s1, $t3, $t7 # // s1 = t3 <= t7
    and $s0, $s0,$s1 # // s0 = t6 <= t3 <= t7
    or $t9, $t9, $s0 # // t9 = t6 <= t2 <= t7 || t6 <= t3 <= t7
    and $s6, $t8, $t9 # // s6 = (t4 <= t1 <= t5 || t4 <= t0 <= t5) && (t6 <= t2 <= t7 || t6 <= t3 <= t7)
    
    # if (collide either way)
    or $t8, $s6, $s7
    beq $t8, 0, ELSE_rect_collide_1
    IF_rect_collide_1:
        # return 1
        li $t9, 1
        sw $t9, 0($sp)
        subi $sp, $sp, 4
        jr $ra
        
        j ENDIF_rect_collide_1
    ELSE_rect_collide_1:
        # return 0
        li $t9, 0
        sw $t9, 0($sp)
        subi $sp, $sp, 4
        jr $ra
    ENDIF_rect_collide_1:


END_PROG:

