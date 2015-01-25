#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"Enter size of string : "
str1:	.asciiz	"Enter the string : "
	.text
	.globl	main
main:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	-8
	la	$a0,	str0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	jal	read_int
	sw	$a0,	0($fp)
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	sbrk
	sw	$a0,	-4($fp)
	la	$a0,	str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	read_str
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	addiu	$sp,	$sp,	8
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
print_int:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	li	$v0,	1
	lw	$a0,	12($fp)
	syscall	
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
read_int:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	li	$v0,	5
	syscall	
	move	$a0,	$v0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	jr	$ra	
print_str:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	li	$v0,	4
	lw	$a0,	12($fp)
	syscall	
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
read_str:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	li	$v0,	8
	lw	$a0,	12($fp)
	lw	$a1,	16($fp)
	syscall	
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	8
	jr	$ra	
sbrk:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	li	$v0,	9
	lw	$a0,	12($fp)
	syscall	
	move	$a0,	$v0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
#End of code
