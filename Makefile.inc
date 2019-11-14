# edit to make paths based on where you have downloaded and compiled windvane,
# windvane_examples:

A64SIM_HOME=~/Desktop/windvane
EXAMPLES=~/Desktop/windvane_examples


# paths to the a64sim simulator and sim-trace viewer:

A64SIM = ${A64SIM_HOME}/bin/a64sim
A64SIMTRACE_VIEWER = ${A64SIM_HOME}/bin/simtrace_viewer.sh


# path to bin where gnu aarch64 tools are installed...

# (was using the 'default' aarch64 tools, but lately have been using the latest linaro provided tools)

#AARCH64_GNU=/usr/bin/aarch64-linux-gnu
AARCH64_GNU=${HOME}/Desktop/tools/gcc-arm-8.3-2019.03-x86_64-aarch64-elf

CC = ${AARCH64_GNU}/bin/aarch64-elf-gcc

GASM = ${AARCH64_GNU}/bin/aarch64-elf-as

OBJCOPY = ${AARCH64_GNU}/bin/aarch64-elf-objcopy


# path to where you have compiled aarch64 version of newlib:

# (was compiling newlib, using the locally installed aarch64 tools, but lately am using the
#  linaro supplied libs)

ifndef NEWLIB
#NEWLIB := ${HOME}/Desktop/tools/newlib/aarch64-unknown-none
NEWLIB := ${AARCH64_GNU}/lib/gcc/aarch64-elf/8.3.0
endif



