#!/usr/bin/env perl

use strict;
use warnings;

use Local::Searcher::Alone;
use Local::Searcher::MutualFriends;
use Local::Info;
use Local::JsonEncode;
use Local::Searcher::handshakes;
use DDP;
use Scalar::Util qw (looks_like_number);

use DBI;
use Getopt::Long;

my ($friends_key, $num_handshakes_key, $nofriends_key, @users_array);

GetOptions (
	'friends' => \$friends_key, 
	'nofriends' => \$nofriends_key,
	'num_handshakes' => \$num_handshakes_key,
	'user=s' => \@users_array, 
	);


if (defined $friends_key && defined $users_array[0] && defined $users_array[1])
{
	unless (
		looks_like_number ($users_array[0]) && 
		looks_like_number ($users_array[1])
		) 
	{ die "It is not number!";}

	if ($users_array[0] eq $users_array[1]) {die "It is one person!";}

	my $obj = Local::Searcher::MutualFriends -> new(
		user1 => $users_array[0],
		user2 => $users_array[1]
		);
	my @massive = $obj -> search();
	my $body = Local::Info -> new(array => \@massive);
	my @array = $body -> information();
	if (scalar @array != 0)
	{
		my $json_text = Local::JsonEncode -> make (array => \@array);
		p $json_text;
	}
	else { print "There are not mutual friends!\n" }
}

if (defined $nofriends_key)
{
	my $obj = Local::Searcher::Alone -> new();
	my @massive = $obj -> search ();
	my $body = Local::Info -> new(array => \@massive);
	my @array = $body -> information();
	if (scalar @array != 0)
	{
		my $json_text = Local::JsonEncode -> make (array => \@array);
		p $json_text;
	}
	else { print "There are not alone people!\n" }
}

if (defined $num_handshakes_key && defined $users_array[0] && defined $users_array[1])
{
	if ($users_array[0] eq $users_array[1]) {die "It is one person!";}
	my $obj = Local::Searcher::handshakes -> new(
		user1 => $users_array[0],
		user2 => $users_array[1]
		);
	my ($road) = $obj -> search ();
	p $road;
}


