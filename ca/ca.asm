# Author: Coleton Watt
# Date: November 21, 2022
# Description: Parse MIPS instructions based on opcode and print message

#.globl main, decode_instruction, process_instruction, print_hex_info			# Do not remove this line
.globl main, print_hex_info, Start_decode_instruction, Start_print_opcode_type
# Data for the program goes here
.data
	process: .asciiz "\nNow processing instruction "
	opcode_num: .asciiz "\tThe opcode value is: "
	newLine: .asciiz "\n"

	# number of test cases
	CASES: .word 5
	# array of pointers (addresses) to the instructions
	instructions:	.word 0x01095020, 		# add $t2, $t0, $t1
					.word 0x1220002C,  		# beqz $s1, label
					.word 0x3C011001,		# lw $a0, label($s0)
					.word 0x24020004,		# li $v0, 4
					.word 0x08100002		# j label


# Code goes here
.text
main:
	# Task 1A: Loop over the array of instructions 
li $s0,0

lw $t4, CASES
mul $s2, $t4, 4  #CASES*4 counts how many times it has to iterate 

loop_array:
	
	
	# 	Set registers and call: print_hex_info
	la $a0, process
	lw $a1, instructions($s0) #get instruction from array
	jal print_hex_info
	# 	Set registers and call: decode_instruction 
	lw $a0, instructions($s0) #get instruction from array
	jal Start_decode_instruction
	move $s1, $v0
	
	la $a0, opcode_num
	move $a1, $s1
	jal print_hex_info
	# Print first return value
	
	# 	Set registers and call: print_hex_info
	
	# Update branch and index values
	addi $s0, $s0, 4
	
	bne $s0, $s2,  loop_array	# end of loop
		
	
end_main:
	li $v0, 10		# 10 is the exit program syscall
	syscall			# execute call
###############################################################

## Other procedures here

###############################################################
# Print Message based on opcode type
#
# $a0 - Message to print
# $a1 - Value to print
# Uses $s0: address of string for $a0 (required)
# Uses $s1: value from $a1 (required)
print_hex_info:
	##### Begin Save registers to Stack
	subi  $sp, $sp, 36
	sw   $ra, 32($sp)
	sw   $s0, 28($sp)
	sw   $s1, 24($sp)
	sw   $s2, 20($sp)
	sw   $s3, 16($sp)
	sw   $s4, 12($sp)
	sw   $s5, 8($sp)
	sw   $s6, 4($sp)
	sw   $s7, 0($sp)
	##### End Save registers to Stack

	# Now your function begins here
	move $s0, $a0
	move $s1, $a1
	
	li $v0, 4				# print message
	move $a0, $s0
	syscall
	
	li $v0, 34				# print address in hex value
	move $a0, $s1
	syscall
	
	li $v0, 4				# print message
	la $a0, newLine
	syscall

end_print_hex_info:
	##### Begin Restore registers from Stack
	lw   $ra, 32($sp)
	lw   $s0, 28($sp)
	lw   $s1, 24($sp)
	lw   $s2, 20($sp)
	lw   $s3, 16($sp)
	lw   $s4, 12($sp)
	lw   $s5, 8($sp)
	lw   $s6, 4($sp)
	lw   $s7, 0($sp)
	addi $sp, $sp, 36
	##### End Restore registers from Stack
	
    jr $ra
###############################################################



################################################################
# Fetch instruction to correct procedure based on opcode for
# instruction parsing.

# Argument parameters:
# $a0 - input, 32-bit instruction to process (required)

# Uses: 
# $s0: for input parameter (required)
# $s1: for opcode value (required)

# Return Value:
# $v0 - output, instruction opcode (bits 31-26) value (required)
################################################################
.data

.text
Start_decode_instruction:
	#Begin register in the stack from Stack
	subi $sp, $sp, 36
	sw $ra, 32($sp)
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $s7, 0($sp)
	#End save register from Stack
decode_instruction:
	move $s0, $a0
	andi $s1, $s0, 0xFC000000
	srl $s1, $s1, 26
	
	move $a0, $s1
	jal Start_print_opcode_type
	
End_decode_instruction:
	move $v0, $s1
	
	#Begin restore registers from Stack
	lw $ra, 32($sp)
	lw $s0, 28($sp)
	lw $s1, 24($sp)
	lw $s2, 20($sp)
	lw $s3, 16($sp)
	lw $s4, 12($sp)
	lw $s5, 8($sp)
	lw $s6, 4($sp)
	lw $s7, 0($sp)
	addi $sp, $sp, 36 
	#End restore registers from Stack
	
	jr $ra

#################################
################################################################
# Print Opcode Type

# Argument parameters:
# $a0 - input, 32-bit instruction to process

# Uses:

# Return Value: none
################################################################
.data
	
	inst_0:		.asciiz "\tR-Type Instruction\n"
	inst_other:	.asciiz "\tUnsupported Instruction\n"
	inst_2_3:	.asciiz "\tUnconditional Jump\n"
	inst_4_5:	.asciiz "\tConditional Jump\n"

	# You may use this array of labels to print the different instructions type messages
	inst_types: .word inst_0, inst_other, inst_2_3, inst_2_3, inst_4_5, inst_4_5
.text
Start_print_opcode_type:
	#Begin register in the stack from Stack
	subi $sp, $sp, 36
	sw $ra, 32($sp)
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $s7, 0($sp)
	#End save register from Stack
print_opcode_type:
	move $t0, $a0 #copy a0 to t0
	
	la $v0, 1
	move $a0, $t0 #test print statement
	#syscall 
	
	#######
	#switch Statement 
	beq $t0, 0, RType
	beq $t0, 2, Unconditional
	beq $t0, 3, Unconditional
	beq $t0, 4, Conditional
	beq $t0, 5, Conditional
	j Unsupported

	RType: #if 0
		la $v0, 4
		la $t1, inst_types
		addi $t1, $t1, 0
		lw $a0, ($t1)
		syscall 
		j End_If
	Unsupported: #else
		la $v0, 4
		la $t1, inst_types
		addi $t1, $t1, 4
		lw $a0, ($t1)
		syscall 
		j End_If
	Unconditional: #if 2, 3
		la $v0, 4
		la $t2, inst_types
		addi $t2, $t2, 8
		lw $a0, ($t2)
		syscall 
		j End_If
	Conditional: # if 4, 5
		la $v0, 4
		la $t1, inst_types
		addi $t1, $t1, 16
		lw $a0, ($t1)
		syscall 
		j End_If
	End_If:

	
End_print_opcode_type:
	#Begin restore registers from Stack
	lw $ra, 32($sp)
	lw $s0, 28($sp)
	lw $s1, 24($sp)
	lw $s2, 20($sp)
	lw $s3, 16($sp)
	lw $s4, 12($sp)
	lw $s5, 8($sp)
	lw $s6, 4($sp)
	lw $s7, 0($sp)
	addi $sp, $sp, 36 
	#End restore registers from Stack
	
	jr $ra

#################################
