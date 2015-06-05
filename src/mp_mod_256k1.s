	.file	"mp_mod_256k1.c"
	.text
	.p2align 4,,15
.globl mp_mod_256k1
	.type	mp_mod_256k1, @function
mp_mod_256k1:
.LFB0:
	.cfi_startproc
#	uint64_t mp_mod_256k1(uint64_t r[4], uint64_t a[8])
#	rdi = r[]
#	rsi = a[]
#	----------------
#	load source data
#	----------------
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
#	|---------|---------|---------|---------|
#	|  xmm0   |  xmm1   |  xmm2   |  xmm3   |
#	|----|----|----|----|----|----|----|----|
#	|a[0]|a[1]|a[2]|a[3]|a[4]|a[5]|a[6]|a[7]|
#	|----|----|----|----|----|----|----|----|
#	--------------------------------------------------------------------
#	rsi = (2 ^ 32) + (2 ^ 9) + (2 ^ 8) + (2 ^ 7) + (2 ^ 6) + (2 ^ 4) + 1
#	--------------------------------------------------------------------
	movq	$0x1000003d1, %rsi
#	----------
#	r8  = a[3]
#	r9  = a[4]
#	r10 = a[5]
#	r11 = a[6]
#	rax = a[7]
#	----------
	pextrq	$1, %xmm1, %r8
	movq	%xmm2, %r9
	pextrq	$1, %xmm2, %r10
	movq	%xmm3, %r11
	pextrq	$1, %xmm3, %rax
#	-------------------
#	rax:rdx = rsi * rax
#	-------------------
	mulq	%rsi
#	|---|---|---|---|
#	|rax|rdx| 0 | 0 |
#	|---|---|---|---|
#	| + |(+)|(+)|(+)|
#	|---|---|---|---|
#	|r8 |r9 |r10|r11|
#	|---|---|---|---|
#	|[3]|[4]|[5]|[6]|
#	|---|---|---|---|
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
	adcq	$0, %r11
	jnc	.L1
	addq	%rsi, %r8
	adcq	$0, %r9
	adcq	$0, %r10
	adcq	$0, %r11
.L1:
#	-------------------
#	rax:rdx = rsi * r11
#	-------------------
	movq	%r11, %rax
	mulq	%rsi
#	|---|---|---|---|
#	|rax|rdx| 0 | 0 |
#	|---|---|---|---|
#	| + |(+)|(+)|(+)|
#	|---|---|---|---|
#	|r11|r8 |r9 |r10|
#	|---|---|---|---|
#	|[2]|[3]|[4]|[5]|
#	|---|---|---|---|
	movq	%xmm1, %r11
	addq	%rax, %r11
	adcq	%rdx, %r8
	adcq	$0, %r9
	adcq	$0, %r10
	jnc	.L2
	addq	%rsi, %r11
	adcq	$0, %r8
	adcq	$0, %r9
	adcq	$0, %r10
.L2:	
#	-------------------
#	rax:rdx = rsi * r10
#	-------------------
	movq	%r10, %rax
	mulq	%rsi
#	|---|---|---|---|
#	|rax|rdx| 0 | 0 |
#	|---|---|---|---|
#	| + |(+)|(+)|(+)|
#	|---|---|---|---|
#	|r10|r11|r8 |r9 |
#	|---|---|---|---|
#	|[1]|[2]|[3]|[4]|
#	|---|---|---|---|
	pextrq	$1, %xmm0, %r10
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r8
	adcq	$0, %r9
	jnc	.L3
	addq	%rsi, %r10
	adcq	$0, %r11
	adcq	$0, %r8
	adcq	$0, %r9
.L3:
#	-------------------
#	rax:rdx = rsi * r9
#	-------------------
	movq	%r9, %rax
	mulq	%rsi
#	|---|---|---|---|
#	|rax|rdx| 0 | 0 |
#	|---|---|---|---|
#	| + |(+)|(+)|(+)|
#	|---|---|---|---|
#	|r9 |r10|r11|r8 |
#	|---|---|---|---|
#	|[0]|[1]|[2]|[3]|
#	|---|---|---|---|
	movq	%xmm0, %r9
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
	adcq	$0, %r8
	jnc	.L4
	addq	%rsi, %r9
	adcq	$0, %r10
	adcq	$0, %r11
	adcq	$0, %r8
.L4:
#	------
#	finish
#	------
	movq	%r9, %xmm4
	movq	%r11, %xmm5
	pinsrq	$1, %r10, %xmm4
	pinsrq	$1, %r8, %xmm5
#	|---------|---------|
#	|  xmm4   |  xmm5   |
#	|----|----|----|----|
#	|r[0]|r[1]|r[2]|r[3]|
#	|----|----|----|----|
	movdqa	%xmm4, (%rdi)
	movdqa	%xmm5, 16(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE0:
	.size	mp_mod_256k1, .-mp_mod_256k1
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-11)"
	.section	.note.GNU-stack,"",@progbits
