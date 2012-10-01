#!/usr/bin/perl
#
# Runs a simple cross entropy check given a sentences file.
# Author: yks

use strict;

my $sentences = shift;
if (!$sentences) {
    die "usage: $0 <sentences file>\n";
}

my $grammar = "GRAMMAR.gr";
# Generate a full grammar from S1 and S2.
if (!-e $grammar) {
    system("cat S1.gr S1_Vocab.gr S2.gr S2_Vocab.gr Top.gr > $grammar");
}

die "Can't find or create $grammar file" unless $grammar;

# Run the full grammar through all the example sentences and pretty print them
#system("cat $sentences | ./parse -g $grammar | ./prettyprint");

# compute the cross entropy.
my $cmd = "cat $sentences | ./parse -g $grammar -nC";

my $ce = run_cmd($cmd);
print $ce;

sub run_cmd {
    my $cmd = shift;
    my @contents;
    open(FD, "$cmd |") || die("Can't run $cmd: $!");
    @contents = <FD>;
    close(FD);
    chomp @contents;
    return join("", @contents);
}
