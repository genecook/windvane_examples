include ../Makefile.inc

# number of cores to enable...

ifndef CORE_COUNT
CORE_COUNT = 4
endif

# sim-trace viewer displays simulation trace for one core at a time...

ifndef TRACE_CORE
TRACE_CORE = 0
endif


MPTEST := mp_ldstr_excl_events


all: ${MPTEST}.o


${MPTEST}.o: ${MPTEST}.s
	${GASM} -a=${MPTEST}.lst --defsym CORE_COUNT=${CORE_COUNT} $< -o $@

test:
	${A64SIM} -L ${MPTEST}.o -T ${MPTEST} --num_cores ${CORE_COUNT} 

viewtrace:
	${A64SIMTRACE_VIEWER} ${EXAMPLES}/example7/${MPTEST}.top ${TRACE_CORE} 0

clean:
	rm -f *.o *.lst *.0 *.top *.elf 1.7


