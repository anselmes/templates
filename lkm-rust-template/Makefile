################################################################################
# Makefile for Linux Kernel Module (LKM) compilation
#
# This Makefile builds a kernel module named "hello" using the kernel build system.
# It detects the current kernel version and uses the appropriate build directory.
################################################################################

# Path to the kernel build system for the current kernel version
KDIR := "/lib/modules/$(shell uname -r)/build"

# Current working directory where the module source code is located
KMOD := $(shell pwd)

# Define the module object file to be built
# This will create a hello.ko kernel module
obj-m := hello.o

# Default target: build the kernel module
all:
	# Invoke the kernel build system to compile the module
	make -C $(KDIR) M=$(KMOD) modules

# Clean target: remove all generated files
clean:
	# Use the kernel build system to clean up compilation artifacts
	make -C $(KDIR) M=$(KMOD) clean
