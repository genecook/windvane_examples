	.file   "add_sequence.s"

	.section text
        .text
        .globl  _reset

_reset:
	mov x0,#1
	mov x1,#1
	add x2,x1,x0

	wfi
	
