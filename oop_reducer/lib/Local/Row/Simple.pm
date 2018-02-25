package Local::Row::Simple;

use strict;
use warnings;
use parent qw(Local::Row);

sub new
{
	my ($class) = shift;
	my %params = @_;
	
	my %hash;
	my $flag = undef;
		
		if ($params{str} eq '') { $flag = 1; }
		elsif ( $params{str} =~ /^([\w]+:[\w]+(,[\w]+:[\w]+)*)$/ )
		{
			%hash = split /[\:\,]/, $params{str};
			$flag = 1;		
		}
		if ($flag)
		{
			return $class -> SUPER::new (%hash);
		}
}

1;

