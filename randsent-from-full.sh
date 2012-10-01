#!/bin/bash

if [ "$1" != "" ]; then
    OPTIONS="-S $1"
fi

if [ "$2" != "" ]; then
    SENTS="-n $2"
else
    SENTS="-n 20"
fi

cat S1.gr S1_Vocab.gr S2.gr S2_Vocab.gr Top.gr > GRAMMAR.gr

# add -t if you want to print out trees instead of sentences.
#./randsent -t -n 20 -s START -g S1_GRAMMAR.gr | ./prettyprint

./randsent $OPTIONS $SENTS -s START -g GRAMMAR.gr
