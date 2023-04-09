.data
NEWLINE: .asciiz "\n"

.text

main:

    # print(round(0.837)) // Expect 1
    li $v0, 1
    li $t1, 857
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    
    # print(round(0.488)) // Expect 0
    li $v0, 1
    li $t1, 500
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(8.67)) // Expect 9
    li $v0, 1
    li $t1, 8888
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(8.3)) // Expect 8
    li $v0, 1
    li $t1, 8500
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(3)) // Expect 3
    li $v0, 1
    li $t1, 3072
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 10
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(-12.32)) // Expect -12
    li $v0, 1
    li $t1, -1578
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 7
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(-24.656)) // Expect -25
    li $v0, 1
    li $t1, -1578
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 6
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall
    
    # print(round(7)) // Expect 7
    li $v0, 1
    li $t1, 1792
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    li $t1, 8
    sw $t1, 0($sp)
    subi $sp, $sp, 4
    jal fn_round
    addi $sp, $sp, 4
    lw $a0, 0($sp)
    syscall
    li $v0, 4
    la $a0, NEWLINE
    syscall

j END_PROG

# Given a float value shifted left by shift, round the value
# up or down based on the shift
# e.g 1.899 with a shift of 10 becomes 1945
# so round(1945, 10) = 2
fn_round: # (int value, int shift) -> int
    # t0 value
    # t1 shift
    addi $sp, $sp, 4
    lw $t1, 0($sp)
    addi $sp, $sp, 4
    lw $t0, 0($sp)
    
    # t2 lower_bound_unshifted = floor(value)  (unshifted)
    srav $t2, $t0, $t1
    # t3 lower_bound_shifted = floor(value)   (shifted)
    sllv $t3, $t2, $t1
    
    # if (value == lower_bound_shifted)
    bne $t3, $t0, ENDIF_fn_round_1
    IF_fn_round_1:
        # return lower_bound_unshifted
        sw $t2, 0($sp)
        subi $sp, $sp, 4
        jr $ra
    ENDIF_fn_round_1:
    
    # t4 upper_bound_unshifted = floor(value)  (unshifted)
    addi $t4, $t2, 1
    # t5 upper_bound_shifted = floor(value)  (shifted)
    sllv $t5, $t4, $t1
    
    # t6 diff_upper = abs(value - upper_bound_shifted)
    sub $t6, $t0, $t5
    bgtz $t6, ENDIF_fn_round_2
    IF_fn_round_2:
        neg $t6, $t6
    ENDIF_fn_round_2:
    
    # t7 diff_lower = abs(value - lower_bound_shifted)
    sub $t7, $t0, $t3
    bgtz $t7, ENDIF_fn_round_3
    IF_fn_round_3:
        neg $t7, $t7
    ENDIF_fn_round_3:
    
    ble $t6, $t7, ElSE_fn_round_1
    IF_fn_round_4: # if (diff_upper > diff_lower)
        # return lower_bound_unshifted
        sw $t2, 0($sp)
        subi $sp, $sp, 4
        jr $ra
    
        j ENDIF_fn_round_4
    ElSE_fn_round_1: # else // diff_upper <= diff_lower
        # return upper_bound_unshifted
        sw $t4, 0($sp)
        subi $sp, $sp, 4
        jr $ra
        
    ENDIF_fn_round_4:
    

END_PROG:
