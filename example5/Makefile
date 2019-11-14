# use Linaro supplied aarch64 tool chain...

LINARO_GCC = ~/Desktop/tools/gcc-arm-8.3-2019.03-x86_64-aarch64-elf

CC      = ${LINARO_GCC}/bin/aarch64-elf-gcc
GASM    = ${LINARO_GCC}/bin/aarch64-elf-as
READELF = ${LINARO_GCC}/bin/aarch64-elf-readelf
OBJDUMP = ${LINARO_GCC}/bin/aarch64-elf-objdump
NM      = ${LINARO_GCC}/bin/aarch64-elf-nm

# -specs=nosys.specs    - do not include system calls
# -nostartfiles         - do not include newlib supplied stock startup code (crt0.s)
# -march=armv8-a+nosimd - arch is armv8-a; do not use simd instructions during
#                         code generation

CFLAGS = -specs=nosys.specs -nostartfiles -march=armv8-a+nosimd

A64SIM = ~/Desktop/windvane/bin/a64sim

A64SIMTRACE_VIEWER = ~/Desktop/windvane/bin/simtrace_viewer.sh

all: HelloWorld
	@echo HelloWorld ready to go

# list crt0.o first so as to cause 1st instruction of crt0.s to be set as
#  execution entry point at link time (by virtue of _start symbol)
# note also that we are allowing the compiler/linker to set the start address
# (which for the linaro build defaults to 0x400000

HelloWorld: crt0.o main.c my_stubs.o 
	${CC} ${CFLAGS} -o $@ $^

# our startup code...

crt0.o: crt0.s
	${GASM} -g -a=crt0.lst $< -o $@

# our system calls...

my_stubs.o: my_stubs.c
	${CC} ${CFLAGS} -c -o $@ $^

#       a64sim option                           usage
# --------------------------  -----------------------------------------------
#   -L                         load HelloWorld, format is ELF(64) executable
#   --reset_address 0x400000   specify address of 1st instruction to simulate
#   --uart 0x9000000           instantiate uart; memory mapped uart registers
#                              start at 0x9000000

test: HelloWorld
	${A64SIM} -L HelloWorld --reset_address 0x400000 --uart 0x9000000

clean:
	rm -f HelloWorld my_stubs.o crt0.o crt0.lst

viewtrace:
	${A64SIMTRACE_VIEWER} HelloWorld.top 0 0

