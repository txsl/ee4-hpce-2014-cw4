from sys import argv

"""
A simple script which takes two file handles of word simulations and compares their outputs
"""

def read_world(fname):
    f = open(fname, 'r')
    
    dashes = 0
    data = []

    for line in f:

        if "End" in line:
            break

        if dashes == 2:
            data.append(line.strip('\n\r').split(" ")[1:])

        if "-" in line:
            dashes += 1

    return data



if len(argv) < 3:
    print "{0} : Not enough input arguments given".format(argv[0])
    exit(1)

first = read_world(argv[1])

second = read_world(argv[2])

for row_idx, row in enumerate(first):
    for item_idx, item in enumerate(row):
        if item != second[row_idx][item_idx]:
            print "Row {0}, Column {1} does not match. Values are {2} (first input) and {3} (second)".format(row_idx, item_idx, item, second[row_idx][item_idx])