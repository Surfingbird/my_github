package Local::Date::Interval;

use strict;
use warnings;

use Mouse;
use Time::Local;
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

has hours => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_hours",
	trigger => \&general_cleaning_duration
	);

has minutes => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_minutes",
	trigger => \&general_cleaning_duration
	);

has seconds => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_seconds",
	trigger => \&general_cleaning_duration
	);

has days => (
	is => 'rw',
	isa => 'Int',
	clearer   => "clear_days",
	trigger => \&general_cleaning_duration
	);

our $sec_in_min = 60;
our $sec_in_hour = 3600;
our $sec_in_day = 86400;

has duration => (
	is => 'rw',
	isa => 'Int',
	lazy_build => 1,
	trigger => sub {
		my ($self) = @_;

		my $sec = $self->duration;

		my $day_in_obj = int($sec / $sec_in_day);
		$sec -= $day_in_obj * $sec_in_day;
		$self->days($day_in_obj);

		my $hour_in_obj = int($sec / $sec_in_hour);
		$sec -= $hour_in_obj * $sec_in_hour;
		$self->hours($hour_in_obj);

		my $minutes_in_obj = int($sec / $sec_in_min);
		$sec -= $minutes_in_obj * $sec_in_min;
		$self->minutes($minutes_in_obj);

		$self->seconds($sec);
	}
	);

sub general_cleaning_duration {
	my ($self) = @_;
	$self->clear_duration();
}

sub _build_duration {
		my ($self) = @_;

		my $duration_sec = $self->seconds +
		$self->minutes * $sec_in_min +
		$self->hours * $sec_in_hour +
		$self->days * $sec_in_day;
		$self->duration($duration_sec);
	}

sub to_string {
	my ($self) = @_;
	return "$self->{days} days, $self->{hours} hours, $self->{minutes} minutes, $self->{seconds} seconds";
}

sub to_sum {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '') { return $x->duration + $y; }
	elsif ($name2 eq 'Local::Date')
	{
		my $sec = $x->duration + $y->epoch;
		return Local::Date->new(epoch => $sec) 
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		return Local::Date::Interval->new(duration => $x->duration + $y->duration)
	}
	else {die "Error in to_sum!\n";}

}

sub to_deduct {
	my ($x, $y, $swap) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		my $sec = $x->duration;
		$sec -= $y;
		if ($swap) { $sec *= -1; }
		return $sec = $sec < 0 ? undef : $sec;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		my $dif = $x->duration - $y->duration;

		if ($dif > 0) { Local::Date::Interval->new(duration => $dif); }
		else {die "Error in to_deduct!\n";}
	}
	else {die "Error in to_deduct!\n";}
	}

sub minus_equally {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		$x->duration($x->duration - $y);
		return $x;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		$x->duration($x->duration - $y->duration);
		return $x;
	}
	else {die "Error in minus_equally!\n";}
}

sub plus_equally {
	my ($x, $y) = @_;

	my $name2 = ref $y;

	if ($name2 eq '')
	{
		$x->duration($x->duration + $y);
		return $x;
	}
	elsif ($name2 eq 'Local::Date::Interval')
	{
		$x->duration($x->duration + $y->duration);
		return $x;
	}
	else {die "Error in plus_equally!\n";}
}

sub incr {
	my ($x) = shift;

	$x->duration($x->duration + 1);
	return $x;
}

sub decr {
	my ($x) = shift;

	$x->duration($x->duration - 1);
	return $x;
}

sub to_scalar {
	my ($self) = @_;

	return $self->duration;
}

1;
