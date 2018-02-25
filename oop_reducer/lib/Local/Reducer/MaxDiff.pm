package Local::Reducer::MaxDiff;

use strict;
use warnings;
use Scalar::Util qw (looks_like_number);

use parent qw(Local::Reducer);

sub action
{
	my ($self) = shift;
	my ($row_object) = shift;
	
	my $value1 = $row_object -> get ($self->{top},0);
	my $value2 = $row_object -> get ($self->{bottom},0);

	if ($value1 && $value2)
	{
		if (looks_like_number ($value1)  &&  looks_like_number ($value2) )
		{
			my $result_of_method = abs ($value1 - $value2);
			if ($result_of_method > $self->{value}) { $self->{value} = $result_of_method;}
		}
	}
}

1;
