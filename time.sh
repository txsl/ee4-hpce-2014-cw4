#!/bin/bash

TASKS="bin/step_world bin/txl11/step_world_v1_lambda bin/txl11/step_world_v2_function bin/txl11/step_world_v3_opencl bin/txl11/step_world_v4_double_buffered bin/txl11/step_world_v5_packed_properties"

TIMES="10 100 1000 10000"

for task in $TASKS; do
    for time in $TIMES; do
        echo "Running ${task} for ${time}"
        time -p %e (bin/make_world 5000 0.1 1 | eval "${task} 0.1 ${time} 1" > /dev/null)
    done
done


# time (bin/make_world 5000 0.1 1 | bin/step_world 0.1 1000 1 > /dev/null)
# time (bin/make_world 5000 0.1 1 | bin/dt10/step_world_v3_opencl 0.1 1000 1 > /dev/null)
# time (bin/make_world 5000 0.1 1 | bin/dt10/step_world_v4_double_buffered 0.1 1000 1 > /dev/null)
# time (bin/make_world 5000 0.1 1 | bin/dt10/step_world_v5_packed_properties 0.1 1000 1 > /dev/null)