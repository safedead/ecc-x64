	.file	"mp_mul_384.c"
	.text
	.p2align 4,,15
.globl mp_mul_384
	.type	mp_mul_384, @function
mp_mul_384:
.LFB0:
	.cfi_startproc
#	uint64_t mp_mul_384(uint64_t c[12], uint64_t a[6], uint64_t b[6])
#	rdi = c[]
#	rsi = a[]
#	rdx = b[]
#	-----------------------------------------------------------------
#	load (xmm6 , xmm7 , xmm8 ) = (a[0], a[1], a[2], a[3], a[4], a[5])
#	load (xmm9 , xmm10, xmm11) = (b[0], b[1], b[2], b[3], b[4], b[5])
#	-----------------------------------------------------------------
	movdqa	(%rsi), %xmm6
	movdqa	16(%rsi), %xmm7
	movdqa	32(%rsi), %xmm8
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
#	---------------------------
#	backup (r12, r13, r14, r15)
#	---------------------------
	movq	%r12, %xmm14
	movq	%r14, %xmm15
	pinsrq	$1, %r13, %xmm14
	pinsrq	$1, %r15, %xmm15
#	-----------------------------------------------------------------
#	r10 = a[1] r11 = a[3] r12 = a[5] r13 = b[1] r14 = b[3] r15 = b[5]
#	-----------------------------------------------------------------
	pextrq	$1, %xmm6, %r10
	pextrq	$1, %xmm7, %r11
	pextrq	$1, %xmm8, %r12
	pextrq	$1, %xmm9, %r13
	pextrq	$1, %xmm10, %r14
	pextrq	$1, %xmm11, %r15
#	------------------
#	init (r8, r9, rsi)
#	------------------
	xorq	%r8, %r8
	xorq	%r9, %r9
	xorq	%rsi, %rsi
#	-----------
#	a[0] * b[0]
#	-----------
	movq	%xmm6, %rcx
	movq	%xmm9, %rax
	mulq	%rcx
#	----
	movq	%rax, %xmm0
	movq	%rdx, %r8
#	-----------
#	a[0] * b[1]
#	a[1] * b[0]
#	-----------
	movq	%xmm6, %rax
	mulq	%r13
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm9, %rax
	mulq	%r10
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	pinsrq	$1, %r8, %xmm0
	xorq	%r8, %r8
#	-----------
#	a[0] * b[2]
#	a[1] * b[1]
#	a[2] * b[0]
#	-----------
	movq	%xmm10, %rcx
	movq	%xmm6, %rax
	mulq	%rcx
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r10, %rax
	mulq	%r13
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm9, %rcx
	movq	%xmm7, %rax
	mulq	%rcx
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r9, %xmm1
	xorq	%r9, %r9
#	-----------
#	a[0] * b[3]
#	a[1] * b[2]
#	a[2] * b[1]
#	a[3] * b[0]
#	-----------
	movq	%xmm6, %rax
	mulq	%r14
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm10, %rax
	mulq	%r10
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm7, %rax
	mulq	%r13
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm9, %rax
	mulq	%r11
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %rsi, %xmm1
	xorq	%rsi, %rsi
#	-----------
#	a[0] * b[4]
#	a[1] * b[3]
#	a[2] * b[2]
#	a[3] * b[1]
#	a[4] * b[0]
#	-----------
	movq	%xmm11, %rcx
	movq	%xmm6, %rax
	mulq	%rcx
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r10, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%xmm7, %rcx
	movq	%xmm10, %rax
	mulq	%rcx
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r11, %rax
	mulq	%r13
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%xmm9, %rcx
	movq	%xmm8, %rax
	mulq	%rcx
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r8, %xmm2
	xorq	%r8, %r8
#	-----------
#	a[0] * b[5]
#	a[1] * b[4]
#	a[2] * b[3]
#	a[3] * b[2]
#	a[4] * b[1]
#	a[5] * b[0]
#	-----------
	movq	%xmm6, %rax
	mulq	%r15
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm11, %rax
	mulq	%r10
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm7, %rax
	mulq	%r14
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm10, %rax
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm8, %rax
	mulq	%r13
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm9, %rax
	mulq	%r12
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	pinsrq	$1, %r9, %xmm2
	xorq	%r9, %r9
#	-----------
#	a[1] * b[5]
#	a[2] * b[4]
#	a[3] * b[3]
#	a[4] * b[2]
#	a[5] * b[1]
#	-----------
	movq	%r10, %rax
	mulq	%r15
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm11, %rcx
	movq	%xmm7, %rax
	mulq	%rcx
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r11, %rax
	mulq	%r14
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm10, %rcx
	movq	%xmm8, %rax
	mulq	%rcx
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r12, %rax
	mulq	%r13
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%rsi, %xmm3
	xorq	%rsi, %rsi
#	-----------
#	a[2] * b[5]
#	a[3] * b[4]
#	a[4] * b[3]
#	a[5] * b[2]
#	-----------
	movq	%xmm7, %rax
	mulq	%r15
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%xmm11, %rax
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%xmm8, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%xmm10, %rax
	mulq	%r12
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	pinsrq	$1, %r8, %xmm3
	xorq	%r8, %r8
#	-----------
#	a[3] * b[5]
#	a[4] * b[4]
#	a[5] * b[3]
#	-----------
	movq	%r11, %rax
	mulq	%r15
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%xmm11, %r11
	movq	%xmm8, %rax
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r12, %rax
	mulq	%r14
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r9, %xmm4
	xorq	%r9, %r9
#	-----------
#	a[4] * b[5]
#	a[5] * b[4]
#	-----------
	movq	%xmm8, %rax
	mulq	%r15
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm11, %rax
	mulq	%r12
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %rsi, %xmm4
#	-----------
#	a[5] * b[5]
#	-----------
	movq	%r12, %rax
	mulq	%r15
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%r8, %xmm5
	pinsrq	$1, %r9, %xmm5
#	--------------------------------------
#	restore (r12, r13, r14, r15)
#	--------------------------------------
	movq	%xmm14, %r12
	movq	%xmm15, %r14
	pextrq	$1, %xmm14, %r13
	pextrq	$1, %xmm15, %r15
#	-------------------------------------------
#	output (xmm0, xmm1, xmm2, xmm3, xmm4, xmm5) 
#	-------------------------------------------
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm4, 64(%rdi)
	movdqa	%xmm5, 80(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE0:
	.size	mp_mul_384, .-mp_mul_384
	.p2align 4,,15
.globl mp_sqr_384
	.type	mp_sqr_384, @function
mp_sqr_384:
.LFB1:
	.cfi_startproc
#	uint64_t mp_sqr_384(uint64_t c[12], uint64_t a[6])
#	rdi = c[]
#	rsi = a[]
#	---------------------------------------------------------------
#	load (xmm6, xmm7, xmm8 ) = (a[0], a[1], a[2], a[3], a[4], a[5])
#	---------------------------------------------------------------
	movdqa	(%rsi), %xmm6
	movdqa	16(%rsi), %xmm7
	movdqa	32(%rsi), %xmm8
#	---------------------------
#	backup (r12, r13, r14, r15)
#	---------------------------
	movq	%r12, %xmm14
	movq	%r14, %xmm15
	pinsrq	$1, %r14, %xmm14
	pinsrq	$1, %r15, %xmm15
#	-----------------------------------------------------------------
#	r10 = a[0] r11 = a[1] r12 = a[2] r13 = a[3] r14 = a[4] r15 = a[5]
#	-----------------------------------------------------------------
	movq	%xmm6, %r10
	movq	%xmm7, %r12
	movq	%xmm8, %r14
	pextrq	$1, %xmm6, %r11
	pextrq	$1, %xmm7, %r13
	pextrq	$1, %xmm8, %r15
#	------------------
#	init (r8. r9, rsi)
#	------------------
	xorq	%r8, %r8
	xorq	%r9, %r9
	xorq	%rsi, %rsi
#	-----------
#	a[0] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r10
#	----
	movq	%rax, %xmm0
	movq	%rdx, %r8
#	-----------
#	a[0] * a[1]
#	a[1] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	pinsrq	$1, %r8, %xmm0
	xorq	%r8, %r8
#	-----------
#	a[0] * a[2]
#	a[1] * a[1]
#	a[2] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r12
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r11, %rax
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r9, %xmm1
	xorq	%r9, %r9
#	-----------
#	a[0] * a[3]
#	a[1] * a[2]
#	a[2] * a[1]
#	a[3] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r13
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r11, %rax
	mulq	%r12
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %rsi, %xmm1
	xorq	%rsi, %rsi
#	-----------
#	a[0] * a[4]
#	a[1] * a[3]
#	a[2] * a[2]
#	a[3] * a[1]
#	a[4] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r11, %rax
	mulq	%r13
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r12, %rax
	mulq	%r12
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r8, %xmm2
	xorq	%r8, %r8
#	-----------
#	a[0] * a[5]
#	a[1] * a[4]
#	a[2] * a[3]
#	a[3] * a[2]
#	a[4] * a[1]
#	a[5] * a[0]
#	-----------
	movq	%r10, %rax
	mulq	%r15
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r11, %rax
	mulq	%r14
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r12, %rax
	mulq	%r13
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	pinsrq	$1, %r9, %xmm2
	xorq	%r9, %r9
#	-----------
#	a[1] * a[5]
#	a[2] * a[4]
#	a[3] * a[3]
#	a[4] * a[2]
#	a[5] * a[1]
#	-----------
	movq	%r11, %rax
	mulq	%r15
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r12, %rax
	mulq	%r14
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r13, %rax
	mulq	%r13
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%rsi, %xmm3
	xorq	%rsi, %rsi
#	-----------
#	a[2] * a[5]
#	a[3] * a[4]
#	a[4] * a[3]
#	a[5] * a[2]
#	-----------
	movq	%r12, %rax
	mulq	%r15
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	movq	%r13, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %rsi
#	----
	pinsrq	$1, %r8, %xmm3
	xorq	%r8, %r8
#	-----------
#	a[3] * a[5]
#	a[4] * a[4]
#	a[5] * a[3]
#	-----------
	movq	%r13, %rax
	mulq	%r15
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r14, %rax
	mulq	%r14
	addq	%rax, %r9
	adcq	%rdx, %rsi
	adcq	$0, %r8
#	----
	movq	%r9, %xmm4
	xorq	%r9, %r9
#	-----------
#	a[4] * a[5]
#	a[5] * a[4]
#	-----------
	movq	%r14, %rax
	mulq	%r15
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %rsi
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %rsi, %xmm4
#	-----------
#	a[5] * a[5]
#	-----------
	movq	%r15, %rax
	mulq	%r15
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%r8, %xmm5
	pinsrq	$1, %r9, %xmm5
#	----------------------------
#	restore (r12, r13, r14, r15)
#	----------------------------
	movq	%xmm14, %r12
	movq	%xmm15, %r14
	pextrq	$1, %xmm14, %r13
	pextrq	$1, %xmm15, %r15
#	-------------------------------------------
#	output (xmm0, xmm1, xmm2, xmm3, xmm4, xmm5) 
#	-------------------------------------------
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm4, 64(%rdi)
	movdqa	%xmm5, 80(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE1:
	.size	mp_sqr_384, .-mp_sqr_384
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-11)"
	.section	.note.GNU-stack,"",@progbits
