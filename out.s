#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"Enter the number : "
str1:	.asciiz	"\nSelection Sort : "
str2:	.asciiz	" "
str3:	.asciiz	"\n"
	.text
	.globl	main
main:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp,	$sp
	addiu	$sp,	$sp,	-24
	li	$a0,	40
	li	$v0,	9
	syscall	
	sw	$v0,	-8($fp)
	move	$a0,	$v0
	li	$a0,	0
	sw	$a0,	0($fp)
	li	$a0,	0
	sw	$a0,	-4($fp)
while0:
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	10
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop0
	la	$a0,	str0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	jal	read_int
	sw	$a0,	-4($fp)
	lw	$a0,	-4($fp)
	move	$t1,	$a0
	lw	$a0,	0($fp)
	lw	$t2,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t2
	sw	$t1,	0($a0)
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	sw	$a0,	0($fp)
	b	while0
loop0:
	la	$a0,	str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	li	$a0,	0
	sw	$a0,	-16($fp)
while1:
	lw	$a0,	-16($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	9
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop1
	lw	$a0,	-16($fp)
	sw	$a0,	0($fp)
	lw	$a0,	-16($fp)
	sw	$a0,	-20($fp)
while2:
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	10
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop2
	lw	$a0,	0($fp)
	lw	$t1,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t1
	lw	$a0,	0($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	-20($fp)
	lw	$t1,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t1
	lw	$a0,	0($a0)
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	false0
true0:
	lw	$a0,	0($fp)
	sw	$a0,	-20($fp)
	b	endif0
false0:
endif0:
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	sw	$a0,	0($fp)
	b	while2
loop2:
	lw	$a0,	-16($fp)
	lw	$t1,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t1
	lw	$a0,	0($a0)
	sw	$a0,	-12($fp)
	lw	$a0,	-20($fp)
	lw	$t1,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t1
	lw	$a0,	0($a0)
	move	$t1,	$a0
	lw	$a0,	-16($fp)
	lw	$t2,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t2
	sw	$t1,	0($a0)
	lw	$a0,	-12($fp)
	move	$t1,	$a0
	lw	$a0,	-20($fp)
	lw	$t2,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t2
	sw	$t1,	0($a0)
	lw	$a0,	-16($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	sw	$a0,	-16($fp)
	b	while1
loop1:
	li	$a0,	0
	sw	$a0,	0($fp)
while3:
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	10
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0,	$t1,	$a0
	beqz	$a0,	loop3
	la	$a0,	str2
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	0($fp)
	lw	$t1,	-8($fp)
	sll	$a0,	$a0,	2
	add	$a0,	$a0,	$t1
	lw	$a0,	0($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_int
	lw	$a0,	0($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0,	1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0,	$t1,	$a0
	sw	$a0,	0($fp)
	b	while3
loop3:
	la	$a0,	str3
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	addiu	$sp,	$sp,	24
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
