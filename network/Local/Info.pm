package Local::Info;

use strict;
use warnings;
use DDP;
use DBI;
use JSON::XS;
use utf8;
use Encode;

sub new
{
	my($class) = shift;
	my %params = @_;
	return bless \%params, $class;
}
sub information
{
	my ($self) = shift;
	#-------------------------
	#        	LOGIN
	#-------------------------
	my $password = 'newpass';
	my $user = 'root';
	my $database = 'network';
	my $hostname = 'localhost';
	my $port = 3306;

	my $dbh = DBI->connect (
		"DBI:mysql:database=$database;" . "host=$hostname;port=$port",
		$user,
		$password,
		{mysql_enable_utf8 => 1, mysql_init_command => "set names utf8"}
		);
	if ($dbh) {print "ep\n";}
	#-------------------------
	#     
	#-------------------------

	#my $perem = "SET NAMES utf8"; 
	#$dbh->do ($perem);


	my @massiv;

	for my $i (0..$#{$self->{array}})
	{
		my $ask = $dbh -> prepare ("SELECT * FROM user WHERE id_user = ?"); 
		$ask -> execute( ${$self->{array}}[$i] );
		my %hash = %{$ask -> fetchrow_hashref()};
		push @massiv, {%hash};
	}
#use Data::Dumper;

#warn Dumper(\@massiv);
#warn length $massiv[0]{first_name};
#warn utf8::is_utf8($massiv[0]->{first_name});

	return @massiv;
}




1;
