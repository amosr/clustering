	.text
	.align 4,0x90
	.globl _normalise2_
_normalise2_:
LFB0:
	pushq	%r14
LCFI0:
	movl	$0, %eax
	pushq	%r13
LCFI1:
	movq	%rsi, %r13
	pushq	%r12
LCFI2:
	movq	%rdx, %r12
	pushq	%rbp
LCFI3:
	pushq	%rbx
LCFI4:
	movq	%rdi, %rbx
	movslq	(%rcx), %r14
	testq	%r14, %r14
	cmovs	%rax, %r14
	movb	$1, %al
	leaq	0(,%r14,4), %rdi
	testq	%rdi, %rdi
	cmove	%rax, %rdi
	call	_malloc
	testl	%r14d, %r14d
	movq	%rax, %rdi
	je	L32
	movq	%rbx, %rax
	movl	%r14d, %ebp
	movl	%r14d, %edx
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	%r14d, %eax
	cmova	%r14d, %eax
	cmpl	$8, %r14d
	cmova	%eax, %r14d
	testl	%r14d, %r14d
	je	L36
	cmpl	$1, %r14d
	movl	(%rbx), %r9d
	jbe	L37
	addl	4(%rbx), %r9d
	cmpl	$2, %r14d
	jbe	L38
	addl	8(%rbx), %r9d
	cmpl	$3, %r14d
	jbe	L39
	addl	12(%rbx), %r9d
	cmpl	$4, %r14d
	jbe	L40
	addl	16(%rbx), %r9d
	cmpl	$5, %r14d
	jbe	L41
	addl	20(%rbx), %r9d
	cmpl	$6, %r14d
	jbe	L42
	addl	24(%rbx), %r9d
	cmpl	$7, %r14d
	jbe	L43
	addl	28(%rbx), %r9d
	movl	$9, %eax
L7:
	cmpl	%r14d, %edx
	je	L8
L6:
	subl	%r14d, %edx
	movl	%r14d, %ecx
	movl	%edx, %esi
	movl	%edx, %r10d
	shrl	$2, %esi
	leal	0(,%rsi,4), %r8d
	testl	%r8d, %r8d
	je	L9
	leaq	(%rbx,%rcx,4), %rcx
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
L15:
	addl	$1, %edx
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%esi, %edx
	jb	L15
	movdqa	%xmm0, %xmm2
	addl	%r8d, %eax
	psrldq	$8, %xmm2
	paddd	%xmm2, %xmm0
	movdqa	%xmm0, %xmm3
	psrldq	$4, %xmm3
	paddd	%xmm3, %xmm0
	movd	%xmm0, %edx
	addl	%edx, %r9d
	cmpl	%r8d, %r10d
	je	L8
L9:
	movslq	%eax, %rdx
	addl	-4(%rbx,%rdx,4), %r9d
	leal	1(%rax), %edx
	cmpl	%eax, %ebp
	je	L8
	movslq	%edx, %rcx
	addl	$2, %eax
	addl	-4(%rbx,%rcx,4), %r9d
	cmpl	%edx, %ebp
	je	L8
	cltq
	addl	-4(%rbx,%rax,4), %r9d
L8:
	xorl	%ecx, %ecx
	xorl	%r10d, %r10d
	.align 4,0x90
L18:
	movl	(%rbx,%rcx,4), %r8d
	testl	%r8d, %r8d
	jle	L16
	addl	$1, %r10d
	movslq	%r10d, %rax
	movl	%r8d, -4(%rdi,%rax,4)
L16:
	addq	$1, %rcx
	cmpl	%ecx, %ebp
	jne	L18
	testl	%r10d, %r10d
	je	L44
	movq	%rdi, %rax
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	%eax, %r10d
	cmovbe	%r10d, %eax
	cmpl	$8, %r10d
	movl	%eax, %edx
	movl	%r10d, %eax
	ja	L65
L20:
	cmpl	$1, %eax
	movl	(%rdi), %r8d
	jbe	L47
	addl	4(%rdi), %r8d
	cmpl	$2, %eax
	jbe	L48
	addl	8(%rdi), %r8d
	cmpl	$3, %eax
	jbe	L49
	addl	12(%rdi), %r8d
	cmpl	$4, %eax
	jbe	L50
	addl	16(%rdi), %r8d
	cmpl	$5, %eax
	jbe	L51
	addl	20(%rdi), %r8d
	cmpl	$6, %eax
	jbe	L52
	addl	24(%rdi), %r8d
	cmpl	$7, %eax
	jbe	L53
	addl	28(%rdi), %r8d
	movl	$9, %edx
L22:
	cmpl	%eax, %r10d
	je	L19
L21:
	movl	%r10d, %r14d
	movl	%eax, %ecx
	subl	%eax, %r14d
	movl	%r14d, %esi
	shrl	$2, %esi
	leal	0(,%rsi,4), %r11d
	testl	%r11d, %r11d
	je	L24
	leaq	(%rdi,%rcx,4), %rcx
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
L30:
	addl	$1, %eax
	paddd	(%rcx), %xmm0
	addq	$16, %rcx
	cmpl	%esi, %eax
	jb	L30
	movdqa	%xmm0, %xmm4
	addl	%r11d, %edx
	psrldq	$8, %xmm4
	paddd	%xmm4, %xmm0
	movdqa	%xmm0, %xmm5
	psrldq	$4, %xmm5
	paddd	%xmm5, %xmm0
	movd	%xmm0, %eax
	addl	%eax, %r8d
	cmpl	%r14d, %r11d
	je	L19
L24:
	movslq	%edx, %rax
	addl	-4(%rdi,%rax,4), %r8d
	leal	1(%rdx), %eax
	cmpl	%r10d, %edx
	je	L19
	movslq	%eax, %rcx
	addl	$2, %edx
	addl	-4(%rdi,%rcx,4), %r8d
	cmpl	%eax, %r10d
	je	L19
	movslq	%edx, %rdx
	addl	-4(%rdi,%rdx,4), %r8d
L19:
	xorl	%ecx, %ecx
	.align 4,0x90
L34:
	movl	(%rbx,%rcx,4), %eax
	cltd
	idivl	%r9d
	movl	%eax, 0(%r13,%rcx,4)
	addq	$1, %rcx
	cmpl	%ecx, %ebp
	jne	L34
	xorl	%ecx, %ecx
	.align 4,0x90
L33:
	movl	(%rbx,%rcx,4), %eax
	cltd
	idivl	%r8d
	movl	%eax, (%r12,%rcx,4)
	addq	$1, %rcx
	cmpl	%ecx, %ebp
	jne	L33
L32:
	testq	%rdi, %rdi
	je	L66
	popq	%rbx
LCFI5:
	popq	%rbp
LCFI6:
	popq	%r12
LCFI7:
	popq	%r13
LCFI8:
	popq	%r14
LCFI9:
	jmp	_free
	.align 4,0x90
L36:
LCFI10:
	xorl	%r9d, %r9d
	movl	$1, %eax
	jmp	L6
	.align 4,0x90
L65:
	testl	%edx, %edx
	jne	L67
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	movl	$1, %edx
	jmp	L21
	.align 4,0x90
L66:
	popq	%rbx
LCFI11:
	popq	%rbp
LCFI12:
	popq	%r12
LCFI13:
	popq	%r13
LCFI14:
	popq	%r14
LCFI15:
	ret
L37:
LCFI16:
	movl	$2, %eax
	jmp	L7
L53:
	movl	$8, %edx
	jmp	L22
L52:
	movl	$7, %edx
	jmp	L22
L51:
	movl	$6, %edx
	jmp	L22
L50:
	movl	$5, %edx
	jmp	L22
L49:
	movl	$4, %edx
	jmp	L22
L48:
	movl	$3, %edx
	jmp	L22
L47:
	movl	$2, %edx
	jmp	L22
L43:
	movl	$8, %eax
	jmp	L7
L42:
	movl	$7, %eax
	jmp	L7
L41:
	movl	$6, %eax
	jmp	L7
L40:
	movl	$5, %eax
	jmp	L7
L39:
	movl	$4, %eax
	jmp	L7
L38:
	movl	$3, %eax
	jmp	L7
L67:
	movl	%edx, %eax
	jmp	L20
L44:
	xorl	%r8d, %r8d
	jmp	L19
LFE0:
	.const
	.align 2
LC0:
	.long	1
	.cstring
LC1:
	.ascii "Normalise2.f90\0"
	.const
LC2:
	.ascii "(i10)"
	.cstring
	.align 3
LC3:
	.ascii "Allocation would exceed memory limit\0"
	.text
	.align 4,0x90
_MAIN__:
LFB2:
	pushq	%r14
LCFI17:
	movl	$32, %edx
	xorl	%eax, %eax
	pushq	%r13
LCFI18:
	leaq	LC0(%rip), %rdi
	pushq	%r12
LCFI19:
	pushq	%rbp
LCFI20:
	pushq	%rbx
LCFI21:
	subq	$528, %rsp
LCFI22:
	leaq	16(%rsp), %rbx
	movq	%rsp, %r14
	movq	%rbx, %rsi
	call	__gfortran_getarg_i4
	leaq	LC1(%rip), %rax
	movq	%rbx, 144(%rsp)
	leaq	48(%rsp), %rbx
	movq	%rax, 56(%rsp)
	movq	%rbx, %rdi
	movl	$8, 64(%rsp)
	leaq	LC2(%rip), %rax
	movl	$32, 152(%rsp)
	movq	%rax, 120(%rsp)
	movq	$0, 112(%rsp)
	movl	$0, 52(%rsp)
	movl	$5, 128(%rsp)
	movl	$20480, 48(%rsp)
	call	__gfortran_st_read
	movl	$4, %edx
	movq	%rsp, %rsi
	movq	%rbx, %rdi
	call	__gfortran_transfer_integer
	movq	%rbx, %rdi
	call	__gfortran_st_read_done
	movl	(%rsp), %eax
	xorl	%ecx, %ecx
	testl	%eax, %eax
	cmovns	%eax, %ecx
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	L69
	movslq	%ecx, %rdx
	salq	$2, %rdx
L69:
	testq	%rdx, %rdx
	movl	$1, %edi
	cmovne	%rdx, %rdi
	call	_malloc
	testq	%rax, %rax
	movq	%rax, %rbp
	je	L72
	movl	(%rsp), %eax
	xorl	%ecx, %ecx
	testl	%eax, %eax
	cmovns	%eax, %ecx
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	L71
	movslq	%ecx, %rdx
	salq	$2, %rdx
L71:
	testq	%rdx, %rdx
	movl	$1, %edi
	cmovne	%rdx, %rdi
	call	_malloc
	testq	%rax, %rax
	movq	%rax, %r12
	je	L72
	movl	(%rsp), %eax
	xorl	%ecx, %ecx
	testl	%eax, %eax
	cmovns	%eax, %ecx
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	L73
	movslq	%ecx, %rdx
	salq	$2, %rdx
L73:
	testq	%rdx, %rdx
	movl	$1, %edi
	cmovne	%rdx, %rdi
	call	_malloc
	testq	%rax, %rax
	movq	%rax, %r13
	je	L72
	movslq	(%rsp), %r9
	movl	$0, %eax
	testq	%r9, %r9
	cmovs	%rax, %r9
	testl	%r9d, %r9d
	je	L75
	imull	$512354, %r9d, %r9d
	movq	%rbp, %rcx
	movl	$1234824, %r8d
	movl	$1424583857, %edi
	addl	$1234824, %r9d
	.align 4,0x90
L76:
	movl	%r8d, %esi
	movl	%r8d, %edx
	addq	$4, %rcx
	sarl	$31, %esi
	xorl	%esi, %edx
	movl	%edx, %eax
	mull	%edi
	movl	%r8d, %eax
	addl	$512354, %r8d
	shrl	$12, %edx
	xorl	%esi, %edx
	imull	$12349, %edx, %edx
	subl	%edx, %eax
	movl	%eax, -4(%rcx)
	cmpl	%r9d, %r8d
	jne	L76
L75:
	leaq	LC1(%rip), %rax
	movq	%rbx, %rdi
	movl	$14, 64(%rsp)
	movq	%rax, 56(%rsp)
	movl	$128, 48(%rsp)
	movl	$6, 52(%rsp)
	call	__gfortran_st_write
	movq	%rbp, %rsi
	movl	$4, %edx
	movq	%rbx, %rdi
	call	__gfortran_transfer_integer_write
	movq	%rbx, %rdi
	call	__gfortran_st_write_done
	movq	%r14, %rcx
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	_normalise2_
	leaq	LC1(%rip), %rax
	movq	%rbx, %rdi
	movq	%rax, 56(%rsp)
	movl	$17, 64(%rsp)
	movl	$128, 48(%rsp)
	movl	$6, 52(%rsp)
	call	__gfortran_st_write
	movq	%r12, %rsi
	movl	$4, %edx
	movq	%rbx, %rdi
	call	__gfortran_transfer_integer_write
	movq	%rbx, %rdi
	call	__gfortran_st_write_done
	leaq	LC1(%rip), %rax
	movq	%rbx, %rdi
	movq	%rax, 56(%rsp)
	movl	$19, 64(%rsp)
	movl	$128, 48(%rsp)
	movl	$6, 52(%rsp)
	call	__gfortran_st_write
	movq	%r13, %rsi
	movl	$4, %edx
	movq	%rbx, %rdi
	call	__gfortran_transfer_integer_write
	movq	%rbx, %rdi
	call	__gfortran_st_write_done
	movq	%rbp, %rdi
	call	_free
	movq	%r13, %rdi
	call	_free
	addq	$528, %rsp
LCFI23:
	movq	%r12, %rdi
	popq	%rbx
LCFI24:
	popq	%rbp
LCFI25:
	popq	%r12
LCFI26:
	popq	%r13
LCFI27:
	popq	%r14
LCFI28:
	jmp	_free
L72:
LCFI29:
	leaq	LC3(%rip), %rdi
	call	__gfortran_os_error
LFE2:
	.align 4,0x90
	.globl _generate_
_generate_:
LFB1:
	movslq	(%rsi), %rax
	movl	$0, %ecx
	testq	%rax, %rax
	cmovs	%rcx, %rax
	testl	%eax, %eax
	movl	%eax, %r9d
	je	L87
	movl	(%rdx), %eax
	movl	$1234824, %ecx
	xorl	%esi, %esi
	movl	$1424583857, %r10d
	imull	$512354, %eax, %r11d
	.align 4,0x90
L90:
	movl	%ecx, %r8d
	movl	%ecx, %edx
	sarl	$31, %r8d
	xorl	%r8d, %edx
	movl	%edx, %eax
	mull	%r10d
	movl	%ecx, %eax
	addl	%r11d, %ecx
	shrl	$12, %edx
	xorl	%r8d, %edx
	imull	$12349, %edx, %edx
	subl	%edx, %eax
	movl	%eax, (%rdi,%rsi,4)
	addq	$1, %rsi
	cmpl	%esi, %r9d
	jne	L90
L87:
	rep; ret
LFE1:
	.section __TEXT,__text_startup,regular,pure_instructions
	.align 4
	.globl _main
_main:
LFB3:
	subq	$8, %rsp
LCFI30:
	call	__gfortran_set_args
	leaq	_options.23.2043(%rip), %rsi
	movl	$7, %edi
	call	__gfortran_set_options
	call	_MAIN__
	xorl	%eax, %eax
	addq	$8, %rsp
LCFI31:
	ret
LFE3:
	.const
	.align 4
_options.23.2043:
	.long	68
	.long	1023
	.long	0
	.long	0
	.long	1
	.long	1
	.long	0
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0
	.byte	0x1
	.ascii "zR\0"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 3
LECIE1:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB0-.
	.set L$set$2,LFE0-LFB0
	.quad L$set$2
	.byte	0
	.byte	0x4
	.set L$set$3,LCFI0-LFB0
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x8e
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.byte	0x18
	.byte	0x8d
	.byte	0x3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.byte	0x20
	.byte	0x8c
	.byte	0x4
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xe
	.byte	0x28
	.byte	0x86
	.byte	0x5
	.byte	0x4
	.set L$set$7,LCFI4-LCFI3
	.long L$set$7
	.byte	0xe
	.byte	0x30
	.byte	0x83
	.byte	0x6
	.byte	0x4
	.set L$set$8,LCFI5-LCFI4
	.long L$set$8
	.byte	0xa
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$9,LCFI6-LCFI5
	.long L$set$9
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$10,LCFI7-LCFI6
	.long L$set$10
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$11,LCFI8-LCFI7
	.long L$set$11
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$12,LCFI9-LCFI8
	.long L$set$12
	.byte	0xe
	.byte	0x8
	.byte	0x4
	.set L$set$13,LCFI10-LCFI9
	.long L$set$13
	.byte	0xb
	.byte	0x4
	.set L$set$14,LCFI11-LCFI10
	.long L$set$14
	.byte	0xa
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$15,LCFI12-LCFI11
	.long L$set$15
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$16,LCFI13-LCFI12
	.long L$set$16
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$17,LCFI14-LCFI13
	.long L$set$17
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$18,LCFI15-LCFI14
	.long L$set$18
	.byte	0xe
	.byte	0x8
	.byte	0x4
	.set L$set$19,LCFI16-LCFI15
	.long L$set$19
	.byte	0xb
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$20,LEFDE3-LASFDE3
	.long L$set$20
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB2-.
	.set L$set$21,LFE2-LFB2
	.quad L$set$21
	.byte	0
	.byte	0x4
	.set L$set$22,LCFI17-LFB2
	.long L$set$22
	.byte	0xe
	.byte	0x10
	.byte	0x8e
	.byte	0x2
	.byte	0x4
	.set L$set$23,LCFI18-LCFI17
	.long L$set$23
	.byte	0xe
	.byte	0x18
	.byte	0x8d
	.byte	0x3
	.byte	0x4
	.set L$set$24,LCFI19-LCFI18
	.long L$set$24
	.byte	0xe
	.byte	0x20
	.byte	0x8c
	.byte	0x4
	.byte	0x4
	.set L$set$25,LCFI20-LCFI19
	.long L$set$25
	.byte	0xe
	.byte	0x28
	.byte	0x86
	.byte	0x5
	.byte	0x4
	.set L$set$26,LCFI21-LCFI20
	.long L$set$26
	.byte	0xe
	.byte	0x30
	.byte	0x83
	.byte	0x6
	.byte	0x4
	.set L$set$27,LCFI22-LCFI21
	.long L$set$27
	.byte	0xe
	.byte	0xc0,0x4
	.byte	0x4
	.set L$set$28,LCFI23-LCFI22
	.long L$set$28
	.byte	0xa
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$29,LCFI24-LCFI23
	.long L$set$29
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$30,LCFI25-LCFI24
	.long L$set$30
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$31,LCFI26-LCFI25
	.long L$set$31
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$32,LCFI27-LCFI26
	.long L$set$32
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$33,LCFI28-LCFI27
	.long L$set$33
	.byte	0xe
	.byte	0x8
	.byte	0x4
	.set L$set$34,LCFI29-LCFI28
	.long L$set$34
	.byte	0xb
	.align 3
LEFDE3:
LSFDE5:
	.set L$set$35,LEFDE5-LASFDE5
	.long L$set$35
LASFDE5:
	.long	LASFDE5-EH_frame1
	.quad	LFB1-.
	.set L$set$36,LFE1-LFB1
	.quad L$set$36
	.byte	0
	.align 3
LEFDE5:
LSFDE7:
	.set L$set$37,LEFDE7-LASFDE7
	.long L$set$37
LASFDE7:
	.long	LASFDE7-EH_frame1
	.quad	LFB3-.
	.set L$set$38,LFE3-LFB3
	.quad L$set$38
	.byte	0
	.byte	0x4
	.set L$set$39,LCFI30-LFB3
	.long L$set$39
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$40,LCFI31-LCFI30
	.long L$set$40
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE7:
	.subsections_via_symbols
