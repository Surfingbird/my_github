#!/bin/perl

use warnings;
use strict;

my $READ_per = $ARGV[0];
my $WRITE_per = $ARGV[1];

print "$READ_per\n";
print "$WRITE_per\n";

my $Possition;
my @Massive;
my $DiskName = "vda";

open(my $fh_read, "<", "$READ_per")
or die "cant open log file!\n";
open(my $fh_write, ">>", "$WRITE_per")
or die "cant open alerts file!\n";

#if ($_ =~ m/([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2})/)

my @Array = <$fh_read>;

for my $i (0..$#Array) {
        if ($Array[$i] =~ m/\%util/i) {
                @Massive = split( /[\s]+/,$Array[$i]);
                for my $j (0..$#Massive) {
                        if ($Massive[$j] =~ m/%util/) {
                                $Possition = $j;
                        }
                }
                last;
        }
}

my ($Since, $ToDate);
my $IsItStart = 0;

for my $i (0..$#Array) {
        if ($Array[$i] =~ m/$DiskName/g) {
                @Massive = split( /[\s]+/,$Array[$i]);
                if ($Massive[$Possition] > 0.1) {
                        if ($IsItStart == 0) {
                                $Array[$i] =~ m/([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2})/;
                                $Since = $1;
                                $ToDate = $1;
                                $IsItStart = 1;
                        }
                        else {
                                $Array[$i] =~ m/([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2})/;
                                $ToDate = $1;
                        }
                }
                else {
                        if ($IsItStart == 1) {
                                print $fh_write "$Since - $ToDate\n";
                                $IsItStart = 0;
                        }

                }
        }
}
if ($IsItStart == 1) {
        print $fh_write "$Since - $ToDate\n";
        $IsItStart = 0;
}
