#!/usr/bin/env python
# A program for trying out all settings of weights
# between S1 and S2 and outputs the settings that achieves the
# lowest cross entropy.  Useful to determining the optimal weighting
# you should set between S1 and S2.
#
# Author: Yuan K. Shen (yks)

import os
import re
from optparse import OptionParser

def find_best_weights(examples):
    tmp_output = "test-input-GRAMMAR.gr"

    # concatenate all the necessary grammar files except Top.gr
    fd = os.popen("cat S1.gr S1_Vocab.gr S2.gr S2_Vocab.gr")
    lines = fd.readlines()
    fd.close()

    min_s1 = 0
    min_s2 = 100
    min_val = None

    for i in xrange(1,100):

	# generate a temporary grammar files
	# with a given S1, S2 weight setting.
	out = open(tmp_output, "w")
	s1 = i
	s2 = 100-i
	if s1 > 0:
	    out.write("%d	START	S1\n" %(s1))
	if s2 > 0:
	    out.write("%d	START	S2\n" %(s2))

	for line in lines:
	    out.write(line)
	out.flush()
	out.close()

	# parse temporary grammar to get cross entropy scores.
	out = os.popen("cat %s | ./parse -g %s -nC 2>&1" %(examples,
							   tmp_output))
	outlines = out.readlines()
	out.close()

	# cleanup
	os.system("rm %s" %(tmp_output))

	bits = None
	for line in outlines:
	    m = re.search("cross-entropy = ([\.\d\w]+) bits", line)
	    if m:
		bits = m.group(1)
		break

	if bits is not None:
	    print "# S1: %d  S2: %d cross-entropy: %s bits" %(s1, s2, bits)
	else:
	    print "# error can't parse cross-entropy: %s" %(outlines)
	
	if bits is not None and bits != "inf":
	    num_bits = float(bits)
	    if min_val is None or num_bits < min_val:
		min_val = num_bits
		min_s1 = s1
		min_s2 = s2

	    
    print "# Best settings for Top.gr"
    print "# ----------------"
    if min_s1 > 0:
	print("%d	START	S1" %(min_s1))
    if min_s2 > 0:
	print("%d	START	S2" %(min_s2))

	
if __name__ == "__main__":
    parser = OptionParser()
    parser.add_option("-f", "--file", dest="fileName",
		      help="sentences file name", metavar="file")
      
    (options, args) = parser.parse_args()

    if options.fileName is None:
	parser.print_help()
	exit(1)

    find_best_weights(options.fileName)

