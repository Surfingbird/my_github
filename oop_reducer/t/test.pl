#!/usr/bin/env perl
use DDP;



	my %hash;

	$hash{a} = 1;
	$hash{key} = 0;
	$hash{c} = 3;
	$hash{d} = 4;

	my $default = 69;
	my $name = "key";

	if ($hash{$name} == 0) { print "$hash{$name}\n";}
	else
	{
		print "$hash{$name} ? $hash{$name} : $default\n";
	}


