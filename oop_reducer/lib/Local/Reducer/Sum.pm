package Local::Reducer::Sum;

use strict;
use warnings;
use Scalar::Util qw (looks_like_number);

use parent qw(Local::Reducer);

sub action
{
	my ($self) = shift;
	my ($row_object) = shift;

	my $value_of_object = $row_object -> get ($self->{field},0);
	if (looks_like_number ($value_of_object) )
	{
		$self->{value} += $value_of_object;
	}

}

1;