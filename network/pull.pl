#!/usr/bin/env perl

use strict;
use warnings;
use DDP;
use PerlIO::via::gzip;
use DBI;
use Encode qw(decode_utf8);
use Cwd;


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
	$password
	);
unless ($dbh) {die "Connection failed!\n";}
#-------------------------
#        	
#-------------------------


my ($fh, $fh_new, $str, $ask);

open ($fh, "<:via(gzip)", 'user_relation.zip') or die $!;
open ($fh_new, ">", 'user_relation.txt')or die $!;

while (<$fh>)
{
	print $fh_new "$_";
}
close $fh;
close $fh_new;

$str =cwd().'/user_relation.txt';
$ask = "LOAD DATA LOCAL INFILE '$str' INTO TABLE friends CHARACTER SET UTF8 FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n'";
$dbh -> do ($ask);

open ($fh, "<:via(gzip)", 'user.zip') or die $!;
open ($fh_new, ">", 'user.txt')or die $!;

while (<$fh>)
{
	print $fh_new "$_";
}
close $fh;
close $fh_new;

$str =cwd().'/user.txt';
$ask = "LOAD DATA LOCAL INFILE '$str' INTO TABLE user CHARACTER SET UTF8 FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n'";
$dbh -> do ($ask);