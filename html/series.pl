#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use DBI;
use Template;
use DateTime;


my $today = DateTime->now()->ymd();

my $dsn = "DBI:mysql:database=tvseries;host=localhost";
my $dbh = DBI->connect($dsn, 'tvseries', '12345');
my $sql = "SELECT * FROM episodes ORDER BY air_date";
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
    my $day = {
        date   => $ymd,
        date_f => $date->strftime("%d.%m.%y"),
        old    => ($today gt $ymd) ? 1 : 0,
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
    .old td {color: grey}
    .today td {font-weight: bold}
</style>
</head>
<body>
<h1>TV Series</h1>

<table border=1>
[% FOREACH day IN calendar %]
[% IF day.skip %]
    [% NEXT %]
[% END %]
<tr[% IF day.old %] class="old"[% ELSIF day.date == today %] class="today"[% END %]>
    <td>[% day.date_f %]</td>
    <td>
        <table>
            [% FOREACH ep IN day.episodes %]
            <tr[% IF day.old %] class="old"[% END %]>
                <td>[% ep.series_name %]</td>
                <td>S[% ep.season_no %]E[% ep.episode_no %]</td>
                <td>[% ep.episode_name %]</td>
            </tr>
            [% END %]
        </table>
    </td>
</tr>
[% END %]
</table>

</body>
</html>