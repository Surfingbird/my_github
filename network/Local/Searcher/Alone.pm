package Local::Searcher::Alone;

use strict;
use warnings;
use DDP;
use DBI;
use Encode qw(decode_utf8);
use JSON::XS;

use parent qw(Local::Searcher);

sub action 
{
	my ($self) = shift;
	my $dbh = shift; 

	my @massiv_alone_person;
	my @massiv1;
	my @massiv2;
	my $ask;

	$ask = $dbh -> prepare (
	"select u.id_user, f.user_friend  from user as u left join friends as f on f.user_friend = u.id_user  where f.user_friend is null"
	); 
	$ask -> execute(); 
	@massiv1 = @{$ask -> fetchall_arrayref()};

	for my $i (0..$#massiv1)
	{
		push @massiv_alone_person, $massiv1[$i][0];
	}

	$ask = $dbh -> prepare (
	"select u.id_user,f.id_user from user as u left join friends as f using(id_user) where f.id_user is null;"
	); 
	$ask -> execute();
	@massiv2 = @{$ask -> fetchall_arrayref()};

	for my $i (0..$#massiv2)
	{
		push @massiv_alone_person, $massiv2[$i][0];
	}

	return @massiv_alone_person;
}

1;

#select u.id_user, f.user_friend  from user as u left join friends as f on f.user_friend = u.id_user  where f.user_friend is null;