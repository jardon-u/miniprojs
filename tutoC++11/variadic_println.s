	.file	"variadic_println.cc"
	.text
	.globl	_Z7printlnv
	.type	_Z7printlnv, @function
_Z7printlnv:
.LFB1253:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	.cfi_escape 0x2e,0xc
	pushl	$_ZSt4cout
	.cfi_escape 0x2e,0x10
	call	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
	addl	$16, %esp
	.cfi_escape 0x2e,0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1253:
	.size	_Z7printlnv, .-_Z7printlnv
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	" "
.LC1:
	.string	"foo"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB1255:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$12, %esp
	.cfi_escape 0x2e,0x8
	pushl	$5
	.cfi_escape 0x2e,0xc
	pushl	$_ZSt4cout
	.cfi_escape 0x2e,0x10
	call	_ZNSolsEi
	popl	%edx
	.cfi_escape 0x2e,0xc
	popl	%ecx
	.cfi_escape 0x2e,0x8
	pushl	$.LC0
	.cfi_escape 0x2e,0xc
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	popl	%eax
	.cfi_escape 0x2e,0xc
	popl	%edx
	.cfi_escape 0x2e,0x8
	pushl	$.LC1
	.cfi_escape 0x2e,0xc
	pushl	$_ZSt4cout
	.cfi_escape 0x2e,0x10
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	popl	%ecx
	.cfi_escape 0x2e,0xc
	popl	%edx
	.cfi_escape 0x2e,0x8
	pushl	$.LC0
	.cfi_escape 0x2e,0xc
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	addl	$12, %esp
	.cfi_escape 0x2e,0x4
	pushl	$1075956940
	.cfi_escape 0x2e,0x8
	pushl	$-858993459
	.cfi_escape 0x2e,0xc
	pushl	$_ZSt4cout
	.cfi_escape 0x2e,0x10
	call	_ZNSo9_M_insertIdEERSoT_
	popl	%ecx
	.cfi_escape 0x2e,0xc
	popl	%edx
	.cfi_escape 0x2e,0x8
	pushl	$.LC0
	.cfi_escape 0x2e,0xc
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	popl	%ecx
	.cfi_escape 0x2e,0xc
	popl	%eax
	.cfi_escape 0x2e,0x8
	pushl	$5
	.cfi_escape 0x2e,0xc
	pushl	$_ZSt4cout
	.cfi_escape 0x2e,0x10
	call	_ZNSolsEi
	popl	%edx
	.cfi_escape 0x2e,0xc
	popl	%ecx
	.cfi_escape 0x2e,0x8
	pushl	$.LC0
	.cfi_escape 0x2e,0xc
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	addl	$16, %esp
	.cfi_escape 0x2e,0
	call	_Z7printlnv
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	xorl	%eax, %eax
	leave
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1255:
	.size	main, .-main
	.type	_GLOBAL__sub_I__Z7printlnv, @function
_GLOBAL__sub_I__Z7printlnv:
.LFB1417:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	.cfi_escape 0x2e,0xc
	pushl	$_ZStL8__ioinit
	.cfi_escape 0x2e,0x10
	call	_ZNSt8ios_base4InitC1Ev
	addl	$12, %esp
	.cfi_escape 0x2e,0x4
	pushl	$__dso_handle
	.cfi_escape 0x2e,0x8
	pushl	$_ZStL8__ioinit
	.cfi_escape 0x2e,0xc
	pushl	$_ZNSt8ios_base4InitD1Ev
	.cfi_escape 0x2e,0x10
	call	__cxa_atexit
	addl	$16, %esp
	.cfi_escape 0x2e,0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1417:
	.size	_GLOBAL__sub_I__Z7printlnv, .-_GLOBAL__sub_I__Z7printlnv
	.section	.ctors,"aw",@progbits
	.align 4
	.long	_GLOBAL__sub_I__Z7printlnv
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.weakref	_ZL20__gthrw_pthread_oncePiPFvvE,pthread_once
	.weakref	_ZL27__gthrw_pthread_getspecificj,pthread_getspecific
	.weakref	_ZL27__gthrw_pthread_setspecificjPKv,pthread_setspecific
	.weakref	_ZL22__gthrw_pthread_createPmPK14pthread_attr_tPFPvS3_ES3_,pthread_create
	.weakref	_ZL20__gthrw_pthread_joinmPPv,pthread_join
	.weakref	_ZL21__gthrw_pthread_equalmm,pthread_equal
	.weakref	_ZL20__gthrw_pthread_selfv,pthread_self
	.weakref	_ZL22__gthrw_pthread_detachm,pthread_detach
	.weakref	_ZL22__gthrw_pthread_cancelm,pthread_cancel
	.weakref	_ZL19__gthrw_sched_yieldv,sched_yield
	.weakref	_ZL26__gthrw_pthread_mutex_lockP15pthread_mutex_t,pthread_mutex_lock
	.weakref	_ZL29__gthrw_pthread_mutex_trylockP15pthread_mutex_t,pthread_mutex_trylock
	.weakref	_ZL31__gthrw_pthread_mutex_timedlockP15pthread_mutex_tPK8timespec,pthread_mutex_timedlock
	.weakref	_ZL28__gthrw_pthread_mutex_unlockP15pthread_mutex_t,pthread_mutex_unlock
	.weakref	_ZL26__gthrw_pthread_mutex_initP15pthread_mutex_tPK19pthread_mutexattr_t,pthread_mutex_init
	.weakref	_ZL29__gthrw_pthread_mutex_destroyP15pthread_mutex_t,pthread_mutex_destroy
	.weakref	_ZL30__gthrw_pthread_cond_broadcastP14pthread_cond_t,pthread_cond_broadcast
	.weakref	_ZL27__gthrw_pthread_cond_signalP14pthread_cond_t,pthread_cond_signal
	.weakref	_ZL25__gthrw_pthread_cond_waitP14pthread_cond_tP15pthread_mutex_t,pthread_cond_wait
	.weakref	_ZL30__gthrw_pthread_cond_timedwaitP14pthread_cond_tP15pthread_mutex_tPK8timespec,pthread_cond_timedwait
	.weakref	_ZL28__gthrw_pthread_cond_destroyP14pthread_cond_t,pthread_cond_destroy
	.weakref	_ZL26__gthrw_pthread_key_createPjPFvPvE,pthread_key_create
	.weakref	_ZL26__gthrw_pthread_key_deletej,pthread_key_delete
	.weakref	_ZL30__gthrw_pthread_mutexattr_initP19pthread_mutexattr_t,pthread_mutexattr_init
	.weakref	_ZL33__gthrw_pthread_mutexattr_settypeP19pthread_mutexattr_ti,pthread_mutexattr_settype
	.weakref	_ZL33__gthrw_pthread_mutexattr_destroyP19pthread_mutexattr_t,pthread_mutexattr_destroy
	.ident	"GCC: (Ubuntu 4.6.0-3~ppa1) 4.6.1 20110409 (prerelease)"
	.section	.note.GNU-stack,"",@progbits
