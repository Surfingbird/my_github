package Local::JsonEncode;

use strict;
use warnings;
use DDP;
use JSON::XS;
use utf8;

sub make
{
	my($class) = shift;
	my %params = @_;
	my $some_json = JSON::XS->new->utf8->encode($params{array});
	return $some_json;
}

1;