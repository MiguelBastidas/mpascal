	.data
string: .asciiz	"input two numbers to compute nCr.\nn: "
string2:.asciiz "r: "
nline:	.asciiz "\n"

	.text
main:		
	li	$v0, 4
	la	$a0, string
	syscall

	li	$v0, 5	
	syscall
	move	$t0, $v0

	li	$v0, 4
	la	$a0, string2
	syscall

	li	$v0, 5	
	syscall
	move	$t1, $v0

	move	$a0, $t0
	move	$a1, $t1
	jal	comb

exit:		
	move	$a0, $v0
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, nline
	syscall

	li	$v0, 10
	syscall


# int fact(int a);
fact:
	li	$t8, 1
	move	$t9, $a0
loop:
	beq	$t9, $zero, quit
	mult	$t8, $t9
	mflo	$t8
	addi	$t9, $t9, -1
	bgtz	$t9, loop

quit:
	move	$v0, $t8
	jr	$ra

# int comb(int a, int b);
# aCb = a!/b!(a-b)!
# t0 = a, t1 = b
# t2 = a - b
# t3 = a!, t4 = b!
# t5 = (a - b)!
# t6 = t4 * t5
comb:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	sub	$t2, $a0, $a1
	move	$t0, $a0
	move	$t1, $a1

	jal 	fact
	move	$t3, $v0

	move	$a0, $t1
	jal 	fact
	move	$t4, $v0

	move	$a0, $t2
	jal	fact
	move	$t5, $v0

	mult	$t4, $t5
	mflo	$t6

	div	$t3, $t6
	mflo	$v0

	lw	$ra, 0($sp)
	jr	$ra

