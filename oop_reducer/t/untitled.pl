#!/usr/bin/env perl

use warnings;
use Scalar::Util qw (looks_like_number);
use DDP;

my %ha;;
p %ha;
my $hash = {};
p $hash;
my  %hash2 = %{$hash};
p %hash2;
my $ref = \%hash2;
p $ref;