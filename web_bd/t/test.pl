#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";
use DDP;

use Test::More tests => 17;

BEGIN { use_ok("Local::Inquiry_maker"); use_ok("Local::go_to_db"); }

my $obj1 = Local::Inquiry_maker->new(
    string => 'GET http://localhost:3306/mydb/mytable/100500',
    );
ok $obj1, 'created';
is $obj1->{string}, 'GET http://localhost:3306/mydb/mytable/100500', "string GET";
is $obj1->sql_ask, "SELECT * FROM mytable WHERE id = 100500 ", "SIMPLE GET";

my $obj2 = Local::Inquiry_maker->new(
    string => 'PUT http://localhost:3306/mydb/mytable/100500',
    );
ok $obj2, 'created';
is $obj2->{string}, 'PUT http://localhost:3306/mydb/mytable/100500', "string PUT";
is $obj2->sql_ask, "UPDATE mytable SET WHERE id = 100500 ", "SIMPLE GET";

my $obj3 = Local::Inquiry_maker->new(
    string => 'DELETE http://localhost:3306/mydb/mytable/100500',
    );
ok $obj3, 'created';
is $obj3->{string}, 'DELETE http://localhost:3306/mydb/mytable/100500', "string DELETE";
is $obj3->sql_ask, "DELETE mytable WHERE id = 100500 ", "SIMPLE DELETE";

my $obj5 = Local::Inquiry_maker->new(
    string => 'PUT http://localhost:3306/mydb/mytable/100500?field1=abc',
    );
ok $obj5, 'created';
is $obj5->sql_ask, 'UPDATE mytable SET field1 = "abc" WHERE id = 100500 ', "full UPDATE";

my $obj6 = Local::Inquiry_maker->new(
    string => 'POST http://localhost:3306/mydb/mytable/?field1=abc&?field2=abc&field3=123',
    );
ok $obj6, 'created';
is $obj6->sql_ask, 'INSERT INTO mytable (field1, field2) VALUES ("abc", "abc") ', "full INSERT";

my $obj7 = Local::go_to_db->new (
	string => 'GET http://localhost:3306/mydb/mytable/1000',
	);
ok $obj7, 'created';
my $string_json = $obj7->main;
is $string_json, '[[1000, "acv", "dss"]]', 'check INSERT'; 















 

