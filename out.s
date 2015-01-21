#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"ret"
str1:	.asciiz	"Enter the value to factorial : "
str2:	.asciiz	" "
str3:	.asciiz	"\n"
	.text
	.globl	main
sum:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	0
	lw	$a0,	12($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	16($fp)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	lw	$a0,	20($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	12
	jr	$ra	
main:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	-12
	li	$a0,	1
	sw	$a0,	0($fp)
	li	$a0,	0
	sw	$a0,	-4($fp)
	la	$a0,	str0
	sw	$a0,	-8($fp)
	la	$a0,	str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	li	$v0,	5
	syscall	
	sw	$v0,	-4($fp)
	move	$a0,	$v0
while0:
	li	$a0,	0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	-4($fp)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop0
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	-4($fp)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	mul	$a0,	$t1,	$a0
	sw	$a0,	0($fp)
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	sub	$a0,	$t1,	$a0
	sw	$a0,	-4($fp)
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	1
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	la	$a0,	str2
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	b	while0
loop0:
	la	$a0,	str3
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$a0,	-8($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	sum
	addiu	$sp,	$sp,	12
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp,	$sp,	4
	jr	$ra	
	jr	$ra	
#End of code
