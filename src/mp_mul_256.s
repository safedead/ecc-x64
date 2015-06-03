	.file	"mp_mul_256.c"
	.text
	.p2align 4,,15
.globl mp_mul_256
	.type	mp_mul_256, @function
mp_mul_256:
.LFB0:
	.cfi_startproc
#	uint64_t mp_mul_256(uint64_t c[8], uint64_t a[4], uint64_t b[4])
#	rdi = c[]
#	rsi = a[]
#	rdx = b[]
#	--------------------------------------------
#	load (xmm4, xmm5) = (a[0], a[1], a[2], a[3]) 
#	load (xmm6, xmm7) = (b[0], b[1], b[2], b[3]) 
#	--------------------------------------------
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm5
	movdqa	(%rdx), %xmm6
	movdqa	16(%rdx), %xmm7
#	---------------------------
#	backup (r12, r13, r14, r15)
#	---------------------------
	movq	%r12, %xmm14
	movq	%r14, %xmm15
	pinsrq	$1, %r13, %xmm14
	pinsrq	$1, %r15, %xmm15
#	-----------------------------------------------
#	(r12, r13, r14, r15) = (a[1], a[3], b[1], b[3])
#	-----------------------------------------------
	pextrq	$1, %xmm4, %r12
	pextrq	$1, %xmm5, %r13
	pextrq	$1, %xmm6, %r14
	pextrq	$1, %xmm7, %r15
#	--------------
#	init (r9, r10)
#	--------------
	xorq	%r9, %r9
	xorq	%r10, %r10
#	-----------
#	a[0] * b[0]
#	-----------
	movq	%xmm6, %r11
	movq	%xmm4, %rax
	mulq	%r11
#	----
	movq	%rax, %xmm0
	movq	%rdx, %r8
#	-----------
#	a[0] * b[1]
#	a[1] * b[0]
#	-----------
	movq	%xmm4, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm6, %rax
	mulq	%r12
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	pinsrq	$1, %r8, %xmm0
	xorq	%r8, %r8
#	-----------
#	a[0] * b[2]
#	a[1] * b[1]
#	a[2] * b[0]
#	-----------
	movq	%xmm7, %r11
	movq	%xmm4, %rax
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	movq	%r12, %rax
	mulq	%r14
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	movq	%xmm6, %r11
	movq	%xmm5, %rax
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r10
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
	movq	%xmm4, %rax
	mulq	%r15
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm7, %rax
	mulq	%r12
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm5, %rax
	mulq	%r14
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%xmm6, %rax
	mulq	%r13
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %r10, %xmm1
	xorq	%r10, %r10
#	-----------
#	a[1] * b[3]
#	a[2] * b[2]
#	a[3] * b[1]
#	-----------
	movq	%r12, %rax
	mulq	%r15
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	movq	%xmm7, %r11
	movq	%xmm5, %rax
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	movq	%r13, %rax
	mulq	%r14
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	movq	%r8, %xmm2
	xorq	%r8, %r8
#	-----------
#	a[2] * b[3]
#	a[3] * b[2]
#	-----------
	movq	%xmm5, %rax
	mulq	%r15
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	movq	%xmm7, %rax
	mulq	%r13
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	pinsrq	$1, %r9, %xmm2
#	-----------
#	a[3] * b[3]
#	-----------
	movq	%r13, %rax
	mulq	%r15
	addq	%rax, %r10
	adcq	%rdx, %r8
#	----
	movq	%r10, %xmm3
	pinsrq	$1, %r8, %xmm3
#	----------------------------
#	restore (r12, r13, r14, r15)
#	----------------------------
	movq	%xmm14, %r12
	movq	%xmm15, %r14
	pextrq	$1, %xmm14, %r13
	pextrq	$1, %xmm15, %r15
#	-------------------------------
#	output (xmm0, xmm1, xmm2, xmm3) 
#	-------------------------------
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm3, 48(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE0:
	.size	mp_mul_256, .-mp_mul_256
	.p2align 4,,15
.globl mp_sqr_256
	.type	mp_sqr_256, @function
mp_sqr_256:
.LFB1:
	.cfi_startproc
#	uint64_t mp_sqr_256(uint64_t c[8], uint64_t a[4]);
#	rdi = c[]
#	rsi = a[]
#	--------------------------------------------
#	load (xmm4, xmm5) = (a[0], a[1], a[2], a[3]) 
#	--------------------------------------------
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm5
#	---------------------------
#	backup (r12, r13, r14, r15)
#	---------------------------
	movq	%r12, %xmm14
	movq	%r14, %xmm15
	pinsrq	$1, %r13, %xmm14
	pinsrq	$1, %r15, %xmm15
#	-----------------------------------------------
#	(r12, r13, r14, r15) = (a[0], a[1], a[2], a[3])
#	-----------------------------------------------
	movq	%xmm4, %r12
	movq	%xmm5, %r14
	pextrq	$1, %xmm4, %r13
	pextrq	$1, %xmm5, %r15
#	-----------
#	a[0] * a[0]
#	-----------
	movq	%r12, %rax
	mulq	%r12
#	----
	movq	%rax, %xmm0
	movq	%rdx, %r8
	xorq	%r9, %r9
	xorq	%r10, %r10
#	---------------
#	a[0] * a[1] * 2
#	---------------
	movq	%r12, %rax
	mulq	%r13
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	pinsrq	$1, %r8, %xmm0
	xorq	%r8, %r8
#	---------------
#	a[0] * a[2] * 2
#	a[1] * a[1]
#	---------------
	movq	%r12, %rax
	mulq	%r14
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	movq	%r13, %rax
	mulq	%r13
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	movq	%r9, %xmm1
	xorq	%r9, %r9
#	---------------
#	a[0] * a[3] * 2
#	a[1] * a[2] * 2
#	---------------
	movq	%r12, %rax
	mulq	%r15
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	movq	%r13, %rax
	mulq	%r14
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
	adcq	$0, %r9
#	----
	pinsrq	$1, %r10, %xmm1
	xorq	%r10, %r10
#	---------------
#	a[1] * a[3] * 2
#	a[2] * a[2]
#	---------------
	movq	%r13, %rax
	mulq	%r15
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	movq	%r14, %rax
	mulq	%r14
#	----
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
#	----
	movq	%r8, %xmm2
	xorq	%r8, %r8
#	---------------
#	a[2] * a[3] * 2
#	---------------
	movq	%r14, %rax
	mulq	%r15
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r8
#	----
	pinsrq	$1, %r9, %xmm2
#	-----------
#	a[3] * a[3]
#	-----------
	movq	%r15, %rax
	mulq	%r15
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
#	----
	movq	%r10, %xmm3
	pinsrq	$1, %r8, %xmm3
#	----------------------------
#	restore (r12, r13, r14, r15)
#	----------------------------
	movq	%xmm14, %r12
	movq	%xmm15, %r14
	pextrq	$1, %xmm14, %r13
	pextrq	$1, %xmm15, %r15
#	-------------------------------
#	output (xmm0, xmm1, xmm2, xmm3) 
#	-------------------------------
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm3, 48(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE1:
	.size	mp_sqr_256, .-mp_sqr_256
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-11)"
	.section	.note.GNU-stack,"",@progbits
