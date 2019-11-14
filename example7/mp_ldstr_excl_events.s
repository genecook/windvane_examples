	.file	"mp_ldstr_excl_events.s"

	.section text
	.text
	.globl	boot
	.type	boot, @function
	
boot:
	# branch if not core 0...

	mrs x2,mpidr_el1
	and w2,w2,#0xff
	cmp w2,#0
	bne not_core0

	# core 0 waits 'til count
	# indicates all other cores are waiting...

	mov x1,#shared_counter

wait_on_cores:
	ldrb w2,[x1]
	cmp w2,#CORE_COUNT
	bne wait_on_cores
	
	# throw in some nop's as a totally
	# bogus delay to give last core
	# more time to enter wait-state...

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	# core 0 issues SEV instruction to
	# wake up other cores...

	sev
	b test_end

	
not_core0:	
	# cores 1..N increment the counter, then wait...
	
	mov x1,#shared_counter

increment_count:
	ldxrb w2,[x1]
	add w2,w2,#1
	stlxrb w3,w2,[x1]
	cmp w3,#0
	bne increment_count

        # cores 1 through N issue WFE to wait...
	wfe
	nop

# do all cores get here?...
test_end:
	wfi


shared_counter:
	.byte 1
	.align 2



	
