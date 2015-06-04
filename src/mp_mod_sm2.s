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
#	-----------------------------------
#	load (xmm0 ~ xmm3) = (c[0] ~ c[7])
#	-----------------------------------
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
#	---------------------------
#	backup (r12, r13, r14, r15)
#	---------------------------
	movq	%r12, %xmm14
	movq	%r14, %xmm15
	pinsrq	$1, %r13, %xmm14
	pinsrq	$1, %r15, %xmm15
#	---------
#	r8  = a08
#	r9  = a09
#	r10 = a10
#	r11 = a11
#	r12 = a12
#	r13 = a13
#	r14 = a14
#	r15 = a15
#	---------
	movd	%xmm2, %r8d
	movd	%xmm3, %r12d
	pextrd	$1, %xmm2, %r9d
	pextrd	$2, %xmm2, %r10d
	pextrd	$3, %xmm2, %r11d
	pextrd	$1, %xmm3, %r13d
	pextrd	$2, %xmm3, %r14d
	pextrd	$3, %xmm3, %r15d
#	---------------------------
#	rsi = a08 + a09 + a10 + a11
#	---------------------------
	movq	%r8, %rsi
	addq	%r9, %rsi
	addq	%r10, %rsi
	addq	%r11, %rsi
#	---------------
#	r8  = a08 + a13
#	r9  = a09 + a14
#	---------------
	addq	%r13, %r8
	addq	%r14, %r9
#	---------------------
#	r13 = a13 + a14 + a15
#	---------------------
	addq	%r15, %r13
	addq	%r14, %r13
#	---------------------------
#	r12 = a12 + a13 + a14 + a15
#	---------------------------
	addq	%r13, %r12
#	----------------
#	rcx = 0xffffffff
#	----------------
	xorq	%rcx, %rcx
	not	%ecx
#	---------------------------------------------------------------------------------------
#	a00 + (a08 + a09 + a10 +a11) + (a12 + a13 + a14 + a15) + (a13 + a14 + a15) + 0xffffffff
#	---------------------------------------------------------------------------------------
	movd	%xmm0, %eax
	addq	%rsi, %rax
	addq	%r12, %rax
	addq	%r13, %rax
	addq	%rcx, %rax
#	----
	movd	%eax, %xmm4
	shrq	$32, %rax
#	-----------------------------------------------------------------------------------------------------------
#	up + a01 + (a08 + a09 + a10 + a11) + (a12 + a13 + a14 + a15) + (a13 + a14 + a15) + 0xffffffff - (a08 + a13)
#	-----------------------------------------------------------------------------------------------------------
	pextrd	$1, %xmm0, %edx
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%r12, %rax
	addq	%r13, %rax
	addq	%rcx, %rax
	subq	%r8, %rax
#	----
	pinsrd	$1, %eax, %xmm4
	shrq	$32, %rax
#	--------------------------------------------------
#	up + a02 + 0xf00000000 - (a08 + a13) - (a09 + a14)
#	--------------------------------------------------
	pextrd	$2, %xmm0, %edx
	addq	%rdx, %rax
	movq	$0xf, %rdx
	shlq	$32, %rdx
	addq	%rdx, %rax
	subq	%r8, %rax
	subq	%r9, %rax
#	----
	pinsrd	$2, %eax, %xmm4
	shrq	$32, %rax
#	-------------------------------------------------------------------
#	up + a03 + (a12 + a13 + a14 + a15) + (a08 + a13) + a11 + 0xfffffff0
#	-------------------------------------------------------------------
	pextrd	$3, %xmm0, %edx
	addq	%rdx, %rax
	addq	%r12, %rax
	addq	%r8, %rax
	addq	%r11, %rax
	addq	%rcx, %rax
	subq	$0xf, %rax
#	----
	pinsrd	$3, %eax, %xmm4
	shrq	$32, %rax
#	-------------------------------------------------------------
#	up + a04 + (a12 + a13 + a14 + a15) + (a09 + a14) + 0xffffffff
#	-------------------------------------------------------------
	movd	%xmm1, %edx
	addq	%rdx, %rax
	addq	%r12, %rax
	addq	%r9, %rax
	addq	%rcx, %rax
#	----
	movd	%eax, %xmm5
	shrq	$32, %rax
#	-----------------------------------------------------
#	up + a05 + (a13 + a14 + a15) + a10 + a15 + 0xffffffff
#	-----------------------------------------------------
	pextrd	$1, %xmm1, %edx
	addq	%rdx, %rax
	addq	%r13, %rax
	addq	%r10, %rax
	addq	%r15, %rax
	addq	%rcx, %rax
#	----
	pinsrd	$1, %eax, %xmm5
	shrq	$32, %rax
#	---------------------------------------
#	up + a06 + a11 + a14 + a15 + 0xffffffff
#	---------------------------------------
	pextrd	$2, %xmm1, %edx
	addq	%rdx, %rax
	addq	%r11, %rax
	addq	%r14, %rax
	addq	%r15, %rax
	addq	%rcx, %rax
#	----
	pinsrd	$2, %eax, %xmm5
	shrq	$32, %rax
#	--------------------------------------------------------------------------------------------------------
#	up + a07 + (a08 + a09 + a10 +a11) + (a12 + a13 + a14 + a15) + (a12 + a13 + a14 + a15) + a15 + 0xfffffffe
#	--------------------------------------------------------------------------------------------------------
	pextrd	$3, %xmm1, %edx
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%r12, %rax
	addq	%r12, %rax
	addq	%r15, %rax
	addq	%rcx, %rax
	decq	%rax
#	----
	pinsrd	$3, %eax, %xmm5
	shrq	$32, %rax
#	-----
#	final
#	-----
	movq	%xmm4, %r8
	movq	%xmm5, %r10
	pextrq	$1, %xmm4, %r9
	pextrq	$1, %xmm5, %r11
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
	xorq	%r14, %r14	#r14 = 0
	notq	%r14		#r14 = !0
	negq	%r12		#r12 = -n
	shlq	$32, %r15	#r15 = (n << 32)
	subq	%r15, %r13	#r13 = (n - 1) - (n << 32)
	notq	%r15		#r15 = !(n << 32)
#	---------
#	sub n * p
#	---------
	subq	%r12, %r8
	sbbq	%r13, %r9
	sbbq	%r14, %r10
	sbbq	%r15, %r11
	sbbq	%rdx, %rax
	jnc	.L1
#	|---------------|
#	|       p       |
#	|---|---|---|---|
#	|r12|r13|r14|r15|
#	|---|---|---|---|
	xorq	%r12, %r12
	xorq	%r13, %r13
	notq	%r12
	movq	%r12, %r14
	not	%r13d
	notq	%r13
	movq	%r13, %r15
	decq	%r15
#	|---|---|---|---|
#	|r12|r13|r14|r15|
#	|---|---|---|---|
#	| + |(+)|(+)|(+)|
#	|---|---|---|---|
#	|r8 |r9 |r10|r11|
#	|---|---|---|---|
	addq	%r12, %r8
	adcq	%r13, %r9
	adcq	%r14, %r10
	adcq	%r15, %r11
.L1:
	movq	%r8, %xmm4
	movq	%r10, %xmm5
	pinsrq	$1, %r9, %xmm4
	pinsrq	$1, %r11, %xmm5
.L2:
#	----------------------------
#	restore (r12, r13, r14, r15)
#	----------------------------
	movq	%xmm14, %r12
	movq	%xmm15, %r14
	pextrq	$1, %xmm14, %r13
	pextrq	$1, %xmm15, %r15
#	-------------------
#	output (xmm4, xmm5)
#	-------------------
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
	.size	mp_mod_sm2, .-mp_mod_sm2
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-11)"
	.section	.note.GNU-stack,"",@progbits
