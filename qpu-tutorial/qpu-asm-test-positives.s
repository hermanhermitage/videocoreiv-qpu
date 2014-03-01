# qpu-asm-test-positives.s
#
# This file is intended to be a set of positive tests for the qpu assembler.
# It should succeed with no errors.
#
# Run:
#  nodejs qpuasm.js qpu-asm-test-positives.s

.set a, 1
.set b, 2

	mov r0, a+b
	add r0, r1, a+b
	add r0, a+b, a+b
	nop; mov r0, a+b
	nop; mul24 r0, r1, a+b
	nop; mul24 r0, a+b, a+b
	add r0, a+b, a+b; mul24 r0, a+b, a+b

	# Add ALU operations
	nop
	fadd r0, r1, r2
	fsub r0, r1, r2
	fmin r0, r1, r2
	fmax r0, r1, r2
	fminabs r0, r1, r2
	fmaxabs r0, r1, r2
	ftoi r0, r1
	itof r0, r1
	add r0, r1, r2
	sub r0, r1, r2
	shr r0, r1, r2
	asr r0, r1, r2
	ror r0, r1, r2
	shl r0, r1, r2
	min r0, r1, r2
	max r0, r1, r2
	and r0, r1, r2
	or r0, r1, r2
	xor r0, r1, r2
	not r0, r1
	clz r0, r1
	v8adds r0, r1, r2
	v8subs r0, r1, r2
	mov r0, r1

	# Mul operations
	nop; fmul r0, r1, r2
	nop; mul24 r0, r1, r2
	nop; v8muld r0, r1, r2
	nop; v8min r0, r1, r2
	nop; v8max r0, r1, r2
	nop; v8adds r0, r1, r2
	nop; v8subs r0, r1, r2
	nop; mov r0, r1

	# Control operations
	nop; nop; bkpt
	nop; nop; nop
	nop; nop; thrsw
	nop; nop; thrend
	nop; nop; sbwait
	nop; nop; sbdone
	nop; nop; lthrsw
	nop; nop; loadcv
	nop; nop; loadc
	nop; nop; ldcend
	nop; nop; ldtmu0
	nop; nop; ldtmu1
	nop; nop; loadam

	# ldi
	ldi r0, 0x12345678

	# sacq
	sacq -, 0
	sacq -, 1
	sacq -, 2
	sacq -, 3
	sacq -, 4
	sacq -, 5
	sacq -, 6
	sacq -, 7
	sacq -, 8
	sacq -, 9
	sacq -, 10
	sacq -, 11
	sacq -, 12
	sacq -, 13
	sacq -, 14
	sacq -, 15
	
	# srel
	srel -, 0
	srel -, 1
	srel -, 2
	srel -, 3
	srel -, 4
	srel -, 5
	srel -, 6
	srel -, 7
	srel -, 8
	srel -, 9
	srel -, 10
	srel -, 11
	srel -, 12
	srel -, 13
	srel -, 14
	srel -, 15

	# crazy sacq, srel
	sacq r0, 0; sacq r1, 0
	nop; sacq -, 0

	# bra
	bra -, 0
	bra -, +0
	bra -, -0

	# brr
	brr -, 0
	brr -, +0
	brr -, -0

