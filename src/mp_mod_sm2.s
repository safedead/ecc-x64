	.file	"mp_mod_sm2.c"
	.text
	.p2align 4,,15
.globl mp_mod_sm2
	.type	mp_mod_sm2, @function
mp_mod_sm2:
.LFB0:
	.cfi_startproc
#	uint64_t mp_mod_sm2(uint64_t r[4], uint64_t a[8])
#	rdi = r[]
#	rsi = a[]
#	--------------------------
#	load a[0:7] to xmm10:xmm13
#	--------------------------
	movdqa	(%rsi), %xmm10
	movdqa	16(%rsi), %xmm11
	movdqa	32(%rsi), %xmm12
	movdqa	48(%rsi), %xmm13
#	----------------------
#	backup rbx:rbp,r12:r15
#	----------------------
	movq	%rbx, %xmm0
	movq	%r12, %xmm1
	movq	%r14, %xmm2
	pinsrq	$1, %rbp, %xmm0
	pinsrq	$1, %r13, %xmm1
	pinsrq	$1, %r15, %xmm2
#	------------------------
#	rbx = 0xFFFFFFFF00000000
#	rbp = 0xFFFFFFFEFFFFFFFF
#	------------------------
	movq	$-0x100000000, %rbx
	movq	$-0x100000001, %rbp
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
	jnc	.L1
#	--------------
#	r8:r11 += p256
#	--------------
	addq	$-1, %r8
	adcq	%rbx, %r9
	adcq	$-1, %r10
	adcq	%rbp, %r11
.L1:
#	-----------------------
#	restore rbx:rbp,r12:r15
#	-----------------------
	movq	%xmm0, %rbx
	movq	%xmm1, %r12
	movq	%xmm2, %r14
	pextrq	$1, %xmm0, %rbp
	pextrq	$1, %xmm1, %r13
	pextrq	$1, %xmm2, %r15
#	---------------------
#	save r8:r11 to r[0:3]
#	---------------------
	movq	%r8, (%rdi)
	movq	%r9, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r11, 24(%rdi)
#	------
#	return
#	------
	emms
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	ret
	.cfi_endproc
.LFE0:
	.size	mp_mod_sm2, .-mp_mod_sm2
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-11)"
	.section	.note.GNU-stack,"",@progbits
