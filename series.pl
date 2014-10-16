#!/usr/bin/perl -w
use strict;
use Data::Dumper;
#use LWP::Simple;
#use JSON;
use DBI;
use Template;
use Date::Format;


my $today = time2str("%Y-%m-%d", time);

my $dsn = "DBI:mysql:database=tvseries;host=localhost";

my $dbh = DBI->connect($dsn, 'tvseries', '12345');

my $sql = "SELECT * FROM episodes ORDER BY air_date";
my $sth = $dbh->prepare($sql);
$sth->execute();

my @episodes;
while (my $row = $sth->fetchrow_hashref()) {
    $row->{old} = ($today gt $row->{air_date}) ? 1 : 0;
    push @episodes, $row;
}



my $template = Template->new();


$template->process( \*DATA, {episodes => \@episodes, today => $today} );

__DATA__
Content-type: text/html

<html>
<head>
<style>
    .old td {color: grey}
</style>
</head>
<body>
<h1>TV Series</h1>
<table border=1>
[% FOREACH ep IN episodes %]
<tr[% IF ep.old %] class="old"[% END %]>
    <td>[% ep.series_name %]</td>
    <td>S[% ep.season_no %]E[% ep.episode_no %]</td>
    <td>[% ep.episode_name %]</td>
    <td>[% ep.air_date %]</td>
</tr>
[% END %]
</table>
</body>
</html>