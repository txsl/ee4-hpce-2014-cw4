# Makefile adapted from the Hands On OpenCL course: https://github.com/HandsOnOpenCL

ifndef CPPC
	CPPC=g++
endif

CPP_COMMON = include

CCFLAGS=

INC = -I $(CPP_COMMON)

LIBS = -lOpenCL

# Check our platform and make sure we define the APPLE variable
# and set up the right compiler flags and libraries
PLATFORM = $(shell uname -s)
ifeq ($(PLATFORM), Darwin)
	CPPC = clang++
	LIBS = -framework OpenCL
endif

# DeviceInfo: DeviceInfo.cpp
# 	-mkdir -p bin
# 	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@


bin/test_opencl : src/test_opencl.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@
