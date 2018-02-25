package Local::Row::JSON;

use strict;
use warnings;
use JSON::XS;

use parent qw(Local::Row);

sub new
{
	my ($class) = shift;
	my %params = @_;
	my %hash;
	my $flag = undef;

	if ( $params{str} eq '' ) { $flag = 1; }  
	else
	{
		eval { %hash = %{ decode_json ($params{str}) }; };
		unless ($@) { $flag = 1; }  
	}
	if ($flag)
	{
		return $class -> SUPER::new (%hash);
	}
}

1;
 

