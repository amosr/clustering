
	.section	__TEXT,__text,regular,pure_instructions

	.section	__DATA,__data
	.globl	_Main_normalise2_closure ## @Main_normalise2_closure
	.align	3
_Main_normalise2_closure:
	.quad	_Main_normalise2_info

	.globl	_Main_main6_closure     ## @Main_main6_closure
	.align	3
_Main_main6_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	1123                    ## 0x463

	.globl	_Main_main2_closure     ## @Main_main2_closure
	.align	4
_Main_main2_closure:
	.quad	_Main_main2_info
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0

	.section	__TEXT,__const
	.align	3                       ## @c3vI_str
_c3vI_str:
	.asciz	"Ok"

	.section	__DATA,__data
	.align	4                       ## @r3mT_closure
_r3mT_closure:
	.quad	_r3mT_info
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0

	.section	__TEXT,__const
	.align	4                       ## @c3vB_str
_c3vB_str:
	.asciz	"./Data/Vector/Generic.hs"

	.section	__DATA,__data
	.align	3                       ## @r3mU_closure
_r3mU_closure:
	.quad	_ghczmprim_GHCziTypes_Izh_static_info
	.quad	244                     ## 0xf4

	.align	4                       ## @r3mV_closure
_r3mV_closure:
	.quad	_r3mV_info
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0
	.quad	0                       ## 0x0

	.section	__TEXT,__const
	.align	3                       ## @c3vu_str
_c3vu_str:
	.asciz	"(!)"

	.section	__DATA,__const
	.align	4                       ## @Main_main3_srt
_Main_main3_srt:
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_closure
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_closure
	.quad	_r3mT_closure
	.quad	_r3mV_closure

	.section	__DATA,__data
	.globl	_Main_main3_closure     ## @Main_main3_closure
	.align	3
_Main_main3_closure:
	.quad	_Main_main3_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	4                       ## @Main_main4_srt
_Main_main4_srt:
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_closure
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_closure
	.quad	_r3mT_closure
	.quad	_r3mV_closure

	.section	__DATA,__data
	.globl	_Main_main4_closure     ## @Main_main4_closure
	.align	3
_Main_main4_closure:
	.quad	_Main_main4_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	4                       ## @Main_main5_srt
_Main_main5_srt:
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_closure
	.quad	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_closure
	.quad	_r3mT_closure
	.quad	_r3mV_closure

	.section	__DATA,__data
	.globl	_Main_main5_closure     ## @Main_main5_closure
	.align	3
_Main_main5_closure:
	.quad	_Main_main5_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	4                       ## @Main_main1_srt
_Main_main1_srt:
	.quad	_Main_main2_closure
	.quad	_base_GHCziShow_showzutuple_closure
	.quad	_Main_main3_closure
	.quad	_Main_main4_closure
	.quad	_Main_main5_closure
	.quad	_base_GHCziIOziHandleziFD_stdout_closure
	.quad	_base_GHCziIOziHandleziText_hPutStr2_closure
	.quad	_Common_getzusizze1_closure

	.section	__DATA,__data
	.globl	_Main_main1_closure     ## @Main_main1_closure
	.align	3
_Main_main1_closure:
	.quad	_Main_main1_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	3                       ## @Main_main_srt
_Main_main_srt:
	.quad	_Main_main1_closure

	.section	__DATA,__data
	.globl	_Main_main_closure      ## @Main_main_closure
	.align	3
_Main_main_closure:
	.quad	_Main_main_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	3                       ## @Main_main7_srt
_Main_main7_srt:
	.quad	_base_GHCziTopHandler_runMainIO1_closure
	.quad	_Main_main1_closure

	.section	__DATA,__data
	.globl	_Main_main7_closure     ## @Main_main7_closure
	.align	3
_Main_main7_closure:
	.quad	_Main_main7_info
	.quad	0                       ## 0x0

	.section	__DATA,__const
	.align	3                       ## @ZCMain_main_srt
_ZCMain_main_srt:
	.quad	_Main_main7_closure

	.section	__DATA,__data
	.globl	_ZCMain_main_closure    ## @ZCMain_main_closure
	.align	3
_ZCMain_main_closure:
	.quad	_ZCMain_main_info
	.quad	0                       ## 0x0

	.text
	.align	3                       ## @s3nt_info_itable
_s3nt_info_itable:
	.quad	12884901901             ## 0x30000000d
	.quad	8589934593              ## 0x200000001
	.quad	9                       ## 0x9

	.text
	.align	3, 0x90
_s3nt_info:                             ## @s3nt_info
## BB#0:                                ## %c3x1
	movq	13(%rbx), %rax
	cmpq	%r14, %rax
	je	LBB0_5
## BB#1:                                ## %n3xd.lr.ph.lr.ph
	movq	5(%rbx), %rcx
	movq	21(%rbx), %r8
	movl	$1, %r9d
	subq	%rax, %r9
	negq	%rax
	addq	$16, %rcx
LBB0_2:                                 ## %n3xd.lr.ph
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_3 Depth 2
	leaq	(%r8,%r14), %rdx
	negq	%r14
	leaq	(%rcx,%rdx,8), %rdx
	.align	4, 0x90
LBB0_3:                                 ## %n3xd
                                        ##   Parent Loop BB0_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%rdx), %rbx
	testq	%rbx, %rbx
	jg	LBB0_6
## BB#4:                                ## %n3xC
                                        ##   in Loop: Header=BB0_3 Depth=2
	addq	%rbx, %rsi
	decq	%r14
	addq	$8, %rdx
	cmpq	%r14, %rax
	jne	LBB0_3
	jmp	LBB0_5
	.align	4, 0x90
LBB0_6:                                 ## %c3xB
                                        ##   in Loop: Header=BB0_2 Depth=1
	addq	%rbx, %rdi
	addq	%rbx, %rsi
	movl	$1, %edx
	subq	%r14, %rdx
	cmpq	%r14, %r9
	movq	%rdx, %r14
	jne	LBB0_2
LBB0_5:                                 ## %c3xc
	movq	(%rbp), %rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3o3_info_itable
_s3o3_info_itable:
	.quad	12884901897             ## 0x300000009
	.quad	17179869187             ## 0x400000003
	.quad	9                       ## 0x9

	.text
	.align	3, 0x90
_s3o3_info:                             ## @s3o3_info
## BB#0:                                ## %c3Al
	movq	%r12, %r8
	leaq	16(%r8), %r12
	cmpq	144(%r13), %r12
	jbe	LBB1_1
## BB#4:                                ## %c3Az
	movq	$16, 192(%r13)
	movq	-8(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB1_1:                                 ## %n3AA.lr.ph
	movq	29(%rbx), %r9
	leaq	16(,%r14,8), %rcx
	jmp	LBB1_2
	.align	4, 0x90
LBB1_3:                                 ## %n3AN
                                        ##   in Loop: Header=BB1_2 Depth=1
	movq	37(%rbx), %rax
	addq	%rsi, %rax
	movq	5(%rbx), %rdx
	movq	21(%rbx), %r11
	movq	16(%rdx,%rax,8), %rdi
	movq	%rdi, %rax
	cqto
	idivq	45(%rbx)
	movq	%rax, %r10
	movq	%rdi, %rax
	cqto
	idivq	53(%rbx)
	movq	%rax, (%rcx,%r11)
	movq	13(%rbx), %rax
	movq	%r10, (%rcx,%rax)
	incq	%rsi
	incq	%r14
	addq	$8, %rcx
LBB1_2:                                 ## %n3AA
                                        ## =>This Inner Loop Header: Depth=1
	cmpq	%rsi, %r9
	jg	LBB1_3
## BB#5:                                ## %c3AM
	movq	_ghczmprim_GHCziTypes_Izh_con_info@GOTPCREL(%rip), %rax
	movq	%rax, 8(%r8)
	movq	%r14, 16(%r8)
	movq	(%rbp), %rax
	leaq	-7(%r12), %rbx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3qN_info_itable
_s3qN_info_itable:
	.quad	1926                    ## 0x786
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qN_info:                             ## @s3qN_info
## BB#0:                                ## %c3E3
	movq	%r12, %rax
	leaq	96(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB2_1
## BB#2:                                ## %c3Ej
	movq	$96, 192(%r13)
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB2_1:                                 ## %n3Ek
	movq	8(%rbp), %rcx
	movq	48(%rbp), %rdx
	movq	_vectorzm0zi10zi0zi1_DataziVectorziPrimitive_Vector_con_info@GOTPCREL(%rip), %rsi
	movq	%rsi, 8(%rax)
	movq	%rdx, 16(%rax)
	movq	$0, 24(%rax)
	movq	7(%rbx), %rdx
	movq	%rdx, 32(%rax)
	movq	%rsi, 40(%rax)
	movq	%rcx, 48(%rax)
	movq	$0, 56(%rax)
	movq	7(%rbx), %rcx
	movq	%rcx, 64(%rax)
	movq	_vectorzm0zi10zi0zi1_DataziVectorziUnboxedziBase_Vzu2_con_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 72(%rax)
	leaq	-55(%r12), %rcx
	movq	%rcx, 80(%rax)
	leaq	-87(%r12), %rcx
	movq	%rcx, 88(%rax)
	movq	7(%rbx), %rcx
	movq	%rcx, 96(%rax)
	movq	56(%rbp), %rax
	addq	$56, %rbp
	leaq	-23(%r12), %rbx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3qO_info_itable
_s3qO_info_itable:
	.quad	1926                    ## 0x786
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qO_info:                             ## @s3qO_info
## BB#0:                                ## %c3G4
	leaq	_s3qN_info(%rip), %rax
	movq	%rax, (%rbp)
	testb	$7, %bl
	je	LBB3_3
## BB#1:                                ## %c3Gd
	leaq	96(%r12), %rax
	cmpq	144(%r13), %rax
	jbe	LBB3_4
## BB#2:                                ## %c3Ej.i
	movq	$96, 192(%r13)
	movq	-16(%r13), %rcx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB3_3:                                 ## %n3Ge
	movq	(%rbx), %rax
	jmpq	*%rax  # TAILCALL
LBB3_4:                                 ## %n3Ek.i
	movq	8(%rbp), %rcx
	movq	48(%rbp), %rdx
	movq	_vectorzm0zi10zi0zi1_DataziVectorziPrimitive_Vector_con_info@GOTPCREL(%rip), %rsi
	movq	%rsi, 8(%r12)
	movq	%rdx, 16(%r12)
	movq	$0, 24(%r12)
	movq	7(%rbx), %rdx
	movq	%rdx, 32(%r12)
	movq	%rsi, 40(%r12)
	movq	%rcx, 48(%r12)
	movq	$0, 56(%r12)
	movq	7(%rbx), %rcx
	movq	%rcx, 64(%r12)
	movq	_vectorzm0zi10zi0zi1_DataziVectorziUnboxedziBase_Vzu2_con_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 72(%r12)
	leaq	-55(%rax), %rcx
	movq	%rcx, 80(%r12)
	leaq	-87(%rax), %rcx
	movq	%rcx, 88(%r12)
	movq	7(%rbx), %rcx
	movq	%rcx, 96(%r12)
	movq	56(%rbp), %rcx
	addq	$56, %rbp
	leaq	-23(%rax), %rbx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL

	.text
	.align	3                       ## @s3qI_info_itable
_s3qI_info_itable:
	.quad	2950                    ## 0xb86
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qI_info:                             ## @s3qI_info
## BB#0:                                ## %c3HL
	movq	%r12, %rax
	leaq	64(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB4_1
## BB#2:                                ## %c3HZ
	movq	$64, 192(%r13)
	movq	$254, 64(%r13)
	jmp	_stg_gc_ut              ## TAILCALL
LBB4_1:                                 ## %n3I0
	leaq	_s3o3_info(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	40(%rbp), %rcx
	movq	%rcx, 16(%rax)
	movq	%rbx, 24(%rax)
	movq	8(%rbp), %rcx
	movq	%rcx, 32(%rax)
	movq	48(%rbp), %rcx
	movq	%rcx, 40(%rax)
	movq	32(%rbp), %rcx
	movq	%rcx, 48(%rax)
	movq	24(%rbp), %rcx
	movq	%rcx, 56(%rax)
	movq	16(%rbp), %rcx
	movq	%rcx, 64(%rax)
	movq	%rbx, 48(%rbp)
	leaq	_s3qO_info(%rip), %rax
	movq	%rax, (%rbp)
	leaq	-53(%r12), %rbx
	xorl	%r14d, %r14d
	xorl	%esi, %esi
	jmp	_s3o3_info              ## TAILCALL

	.text
	.align	3                       ## @s3qJ_info_itable
_s3qJ_info_itable:
	.quad	1477                    ## 0x5c5
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qJ_info:                             ## @s3qJ_info
## BB#0:                                ## %c3Jt
	movq	40(%rbp), %rax
	shlq	$3, %rax
	movq	%rbx, (%rbp)
	leaq	_s3qI_info(%rip), %rcx
	movq	%rcx, -8(%rbp)
	addq	$-8, %rbp
	movq	%rax, %rbx
	jmp	_stg_newByteArrayzh     ## TAILCALL

	.text
	.align	3                       ## @s3qz_info_itable
_s3qz_info_itable:
	.quad	4294967299              ## 0x100000003
	.quad	17179869185             ## 0x400000001
	.quad	9                       ## 0x9

	.text
	.align	3, 0x90
_s3qz_info:                             ## @s3qz_info
## BB#0:                                ## %c3KS
	leaq	-56(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB6_1
## BB#2:                                ## %c3KZ
	movq	-8(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB6_1:                                 ## %n3L0
	movq	15(%rbx), %rax
	movq	%rax, -8(%rbp)
	shlq	$3, %rax
	movq	7(%rbx), %rcx
	movq	%rcx, -16(%rbp)
	movq	23(%rbx), %rcx
	movq	%rcx, -24(%rbp)
	movq	31(%rbx), %rcx
	movq	%rcx, -32(%rbp)
	movq	39(%rbx), %rcx
	movq	%rcx, -40(%rbp)
	leaq	_s3qJ_info(%rip), %rcx
	movq	%rcx, -48(%rbp)
	addq	$-48, %rbp
	movq	%rax, %rbx
	jmp	_stg_newByteArrayzh     ## TAILCALL

	.text
	.align	3                       ## @s3qP_info_itable
_s3qP_info_itable:
	.quad	0                       ## 0x0
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qP_info:                             ## @s3qP_info
## BB#0:                                ## %c3MU
	movq	%r12, %rax
	leaq	24(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB7_1
## BB#2:                                ## %c3Na
	movq	$24, 192(%r13)
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB7_1:                                 ## %n3Nb
	movq	_ghczmprim_GHCziTuple_Z2T_con_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	7(%rbx), %rcx
	movq	%rcx, 16(%rax)
	movq	15(%rbx), %rcx
	movq	%rcx, 24(%rax)
	movq	8(%rbp), %rax
	addq	$8, %rbp
	leaq	-15(%r12), %rbx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3qK_info_itable
_s3qK_info_itable:
	.quad	323                     ## 0x143
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qK_info:                             ## @s3qK_info
## BB#0:                                ## %c3OZ
	movq	%r12, %rax
	leaq	48(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB8_1
## BB#2:                                ## %c3Pd
	movq	$48, 192(%r13)
	movq	$255, 64(%r13)
	jmp	_stg_gc_ut              ## TAILCALL
LBB8_1:                                 ## %n3Pe
	leaq	_s3qz_info(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	16(%rbp), %rcx
	movq	%rcx, 16(%rax)
	movq	24(%rbp), %rcx
	movq	%rcx, 24(%rax)
	movq	8(%rbp), %rcx
	movq	%rcx, 32(%rax)
	movq	%r14, 40(%rax)
	movq	%rbx, 48(%rax)
	leaq	_s3qP_info(%rip), %rax
	movq	%rax, 24(%rbp)
	leaq	24(%rbp), %rbp
	leaq	-39(%r12), %r14
	jmp	_base_GHCziST_runSTRep_info ## TAILCALL

	.text
	.align	3                       ## @s3qG_info_itable
_s3qG_info_itable:
	.quad	0                       ## 0x0
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3qG_info:                             ## @s3qG_info
## BB#0:                                ## %c3Rr
	leaq	32(%r12), %rax
	movq	144(%r13), %rcx
	cmpq	%rcx, %rax
	jbe	LBB9_1
## BB#9:                                ## %c3RF
	movq	$32, 192(%r13)
	movq	-16(%r13), %rcx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB9_1:                                 ## %n3RG
	leaq	_s3nt_info(%rip), %rdx
	movq	%rdx, 8(%r12)
	movq	7(%rbx), %rdx
	movq	%rdx, 16(%r12)
	movq	23(%rbx), %rdx
	movq	%rdx, 24(%r12)
	movq	15(%rbx), %r10
	movq	%r10, 32(%r12)
	movq	15(%rbx), %rdx
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, -16(%rbp)
	movq	7(%rbx), %rdx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rdx, -8(%rbp)
	movq	23(%rbx), %rdx
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rdx, (%rbp)
	leaq	_s3qK_info(%rip), %rsi
	movq	%rsi, -24(%rbp)
	movq	24(%r12), %rsi
	xorl	%r14d, %r14d
	movl	$0, %ebx
	testq	%rsi, %rsi
	je	LBB9_7
## BB#2:                                ## %n3xd.lr.ph.lr.ph.i
	movq	-16(%rax), %rax
	movl	$1, %r11d
	subq	%rsi, %r11
	negq	%rsi
	addq	$16, %rax
	xorl	%r14d, %r14d
	xorl	%ebx, %ebx
	xorl	%edi, %edi
LBB9_3:                                 ## %n3xd.lr.ph.i
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB9_4 Depth 2
	leaq	(%r10,%rdi), %rdx
	negq	%rdi
	leaq	(%rax,%rdx,8), %r8
	.align	4, 0x90
LBB9_4:                                 ## %n3xd.i
                                        ##   Parent Loop BB9_3 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%r8), %r9
	testq	%r9, %r9
	jg	LBB9_6
## BB#5:                                ## %n3xC.i
                                        ##   in Loop: Header=BB9_4 Depth=2
	addq	%r9, %rbx
	decq	%rdi
	addq	$8, %r8
	cmpq	%rdi, %rsi
	jne	LBB9_4
	jmp	LBB9_7
	.align	4, 0x90
LBB9_6:                                 ## %c3xB.i
                                        ##   in Loop: Header=BB9_3 Depth=1
	addq	%r9, %r14
	addq	%r9, %rbx
	movl	$1, %edx
	subq	%rdi, %rdx
	cmpq	%rdi, %r11
	movq	%rdx, %rdi
	jne	LBB9_3
LBB9_7:                                 ## %s3nt_info.exit
	leaq	80(%r12), %rax
	cmpq	%rcx, %rax
	jbe	LBB9_10
## BB#8:                                ## %c3Pd.i
	addq	$-24, %rbp
	movq	$48, 192(%r13)
	movq	$255, 64(%r13)
	movq	%rax, %r12
	jmp	_stg_gc_ut              ## TAILCALL
LBB9_10:                                ## %n3Pe.i
	leaq	_s3qz_info(%rip), %rcx
	movq	%rcx, 40(%r12)
	movq	-16(%rsp), %rcx         ## 8-byte Reload
	movq	%rcx, 48(%r12)
	movq	-24(%rsp), %rcx         ## 8-byte Reload
	movq	%rcx, 56(%r12)
	movq	-8(%rsp), %rcx          ## 8-byte Reload
	movq	%rcx, 64(%r12)
	movq	%r14, 72(%r12)
	movq	%rbx, 80(%r12)
	leaq	_s3qP_info(%rip), %rcx
	movq	%rcx, (%rbp)
	leaq	-39(%rax), %r14
	movq	%rax, %r12
	jmp	_base_GHCziST_runSTRep_info ## TAILCALL

	.text
	.globl	_Main_normalise2_info_itable ## @Main_normalise2_info_itable
	.align	3
_Main_normalise2_info_itable:
	.quad	4294967301              ## 0x100000005
	.quad	0                       ## 0x0
	.quad	15                      ## 0xf

	.text
	.globl	_Main_normalise2_info
	.align	3, 0x90
_Main_normalise2_info:                  ## @Main_normalise2_info
## BB#0:                                ## %c3Tl
	leaq	-32(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB10_1
## BB#2:                                ## %c3Ts
	movq	-8(%r13), %rax
	leaq	_Main_normalise2_closure(%rip), %rbx
	jmpq	*%rax  # TAILCALL
LBB10_1:                                ## %n3Tt
	leaq	_s3qG_info(%rip), %rax
	movq	%rax, -8(%rbp)
	addq	$-8, %rbp
	movq	%r14, %rbx
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.globl	_Main_main2_info_itable ## @Main_main2_info_itable
	.align	3
_Main_main2_info_itable:
	.quad	0                       ## 0x0
	.quad	22                      ## 0x16

	.text
	.globl	_Main_main2_info
	.align	3, 0x90
_Main_main2_info:                       ## @Main_main2_info
## BB#0:                                ## %c3Ve
	pushq	%rax
	movq	%r12, %rax
	leaq	-16(%rbp), %r14
	cmpq	%r15, %r14
	jae	LBB11_2
## BB#1:
	movq	%rax, %r12
	jmp	LBB11_6
LBB11_2:                                ## %n3Vm
	leaq	16(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB11_3
## BB#5:                                ## %c3Vz
	movq	$16, 192(%r13)
LBB11_6:                                ## %c3Vl
	movq	-16(%r13), %rax
	popq	%rdx
	jmpq	*%rax  # TAILCALL
LBB11_3:                                ## %n3VA
	movq	%r15, (%rsp)            ## 8-byte Spill
	movq	_stg_CAF_BLACKHOLE_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	160(%r13), %rcx
	movq	%rcx, 16(%rax)
	leaq	8(%rax), %r15
	movq	%r13, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_newCAF
	testq	%rax, %rax
	je	LBB11_4
## BB#7:                                ## %c3VY
	movq	_stg_bh_upd_frame_info@GOTPCREL(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	%r15, -8(%rbp)
	leaq	_c3vI_str(%rip), %rax
	movq	%r14, %rbp
	movq	%rax, %r14
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rax
	jmp	_ghczmprim_GHCziCString_unpackCStringzh_info ## TAILCALL
LBB11_4:                                ## %c3VW
	movq	(%rbx), %rax
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rdx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @r3mT_info_itable
_r3mT_info_itable:
	.quad	0                       ## 0x0
	.quad	22                      ## 0x16

	.text
	.align	3, 0x90
_r3mT_info:                             ## @r3mT_info
## BB#0:                                ## %c3XY
	pushq	%rax
	movq	%r12, %rax
	leaq	-16(%rbp), %r14
	cmpq	%r15, %r14
	jae	LBB12_2
## BB#1:
	movq	%rax, %r12
	jmp	LBB12_6
LBB12_2:                                ## %n3Y6
	leaq	16(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB12_3
## BB#5:                                ## %c3Yj
	movq	$16, 192(%r13)
LBB12_6:                                ## %c3Y5
	movq	-16(%r13), %rax
	popq	%rdx
	jmpq	*%rax  # TAILCALL
LBB12_3:                                ## %n3Yk
	movq	%r15, (%rsp)            ## 8-byte Spill
	movq	_stg_CAF_BLACKHOLE_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	160(%r13), %rcx
	movq	%rcx, 16(%rax)
	leaq	8(%rax), %r15
	movq	%r13, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_newCAF
	testq	%rax, %rax
	je	LBB12_4
## BB#7:                                ## %c3YI
	movq	_stg_bh_upd_frame_info@GOTPCREL(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	%r15, -8(%rbp)
	leaq	_c3vB_str(%rip), %rax
	movq	%r14, %rbp
	movq	%rax, %r14
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rax
	jmp	_ghczmprim_GHCziCString_unpackCStringzh_info ## TAILCALL
LBB12_4:                                ## %c3YG
	movq	(%rbx), %rax
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rdx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @r3mV_info_itable
_r3mV_info_itable:
	.quad	0                       ## 0x0
	.quad	22                      ## 0x16

	.text
	.align	3, 0x90
_r3mV_info:                             ## @r3mV_info
## BB#0:                                ## %c40I
	pushq	%rax
	movq	%r12, %rax
	leaq	-16(%rbp), %r14
	cmpq	%r15, %r14
	jae	LBB13_2
## BB#1:
	movq	%rax, %r12
	jmp	LBB13_6
LBB13_2:                                ## %n40Q
	leaq	16(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB13_3
## BB#5:                                ## %c413
	movq	$16, 192(%r13)
LBB13_6:                                ## %c40P
	movq	-16(%r13), %rax
	popq	%rdx
	jmpq	*%rax  # TAILCALL
LBB13_3:                                ## %n414
	movq	%r15, (%rsp)            ## 8-byte Spill
	movq	_stg_CAF_BLACKHOLE_info@GOTPCREL(%rip), %rcx
	movq	%rcx, 8(%rax)
	movq	160(%r13), %rcx
	movq	%rcx, 16(%rax)
	leaq	8(%rax), %r15
	movq	%r13, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_newCAF
	testq	%rax, %rax
	je	LBB13_4
## BB#7:                                ## %c41s
	movq	_stg_bh_upd_frame_info@GOTPCREL(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	%r15, -8(%rbp)
	leaq	_c3vu_str(%rip), %rax
	movq	%r14, %rbp
	movq	%rax, %r14
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rax
	jmp	_ghczmprim_GHCziCString_unpackCStringzh_info ## TAILCALL
LBB13_4:                                ## %c41q
	movq	(%rbx), %rax
	movq	(%rsp), %r15            ## 8-byte Reload
	popq	%rdx
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3sW_info_itable
_s3sW_info_itable:
	.quad	(_Main_main3_srt-_s3sW_info)+8
	.quad	0                       ## 0x0
	.quad	30064771104             ## 0x700000020

	.text
	.align	3, 0x90
_s3sW_info:                             ## @s3sW_info
## BB#0:                                ## %c42y
	addq	$8, %rbp
	movq	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_Bounds_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	leaq	_r3mT_closure(%rip), %r14
	leaq	_r3mU_closure+1(%rip), %rsi
	leaq	_r3mV_closure(%rip), %r8
	movq	%rbx, %r9
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_info ## TAILCALL

	.text
	.globl	_Main_main3_info_itable ## @Main_main3_info_itable
	.align	3
_Main_main3_info_itable:
	.quad	_Main_main3_srt-_Main_main3_info
	.quad	4294967300              ## 0x100000004
	.quad	0                       ## 0x0
	.quad	64424509455             ## 0xf0000000f

	.text
	.globl	_Main_main3_info
	.align	3, 0x90
_Main_main3_info:                       ## @Main_main3_info
## BB#0:                                ## %c43s
	movq	%r14, %rax
	movq	%rbp, %rcx
	leaq	-8(%rcx), %rbp
	cmpq	%r15, %rbp
	jae	LBB15_1
## BB#2:                                ## %c43z
	movq	-8(%r13), %rdx
	leaq	_Main_main3_closure(%rip), %rbx
	movq	%rcx, %rbp
	movq	%rax, %r14
	jmpq	*%rdx  # TAILCALL
LBB15_1:                                ## %n43A
	leaq	_s3sW_info(%rip), %rcx
	movq	%rcx, (%rbp)
	xorl	%r14d, %r14d
	movq	%rax, %rsi
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3t1_info_itable
_s3t1_info_itable:
	.quad	(_Main_main4_srt-_s3t1_info)+8
	.quad	0                       ## 0x0
	.quad	30064771104             ## 0x700000020

	.text
	.align	3, 0x90
_s3t1_info:                             ## @s3t1_info
## BB#0:                                ## %c44t
	addq	$8, %rbp
	movq	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_Bounds_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	leaq	_r3mT_closure(%rip), %r14
	leaq	_r3mU_closure+1(%rip), %rsi
	leaq	_r3mV_closure(%rip), %r8
	movq	%rbx, %r9
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_info ## TAILCALL

	.text
	.globl	_Main_main4_info_itable ## @Main_main4_info_itable
	.align	3
_Main_main4_info_itable:
	.quad	_Main_main4_srt-_Main_main4_info
	.quad	4294967300              ## 0x100000004
	.quad	0                       ## 0x0
	.quad	64424509455             ## 0xf0000000f

	.text
	.globl	_Main_main4_info
	.align	3, 0x90
_Main_main4_info:                       ## @Main_main4_info
## BB#0:                                ## %c45n
	movq	%r14, %rax
	movq	%rbp, %rcx
	leaq	-8(%rcx), %rbp
	cmpq	%r15, %rbp
	jae	LBB17_1
## BB#2:                                ## %c45u
	movq	-8(%r13), %rdx
	leaq	_Main_main4_closure(%rip), %rbx
	movq	%rcx, %rbp
	movq	%rax, %r14
	jmpq	*%rdx  # TAILCALL
LBB17_1:                                ## %n45v
	leaq	_s3t1_info(%rip), %rcx
	movq	%rcx, (%rbp)
	xorl	%r14d, %r14d
	movq	%rax, %rsi
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3t6_info_itable
_s3t6_info_itable:
	.quad	(_Main_main5_srt-_s3t6_info)+8
	.quad	0                       ## 0x0
	.quad	30064771104             ## 0x700000020

	.text
	.align	3, 0x90
_s3t6_info:                             ## @s3t6_info
## BB#0:                                ## %c46o
	addq	$8, %rbp
	movq	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_Bounds_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	leaq	_r3mT_closure(%rip), %r14
	leaq	_r3mU_closure+1(%rip), %rsi
	leaq	_r3mV_closure(%rip), %r8
	movq	%rbx, %r9
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkError_info ## TAILCALL

	.text
	.globl	_Main_main5_info_itable ## @Main_main5_info_itable
	.align	3
_Main_main5_info_itable:
	.quad	_Main_main5_srt-_Main_main5_info
	.quad	4294967300              ## 0x100000004
	.quad	0                       ## 0x0
	.quad	64424509455             ## 0xf0000000f

	.text
	.globl	_Main_main5_info
	.align	3, 0x90
_Main_main5_info:                       ## @Main_main5_info
## BB#0:                                ## %c47i
	movq	%r14, %rax
	movq	%rbp, %rcx
	leaq	-8(%rcx), %rbp
	cmpq	%r15, %rbp
	jae	LBB19_1
## BB#2:                                ## %c47p
	movq	-8(%r13), %rdx
	leaq	_Main_main5_closure(%rip), %rbx
	movq	%rcx, %rbp
	movq	%rax, %r14
	jmpq	*%rdx  # TAILCALL
LBB19_1:                                ## %n47q
	leaq	_s3t6_info(%rip), %rcx
	movq	%rcx, (%rbp)
	xorl	%r14d, %r14d
	movq	%rax, %rsi
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3th_info_itable
_s3th_info_itable:
	.quad	0                       ## 0x0
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3th_info:                             ## @s3th_info
## BB#0:                                ## %c48d
	movq	7(%rbx), %rsi
	addq	$8, %rbp
	leaq	_Main_main6_closure+1(%rip), %r14
	jmp	_Common_zdwrandomzuints_info ## TAILCALL

	.text
	.align	3                       ## @s3p3_info_itable
_s3p3_info_itable:
	.quad	1                       ## 0x1
	.quad	17                      ## 0x11

	.text
	.align	3, 0x90
_s3p3_info:                             ## @s3p3_info
## BB#0:                                ## %c49n
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB21_1
## BB#3:                                ## %c49u
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB21_1:                                ## %n49v
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rcx
	movq	%rcx, -16(%rbp)
	movq	%rbx, -8(%rbp)
	movq	16(%rbx), %rbx
	leaq	_s3th_info(%rip), %rcx
	movq	%rcx, -24(%rbp)
	testb	$7, %bl
	je	LBB21_2
## BB#4:                                ## %c49Q
	addq	$-16, %rbp
	movq	7(%rbx), %rsi
	leaq	_Main_main6_closure+1(%rip), %r14
	jmp	_Common_zdwrandomzuints_info ## TAILCALL
LBB21_2:                                ## %n49R
	movq	(%rbx), %rcx
	movq	%rax, %rbp
	jmpq	*%rcx  # TAILCALL

	.text
	.align	3                       ## @s3tk_info_itable
_s3tk_info_itable:
	.quad	(_Main_main1_srt-_s3tk_info)+32
	.quad	0                       ## 0x0
	.quad	4294967328              ## 0x100000020

	.text
	.align	3, 0x90
_s3tk_info:                             ## @s3tk_info
## BB#0:                                ## %c4b6
	movq	23(%rbx), %rsi
	testq	%rsi, %rsi
	jle	LBB22_1
## BB#3:                                ## %c4bh
	movq	7(%rbx), %rax
	movq	15(%rbx), %rcx
	movq	16(%rax,%rcx,8), %rsi
	addq	$8, %rbp
	movq	_ghczmprim_GHCziTypes_ZMZN_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	xorl	%r14d, %r14d
	jmp	_base_GHCziShow_zdwshowSignedInt_info ## TAILCALL
LBB22_1:                                ## %n4bi
	cmpq	%r15, %rbp
	jae	LBB22_4
## BB#2:                                ## %c47p.i
	addq	$8, %rbp
	movq	-8(%r13), %rax
	leaq	_Main_main5_closure(%rip), %rbx
	movq	%rsi, %r14
	jmpq	*%rax  # TAILCALL
LBB22_4:                                ## %n47q.i
	leaq	_s3t6_info(%rip), %rax
	movq	%rax, (%rbp)
	xorl	%r14d, %r14d
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3tf_info_itable
_s3tf_info_itable:
	.quad	(_Main_main1_srt-_s3tf_info)+32
	.quad	1                       ## 0x1
	.quad	4294967313              ## 0x100000011

	.text
	.align	3, 0x90
_s3tf_info:                             ## @s3tf_info
## BB#0:                                ## %c4cD
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB23_1
## BB#2:                                ## %c4cK
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB23_1:                                ## %n4cL
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rcx
	movq	%rcx, -16(%rbp)
	movq	%rbx, -8(%rbp)
	movq	16(%rbx), %rbx
	leaq	_s3tk_info(%rip), %rcx
	movq	%rcx, -24(%rbp)
	movq	%rax, %rbp
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3pl_info_itable
_s3pl_info_itable:
	.quad	1                       ## 0x1
	.quad	17                      ## 0x11

	.text
	.align	3, 0x90
_s3pl_info:                             ## @s3pl_info
## BB#0:                                ## %c4dV
	leaq	-16(%rbp), %rcx
	cmpq	%r15, %rcx
	jae	LBB24_1
## BB#3:                                ## %c4e2
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB24_1:                                ## %n4e3
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	%rbx, -8(%rbp)
	movq	16(%rbx), %rax
	leaq	-48(%rbp), %rdx
	cmpq	%r15, %rdx
	jae	LBB24_4
## BB#2:                                ## %c3Ts.i
	movq	-8(%r13), %rdx
	leaq	_Main_normalise2_closure(%rip), %rbx
	movq	%rcx, %rbp
	movq	%rax, %r14
	jmpq	*%rdx  # TAILCALL
LBB24_4:                                ## %n3Tt.i
	leaq	_s3qG_info(%rip), %rcx
	movq	%rcx, -24(%rbp)
	addq	$-24, %rbp
	movq	%rax, %rbx
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3tp_info_itable
_s3tp_info_itable:
	.quad	(_Main_main1_srt-_s3tp_info)+24
	.quad	0                       ## 0x0
	.quad	4294967328              ## 0x100000020

	.text
	.align	3, 0x90
_s3tp_info:                             ## @s3tp_info
## BB#0:                                ## %c4fY
	leaq	16(%r12), %rax
	cmpq	144(%r13), %rax
	jbe	LBB25_1
## BB#4:                                ## %c4gc
	movq	$16, 192(%r13)
	movq	-16(%r13), %rcx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB25_1:                                ## %n4gd
	movq	23(%rbx), %rsi
	testq	%rsi, %rsi
	jle	LBB25_2
## BB#5:                                ## %c4go
	movq	7(%rbx), %rcx
	movq	15(%rbx), %rdx
	movq	16(%rcx,%rdx,8), %rcx
	movq	_ghczmprim_GHCziTypes_Izh_con_info@GOTPCREL(%rip), %rdx
	movq	%rdx, 8(%r12)
	movq	%rcx, 16(%r12)
	movq	8(%rbp), %rcx
	addq	$8, %rbp
	leaq	-7(%rax), %rbx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB25_2:                                ## %n4gp
	cmpq	%r15, %rbp
	jae	LBB25_6
## BB#3:                                ## %c45u.i
	addq	$8, %rbp
	movq	-8(%r13), %rax
	leaq	_Main_main4_closure(%rip), %rbx
	movq	%rsi, %r14
	jmpq	*%rax  # TAILCALL
LBB25_6:                                ## %n45v.i
	leaq	_s3t1_info(%rip), %rax
	movq	%rax, (%rbp)
	xorl	%r14d, %r14d
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3pJ_info_itable
_s3pJ_info_itable:
	.quad	(_Main_main1_srt-_s3pJ_info)+24
	.quad	1                       ## 0x1
	.quad	4294967313              ## 0x100000011

	.text
	.align	3, 0x90
_s3pJ_info:                             ## @s3pJ_info
## BB#0:                                ## %c4i9
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB26_1
## BB#2:                                ## %c4ig
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB26_1:                                ## %n4ih
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rcx
	movq	%rcx, -16(%rbp)
	movq	%rbx, -8(%rbp)
	movq	16(%rbx), %rbx
	leaq	_s3tp_info(%rip), %rcx
	movq	%rcx, -24(%rbp)
	movq	%rax, %rbp
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3tr_info_itable
_s3tr_info_itable:
	.quad	(_Main_main1_srt-_s3tr_info)+16
	.quad	0                       ## 0x0
	.quad	4294967328              ## 0x100000020

	.text
	.align	3, 0x90
_s3tr_info:                             ## @s3tr_info
## BB#0:                                ## %c4ke
	leaq	16(%r12), %rax
	cmpq	144(%r13), %rax
	jbe	LBB27_1
## BB#4:                                ## %c4ks
	movq	$16, 192(%r13)
	movq	-16(%r13), %rcx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB27_1:                                ## %n4kt
	movq	23(%rbx), %rsi
	testq	%rsi, %rsi
	jle	LBB27_2
## BB#5:                                ## %c4kE
	movq	7(%rbx), %rcx
	movq	15(%rbx), %rdx
	movq	16(%rcx,%rdx,8), %rcx
	movq	_ghczmprim_GHCziTypes_Izh_con_info@GOTPCREL(%rip), %rdx
	movq	%rdx, 8(%r12)
	movq	%rcx, 16(%r12)
	movq	8(%rbp), %rcx
	addq	$8, %rbp
	leaq	-7(%rax), %rbx
	movq	%rax, %r12
	jmpq	*%rcx  # TAILCALL
LBB27_2:                                ## %n4kF
	cmpq	%r15, %rbp
	jae	LBB27_6
## BB#3:                                ## %c43z.i
	addq	$8, %rbp
	movq	-8(%r13), %rax
	leaq	_Main_main3_closure(%rip), %rbx
	movq	%rsi, %r14
	jmpq	*%rax  # TAILCALL
LBB27_6:                                ## %n43A.i
	leaq	_s3sW_info(%rip), %rax
	movq	%rax, (%rbp)
	xorl	%r14d, %r14d
	jmp	_vectorzm0zi10zi0zi1_DataziVectorziInternalziCheck_checkIndexzumsgzh_info ## TAILCALL

	.text
	.align	3                       ## @s3pV_info_itable
_s3pV_info_itable:
	.quad	(_Main_main1_srt-_s3pV_info)+16
	.quad	1                       ## 0x1
	.quad	4294967313              ## 0x100000011

	.text
	.align	3, 0x90
_s3pV_info:                             ## @s3pV_info
## BB#0:                                ## %c4mp
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB28_1
## BB#2:                                ## %c4mw
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB28_1:                                ## %n4mx
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rcx
	movq	%rcx, -16(%rbp)
	movq	%rbx, -8(%rbp)
	movq	16(%rbx), %rbx
	leaq	_s3tr_info(%rip), %rcx
	movq	%rcx, -24(%rbp)
	movq	%rax, %rbp
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3ts_info_itable
_s3ts_info_itable:
	.quad	1                       ## 0x1
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3ts_info:                             ## @s3ts_info
## BB#0:                                ## %c4nu
	movq	7(%rbx), %rsi
	movq	8(%rbp), %rdi
	addq	$16, %rbp
	xorl	%r14d, %r14d
	jmp	_base_GHCziShow_zdwshowSignedInt_info ## TAILCALL

	.text
	.align	3                       ## @s3q8_info_itable
_s3q8_info_itable:
	.quad	4294967301              ## 0x100000005
	.quad	1                       ## 0x1
	.quad	10                      ## 0xa

	.text
	.align	3, 0x90
_s3q8_info:                             ## @s3q8_info
## BB#0:                                ## %c4oD
	movq	%r14, %rax
	leaq	-16(%rbp), %rcx
	cmpq	%r15, %rcx
	jae	LBB30_1
## BB#3:                                ## %c4oK
	movq	-8(%r13), %rcx
	movq	%rax, %r14
	jmpq	*%rcx  # TAILCALL
LBB30_1:                                ## %n4oL
	movq	%rax, -8(%rbp)
	movq	7(%rbx), %rbx
	leaq	_s3ts_info(%rip), %rdx
	movq	%rdx, -16(%rbp)
	testb	$7, %bl
	je	LBB30_2
## BB#4:                                ## %c4p5
	movq	7(%rbx), %rsi
	xorl	%r14d, %r14d
	movq	%rax, %rdi
	jmp	_base_GHCziShow_zdwshowSignedInt_info ## TAILCALL
LBB30_2:                                ## %n4p6
	movq	(%rbx), %rax
	movq	%rcx, %rbp
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3tt_info_itable
_s3tt_info_itable:
	.quad	1                       ## 0x1
	.quad	32                      ## 0x20

	.text
	.align	3, 0x90
_s3tt_info:                             ## @s3tt_info
## BB#0:                                ## %c4pW
	movq	7(%rbx), %rsi
	movq	8(%rbp), %rdi
	addq	$16, %rbp
	xorl	%r14d, %r14d
	jmp	_base_GHCziShow_zdwshowSignedInt_info ## TAILCALL

	.text
	.align	3                       ## @s3qb_info_itable
_s3qb_info_itable:
	.quad	4294967301              ## 0x100000005
	.quad	1                       ## 0x1
	.quad	10                      ## 0xa

	.text
	.align	3, 0x90
_s3qb_info:                             ## @s3qb_info
## BB#0:                                ## %c4r5
	movq	%r14, %rax
	leaq	-16(%rbp), %rcx
	cmpq	%r15, %rcx
	jae	LBB32_1
## BB#3:                                ## %c4rc
	movq	-8(%r13), %rcx
	movq	%rax, %r14
	jmpq	*%rcx  # TAILCALL
LBB32_1:                                ## %n4rd
	movq	%rax, -8(%rbp)
	movq	7(%rbx), %rbx
	leaq	_s3tt_info(%rip), %rdx
	movq	%rdx, -16(%rbp)
	testb	$7, %bl
	je	LBB32_2
## BB#4:                                ## %c4rx
	movq	7(%rbx), %rsi
	xorl	%r14d, %r14d
	movq	%rax, %rdi
	jmp	_base_GHCziShow_zdwshowSignedInt_info ## TAILCALL
LBB32_2:                                ## %n4ry
	movq	(%rbx), %rax
	movq	%rcx, %rbp
	jmpq	*%rax  # TAILCALL

	.text
	.align	3                       ## @s3tb_info_itable
_s3tb_info_itable:
	.quad	(_Main_main1_srt-_s3tb_info)+8
	.quad	2                       ## 0x2
	.quad	30064771091             ## 0x700000013

	.text
	.align	3, 0x90
_s3tb_info:                             ## @s3tb_info
## BB#0:                                ## %c4tR
	movq	%r12, %rcx
	leaq	-32(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB33_2
## BB#1:
	movq	%rcx, %r12
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB33_2:                                ## %n4tZ
	movq	%rcx, %r12
	subq	$-128, %r12
	cmpq	144(%r13), %r12
	jbe	LBB33_5
## BB#3:                                ## %c4uc
	movq	$128, 192(%r13)
	movq	-16(%r13), %rax
	jmpq	*%rax  # TAILCALL
LBB33_5:                                ## %n4ud
	movq	_stg_upd_frame_info@GOTPCREL(%rip), %rdx
	movq	%rdx, -16(%rbp)
	movq	%rbx, -8(%rbp)
	leaq	8(%rcx), %rdx
	leaq	_s3pJ_info(%rip), %rsi
	movq	%rsi, 8(%rcx)
	movq	16(%rbx), %rsi
	movq	%rsi, 24(%rcx)
	leaq	32(%rcx), %rsi
	leaq	_s3pV_info(%rip), %rdi
	movq	%rdi, 32(%rcx)
	movq	24(%rbx), %rdi
	movq	%rdi, 48(%rcx)
	leaq	_s3q8_info(%rip), %rdi
	movq	%rdi, 56(%rcx)
	movq	%rdx, 64(%rcx)
	movq	_ghczmprim_GHCziTypes_ZC_con_info@GOTPCREL(%rip), %r8
	movq	%r8, 72(%rcx)
	leaq	-71(%r12), %rdi
	movq	%rdi, 80(%rcx)
	movq	_ghczmprim_GHCziTypes_ZMZN_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	movq	%rdi, 88(%rcx)
	leaq	_s3qb_info(%rip), %rdx
	movq	%rdx, 96(%rcx)
	movq	%rsi, 104(%rcx)
	movq	%r8, 112(%rcx)
	leaq	-31(%r12), %rdx
	movq	%rdx, 120(%rcx)
	leaq	-54(%r12), %rdx
	movq	%rdx, 128(%rcx)
	movq	%rdi, -24(%rbp)
	movq	_stg_ap_p_info@GOTPCREL(%rip), %rcx
	movq	%rcx, -32(%rbp)
	leaq	-14(%r12), %r14
	movq	%rax, %rbp
	jmp	_base_GHCziShow_showzutuple_info ## TAILCALL

	.text
	.align	3                       ## @s3tu_info_itable
_s3tu_info_itable:
	.quad	_Main_main1_srt-_s3tu_info
	.quad	0                       ## 0x0
	.quad	416611827744            ## 0x6100000020

	.text
	.align	3, 0x90
_s3tu_info:                             ## @s3tu_info
## BB#0:                                ## %c4wd
	addq	$8, %rbp
	movq	_ghczmprim_GHCziTypes_False_closure@GOTPCREL(%rip), %rdi
	incq	%rdi
	movq	_base_GHCziIOziHandleziFD_stdout_closure@GOTPCREL(%rip), %r14
	leaq	_Main_main2_closure(%rip), %rsi
	jmp	_base_GHCziIOziHandleziText_hPutStr2_info ## TAILCALL

	.text
	.align	3                       ## @s3tv_info_itable
_s3tv_info_itable:
	.quad	_Main_main1_srt-_s3tv_info
	.quad	1                       ## 0x1
	.quad	416611827744            ## 0x6100000020

	.text
	.align	3, 0x90
_s3tv_info:                             ## @s3tv_info
## BB#0:                                ## %c4wL
	movq	8(%rbp), %rbx
	leaq	_s3tu_info(%rip), %rax
	movq	%rax, 8(%rbp)
	leaq	8(%rbp), %rbp
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3tw_info_itable
_s3tw_info_itable:
	.quad	_Main_main1_srt-_s3tw_info
	.quad	2                       ## 0x2
	.quad	416611827744            ## 0x6100000020

	.text
	.align	3, 0x90
_s3tw_info:                             ## @s3tw_info
## BB#0:                                ## %c4xj
	movq	8(%rbp), %rbx
	leaq	_s3tv_info(%rip), %rax
	movq	%rax, 8(%rbp)
	leaq	8(%rbp), %rbp
	jmp	_stg_ap_0_fast          ## TAILCALL

	.text
	.align	3                       ## @s3tl_info_itable
_s3tl_info_itable:
	.quad	_Main_main1_srt-_s3tl_info
	.quad	1                       ## 0x1
	.quad	476741369888            ## 0x6f00000020

	.text
	.align	3, 0x90
_s3tl_info:                             ## @s3tl_info
## BB#0:                                ## %c4z3
	movq	%r12, %rax
	leaq	104(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB37_1
## BB#2:                                ## %c4zh
	movq	$104, 192(%r13)
	movq	$254, 64(%r13)
	jmp	_stg_gc_ut              ## TAILCALL
LBB37_1:                                ## %n4zi
	leaq	8(%rax), %rcx
	leaq	_s3pl_info(%rip), %rdx
	movq	%rdx, 8(%rax)
	movq	8(%rbp), %rdx
	movq	%rdx, 24(%rax)
	leaq	32(%rax), %rdx
	movq	_stg_sel_1_upd_info@GOTPCREL(%rip), %rsi
	movq	%rsi, 32(%rax)
	movq	%rcx, 48(%rax)
	leaq	56(%rax), %rdi
	movq	_stg_sel_0_upd_info@GOTPCREL(%rip), %rsi
	movq	%rsi, 56(%rax)
	movq	%rcx, 72(%rax)
	leaq	_s3tb_info(%rip), %rcx
	movq	%rcx, 80(%rax)
	movq	%rdx, 96(%rax)
	movq	%rdi, 104(%rax)
	leaq	80(%rax), %rsi
	movq	%rdi, (%rbp)
	movq	%rdx, 8(%rbp)
	leaq	_s3tw_info(%rip), %rax
	movq	%rax, -8(%rbp)
	addq	$-8, %rbp
	movq	_ghczmprim_GHCziTypes_True_closure@GOTPCREL(%rip), %rdi
	addq	$2, %rdi
	movq	_base_GHCziIOziHandleziFD_stdout_closure@GOTPCREL(%rip), %r14
	jmp	_base_GHCziIOziHandleziText_hPutStr2_info ## TAILCALL

	.text
	.align	3                       ## @s3ti_info_itable
_s3ti_info_itable:
	.quad	_Main_main1_srt-_s3ti_info
	.quad	0                       ## 0x0
	.quad	545460846624            ## 0x7f00000020

	.text
	.align	3, 0x90
_s3ti_info:                             ## @s3ti_info
## BB#0:                                ## %c4BA
	movq	%r12, %rax
	leaq	48(%rax), %r12
	cmpq	144(%r13), %r12
	jbe	LBB38_1
## BB#2:                                ## %c4BO
	movq	$48, 192(%r13)
	movq	$254, 64(%r13)
	jmp	_stg_gc_ut              ## TAILCALL
LBB38_1:                                ## %n4BP
	leaq	8(%rax), %rcx
	leaq	_s3p3_info(%rip), %rdx
	movq	%rdx, 8(%rax)
	movq	%rbx, 24(%rax)
	leaq	_s3tf_info(%rip), %rdx
	movq	%rdx, 32(%rax)
	movq	%rcx, 48(%rax)
	leaq	32(%rax), %rsi
	movq	%rcx, (%rbp)
	leaq	_s3tl_info(%rip), %rax
	movq	%rax, -8(%rbp)
	addq	$-8, %rbp
	movq	_ghczmprim_GHCziTypes_True_closure@GOTPCREL(%rip), %rdi
	addq	$2, %rdi
	movq	_base_GHCziIOziHandleziFD_stdout_closure@GOTPCREL(%rip), %r14
	jmp	_base_GHCziIOziHandleziText_hPutStr2_info ## TAILCALL

	.text
	.globl	_Main_main1_info_itable ## @Main_main1_info_itable
	.align	3
_Main_main1_info_itable:
	.quad	_Main_main1_srt-_Main_main1_info
	.quad	4294967299              ## 0x100000003
	.quad	0                       ## 0x0
	.quad	1095216660495           ## 0xff0000000f

	.text
	.globl	_Main_main1_info
	.align	3, 0x90
_Main_main1_info:                       ## @Main_main1_info
## BB#0:                                ## %c4D8
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB39_1
## BB#2:                                ## %c4Df
	movq	-8(%r13), %rax
	leaq	_Main_main1_closure(%rip), %rbx
	jmpq	*%rax  # TAILCALL
LBB39_1:                                ## %n4Dg
	leaq	_s3ti_info(%rip), %rax
	movq	%rax, -8(%rbp)
	addq	$-8, %rbp
	jmp	_Common_getzusizze1_info ## TAILCALL

	.text
	.globl	_Main_main_info_itable  ## @Main_main_info_itable
	.align	3
_Main_main_info_itable:
	.quad	_Main_main_srt-_Main_main_info
	.quad	4294967299              ## 0x100000003
	.quad	0                       ## 0x0
	.quad	4294967311              ## 0x10000000f

	.text
	.globl	_Main_main_info
	.align	3, 0x90
_Main_main_info:                        ## @Main_main_info
## BB#0:                                ## %c4DN
	leaq	-24(%rbp), %rax
	cmpq	%r15, %rax
	jae	LBB40_1
## BB#2:                                ## %c4Df.i
	movq	-8(%r13), %rax
	leaq	_Main_main1_closure(%rip), %rbx
	jmpq	*%rax  # TAILCALL
LBB40_1:                                ## %n4Dg.i
	leaq	_s3ti_info(%rip), %rax
	movq	%rax, -8(%rbp)
	addq	$-8, %rbp
	jmp	_Common_getzusizze1_info ## TAILCALL

	.text
	.globl	_Main_main7_info_itable ## @Main_main7_info_itable
	.align	3
_Main_main7_info_itable:
	.quad	_Main_main7_srt-_Main_main7_info
	.quad	4294967299              ## 0x100000003
	.quad	0                       ## 0x0
	.quad	12884901903             ## 0x30000000f

	.text
	.globl	_Main_main7_info
	.align	3, 0x90
_Main_main7_info:                       ## @Main_main7_info
## BB#0:                                ## %c4E5
	leaq	_Main_main1_closure+1(%rip), %r14
	jmp	_base_GHCziTopHandler_runMainIO1_info ## TAILCALL

	.text
	.globl	_ZCMain_main_info_itable ## @ZCMain_main_info_itable
	.align	3
_ZCMain_main_info_itable:
	.quad	_ZCMain_main_srt-_ZCMain_main_info
	.quad	4294967299              ## 0x100000003
	.quad	0                       ## 0x0
	.quad	4294967311              ## 0x10000000f

	.no_dead_strip	_s3ti_info_itable
	.no_dead_strip	_s3tl_info_itable
	.no_dead_strip	_s3tw_info_itable
	.no_dead_strip	_s3tv_info_itable
	.no_dead_strip	_s3tu_info_itable
	.no_dead_strip	_s3tb_info_itable
	.no_dead_strip	_s3qb_info_itable
	.no_dead_strip	_s3tt_info_itable
	.no_dead_strip	_s3q8_info_itable
	.no_dead_strip	_s3ts_info_itable
	.no_dead_strip	_s3pV_info_itable
	.no_dead_strip	_s3tr_info_itable
	.no_dead_strip	_s3pJ_info_itable
	.no_dead_strip	_s3tp_info_itable
	.no_dead_strip	_s3pl_info_itable
	.no_dead_strip	_s3tf_info_itable
	.no_dead_strip	_s3tk_info_itable
	.no_dead_strip	_s3p3_info_itable
	.no_dead_strip	_s3th_info_itable
	.no_dead_strip	_s3t6_info_itable
	.no_dead_strip	_s3t1_info_itable
	.no_dead_strip	_s3sW_info_itable
	.no_dead_strip	_r3mV_info_itable
	.no_dead_strip	_r3mT_info_itable
	.no_dead_strip	_s3qG_info_itable
	.no_dead_strip	_s3qK_info_itable
	.no_dead_strip	_s3qP_info_itable
	.no_dead_strip	_s3qz_info_itable
	.no_dead_strip	_s3qJ_info_itable
	.no_dead_strip	_s3qI_info_itable
	.no_dead_strip	_s3qO_info_itable
	.no_dead_strip	_s3qN_info_itable
	.no_dead_strip	_s3o3_info_itable
	.no_dead_strip	_s3nt_info_itable

.subsections_via_symbols
	.text
	.globl	_ZCMain_main_info
	.align	3, 0x90
_ZCMain_main_info:                      ## @ZCMain_main_info
## BB#0:                                ## %c4En
	leaq	_Main_main1_closure+1(%rip), %r14
	jmp	_base_GHCziTopHandler_runMainIO1_info ## TAILCALL

	.globl	___stginit_Main         ## @__stginit_Main
.zerofill __DATA,__common,___stginit_Main,1,3
