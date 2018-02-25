package Local::Date;

use strict;
use warnings;
use Local::Date::Interval;

use Mouse;
use Time::Local;
use POSIX qw(strftime);
use DDP;

use overload
	'""' => 'to_string',
	'0+' => 'to_scalar',
	'+' => 'to_sum',
	'-' => 'to_deduct',
	'-=' => 'minus_equally',
	'+=' => 'plus_equally',
	'++' => 'incr',
	'--' => 'decr',
	fallback => 1;

has day => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_day",
	trigger => \&general_cleaning_epoch
	  );

has month => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_month",
	trigger => \&general_cleaning_epoch
	);

has year => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_year",
	trigger => \&general_cleaning_epoch
	);

has hours => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_hours",
	trigger => \&general_cleaning_epoch
	);

has minutes => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_minutes",
	trigger => \&general_cleaning_epoch
	);

has seconds => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_seconds",
	trigger => \&general_cleaning_epoch
	);

has epoch => ( 
	is => 'rw',
	isa => 'Int',
	required => 1,
	clearer   => "clear_epoch",
	lazy => 1,
	builder => \&new_epoch,
	trigger => sub {
		my ($self) = @_;

		my ($seconds, $minutes, $hours, $day, $month, $year) = gmtime($self->epoch);

		$self->seconds($seconds);
		$self->minutes($minutes);
		$self->hours($hours);
		$self->day($day);
		$self->month($month + 1);
		$self->year($year + 1900);
	}
	);

has format => (
	is => 'rw',
	isa => 'Str',
	default => "%a %b %e %H:%M:%S %Y"
	);

sub general_cleaning_epoch {
	my ($self) = @_;
	$self->clear_epoch();
}

sub to_string {
	my ($self) = @_;

	return strftime $self->format, gmtime($self->epoch);
}

sub new_epoch {
	my ($self) = @_;

	my $time = timegm(
		$self->seconds,
		$self->minutes,
		$self->hours,
		$self->day,
		$self->month - 1,
		$self->year - 1900
		);

	$self->epoch($time);
}

sub to_scalar {
	my ($self) = @_;

	return $self->epoch;
}

sub to_sum {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		my $sec = $x->epoch;
		$sec += $y;
		return $sec;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		my $sec1 = $x->epoch;
		my $sec2 = $y->duration;

		return Local::Date->new(epoch => $sec2 + $sec1);
	}
	else {die "Error in to_sum!\n";}
}

sub to_deduct {
	my ($x, $y, $swap) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		my $sec = $x->epoch;
		$sec -= $y;
		if ($swap) { $sec *= -1; }
		return $sec = $sec < 0 ? undef : $sec;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		if ( $swap >= 1 ) {die "Error!\n";} 
		my $sec1 = $x->epoch;
		my $sec2 = $y->duration;

		return Local::Date->new(epoch => $sec1 - $sec2);
	}
	elsif ($name2 eq 'Local::Date')
	{
		my $sec1 = $x->epoch;
		my $sec2 = $y->epoch;
		my $diff = $sec1 - $sec2;

		if ($sec1 > $sec2) { return Local::Date::Interval->new(duration => $diff); }
		else {die "Error in to_deduct!\n";}
	}
	else {die "Error in to_deduct!\n";}
}

sub minus_equally {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		$x->epoch($x->epoch - $y);
		return $x;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		$x->epoch($x->epoch - $y->duration);
		return $x;
	}
	else {die "Error in minus_equally!\n";}
}

sub plus_equally {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		$x->epoch($x->epoch + $y);
		return $x;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		$x->epoch($x->epoch + $y->duration);
		return $x;
	}
	else {die "Error  in plus_equally!\n";}
}

sub incr {
	my ($x) = @_;

	$x->epoch($x->epoch + 1);
	return $x;
}

sub decr {
	my ($x) = @_;

	$x->epoch($x->epoch - 1);
	return $x;
}


1;
