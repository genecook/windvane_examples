include ../Makefile.inc


all: add_sequence.o


add_sequence.o: add_sequence.s
	${GASM} -g -a=add_sequence.lst $< -o $@

test:
	${A64SIM} -L add_sequence.o ${A64SIM_OPTIONS}

viewtrace:
	${A64SIMTRACE_VIEWER} ${EXAMPLES}/example1/add_sequence.top 0 0

clean:
	rm -f *.o *.lst *.0 *.top *.elf

