import os
import csv
import time

TASKS = ['bin/step_world', 'bin/txl11/step_world_v1_lambda', 'bin/txl11/step_world_v2_function', 'bin/txl11/step_world_v3_opencl', 'bin/txl11/step_world_v4_double_buffered', 'bin/txl11/step_world_v5_packed_properties']

TIMES = [10, 100, 1000, 10000]

current_folder_path= os.getcwd()
# print current_folder_path
# exit()

with open('results/data.csv', 'a') as csvfile:
    reswriter = csv.writer(csvfile)
    reswriter.writerow(['command', 'iterations', 'time'])

    for task in TASKS:
        for stime in TIMES:

            start = time.time()  
            # http://stackoverflow.com/questions/5478351/python-time-measure-function
            
            print "working on " + task + str(stime)

            os.system("{0}/bin/make_world 5000 0.1 1 | {1}/{2} 0.1 {3} 1 > /dev/null".format(current_folder_path, current_folder_path, task, stime))
            
            elapsed = time.time()
            elapsed = elapsed - start

            print "{0} elapsed".format(elapsed)
            
            reswriter.writerow([task, stime, elapsed])