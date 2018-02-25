package Local::Source::Text;

use strict;
use warnings;

use parent qw(Local::Source);


sub new 
{

	my ($class, %params) = @_;

	my @botl =  split  ( $params{delimiter} ? $params{delimiter} : '\n' , $params{text} );
	delete $params{text};
	@{$params{key}} =  @botl;

	return $class -> SUPER::new(%params);
}

1;


