#!/bin/bash

# Generate a full grammar from S1 and S2.
cat S1.gr S1_Vocab.gr S2.gr S2_Vocab.gr Top.gr > GRAMMAR.gr

# Run the full grammar through all the example sentences and pretty print them
cat examples.sen | ./parse -g GRAMMAR.gr | ./prettyprint

# compute the cross entropy.
cat examples.sen | ./parse -g GRAMMAR.gr -nC
 
