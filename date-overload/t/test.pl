#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";
use DDP;
use Time::Local;
use Time::Moment;

use Local::Date;
use Local::Date::Interval;

my $date2 = Local::Date->new(day => 1, month => 5, year => 2017, hours => 3, minutes => 20, seconds => 50);

print "1\n";
p $date2;
print "2\n";
p $date2->epoch;
print "3\n";
p $date2->month;















































__END__
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
=cut 
==================================================================================================
-----------РАБОЧИЙ ПРИМЕР ПЕРЕГРУЗКИ-------------
my $date2 = Local::Date->new(day => 1, month => 5, year => 2017, hours => 3, minutes => 20, seconds => 50);
print "$date2"."\n";

  my $dt = Time::Moment->new(
      year       => $date2->{year},
      month      => $date2->{month},
      day        => $date2->{day},
      hour       => $date2->{hours},
      minute     => $date2->{minutes},
      second     => $date2->{seconds},
  );

  my $string = $tm->at_utc->strftime("%F %T");
  p $string;

$date2->format("%D %r");

print "$date2"."\n";


my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
              gmtime(time);
              p $sec;
              p $min;
              p $hour;
              p $mday;
              p $mon;
              p $year;
              p $wday;
              p $yday;
              p $isdst;

