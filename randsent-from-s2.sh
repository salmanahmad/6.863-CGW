#!/bin/bash
# Generate random sentences from the falloff all sentences grammar (S2)

cat S2.gr S2_Vocab.gr Top.gr | grep -v S1 > S2_GRAMMAR.gr

# add -t if you want to print out trees instead of sentences.
#./randsent -t -n 17 -s START -g S2_GRAMMAR.gr | ./prettyprint

./randsent -n 17 -s START -g S2_GRAMMAR.gr
