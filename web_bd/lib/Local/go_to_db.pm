package Local::go_to_db;

use strict;
use warnings;
use DBI;
use JSON::XS;

sub new {
	my ($class) = shift;
	my %params = @_;

	my @inquiry = split /(\/)|' '/, $params{string};

	my ($hostname, $port, $database);

	if ($inquiry[4] =~ /^(\w+)\:([0-9]+)$/) {
		$hostname = $1;
		$port = $2;
	}
	else {
		die "Invalid inquiry! Error in hostname or port!";
	}
	$database = $inquiry[6];

	#-------------------------
	#        	LOGIN
	#-------------------------
	my $password = 'newpass';
	my $user = 'root';

	my $dbh = DBI->connect (
		"DBI:mysql:database=$database;" . "host=$hostname;port=$port",
		$user,
		$password,
		{mysql_enable_utf8 => 1, mysql_init_command => "set names utf8"}
		) or die "You have bags!";
	#-------------------------
	#     
	#-------------------------
	if ($dbh) { print "connect is ok!\n";}

	$params{dbh} = $dbh;
	
	return bless \%params, $class;
}

sub main {

	my ($self) = shift;

	my $obj = Local::Inquiry_maker->new( string => $self->{string});
	my $string = $obj->sql_ask;

	my $hashref;

	if ($string =~ /^(insert|update|delete)/i) {
		$self->{dbh}->do($string);
	}
	elsif ($string =~ /^select/i) {
		$hashref = $self->{dbh}->selectall_arrayref($string);
	}
	if (defined $hashref) {
		my $json = JSON::XS->new->utf8->space_after->encode ($hashref);
		return $json;
	}
}

1;