#!/usr/bin/env perl

use strict;
use warnings;
use FindBin; use lib "$FindBin::Bin/../lib";
use Test::More;

use Local::Reducer::Sum;
use Local::Source::Array;
use Local::Row::JSON;

my $sum_reducer = Local::Reducer::Sum->new(
    field => 'price',
    source => Local::Source::Array->new(array => [
        'not-a-json',
        '{"price": 0.5}',
        '{"price": 1.5}',
        '{"price": 2.5}',
        '[ "invalid json structure" ]',
        '{"price":"low"}',
        '{"price": 3.5}',
    ]),
    row_class => 'Local::Row::JSON',
    initial_value => 0,
);

my $sum_result;

$sum_result = $sum_reducer->reduce_n(3);
is($sum_result, 2, 'sum reduced 2');
is($sum_reducer->reduced, 2, 'sum reducer saved');

$sum_result = $sum_reducer->reduce_all();
is($sum_result, 8, 'sum reduced all');
is($sum_reducer->reduced, 8, 'sum reducer saved at the end');

done_testing();
