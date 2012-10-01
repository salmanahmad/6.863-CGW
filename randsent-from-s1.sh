#!/bin/bash
# Generate random sentences only from the S1 Grammar (The English grammar)

cat S1.gr S1_Vocab.gr Top.gr | grep -v S2 > S1_GRAMMAR.gr

# add -t if you want to print out trees instead of sentences.
#./randsent -t -n 20 -s START -g S1_GRAMMAR.gr | ./prettyprint

./randsent -n 20 -s START -g S1_GRAMMAR.gr
