#!/bin/bash

TASKS="bin/step_world bin/txl11/step_world_v3_opencl bin/txl11/step_world_v4_double_buffered bin/txl11/step_world_v5_packed_properties";

TIMES="10 100 1000 10000";

for task in $TASKS; do
    for time in $TIMES; do
	
	fname=`echo $task | cut -d'/' -f3`;
	if [ $task == "bin/step_world" ]; then
	    fname="step_world";
	fi
	command="bin/make_world 5000 0.1 1 | ${task} 0.1 ${time} 1 > /dev/null";
        echo "Running ${fname} for ${time}";

	/usr/bin/time -f'%e' $command > results/data/${fname}_${time}.csv;
#	time `eval"$command"`;
#        /usr/bin/time -f %e -p sh -c $command >> results/data/${fname}_${time}.csv;
    done
done

