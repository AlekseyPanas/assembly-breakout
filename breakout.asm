################ CSC258H1F Fall 2022 Assembly Final Project ##################
# This file contains your implementation of Breakout.
#
# Student 1: Aleksey Panas, 1007766268
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       8
# - Unit height in pixels:      8
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL: .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD: .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

# x and y are both 0 - 31
# 55 = termination
# 56 = 
bricks_x: .word 0:1000
bricks_y: .word 0:1000

walls_x: .word 0:1000
walls_y: .word 0:1000

ball_x: .word 0
ball_y: .word 0

ball_vel_x: .word 0
ball_vel_y: .word 0

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Brick Breaker game.

main:
    # Initialize the game
    # jal generate_level
    

game_loop:
	# 1a. Check if key has been pressed
	
	
	# 1b. Check which key has been pressed
   	lw $t0, ADDR_KBRD # Get keyboard address
   	lw $t1, 0($t0) # Get if keypress
   	
   	beq $t1, 1, IF # if keypress
   	j ENDIF
	IF:
		lw $t2, 4($t0)
	ENDIF:
	
	
	# 2a. Check for collisions
	

	# 2b. Update locations (paddle, ball)
		
		
	# 3. Draw the screen
	li $t1, 0 # column counter (col)
	li $t2, 0 # row counter (row)
	
	li $t3, 0xff1111 # color = red
	li $t6, 0x555555 # wall_color = gray
	
	LOOP_draw:
		beq $t2, 8, ENDLOOP_draw # while row < 8
		
		# t4 = 128 * row
		li $t4, 128
		mult $t2, $t4
		mflo $t4
		
		# t5 = 20 * col
		li $t5, 20
		mult $t1, $t5
		mflo $t5
		
		lw $t0, ADDR_DSPL # cursor = 0 // load address display
		addi $t0, $t0, 132 # cursor += 132 // 128 skips top row, +4 to skip leftside vertical wall
		add $t0, $t0, $t5 # cursor += t5 // move to current column location
		add $t0, $t0, $t4 # cursor += t4 // move to current row location
		
		sw $t3, 0($t0) # display[cursor] = color
		sw $t3, 4($t0) # display[cursor + 4] = color
		sw $t3, 8($t0) # display[cursor + 8] = color
		sw $t3, 12($t0) # display[cursor + 12] = color
		sw $t3, 16($t0) # display[cursor + 16] = color
		
		addi $t1, $t1, 1 # col ++
		
		beq $t1, 6, IF_inc_row # if col == 6
		j ENDIF_inc_row
		IF_inc_row:
			li $t1, 0 # col = 0
			addi $t2, $t2, 1 # row ++
			
			# if color == red
			beq $t3, 0xff1111, IF_color_red
			j ENDIF_color_red
			IF_color_red:
				li $t3 0x11ffa1 # color = green
				j ENDIF_color_blue # break
			ENDIF_color_red:
			
			# if color == green
			beq $t3, 0x11ffa1, IF_color_green
			j ENDIF_color_green
			IF_color_green:
				li $t3 0xb88335 # color = brown
				j ENDIF_color_blue # break
			ENDIF_color_green:
			
			# if color == brown
			#b88335
			beq $t3, 0xb88335, IF_color_brown
			j ENDIF_color_brown
			IF_color_brown:
				li $t3 0x2222ff # color = blue
				j ENDIF_color_blue # break
			ENDIF_color_brown:
			
			# if color == blue
			beq $t3, 0x2222ff, IF_color_blue
			j ENDIF_color_blue
			IF_color_blue:
				li $t3 0xff1111 # color = red
			ENDIF_color_blue:
		ENDIF_inc_row:
		
		j LOOP_draw
	ENDLOOP_draw:
		
	li $t1, 0 # i = 0
	LOOP_wall:
		beq $t1, 32, ENDLOOP_wall # while i < 32

		lw $t0, ADDR_DSPL # cursor = 0
		
		# t4 = 128 * i
		li $t4, 128
		mult $t1, $t4
		mflo $t4
		
		add $t0, $t0, $t4 # cursor += t4
		sw $t6, 0($t0) # display[cursor] = wall_color
		addi $t0, $t0, 124 # cursor += 116
		sw $t6, 0($t0) # display[cursor] = wall_color
		
		lw $t0, ADDR_DSPL # cursor = 0
		
		# t4 = 4 * i
		li $t4, 4
		mult $t1, $t4
		mflo $t4
		
		add $t0, $t0, $t4 # cursor += t4
		sw $t6, 0($t0) # display[cursor] = wall_color

		addi $t1, $t1, 1 # i ++
		j LOOP_wall
	ENDLOOP_wall:

	# 4. Sleep

	#5. Go back to 1
	b game_loop
	
generate_level:
	li $t0, 0
	
LOOP:	# Generate left vertical wall
	beq $t0, 32, ENDLOOP # Loop condition
	
	
	
	addi $t0, $t0, 1 # t0++
	j LOOP 
ENDLOOP: 
	

	jr $ra
	
	
	
	
	
