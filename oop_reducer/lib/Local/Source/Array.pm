package Local::Source::Array;

use strict;
use warnings;

use parent qw(Local::Source);

sub new 
{

	my ($class, %params) = @_;
	@{$params{key}} = @{$params{array}};
	delete $params{array};

	return $class -> SUPER::new(%params);
}

1;
