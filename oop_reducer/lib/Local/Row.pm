package Local::Row; 

use strict;
use warnings;
use Scalar::Util qw (looks_like_number);

sub new 
{
	my ($class) = shift;
	my %params = @_;

	return bless \%params, $class;
}

sub get
{
	my ($self) = shift;
	my ($name, $default) = @_;

	return defined $self -> {$name} ? $self -> {$name} : $default;
}

1;