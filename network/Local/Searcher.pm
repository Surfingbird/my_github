package Local::Searcher;

use strict;
use warnings;
use DDP;
use utf8;
use DBI;

sub new
{
	my ($class) = shift;
	my %params = @_;
	return bless \%params, $class;
} 

sub search 
{
	my ($self) = shift;

	my $dbh = $self -> connection();

	my @mas = $self ->action ($dbh);

	return @mas;

}

sub connection
{
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
	if ($dbh) {print "OK!\n";}
	#-------------------------
	#     
	#-------------------------

	my $perem = "SET NAMES utf8"; 
	$dbh->do ($perem);

	return $dbh;
}

1;