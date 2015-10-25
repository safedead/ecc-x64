	.file	"ec_double_sm2.c"
	.text
	.p2align 4,,15
.globl ec_double_sm2
	.type	ec_double_sm2, @function
ec_double_sm2:
.LFB0:
	.cfi_startproc
#	uint64_t ec_double_sm2(uint64_t R[12], uint64_t S[12])
#	rdi = R[]
#	rsi = S[]
#	--------------------
#	load Sx to xmm0:xmm1
#	load Sy to xmm2:xmm3
#	load Sz to xmm4:xmm5
#	--------------------
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	movdqa	64(%rsi), %xmm4
	movdqa	80(%rsi), %xmm5
#	--------------
#	test xmm4:xmm5
#	--------------
	movq	%xmm4, %r8
	movq	%xmm5, %r9
	pextrq	$1, %xmm4, %r10
	pextrq	$1, %xmm5, %r11
#	---
	orq	%r9, %r8
	orq	%r11, %r10
	orq	%r10, %r8
	jnz	.L01
#	-------------------
#	set xmm0:xmm1 = 0x1
#	set xmm2:xmm3 = 0x1
#	set xmm4:xmm5 = 0x0
#	-------------------
	movq	$0, %rax
#	----
	movq	%rax, %xmm1
	movq	%rax, %xmm3
	movq	%rax, %xmm4
	movq	%rax, %xmm5
#	----
	movq	$1, %rax
#	----
	movq	%rax, %xmm0
	movq	%rax, %xmm2
#	--------------------
#	save xmm0:xmm1 as Rx
#	save xmm2:xmm3 as Ry
#	save xmm4:xmm5 as Rz
#	--------------------
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
.L01:
#	----------------------------
#	push rbx,rbp,r12,r13,r14,r15
#	----------------------------
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
#	------------------------
#	rbx = 0xFFFFFFFF00000000
#	rbp = 0xFFFFFFFEFFFFFFFF
#	------------------------
	movq	$-0x100000000, %rbx
	movq	$-0x100000001, %rbp
#	-----------------------
#	set r12:r15 = xmm4:xmm5
#	-----------------------
	movq	%xmm4, %r12
	movq	%xmm5, %r14
	pextrq	$1, %xmm4, %r13
	pextrq	$1, %xmm5, %r15
#	----------------
#	set next is .L02
#	----------------
	leaq	.L02, %rsi
#	---
#	sqr
#	---
	jmp	.L88
.L02:
#	-----------------------
#	set r12:r15 = xmm0:xmm1
#	-----------------------
	movq	%xmm0, %r12
	movq	%xmm1, %r14
	pextrq	$1, %xmm0, %r13
	pextrq	$1, %xmm1, %r15
#	-----------------
#	r12:r15 -= r8:r11
#	-----------------
	subq	%r8, %r12
	sbbq	%r9, %r13
	sbbq	%r10, %r14
	sbbq	%r11, %r15
	jnc	.L03
#	---------------
#	r12:r15 += p256
#	---------------
	addq	$-1, %r12
	adcq	%rbx, %r13
	adcq	$-1, %r14
	adcq	%rbp, %r15
.L03:
#	-------------------------
#	set xmm10:xmm11 = r12:r15
#	-------------------------
	movq	%r12, %xmm10
	movq	%r14, %xmm11
	pinsrq	$1, %r13, %xmm10
	pinsrq	$1, %r15, %xmm11
#	-----------------------
#	set r12:r15 = xmm0:xmm1
#	-----------------------
	movq	%xmm0, %r12
	movq	%xmm1, %r14
	pextrq	$1, %xmm0, %r13
	pextrq	$1, %xmm1, %r15
#	-----------------
#	r12:r15 += r8:r11
#	-----------------
	addq	%r8, %r12
	adcq	%r9, %r13
	adcq	%r10, %r14
	adcq	%r11, %r15
	jnc	.L04
#	---------------
#	r12:r15 -= p256
#	---------------
	subq	$-1, %r12
	sbbq	%rbx, %r13
	sbbq	$-1, %r14
	sbbq	%rbp, %r15
.L04:
#	-------------------------
#	set xmm12:xmm13 = r12:r15
#	-------------------------
	movq	%r12, %xmm12
	movq	%r14, %xmm13
	pinsrq	$1, %r13, %xmm12
	pinsrq	$1, %r15, %xmm13
#	---------------------
#	set next step is .L05
#	---------------------
	leaq	.L05, %rsi
#	---
#	mul
#	---
	jmp	.L69
.L05:
#	----------------------
#	set xmm8:xmm9 = r8:r11
#	----------------------
	movq	%r8, %xmm8
	movq	%r10, %xmm9
	pinsrq	$1, %r9, %xmm8
	pinsrq	$1, %r11, %xmm9
#	----------------
#	r12:r15 = r8:r11
#	----------------
	movq	%r8, %r12
	movq	%r9, %r13
	movq	%r10, %r14
	movq	%r11, %r15
	xorq	%rax, %rax
#	---------------------
#	r8:r11,rax += r12:r15
#	---------------------
	addq	%r12, %r8
	adcq	%r13, %r9
	adcq	%r14, %r10
	adcq	%r15, %r11
	adcq	$0, %rax
#	---------------------
#	r8:r11,rax += r12:r15
#	---------------------
	addq	%r12, %r8
	adcq	%r13, %r9
	adcq	%r14, %r10
	adcq	%r15, %r11
	adcq	$0, %rax
#	---------------------
#	set next step is .L06
#	---------------------
	leaq	.L06, %rsi
#	---
#	mod
#	---
	jmp	.L99mid
.L06:
#	----------------------
#	set xmm6:xmm7 = r8:r11
#	----------------------
	movq	%r8, %xmm6
	movq	%r10, %xmm7
	pinsrq	$1, %r9, %xmm6
	pinsrq	$1, %r11, %xmm7
#	---------------------------
#	set xmm10:xmm11 = xmm2:xmm3
#	---------------------------
	movdqa	%xmm2, %xmm10
	movdqa	%xmm3, %xmm11
#	---------------------------
#	set xmm12:xmm13 = xmm4:xmm5
#	---------------------------
	movdqa	%xmm4, %xmm12
	movdqa	%xmm5, %xmm13
#	---------------------
#	set next step is .L07
#	---------------------
	leaq	.L07, %rsi
#	---
#	mul
#	---
	jmp	.L69
.L07:
#	-----------
#	r8:r11 << 1
#	-----------
	xorq	%rax, %rax
	shld	$1, %r11, %rax
	shld	$1, %r10, %r11
	shld	$1, %r9, %r10
	shld	$1, %r8, %r9
	shl	$1, %r8
#	----------------
#	r12:r15 = r8:r11
#	----------------
	movq	%r8, %r12
	movq	%r9, %r13
	movq	%r10, %r14
	movq	%r11, %r15
#	-------------------
#	r12:r15,rax -= p256
#	-------------------
	subq	$-1, %r12
	sbbq	%rbx, %r13
	sbbq	$-1, %r14
	sbbq	%rbp, %r15
	sbbq	$0, %rax
	jc	.L08
#	----------------
#	r8:r11 = r12:r15
#	----------------
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%r15, %r11
.L08:
#	----------------------
#	set xmm4:xmm5 = r8:r11
#	----------------------
	movq	%r8, %xmm4
	movq	%r10, %xmm5
	pinsrq	$1, %r9, %xmm4
	pinsrq	$1, %r11, %xmm5
#	-----------------------
#	set r12:r15 = xmm2:xmm3
#	-----------------------
	movq	%xmm2, %r12
	movq	%xmm3, %r14
	pextrq	$1, %xmm2, %r13
	pextrq	$1, %xmm3, %r15
#	----------------
#	set next is .L09
#	----------------
	leaq	.L09, %rsi
#	---
#	sqr
#	---
	jmp	.L88
.L09:
#	----------------------
#	set xmm2:xmm3 = r8:r11
#	----------------------
	movq	%r8, %xmm2
	movq	%r10, %xmm3
	pinsrq	$1, %r9, %xmm2
	pinsrq	$1, %r11, %xmm3
#	---------------------------
#	set xmm10:xmm11 = xmm0:xmm1
#	---------------------------
	movdqa	%xmm0, %xmm10
	movdqa	%xmm1, %xmm11
#	---------------------------
#	set xmm12:xmm13 = xmm2:xmm3
#	---------------------------
	movdqa	%xmm2, %xmm12
	movdqa	%xmm3, %xmm13
#	---------------------
#	set next step is .L10
#	---------------------
	leaq	.L10, %rsi
#	---
#	mul
#	---
	jmp	.L69
.L10:
#	-----------
#	r8:r11 << 2
#	-----------
	xorq	%rax, %rax
	shld	$2, %r11, %rax
	shld	$2, %r10, %r11
	shld	$2, %r9, %r10
	shld	$2, %r8, %r9
	shl	$2, %r8
#	---------------------
#	set next step is .L11
#	---------------------
	leaq	.L11, %rsi
#	---
#	mod
#	---
	jmp	.L99mid
.L11:
#	----------------------
#	set xmm8:xmm9 = r8:r11
#	----------------------
	movq	%r8, %xmm8
	movq	%r10, %xmm9
	pinsrq	$1, %r9, %xmm8
	pinsrq	$1, %r11, %xmm9
#	-----------------------
#	set r12:r15 = xmm6:xmm7
#	-----------------------
	movq	%xmm6, %r12
	movq	%xmm7, %r14
	pextrq	$1, %xmm6, %r13
	pextrq	$1, %xmm7, %r15
#	----------------
#	set next is .L12
#	----------------
	leaq	.L12, %rsi
#	---
#	sqr
#	---
	jmp	.L88
.L12:
#	-----------------------
#	set r12:r15 = xmm8:xmm9
#	-----------------------
	movq	%xmm8, %r12
	movq	%xmm9, %r14
	pextrq	$1, %xmm8, %r13
	pextrq	$1, %xmm9, %r15
#	----------------
#	r8:r11 -= r12:15
#	----------------
	subq	%r12, %r8
	sbbq	%r13, %r9
	sbbq	%r14, %r10
	sbbq	%r15, %r11
	jnc	.L13
#	--------------
#	r8:r11 += p256
#	--------------
	addq	$-1, %r8
	adcq	%rbx, %r9
	adcq	$-1, %r10
	adcq	%rbp, %r11
.L13:
#	----------------
#	r8:r11 -= r12:15
#	----------------
	subq	%r12, %r8
	sbbq	%r13, %r9
	sbbq	%r14, %r10
	sbbq	%r15, %r11
	jnc	.L14
#	--------------
#	r8:r11 += p256
#	--------------
	addq	$-1, %r8
	adcq	%rbx, %r9
	adcq	$-1, %r10
	adcq	%rbp, %r11
.L14:
#	----------------------
#	set xmm0:xmm1 = r8:r11
#	----------------------
	movq	%r8, %xmm0
	movq	%r10, %xmm1
	pinsrq	$1, %r9, %xmm0
	pinsrq	$1, %r11, %xmm1
#	-----------------------
#	set r12:r15 = xmm2:xmm3
#	-----------------------
	movq	%xmm2, %r12
	movq	%xmm3, %r14
	pextrq	$1, %xmm2, %r13
	pextrq	$1, %xmm3, %r15
#	---------------------
#	set next step is .L15
#	---------------------
	leaq	.L15, %rsi
#	---
#	sqr
#	---
	jmp	.L88
.L15:
#	-----------
#	r8:r11 << 3
#	-----------
	xorq	%rax, %rax
	shld	$3, %r11, %rax
	shld	$3, %r10, %r11
	shld	$3, %r9, %r10
	shld	$3, %r8, %r9
	shl	$3, %r8
#	---------------------
#	set next step is .L16
#	---------------------
	leaq	.L16, %rsi
#	---
#	mod
#	---
	jmp	.L99mid
.L16:
#	----------------------
#	set xmm2:xmm3 = r8:r11
#	----------------------
	movq	%r8, %xmm2
	movq	%r10, %xmm3
	pinsrq	$1, %r9, %xmm2
	pinsrq	$1, %r11, %xmm3
#	-----------------------
#	set r12:r15 = xmm8:xmm9
#	-----------------------
	movq	%xmm8, %r12
	movq	%xmm9, %r14
	pextrq	$1, %xmm8, %r13
	pextrq	$1, %xmm9, %r15
#	-----------------------
#	set r8:r11 = xmm0:xmm1
#	-----------------------
	movq	%xmm0, %r8
	movq	%xmm1, %r10
	pextrq	$1, %xmm0, %r9
	pextrq	$1, %xmm1, %r11
#	-----------------
#	r12:r15 -= r8:r11
#	-----------------
	subq	%r8, %r12
	sbbq	%r9, %r13
	sbbq	%r10, %r14
	sbbq	%r11, %r15
	jnc	.L17
#	---------------
#	r12:r15 += p256
#	---------------
	addq	$-1, %r12
	adcq	%rbx, %r13
	adcq	$-1, %r14
	adcq	%rbp, %r15
.L17:
#	-------------------------
#	set xmm12:xmm13 = r12:r15
#	-------------------------
	movq	%r12, %xmm12
	movq	%r14, %xmm13
	pinsrq	$1, %r13, %xmm12
	pinsrq	$1, %r15, %xmm13
#	---------------------------
#	set xmm10:xmm11 = xmm6:xmm7
#	---------------------------
	movdqa	%xmm6, %xmm10
	movdqa	%xmm7, %xmm11
#	---------------------
#	set next step is .L18
#	---------------------
	leaq	.L18, %rsi
#	---
#	mul
#	---
	jmp	.L69
.L18:
#	-----------------------
#	set r12:r15 = xmm2:xmm3
#	-----------------------
	movq	%xmm2, %r12
	movq	%xmm3, %r14
	pextrq	$1, %xmm2, %r13
	pextrq	$1, %xmm3, %r15
#	----------------
#	r8:r11 -= r12:15
#	----------------
	subq	%r12, %r8
	sbbq	%r13, %r9
	sbbq	%r14, %r10
	sbbq	%r15, %r11
	jnc	.L19
#	--------------
#	r8:r11 += p256
#	--------------
	addq	$-1, %r8
	adcq	%rbx, %r9
	adcq	$-1, %r10
	adcq	%rbp, %r11
.L19:
#	-------------------------
#	set xmm2:xmm3 = r8:r11
#	-------------------------
	movq	%r8, %xmm2
	movq	%r10, %xmm3
	pinsrq	$1, %r9, %xmm2
	pinsrq	$1, %r11, %xmm3
#	----
#	done
#	----
	jmp	.L100
.L69:
#	------------
#	init r10:r15
#	------------
	xorq	%r10, %r10
	xorq	%r11, %r11
	xorq	%r12, %r12
	xorq	%r13, %r13
	xorq	%r14, %r14
	xorq	%r15, %r15
#	-----------
#	a[0] * b[0]
#	-----------
	movq	%xmm10, %rax
	movq	%xmm12, %rcx
	mulq	%rcx
#	----
	movq	%rax, %r8
	movq	%rdx, %r9
#	-----------
#	a[0] * b[1]
#	a[1] * b[0]
#	-----------
	movq	%xmm10, %rax
	pextrq	$1, %xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
#	----
	pextrq	$1, %xmm10, %rax
	movq	%xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r9
	adcq	%rdx, %r10
	adcq	$0, %r11
#	-----------
#	a[0] * b[2]
#	a[1] * b[1]
#	a[2] * b[0]
#	-----------
	movq	%xmm10, %rax
	movq	%xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r12
#	----
	pextrq	$1, %xmm10, %rax
	pextrq	$1, %xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r12
#	----
	movq	%xmm11, %rax
	movq	%xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r10
	adcq	%rdx, %r11
	adcq	$0, %r12
#	-----------
#	a[0] * b[3]
#	a[1] * b[2]
#	a[2] * b[1]
#	a[3] * b[0]
#	-----------
	movq	%xmm10, %rax
	pextrq	$1, %xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r11
	adcq	%rdx, %r12
	adcq	$0, %r13
#	----
	pextrq	$1, %xmm10, %rax
	movq	%xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r11
	adcq	%rdx, %r12
	adcq	$0, %r13
#	----
	movq	%xmm11, %rax
	pextrq	$1, %xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r11
	adcq	%rdx, %r12
	adcq	$0, %r13
#	----
	pextrq	$1, %xmm11, %rax
	movq	%xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r11
	adcq	%rdx, %r12
	adcq	$0, %r13
#	-----------
#	a[1] * b[3]
#	a[2] * b[2]
#	a[3] * b[1]
#	-----------
	pextrq	$1, %xmm10, %rax
	pextrq	$1, %xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r12
	adcq	%rdx, %r13
	adcq	$0, %r14
#	----
	movq	%xmm11, %rax
	movq	%xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r12
	adcq	%rdx, %r13
	adcq	$0, %r14
#	----
	pextrq	$1, %xmm11, %rax
	pextrq	$1, %xmm12, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r12
	adcq	%rdx, %r13
	adcq	$0, %r14
#	-----------
#	a[2] * b[3]
#	a[3] * b[2]
#	-----------
	movq	%xmm11, %rax
	pextrq	$1, %xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r13
	adcq	%rdx, %r14
	adcq	$0, %r15
#	----
	pextrq	$1, %xmm11, %rax
	movq	%xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r13
	adcq	%rdx, %r14
	adcq	$0, %r15
#	-----------
#	a[3] * b[3]
#	-----------
	pextrq	$1, %xmm11, %rax
	pextrq	$1, %xmm13, %rcx
	mulq	%rcx
#	----
	addq	%rax, %r14
	adcq	%rdx, %r15
#	------------------------
#	set xmm10:xmm13 = r8:r15
#	------------------------
	movq	%r8, %xmm10
	movq	%r10, %xmm11
	movq	%r12, %xmm12
	movq	%r14, %xmm13
	pinsrq	$1, %r9, %xmm10
	pinsrq	$1, %r11, %xmm11
	pinsrq	$1, %r13, %xmm12
	pinsrq	$1, %r15, %xmm13
#	---
#	mod
#	---
	jmp	.L99
.L88:
#	-----------
#	init r9:r10
#	-----------
	xorq	%r9, %r9
	xorq	%r10, %r10
#	-----------
#	a[0] * a[0]
#	-----------
	movq	%r12, %rax
	mulq	%r12
#	----
	movq	%rax, %xmm10
	movq	%rdx, %r8
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
	pinsrq	$1, %r8, %xmm10
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
	movq	%r9, %xmm11
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
	pinsrq	$1, %r10, %xmm11
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
	movq	%r8, %xmm12
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
	pinsrq	$1, %r9, %xmm12
#	-----------
#	a[3] * a[3]
#	-----------
	movq	%r15, %rax
	mulq	%r15
#	----
	addq	%rax, %r10
	adcq	%rdx, %r8
#	----
	movq	%r10, %xmm13
	pinsrq	$1, %r8, %xmm13
.L99:
#	-------------------------------
#	extract xmm12:xmm13 to r8d:r15d
#	-------------------------------
	movd	%xmm12, %r8d
	movd	%xmm13, %r12d
	pextrd	$1, %xmm12, %r9d
	pextrd	$1, %xmm13, %r13d
	pextrd	$2, %xmm12, %r10d
	pextrd	$2, %xmm13, %r14d
	pextrd	$3, %xmm12, %r11d
	pextrd	$3, %xmm13, %r15d
#	---------------------------
#	rcx = a08 + a09 + a10 + a11
#	---------------------------
	movq	%r8, %rcx
	addq	%r9, %rcx
	addq	%r10, %rcx
	addq	%r11, %rcx
#	---------------
#	r8  = a08 + a13
#	r9  = a09 + a14
#	---------------
	addq	%r13, %r8
	addq	%r14, %r9
#	---------------
#	r14 = a14 + a15
#	---------------
	addq	%r15, %r14
#	---------------------
#	r13 = a13 + a14 + a15
#	---------------------
	addq	%r14, %r13
#	---------------------------
#	r12 = a12 + a13 + a14 + a15
#	---------------------------
	addq	%r13, %r12
#	---------------------------------------------------
#	rcx = a08 + a09 + a10 + a11 + a12 + a13 + a14 + a15
#	---------------------------------------------------
	addq	%r12, %rcx
#	------------------------------------------------------------------------
#	a00 + (a08 + a09 + a10 +a11 + a12 + a13 + a14 + a15) + (a13 + a14 + a15)
#	------------------------------------------------------------------------
	movd	%xmm10, %eax
	addq	%rcx, %rax
	addq	%r13, %rax
#	----
	movd	%eax, %xmm12
	shrq	$32, %rax
#	--------------------------------------------------------------------------------------------
#	up + a01 + (a08 + a09 + a10 + a11 + a12 + a13 + a14 + a15) + (a13 + a14 + a15) - (a08 + a13)
#	--------------------------------------------------------------------------------------------
	pextrd	$1, %xmm10, %edx
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	%r13, %rax
	subq	%r8, %rax
#	----
	pinsrd	$1, %eax, %xmm12
	shrq	$32, %rax
#	--------------------------------------------------
#	up + a02 + 0x400000000 - (a08 + a13) - (a09 + a14)
#	--------------------------------------------------
	pextrd	$2, %xmm10, %edx
	addq	%rdx, %rax
	movq	$0x400000000, %rdx
	addq	%rdx, %rax
	subq	%r8, %rax
	subq	%r9, %rax
#	----
	pinsrd	$2, %eax, %xmm12
	shrq	$32, %rax
#	------------------------------------------------------------------------
#	up + a03 + (a12 + a13 + a14 + a15) + (a08 + a13) + a11 + 0x100000000 - 4
#	------------------------------------------------------------------------
	pextrd	$3, %xmm10, %edx
	addq	%rdx, %rax
	addq	%r12, %rax
	addq	%r8, %rax
	addq	%r11, %rax
	movq	$0xfffffffc, %rdx
	addq	%rdx, %rax
#	----
	pinsrd	$3, %eax, %xmm12
	shrq	$32, %rax
#	----------------------------------------------------
#	up + a04 + (a12 + a13 + a14 + a15) + (a09 + a14) - 1
#	----------------------------------------------------
	movd	%xmm11, %edx
	addq	%rdx, %rax
	addq	%r12, %rax
	addq	%r9, %rax
	decq	%rax
#	----
	movd	%eax, %xmm13
	shrq	$32, %rax
#	----------------------------------------
#	up + a05 + (a13 + a14 + a15) + a10 + a15
#	----------------------------------------
	pextrd	$1, %xmm11, %edx
	addq	%rdx, %rax
	addq	%r13, %rax
	addq	%r10, %rax
	addq	%r15, %rax
#	----
	pinsrd	$1, %eax, %xmm13
	shrq	$32, %rax
#	----------------------------
#	up + a06 + a11 + (a14 + a15)
#	----------------------------
	pextrd	$2, %xmm11, %edx
	addq	%rdx, %rax
	addq	%r11, %rax
	addq	%r14, %rax
#	----
	pinsrd	$2, %eax, %xmm13
	shrq	$32, %rax
#	-----------------------------------------------------------------------------------------
#	up + a07 + (a08 + a09 + a10 +a11 + a12 + a13 + a14 + a15) + (a12 + a13 + a14 + a15) + a15
#	-----------------------------------------------------------------------------------------
	pextrd	$3, %xmm11, %edx
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	%r12, %rax
	addq	%r15, %rax
#	----
	pinsrd	$3, %eax, %xmm13
	shrq	$32, %rax
#	-----
#	final
#	-----
	movq	%xmm12, %r8
	movq	%xmm13, %r10
	.p2align 4,,15
	pextrq	$1, %xmm12, %r9
	pextrq	$1, %xmm13, %r11
.L99mid:
#	|---|-------------|---|--------|---|
#	|r12|     r13     |r14|   r15  |rdx|
#	|---|-------------|---|--------|---|
#	|-n |(n-1)-(n<<32)|!0 |!(n<<32)|n-1|
#	|---|-------------|---|--------|---|
	movq	%rax, %rdx	#rdx = n - 1
	movq	%rax, %r12	#r12 = n - 1
	incq	%r12		#r12 = n
	movq	%rax, %r13	#r13 = n - 1
	movq	%r12, %r15	#r15 = n
	negq	%r12		#r12 = -n
	shlq	$32, %r15	#r15 = (n << 32)
	subq	%r15, %r13	#r13 = (n - 1) - (n << 32)
	notq	%r15		#r15 = !(n << 32)
#	---------
#	sub n * p
#	---------
	subq	%r12, %r8
	sbbq	%r13, %r9
	sbbq	$-1, %r10
	sbbq	%r15, %r11
	sbbq	%rdx, %rax
	jnc	.L99end
#	--------------
#	r8:r11 += p256
#	--------------
	addq	$-1, %r8
	adcq	%rbx, %r9
	adcq	$-1, %r10
	adcq	%rbp, %r11
.L99end:
	jmp	*%rsi
.L100:
#	---------------------------
#	pop r15,r14,r13,r12,rbp,rbx
#	---------------------------
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
#	--------------------
#	save xmm0:xmm1 as Rx
#	save xmm2:xmm3 as Ry
#	save xmm4:xmm5 as Rz
#	--------------------
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
	.size	ec_double_sm2, .-ec_double_sm2
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-16)"
	.section	.note.GNU-stack,"",@progbits
