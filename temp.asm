.data

thing: .word 0x12345678, 0x9abcdef0

menu_state: .word 0x08020300, 0x00000045  # struct MenuState

.text
la $t0, menu_state

lbu $t1, 0($t0)
lbu $t2, 1($t0)
lbu $t3, 2($t0)
lbu $t4, 3($t0)

lw $t5, 4($t0)



