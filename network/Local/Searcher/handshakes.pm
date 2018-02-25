package Local::Searcher::handshakes;

use strict;
use warnings;
use DDP;
use DBI;
use JSON::XS;
use utf8;
use List::Util qw(uniq);

use parent qw(Local::Searcher);

sub action 
{
	my ($self) = shift;
	my $dbh = shift; 
	my $road = -1;

	my %hash;
	$hash{$self->{user1}} = 1; 

	my $user2 = $self->{user2};

	my @massive;

	push @massive, $self->{user1};



	$road = long_hand($road, $dbh, $user2, \%hash, @massive);

	return [$road]; 
}

sub long_hand
{
	my $road = shift;
	my $dbh = shift;
	my $user2 = shift;
	my ($ref) = shift;
	my %hash = %$ref; 

	my @massive  = @_;

	$road++;

	my @massiv_user;

	for my $i (0..$#massive)
	{
		p $massive[$i];
		my $ask = "SELECT user_friend FROM friends WHERE id_user = '$massive[$i]'";
		my @array_left = $dbh->selectall_array($ask); 

		$ask = "SELECT id_user FROM friends WHERE user_friend = '$massive[$i]'";
		my @array_right = $dbh->selectall_array($ask); 

		for my $j (0..$#array_left)
		{
			my $box = $array_left[$j][0];
			unless ($hash{$box})
			{
				if ($box eq $user2)
				{
					return $road;
				}
				push @massiv_user, $box; 
				$hash{$box} = 1;
			}
		}

		for my $j (0..$#array_right) 
		{
			my $box = $array_right[$j][0];
			unless ($hash{$box})
			{
				if ($box eq $user2)
				{
					return $road;
				}
				push @massiv_user, $box; 
				$hash{$box} = 1;
			}
		}

	}
	@massiv_user = uniq @massiv_user;
	$road = long_hand($road, $dbh, $user2, \%hash, @massiv_user);

	return $road;
}



1;