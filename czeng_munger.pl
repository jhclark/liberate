#!/usr/bin/env perl

# Extract flat text from CzEng 1.0
# By Jonathan Clark
# May 16, 2012

use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

# TODO: Open 5 files
my $id_file = "czeng.ids.gz";
my $cz_file = "czeng.cz.gz";
my $en_file = "czeng.en.gz";
my $cz2en_file = "czeng.align_gdfa.cz2en.gz";
my $en2cz_file = "czeng.align_gdfa.en2cz.gz";
open (IDOUT, "| /bin/gzip -c > $id_file") or die "error starting gzip $!";
open (CZOUT, "| /bin/gzip -c > $cz_file") or die "error starting gzip $!";
open (ENOUT, "| /bin/gzip -c > $en_file") or die "error starting gzip $!";
open (CZ2ENOUT, "| /bin/gzip -c > $cz2en_file") or die "error starting gzip $!";
open (EN2CZOUT, "| /bin/gzip -c > $en2cz_file") or die "error starting gzip $!";
binmode(IDOUT, ":utf8");
binmode(CZOUT, ":utf8");
binmode(ENOUT, ":utf8");
binmode(CZ2ENOUT, ":utf8");
binmode(EN2CZOUT, ":utf8");

while(<STDIN>) {
    # see http://ufal.mff.cuni.cz/czeng/czeng10/
    my @cols = split(/\t/, $_, 17);
    my $id = $cols[0];
    my @cz_a_factors = split(/ /, $cols[2]);
    my @en_a_factors = split(/ /, $cols[6]);
    my $align_gdfa_cz2en = $cols[12];
    my $align_gdfa_en2cz = $cols[13];

    my @cz_toks = map {
	my @factors = split(/\|/, $_);
	$factors[0];
    } @cz_a_factors;
    my @en_toks = map {
	my @factors = split(/\|/, $_);
	$factors[0];
    } @en_a_factors;

    print IDOUT "$id\n";
    print CZOUT join(" ", @cz_toks)."\n";
    print ENOUT join(" ", @en_toks)."\n";
    print CZ2ENOUT "$align_gdfa_cz2en\n";
    print EN2CZOUT "$align_gdfa_en2cz\n";
}
