#!/usr/bin/env perl

use 5.016;  
use warnings;
use DDP;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Anagram;

my @text = <>;

my $resalt = Anagram::anagram(\@text);

p $resalt;




