# Makefile adapted from the Hands On OpenCL course: https://github.com/HandsOnOpenCL

ifndef CPPC
	CPPC=g++
endif

CPP_COMMON = include

CCFLAGS = -std=c++11

CPP_MOD = CPP_COMMON + src

INC = -I $(CPP_COMMON)
INC_MOD = -I $(CPP_MOD)

LIBS = -lOpenCL -lm

# Check our platform and make sure we define the APPLE variable
# and set up the right compiler flags and libraries
PLATFORM = $(shell uname -s)
ifeq ($(PLATFORM), Darwin)
	CPPC = clang++
	LIBS = -framework OpenCL
endif


bin/test_opencl : src/test_opencl.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/make_world : src/make_world.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/render_world : src/render_world.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/step_world : src/step_world.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/step_world_v1_lambda : src/txl11/step_world_v1_lambda.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/step_world_v2_function : src/txl11/step_world_v2_function.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/step_world_v3_opencl : src/txl11/step_world_v3_opencl.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@

bin/step_world_v4_double_buffered : src/txl11/step_world_v4_double_buffered.cpp src/heat.cpp
	-mkdir -p bin
	$(CPPC) $^ $(INC) $(CCFLAGS) $(LIBS) -o $@


all : bin/test_opencl bin/make_world bin/render_world bin/step_world bin/step_world_v1_lambda bin/step_world_v2_function bin/step_world_v3_opencl bin/step_world_v4_double_buffered

