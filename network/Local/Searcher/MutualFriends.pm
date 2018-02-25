package Local::Searcher::MutualFriends;

use strict;
use warnings;
use DDP;
use DBI;
use Encode qw(decode_utf8);
use JSON::XS;
use utf8;

use parent qw(Local::Searcher);

sub action 
{
	my ($self) = shift;
	my $dbh = shift; 

	my $ask;

	my $user1 = $self -> {user1};
	$ask = "SELECT user_friend FROM friends WHERE id_user = '$user1'";
	my @massiv_user1_left = $dbh->selectall_array($ask);
	$ask = "SELECT id_user FROM friends WHERE user_friend = '$user1'";
	my @massiv_user1_right = $dbh->selectall_array($ask);
	
	my @massiv_user1;
	push @massiv_user1, @massiv_user1_left; 
	push @massiv_user1, @massiv_user1_right; 

	my $user2 = $self -> {user2};
	$ask = "SELECT user_friend FROM friends WHERE id_user = '$user2'";
	my @massiv_user2_left = $dbh->selectall_array($ask);
	$ask = "SELECT id_user FROM friends WHERE user_friend  = '$user2'";
	my @massiv_user2_right = $dbh->selectall_array($ask);

	my @massiv_user2;
	push @massiv_user2, @massiv_user2_left; 
	push @massiv_user2, @massiv_user2_right; 

	my @mutual_friends_id;

	for my $i (0..$#massiv_user1)
	{
		for my $j (0..$#massiv_user2)
		{
			if ($massiv_user2[$j][0] eq $massiv_user1[$i][0])
			{
				push @mutual_friends_id, $massiv_user2[$j][0];
			}
		}
	}
	return @mutual_friends_id;
}

1;


