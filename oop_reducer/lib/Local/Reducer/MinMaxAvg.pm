package Local::Reducer::MinMaxAvg;

use strict;
use warnings;

use parent qw(Local::Reducer);

sub new 
{
	my ($class) = shift;
	my %params = @_;
	$params{value} = 0;
	$params{helper} = 0; 

	return bless \%params, $class;
}

sub action
{
	my ($self) = shift;
	my $some_string = shift;

	my $row_object = $self->{row_class}->new (str => $some_string);

	if (defined $row_object)
	{
		my $value_of_object = $row_object -> get ($self->{field},undef);
		if ($value_of_object =~ /^([-+]?[0-9]+(\.[0-9]*)?)$/)
		{
			unless ($self->{min})
			{
				$self->{min} = $value_of_object;
				$self->{max} = $value_of_object;
				$self->{avg} = $value_of_object;
				$self->{sum} = $value_of_object;
			}
			else
			{
				if ($self->{min} > $value_of_object) {$self->{min} = $value_of_object}
				if ($self->{max} < $value_of_object) {$self->{max} = $value_of_object}
				$self->{sum} += $value_of_object;
			}
		}
	}
}

sub get_min
{
	my ($self) = shift;
	return $self->{min};
}

sub get_max
{
	my ($self) = shift;
	return $self->{max};
}

sub get_avg
{
	my ($self) = shift;
	my $answer = $self->{sum} / $self->{helper};
	return $answer ;
}

