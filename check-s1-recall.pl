#!/usr/bin/perl

# runs a s1 recall check
# when given a sentences file.

use strict;

my $sentences = shift;
if (!$sentences) {
    die "usage: $0 <sentences file>\n";
}

my $grammar = "S1_GRAMMAR.gr";
# Generate a full grammar from S1 and S2.
if (!-e $grammar) {
    system("cat S1.gr S1_Vocab.gr Top.gr | grep -v S2 > $grammar");
}

# Run the full grammar through all the example sentences and pretty print them
my $cmd = "cat $sentences | ./parse -g $grammar | grep -v failure | wc -l";
my $parsed = run_cmd($cmd);

my $cmd = "wc -l $sentences";
my $total = run_cmd($cmd);

printf("%1.5f (%d / %d)\n", $parsed/$total, $parsed, $total);

sub run_cmd {
    my $cmd = shift;
    my @contents;
    open(FD, "$cmd |") || die("Can't run $cmd");
    @contents = <FD>;
    close(FD);
    chomp @contents;
    return join("", @contents);
}
