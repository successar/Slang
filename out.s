#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"Enter the value to fibonacci : "
str1:	.asciiz	" "
str2:	.asciiz	"\n"
	.text
	.globl	main
main:
	move	$fp,	$sp
	addiu	$sp,	$sp,	-16
	li	$a0,	0
	sw	$a0,	0($fp)
	li	$a0,	1
	sw	$a0,	4($fp)
	li	$a0,	0
	sw	$a0,	8($fp)
	li	$a0,	0
	sw	$a0,	12($fp)
	la	$a0,	str0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	li	$v0,	5
	syscall	
	sw	$v0,	12($fp)
	move	$a0,	$v0
while0:
	li	$a0,	0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	12($fp)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop0
	lw	$a0,	8($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	1
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	la	$a0,	str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$a0,	4($fp)
	sw	$a0,	0($fp)
	lw	$a0,	8($fp)
	sw	$a0,	4($fp)
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	4($fp)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	sw	$a0,	8($fp)
	lw	$a0,	12($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	sub	$a0,	$t1,	$a0
	sw	$a0,	12($fp)
	b	while0
loop0:
	la	$a0,	str2
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$v0,	4
	syscall	
	lw	$a0,	4($sp)
	addiu	$sp,	$sp,	4
	jr	$ra	
#End of code
