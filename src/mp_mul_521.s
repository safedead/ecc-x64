	.file	"mp_mul_521.c"
	.text
	.p2align 4,,15
.globl mp_mul_521
	.type	mp_mul_521, @function
mp_mul_521:
.LFB0:
	.cfi_startproc
#	uint64_t mp_mul_521(uint64_t c[18], uint64_t a[10], uint64_t b[10])
#	rdi = c[]
#	rsi = a[]
#	rdx = b[]
#	------------------------
#	load a[0~9] to xmm0~xmm4
#	------------------------
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	movdqa	64(%rsi), %xmm4
#	------------------------
#	load b[0~9] to xmm5~xmm9
#	------------------------
	movdqa	(%rdx), %xmm5
	movdqa	16(%rdx), %xmm6
	movdqa	32(%rdx), %xmm7
	movdqa	48(%rdx), %xmm8
	movdqa	64(%rdx), %xmm9
#	-----------------------
#	r10 = 0xFFFFFFFFFFFFFFF
#	-----------------------
	movq	$0xFFFFFFFFFFFFFFF, %r10
#	-----------
#	a[0] * b[0]
#	-----------
	movq	%xmm0, %rax
	movq	%xmm5, %r11
	mulq	%r11
	movq	%rax, %r8
	movq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm10
	xorq	%r8, %r8
#	-----------
#	a[0] * b[1]
#	a[1] * b[0]
#	-----------
	movq	%xmm0, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm0, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm10
	xorq	%r9, %r9
#	-----------
#	a[0] * b[2]
#	a[1] * b[1]
#	a[2] * b[0]
#	-----------
	movq	%xmm0, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm0, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm1, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm11
	xorq	%r8, %r8
#	-----------
#	a[0] * b[3]
#	a[1] * b[2]
#	a[2] * b[1]
#	a[3] * b[0]
#	-----------
	movq	%xmm0, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm0, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm1, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm1, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm11
	xorq	%r9, %r9
#	-----------
#	a[0] * b[4]
#	a[1] * b[3]
#	a[2] * b[2]
#	a[3] * b[1]
#	a[4] * b[0]
#	-----------
	movq	%xmm0, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm0, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm1, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm1, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm2, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm12
	xorq	%r8, %r8
#	-----------
#	a[0] * b[5]
#	a[1] * b[4]
#	a[2] * b[3]
#	a[3] * b[2]
#	a[4] * b[1]
#	a[5] * b[0]
#	-----------
	movq	%xmm0, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm0, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm1, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm1, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm2, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm2, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm12
	xorq	%r9, %r9
#	-----------
#	a[0] * b[6]
#	a[1] * b[5]
#	a[2] * b[4]
#	a[3] * b[3]
#	a[4] * b[2]
#	a[5] * b[1]
#	a[6] * b[0]
#	-----------
	movq	%xmm0, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm0, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm1, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm1, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm2, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm2, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm3, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm13
	xorq	%r8, %r8
#	-----------
#	a[0] * b[7]
#	a[1] * b[6]
#	a[2] * b[5]
#	a[3] * b[4]
#	a[4] * b[3]
#	a[5] * b[2]
#	a[6] * b[1]
#	a[7] * b[0]
#	-----------
	movq	%xmm0, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm0, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm1, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm1, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm2, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm2, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm3, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm3, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm13
	xorq	%r9, %r9
#	-----------
#	a[0] * b[8]
#	a[1] * b[7]
#	a[2] * b[6]
#	a[3] * b[5]
#	a[4] * b[4]
#	a[5] * b[3]
#	a[6] * b[2]
#	a[7] * b[1]
#	a[8] * b[0]
#	-----------
	movq	%xmm0, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm0, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm1, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm1, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm2, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm2, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm3, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm3, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm4, %rax
	movq	%xmm5, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm14
	xorq	%r8, %r8
#	-----------
#	a[1] * b[8]
#	a[2] * b[7]
#	a[3] * b[6]
#	a[4] * b[5]
#	a[5] * b[4]
#	a[6] * b[3]
#	a[7] * b[2]
#	a[8] * b[1]
#	-----------
	pextrq	$1, %xmm0, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm1, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm1, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm2, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm2, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm3, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm3, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm4, %rax
	pextrq	$1, %xmm5, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm14
	xorq	%r9, %r9
#	-----------
#	a[2] * b[8]
#	a[3] * b[7]
#	a[4] * b[6]
#	a[5] * b[5]
#	a[6] * b[4]
#	a[7] * b[3]
#	a[8] * b[2]
#	-----------
	movq	%xmm1, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm1, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm2, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm2, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm3, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm3, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm4, %rax
	movq	%xmm6, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm15
	xorq	%r8, %r8
#	-----------
#	a[3] * b[8]
#	a[4] * b[7]
#	a[5] * b[6]
#	a[6] * b[5]
#	a[7] * b[4]
#	a[8] * b[3]
#	-----------
	pextrq	$1, %xmm1, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm2, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm2, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm3, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm3, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm4, %rax
	pextrq	$1, %xmm6, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm15
	xorq	%r9, %r9
#	-----------
#	a[4] * b[8]
#	a[5] * b[7]
#	a[6] * b[6]
#	a[7] * b[5]
#	a[8] * b[4]
#	-----------
	movq	%xmm2, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm2, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm3, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm3, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm4, %rax
	movq	%xmm7, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm0
	xorq	%r8, %r8
#	-----------
#	a[5] * b[8]
#	a[6] * b[7]
#	a[7] * b[6]
#	a[8] * b[5]
#	-----------
	pextrq	$1, %xmm2, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm3, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	pextrq	$1, %xmm3, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm4, %rax
	pextrq	$1, %xmm7, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm0
	xorq	%r9, %r9
#	-----------
#	a[6] * b[8]
#	a[7] * b[7]
#	a[8] * b[6]
#	-----------
	movq	%xmm3, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	pextrq	$1, %xmm3, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	movq	%xmm4, %rax
	movq	%xmm8, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm1
	xorq	%r8, %r8
#	-----------
#	a[7] * b[8]
#	a[8] * b[7]
#	-----------
	pextrq	$1, %xmm3, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	movq	%xmm4, %rax
	pextrq	$1, %xmm8, %r11
	mulq	%r11
	addq	%rax, %r9
	adcq	%rdx, %r8
#	----
	shld	$4, %r9, %r8
	andq	%r10, %r9
	pinsrq	$1, %r9, %xmm1
	xorq	%r9, %r9
#	-----------
#	a[8] * b[8]
#	-----------
	movq	%xmm4, %rax
	movq	%xmm9, %r11
	mulq	%r11
	addq	%rax, %r8
	adcq	%rdx, %r9
#	----
	shld	$4, %r8, %r9
	andq	%r10, %r8
	movq	%r8, %xmm2
	pinsrq	$1, %r9, %xmm2
#	-------------------------------
#	output (xmm10~xmm15, xmm0~xmm2)
#	-------------------------------
	movdqa	%xmm10, (%rdi)
	movdqa	%xmm11, 16(%rdi)
	movdqa	%xmm12, 32(%rdi)
	movdqa	%xmm13, 48(%rdi)
	movdqa	%xmm14, 64(%rdi)
	movdqa	%xmm15, 80(%rdi)
	movdqa	%xmm0, 96(%rdi)
	movdqa	%xmm1, 112(%rdi)
	movdqa	%xmm2, 128(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE0:
	.size	mp_mul_521, .-mp_mul_521
	.p2align 4,,15
.globl mp_sqr_521
	.type	mp_sqr_521, @function
mp_sqr_521:
.LFB1:
	.cfi_startproc
#	uint64_t mp_sqr_521(uint64_t c[18], uint64_t a[9])
#	rdi = c[]
#	rsi = a[]
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE1:
	.size	mp_sqr_521, .-mp_sqr_521
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-16)"
	.section	.note.GNU-stack,"",@progbits
