package Local::Source;

use strict;
use warnings;

sub new
{
	my ($class) = shift;
	my %params = @_;

	$params{iterator} = - 1;

	return bless \%params, $class;
}

sub next
{
	my ($self) = shift;
	
	$self -> {iterator}++;

	return ($self ->{key} -> [$self->{iterator}]);
}

1;