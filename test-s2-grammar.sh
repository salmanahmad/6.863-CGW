#!/bin/bash
# generate a grammar file containing only
# productions from S2 (all grammar)
#
cat S2.gr S2_Vocab.gr Top.gr | grep -v S1 > S2_GRAMMAR.gr

# parse all the sentences and pretty print the parse trees
cat examples.sen | ./parse -g S2_GRAMMAR.gr 
#| ./prettyprint

# compute the cross entropy
cat examples.sen | ./parse -g S2_GRAMMAR.gr -nC
