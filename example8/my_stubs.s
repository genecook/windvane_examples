	.arch armv8-a+nosimd
	.file	"my_stubs.c"
	.text
	.global	__env
	.bss
	.align	3
	.type	__env, %object
	.size	__env, 8
__env:
	.zero	8
	.global	environ
	.data
	.align	3
	.type	environ, %object
	.size	environ, 8
environ:
	.xword	__env
	.text
	.align	2
	.global	_cpu_init_hook
	.type	_cpu_init_hook, %function
_cpu_init_hook:
	nop
	ret
	.size	_cpu_init_hook, .-_cpu_init_hook
	.align	2
	.global	_exit
	.type	_exit, %function
_exit:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	// Start of user assembly
// 18 "my_stubs.c" 1
	wfi
// 0 "" 2
	// End of user assembly
	nop
	add	sp, sp, 16
	ret
	.size	_exit, .-_exit
	.align	2
	.global	_close
	.type	_close, %function
_close:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 9
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_close, .-_close
	.align	2
	.global	_execve
	.type	_execve, %function
_execve:
	sub	sp, sp, #32
	str	x0, [sp, 24]
	str	x1, [sp, 16]
	str	x2, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 12
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 32
	ret
	.size	_execve, .-_execve
	.align	2
	.global	_fork
	.type	_fork, %function
_fork:
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 11
	str	w1, [x0]
	mov	w0, -1
	ret
	.size	_fork, .-_fork
	.align	2
	.global	_fstat
	.type	_fstat, %function
_fstat:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	str	x1, [sp]
	ldr	x0, [sp]
	mov	w1, 8192
	str	w1, [x0, 4]
	mov	w0, 0
	add	sp, sp, 16
	ret
	.size	_fstat, .-_fstat
	.align	2
	.global	_getpid
	.type	_getpid, %function
_getpid:
	mov	w0, 1
	ret
	.size	_getpid, .-_getpid
	.align	2
	.global	_isatty
	.type	_isatty, %function
_isatty:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	mov	w0, 1
	add	sp, sp, 16
	ret
	.size	_isatty, .-_isatty
	.align	2
	.global	_kill
	.type	_kill, %function
_kill:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	str	w1, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 22
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_kill, .-_kill
	.align	2
	.global	_link
	.type	_link, %function
_link:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	str	x1, [sp]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 31
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_link, .-_link
	.align	2
	.global	_lseek
	.type	_lseek, %function
_lseek:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	str	x1, [sp]
	str	w2, [sp, 8]
	mov	x0, 0
	add	sp, sp, 16
	ret
	.size	_lseek, .-_lseek
	.align	2
	.global	_open
	.type	_open, %function
_open:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	str	w1, [sp, 4]
	str	w2, [sp]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 88
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_open, .-_open
	.align	2
	.global	_inbyte
	.type	_inbyte, %function
_inbyte:
	// Start of user assembly
// 70 "my_stubs.c" 1
	mov x1,#0x9000000
// 0 "" 2
// 71 "my_stubs.c" 1
	ldr w0,[x1],#0
// 0 "" 2
	// End of user assembly
	nop
	ret
	.size	_inbyte, .-_inbyte
	.align	2
	.global	_read
	.type	_read, %function
_read:
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	str	x19, [sp, 16]
	str	w0, [sp, 60]
	str	x1, [sp, 48]
	str	x2, [sp, 40]
	ldr	x0, [sp, 48]
	str	x0, [sp, 64]
	str	wzr, [sp, 72]
	str	wzr, [sp, 76]
	b	.L25
.L28:
	ldrsw	x0, [sp, 76]
	ldr	x1, [sp, 64]
	add	x19, x1, x0
	bl	_inbyte
	and	w0, w0, 255
	strb	w0, [x19]
	ldr	w0, [sp, 72]
	add	w0, w0, 1
	str	w0, [sp, 72]
	ldrsw	x0, [sp, 76]
	ldr	x1, [sp, 64]
	add	x0, x1, x0
	ldrb	w0, [x0]
	cmp	w0, 10
	beq	.L30
	ldr	w0, [sp, 76]
	add	w0, w0, 1
	str	w0, [sp, 76]
.L25:
	ldrsw	x0, [sp, 76]
	ldr	x1, [sp, 40]
	cmp	x1, x0
	bhi	.L28
	b	.L27
.L30:
	nop
.L27:
	ldr	w0, [sp, 72]
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 80
	ret
	.size	_read, .-_read
	.align	2
	.global	_sbrk
	.type	_sbrk, %function
_sbrk:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 12
	str	w1, [x0]
	mov	x0, -1
	add	sp, sp, 16
	ret
	.size	_sbrk, .-_sbrk
	.align	2
	.global	_stat
	.type	_stat, %function
_stat:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	str	x1, [sp]
	ldr	x0, [sp]
	mov	w1, 8192
	str	w1, [x0, 4]
	mov	w0, 0
	add	sp, sp, 16
	ret
	.size	_stat, .-_stat
	.align	2
	.global	_times
	.type	_times, %function
_times:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 13
	str	w1, [x0]
	mov	x0, -1
	add	sp, sp, 16
	ret
	.size	_times, .-_times
	.align	2
	.global	_unlink
	.type	_unlink, %function
_unlink:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 2
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_unlink, .-_unlink
	.align	2
	.global	_wait
	.type	_wait, %function
_wait:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 10
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_wait, .-_wait
	.align	2
	.global	_outbyte
	.type	_outbyte, %function
_outbyte:
	sub	sp, sp, #16
	strb	w0, [sp, 15]
	// Start of user assembly
// 113 "my_stubs.c" 1
	mov x1,#0x9000000
// 0 "" 2
// 114 "my_stubs.c" 1
	str w0,[x1],#0
// 0 "" 2
	// End of user assembly
	nop
	add	sp, sp, 16
	ret
	.size	_outbyte, .-_outbyte
	.align	2
	.global	_write
	.type	_write, %function
_write:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	str	w0, [sp, 44]
	str	x1, [sp, 32]
	str	x2, [sp, 24]
	ldr	x0, [sp, 32]
	str	x0, [sp, 48]
	str	wzr, [sp, 60]
	b	.L43
.L44:
	ldrsw	x0, [sp, 60]
	ldr	x1, [sp, 48]
	add	x0, x1, x0
	ldrb	w0, [x0]
	bl	_outbyte
	ldr	w0, [sp, 60]
	add	w0, w0, 1
	str	w0, [sp, 60]
.L43:
	ldrsw	x0, [sp, 60]
	ldr	x1, [sp, 24]
	cmp	x1, x0
	bhi	.L44
	ldr	x0, [sp, 24]
	ldp	x29, x30, [sp], 64
	ret
	.size	_write, .-_write
	.align	2
	.global	_gettimeofday
	.type	_gettimeofday, %function
_gettimeofday:
	sub	sp, sp, #16
	str	x0, [sp, 8]
	str	x1, [sp]
	adrp	x0, errno
	add	x0, x0, :lo12:errno
	mov	w1, 88
	str	w1, [x0]
	mov	w0, -1
	add	sp, sp, 16
	ret
	.size	_gettimeofday, .-_gettimeofday
	.ident	"GCC: (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 8.3.0"
