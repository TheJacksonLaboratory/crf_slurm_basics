## simple example python program
##   counts number of lines in file
##   single argument is path to file
##   reports input file path and number of lines to stdout

import sys

if len(sys.argv) != 2:
    sys.stderr.write(f"Usage: python {sys.argv[0]} file_in.txt\n")
    sys.exit(3)

file_in = sys.argv[1]
print(f"python file_in: '{file_in}'")

nlines = 0

try:
    with open(file_in, 'r') as fh_in:
        for line in fh_in:
            nlines += 1
except Exception as e:
    sys.stderr.write(f"error reading '{file_in}': {e}\n")
    sys.exit(11)

print(f"python nlines: {nlines}")
sys.exit(0)
