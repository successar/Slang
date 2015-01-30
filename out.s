#Start of Code
	.data
str:	.asciiz "\n"
str0:	.asciiz	"Account info : "
str1:	.asciiz	"\nAccount no : "
str2:	.asciiz	"\nAccount name : "
str3:	.asciiz	"\nAccount balance : "
str4:	.asciiz	"\n"
str5:	.asciiz	"Account number : "
str6:	.asciiz	"Account name : "
str7:	.asciiz	"Account balance : "
	.text
	.globl	main
print:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp, $sp
	addiu	$sp, $sp, 0
	la	$a0, str0
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	la	$a0, str1
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	12($fp)
	lw	$a0,	0($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_int
	la	$a0, str2
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	12($fp)
	lw	$a0,	4($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	la	$a0, str3
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	lw	$a0,	12($fp)
	lw	$a0,	8($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_int
	la	$a0, str4
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	li	$a0, 0
	addiu	$sp, $sp, 0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp, $sp, 4
	jr	$ra	
read_acc:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp, $sp
	addiu	$sp, $sp, 0
	la	$a0, str5
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	jal	read_int
	move	$t1, $a0
	lw	$a0,	12($fp)
	sw	$t1,	0($a0)
	la	$a0, str6
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	li	$a0, 15
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	lw	$a0,	12($fp)
	lw	$a0,	4($a0)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	read_str
	la	$a0, str7
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print_str
	jal	read_int
	move	$t1, $a0
	lw	$a0,	12($fp)
	sw	$t1,	8($a0)
	li	$a0, 0
	addiu	$sp, $sp, 0
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp, $sp, 4
	jr	$ra	
main:
	sw	$fp,	0($sp)
	addiu	$sp,	$sp,	-4
	sw	$ra,	0($sp)
	addiu	$sp,	$sp,	-4
	move	$fp, $sp
	addiu	$sp, $sp, -12
	li	$a0, 40
	li	$v0, 9
	syscall	
	sw	$v0,	0($fp)
	move	$a0, $v0
	li	$a0, 0
	sw	$a0,	-8($fp)
while0:
	lw	$a0,	-8($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0, 10
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	slt	$a0, $t1, $a0
	beqz	$a0, loop0
	li	$a0, 12
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	sbrk
	move	$t1, $a0
	lw	$a0,	-8($fp)
	lw	$t2,	0($fp)
	sll	$a0, $a0, 2
	add	$a0, $a0, $t2
	sw	$t1,	0($a0)
	lw	$a0,	-8($fp)
	lw	$t1,	0($fp)
	sll	$a0, $a0, 2
	add	$a0, $a0, $t1
	lw	$a0,	0($a0)
	sw	$a0,	-4($fp)
	li	$a0, 16
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	sbrk
	move	$t1, $a0
	lw	$a0,	-4($fp)
	sw	$t1,	4($a0)
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	read_acc
	lw	$a0,	-4($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	jal	print
	lw	$a0,	-8($fp)
	sw	$a0,	0($sp)
	addiu	$sp,	$sp,	-4
	li	$a0, 1
	lw	$t1,	4($sp)
	addiu	$sp,	$sp,	4
	add	$a0, $t1, $a0
	sw	$a0,	-8($fp)
	b	while0
loop0:
	addiu	$sp, $sp, 12
	lw	$ra,	4($sp)
	addiu	$sp,	$sp,	4
	lw	$fp,	4($sp)
	addiu	$sp,	$sp,	4
	addiu	$sp, $sp, 4
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
