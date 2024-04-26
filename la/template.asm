# Author: Coleton Watt
# Date: 
# Description: 

.data  # Data used by the program



.text  # Instructions/code of the actual program

.globl main
main:


end_main:
	jal Exit

################################################################
# Procedure: void Exit()
# Functional Description: Exit the rprogram 
# Argument parameters: none
# Return Value: none
################################################################
Exit:
	#exit the program using syscall 10 - exit
	li $v0, 10
	syscall
End_Exit:
	j $ra

################################################################
# Procedure 
# Functional Description: 

# Argument parameters: 
# Return Value: 
################################################################
.data

.text
Start_Function1:
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
Function1:
	
End_Function1:
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
.include "utilities.asm" #at the end of the file