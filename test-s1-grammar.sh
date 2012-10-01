#!/bin/bash
#
# generate a grammar file containing only
# productions from S1 (manually derived grammar)
#
cat S1.gr S1_Vocab.gr Top.gr | grep -v S2 > S1_GRAMMAR.gr

# parse all the sentences and pretty print the parse trees
cat examples.sen | ./parse -g S1_GRAMMAR.gr | ./prettyprint
# cat examples.sen | ./parse -g S1_GRAMMAR.gr 

# compute the cross entropy
cat examples.sen | ./parse -g S1_GRAMMAR.gr -nC
