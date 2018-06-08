	.data
string: .asciiz	"input depth of triangle: "
space:	.asciiz " "
nline:	.asciiz "\n"

	.text
main:		
	li	$v0, 4
	la	$a0, string
	syscall

	li	$v0, 5	
	syscall
	move	$t0, $v0

	move	$a0, $t0
	jal	ptriangle

exit:
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
	addi	$sp, $sp, 4
	jr	$ra

# pascal's triangle line
# void pline(int a)
pline:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	move	$t7, $a0
	li	$a1, 0
for:
	jal	comb
	
	move	$a0, $v0
	li	$v0, 1
	syscall

	la	$a0, space
	li	$v0, 4
	syscall

	move	$a0, $t7
	addi	$a1, $a1, 1
	ble	$a1, $a0, for

	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

# triangle
# void ptriangle(int a)
ptriangle:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	move 	$s0, $a0
	li	$s1, 0

l:
	move	$a0, $s1
	jal	pline
	
	li	$v0, 4
	la	$a0, nline
	syscall
	
	addi	$s1, $s1, 1
	blt	$s1, $s0, l
ex:
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
