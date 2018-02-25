package Local::Inquiry_maker;

use strict;
use warnings;
use DBI;
use Scalar::Util qw(looks_like_number);

sub new
{
	my ($class) = shift;
	my %params = @_;

	return bless \%params, $class;
}

sub sql_ask {
	my ($self) = shift;

	my $string_ask;
	my @array_of_val;
	my @array_of_col;

	my @inquiry = split /(\/)|' '/, $self->{string};

	unless (defined $inquiry[10]) { die "There are not for condition SQL!\n"; }

	if ($inquiry[0] =~ /^get/i) { 
		$string_ask = "SELECT * FROM $inquiry[8] "; 
	}


	elsif ($inquiry[0] =~ /^post/i) { 
		$string_ask = "INSERT INTO $inquiry[8] ";

		my @array_of_inserts = split /\&/, $inquiry[10];

		for my $i (0..$#array_of_inserts) {
			if ($array_of_inserts[$i] =~ /^\?(\w+)\=(\w+)$/) {
				my $str = $2;
				unless (looks_like_number($2)) { $str ='"'.$str.'"'; }
				push @array_of_col, $1;
				push @array_of_val, $str;
			}
		}

		$string_ask = $string_ask."(";
		my $end_of_for = $#array_of_col - 1;
		for my $i (0..$end_of_for)
		{
			$string_ask = $string_ask."$array_of_col[$i], ";
		}
		$string_ask = $string_ask."$array_of_col[$#array_of_col]) VALUES (";

		$end_of_for = $#array_of_val - 1;
		for my $i (0..$end_of_for)
		{
			$string_ask = $string_ask."$array_of_val[$i], ";
		}
		$string_ask = $string_ask."$array_of_val[$#array_of_val]) ";

	}

	elsif ($inquiry[0] =~ /^put/i) {
		$string_ask = "UPDATE $inquiry[8] SET ";
		if ($inquiry[10] =~ /^[0-9]+\?(?:(\w+)\=(\w+))$/g) { 
			my $str = $2;
			unless (looks_like_number($2)) { $str ='"'.$str.'"'; }
			$string_ask = $string_ask."$1 = $str ";
		}
	}

#ToDo нужно добавить работу с условием, по которому нужно искать стоки, которые хотим удалить 
	elsif ($inquiry[0] =~ /^delete/i) {
		$string_ask = "DELETE $inquiry[8] ";

	}

	if (defined $inquiry[10]) {
		if ($inquiry[10] =~ /^([0-9]+)/) {
			$string_ask = $string_ask."WHERE id = $1 ";
		}
	}
	
	return $string_ask;
}

1;

