 package Local::Reducer;
 
 use strict;
 use warnings;
 
=encoding utf8
 
=head1 NAME
 
Local::Reducer - base abstract reducer
 
=head1 VERSION
 
 Version 1.00
 
=cut
 
our $VERSION = '1.00';
 
=head1 SYNOPSIS
 
=cut

sub new 
{
	my ($class) = shift;
	my %params = @_;
	$params{value} = 0;

	return bless \%params, $class;
}

sub reduce_all 
{
	my ($self) = @_;

	$self -> operation;

	return $self -> {value};
}

sub reduce_n 
{
	my ($self) = shift;
	my ($n) = @_;

	$self -> operation ($n);

	return $self -> {value};
}

sub reduced 
{
	my ($self) = @_;

	return $self->{value};
}

sub operation
{
	my ($self) = shift;
	my ($n) = @_;
	my $i = 0; 
	
	while ()
	{
		my $some_string;
		if (defined $n)
		{
			if ($i >= $n) { last; }
		}

		unless ( $some_string =  ($self->{source}) -> next () ) { last; }

		my $row_object = $self->{row_class}->new (str => $some_string);

		if (defined $row_object) { $self -> action($row_object); }
		
		$i++;
	}
}

sub action
{

}

1;