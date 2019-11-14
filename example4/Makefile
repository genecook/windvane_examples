include ../Makefile.inc

TARGET := add_causes_undef


${TARGET}.o: ${TARGET}.s
	${GASM} -g -a=${TARGET}.lst $< -o $@


test:
	${A64SIM} -L ${TARGET}.o -T ${TARGET}_trace

viewtrace:
	${A64SIMTRACE_VIEWER} ${EXAMPLES}/example4/${TARGET}_trace.top 0 0

clean:
	rm -f *.o *.lst *.0 *.top *.elf
