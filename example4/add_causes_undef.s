	.file   "add_causes_undef.s"

	.section text
        .text
        .globl  _reset

_reset:
	# set el1 exception base address...
	
	mov x1,#0
	msr vbar_el1,x1

	mov x1,bogus_add
	msr elr_el3,x1
        # setup saved pstate to get to el0...
        mov x1,#0x3c0
        msr spsr_el3,x1
        # 'return' to el0, at start of test...
        eret

bogus_add:
	nop
	
	# add immediate with reserved shift value to cause UNDEF exception...

	.byte 0x00, 0x00, 0xc0, 0x11

	# how 'bout an SVC for good measure?...

	svc #99
	nop  
	
	wfi

	# exception vector offset for synchronous exceptions at el3 including undef is 0x400...
	.align 10
	
exc_handler:
	# examine exception syndrome - undef vs svc...
	mrs x1,esr_el1
	lsr x1,x1,#16
	cmp x1,#0x200
	bne svc_handler
	
	# bump exception return address by 4 effectively skipping offending instruction...

	mrs x1,elr_el1
	add x1,x1,#4
	msr elr_el1,x1
	eret

	# for svc, simply return...
svc_handler:
	eret

