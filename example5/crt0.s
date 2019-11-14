	.file   "crt0.s"

	.section text
        .text
        .globl  _start
        .globl  _bss_start__
        .globl  _bss_end__

_start:
	# setup stack...
	
	ldr x0, .LC3
	mov sp, x0

	# Setup an initial dummy frame with saved fp=0 and saved lr=0...
	
        mov x29, 0
        stp x29, x29, [sp, #-16]!
        mov x29, sp

	# note: in this simple-minded example, there is no heap, ie, no dynamic
	# memory allocation (gasp!)...

	# initialize bss section...

	ldr x0, .LC1
	mov w1,#0
	ldr x2, .LC2
	sub x2,x2,x0
	bl memset
	
	# run user code...
	
	bl main

	# exit (note: explicitely call _exit, not exit. otherwise an exit subroutine (that invokes _exit)
	# will be linked in before this code, screwing up the entry point)...
	
	b _exit


# linker will resolve these symbols:
	
.LC1:
        .dword __bss_start__
.LC2:
        .dword __bss_end__
.LC3:
        .dword _stack
	
	
