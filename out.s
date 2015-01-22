#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"Enter the number : "
str1:	.asciiz	"\n"
str2:	.asciiz	"The factorial is : "
	.text
	.globl	main
fact:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	0
	lw	$a0,	12($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	seq	$a0,	$t1,	$a0
	beqz	$a0,	false0
true0:
	li	$a0,	1
	b	endif0
false0:
	lw	$a0,	12($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	12($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	sub	$a0,	$t1,	$a0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	fact
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	mul	$a0,	$t1,	$a0
endif0:
	addiu	$sp,	$sp,	0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
main:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	-8
	li	$a0,	1
	sw	$a0,	0($fp)
	la	$a0,	str0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	jal	read_int
	sw	$a0,	-4($fp)
	la	$a0,	str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	fact
	sw	$a0,	0($fp)
	la	$a0,	str2
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_int
	la	$a0,	str1
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
#End of code
