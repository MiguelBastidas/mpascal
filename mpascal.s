	.data
string: .asciiz "factorial de: "
nline: 	.asciiz "\n"

	.text
main:
	li	$v0, 4
	la	$a0,string
	syscall

	li	$v0, 5
	syscall
	
	move 	$a0, $v0
	jal	fact
	
	move	%a0, %v0
	li	$v0, 1
	syscall
	

exit:
	li	$v0, 10
	syscall

fact:
	li	$t0, 1
	move 	$t1, $a0
loop:
	mult	$t0, $t1
	mflo	$t0

	addi	$t1, $t1, -1
	bgtz	$t1, loop
	
	move	$v0, $t0
	
	jr	$ra


