include ../Makefile.inc

ifndef NUM_CORES
NUM_CORES = 4
endif

ifndef TRACE_CORE
TRACE_CORE = 0
endif


all: MPboot2el0.o


MPboot2el0.o: MPboot2el0.s
	${GASM} -g -a=MPboot2el0.lst $< -o $@

test:
	${A64SIM} -L MPboot2el0.o -T mpfreeruntest --num_cores ${NUM_CORES} -D --freerun --max_instrs 50

viewtrace:
	${A64SIMTRACE_VIEWER} ${EXAMPLES}/example6/mpfreeruntest.top ${TRACE_CORE} 0

clean:
	rm -f *.o *.lst *.0 *.top *.elf 1.7


