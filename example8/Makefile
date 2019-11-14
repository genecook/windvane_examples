include ../Makefile.inc

CFLAGS = -specs=nosys.specs -nostartfiles -march=armv8-a+nosimd 

TARGET := TinyBasic

${TARGET}: crt0.o ${TARGET}.c my_stubs.o
	${CC} ${CFLAGS} -o $@ $^

# our startup code...

crt0.o: crt0.s
	${GASM} -a=crt0.lst $< -o $@

# our system calls...

my_stubs.o: my_stubs.c
	${CC} ${CFLAGS} -c -o $@ $^

# dependency commented out for demo sake...
# test: ${TARGET}

test:
	${A64SIM} -L ${TARGET} --reset_address 0x400000 --uart 0x9000000 -n -1

clean:
	rm -f ${TARGET} my_stubs.o crt0.o crt0.lst
