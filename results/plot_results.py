# adapted from cwk3

# Need to have numpy, pandas and matplotlib installed for this script to work.
# aka: `pip install pandas numpy matplotlib`

import matplotlib.pyplot as plt
import csv

results = {}

with open('data.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile)
    
    i = 0
    
    for row in reader:
        if i:
            try:
                results[row[0]]['time'].append(float(row[2]))
                results[row[0]]['iters'].append(int(row[1]))
            except KeyError:
                results[row[0]] = {}
                results[row[0]]['time'] = [float(row[2])]
                results[row[0]]['iters'] = [int(row[1])]
        i += 1

print results