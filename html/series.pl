#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use DBI;
use Template;
use DateTime;


my $today = DateTime->now()->ymd();
my $from_date = DateTime->now()->subtract('months' => 1)->ymd();

my $dsn = "DBI:mysql:database=tvseries;host=localhost";
my $dbh = DBI->connect($dsn, 'tvseries', '12345');
my $sql = "SELECT * FROM episodes WHERE air_date >= '$from_date' AND air_date != '0000-00-00' ORDER BY air_date";
my $sth = $dbh->prepare($sql);
$sth->execute();

my @episodes_list;
my %episodes;
while (my $row = $sth->fetchrow_hashref()) {
    $row->{old} = ($today gt $row->{air_date}) ? 1 : 0;
    push @episodes_list, $row;
    push @{ $episodes{$row->{air_date}} }, $row;
}

my ($y, $m, $d) = split('-', $episodes_list[0]->{air_date});
my $date = DateTime->new(
    year  => $y,
    month => $m,
    day   => $d,
);

($y, $m, $d) = split('-', $episodes_list[-1]->{air_date});
my $date_to = DateTime->new(
    year  => $y,
    month => $m,
    day   => $d,
);

my @calendar;
while ( DateTime->compare($date, $date_to) <= 0 ) {
    my $ymd = $date->ymd();
    my $day_of_week = $date->day_of_week();
    
    my $day = {
        date    => $ymd,
        date_f  => $date->strftime("%d.%m.%y"),
        old     => ($today gt $ymd) ? 1 : 0,
        weekend => ($day_of_week == 6 || $day_of_week == 7) ? 1 : 0,
    };
    
    if ($episodes{$ymd}) {
        $day->{episodes} = $episodes{$ymd};
        $day->{episodes_qty} = scalar( @{$episodes{$ymd}} );
    } elsif ($day->{old}) {
        $day->{skip} = 1;
    }
    
    push @calendar, $day;
    
    $date->add( days => 1 );
}

my $template = Template->new();

$template->process( \*DATA, {episodes => \@episodes_list, today => $today, calendar => \@calendar} );

__DATA__
Content-type: text/html

<html>
<head>
<style>
    table { border-collapse: collapse; }
    .old { color: grey; }
    .today td { font-weight: bold; }
    .weekend>td:first-of-type { background-color: #FFEEEE; }
    .day { border-bottom: 1px dotted grey; }
}
</style>
</head>
<body>
<h1>TV Series</h1>

<table>
[% FOREACH day IN calendar %]
[% IF day.skip %]
    [% NEXT %]
[% END %]
<tr class="day[% IF day.old %] old[% END %][% IF day.date == today %] today[% END %][% IF day.weekend %] weekend[% END %]">
    <td>[% day.date_f %]</td>
    <td>
        <table>
            [% FOREACH ep IN day.episodes %]
            <tr>
                <td>[% ep.series_name %]</td>
                <td>S[% ep.season_no %]E[% ep.episode_no %]</td>
                <td>[% ep.episode_name %]</td>
                <td>[% ep.translate %]</td>
            </tr>
            [% END %]
        </table>
    </td>
</tr>
[% END %]
</table>

</body>
</html>