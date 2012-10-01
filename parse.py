#!/usr/bin/env python
# A python wrapper script around the "./parse" command
# Will print out the failed sentence text instead of a cryptic message: "failure"
#
# Usage:
# ~> ./parse.py -g <grammar> -s <sentences file> | grep "failed"
# above command will output the list of sentences that failed to parse.
#
# Author: yks

import re
from subprocess import *
from optparse import OptionParser

def parse_sentences(sentences, grammar):
    fd = open(sentences)
    lines = fd.readlines()
    fd.close()
    lines = [line.strip() for line in lines]
    for sent in lines:
	if re.match("^\s*$", sent):
	    continue
	output = parse(sent, grammar)
	output = [out.strip() for out in output]
	
	output_str = ' '.join(output)
	if re.match("^.*failure.*$", output_str):
	    print "ERROR: failed: %s" %(sent)
	else:
	    print output_str

def parse(sentence, grammar):
    cmd = "./parse -g %s" %(grammar)
    bufsize = 1024
    p = Popen(cmd, shell=True, bufsize=bufsize,
	      stdin=PIPE, stdout=PIPE, close_fds=True)
    
    (child_stdin, child_stdout) = (p.stdin, p.stdout)
    p.stdin.write("%s\n" %(sentence))
    p.stdin.close()    
    lines = p.stdout.readlines()
    return lines

if __name__ == "__main__":
    parser = OptionParser()
    parser.add_option("-g", "--grammar", dest="grammar",
		      help="input grammar filename", metavar="file")
    parser.add_option("-s", "--sentence_file", dest="sentences",
		      help="input sentences file", metavar="file")

    (options, args) = parser.parse_args()
    if options.grammar is None or options.sentences is None:
	parser.print_help()
	exit(1)
    
    parse_sentences(options.sentences, options.grammar)
