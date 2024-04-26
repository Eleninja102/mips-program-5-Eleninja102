# Author: Coleton Watt
# Date: 
# Description: Function to function stuff

.data  # Data used by the program
	helloMain: .asciiz "Hello from main\n"


.text  # Instructions/code of the actual program

.globl main
main:
	la $a0, helloMain
	jal printString
	
	jal HelloFunction
	
	jal Start_PrintArray

end_main:
	jal Exit

################################################################
# Procedure 
# Functional Description: 

# Argument parameters: 
# Return Value: 
################################################################
.data
	helloFun: .asciiz "Hello from Function\n"
.text
HelloFunction:
	#Begin register in the stack from Stack
	subi $sp, $sp, 36 #move sp to 36 bytes/9 register s0-s7 +ra
	sw $ra, 32($sp)
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $s7, 0($sp)
	#end save register from Stack
	
	la $a0, helloFun
	jal printString

End_HelloFunction:
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
	addi $sp, $sp, 36 #add back 4 bytes
	#End restore registers from Stack
	
	jr $ra
################################################################
# Procedure: Print Array
# Functional Description: print array elements

# Argument parameters: none
# Return Value: none
################################################################
.data
	myArray: .word 0x1010, 0x1020
			.word 0x1030, 0x1040 #word is 4 bytes
.text
Start_PrintArray:
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
PrintArray:
	

	li $t0, 0
loop:
	lw $a0, myArray($t0)
	jal printHex
	jal printNewLine
	addi $t0, $t0, 4
	
	beq $t0, 16, End_loop
	j loop
End_loop:

	
End_PrintArray:
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


##################################
.include "utilities.asm" #at the end of the file