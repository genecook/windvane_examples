include ../Makefile.inc


TARGET := boot2el0MMUon


all: ${TARGET}.o

${TARGET}.o: ${TARGET}.s
	${GASM} -g -a=${TARGET}.lst $< -o $@

test:
	${A64SIM} -L ${TARGET}.o -T ${TARGET}_trace -D

viewtrace:
	${A64SIMTRACE_VIEWER} ${EXAMPLES}/example2/${TARGET}_trace.top 0 0

clean:
	rm -f *.o *.lst *.0 *.top *.elf

