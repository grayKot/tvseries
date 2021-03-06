#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use DBI;
use Template;
use DateTime;
use JSON;

my $conf_file = '../conf/conf.json';
open my $CONF, '<', $conf_file or die "can't open conf";
my $conf_json = join '', <$CONF>;
my $conf = from_json($conf_json);
close $CONF;


my $today = DateTime->now()->ymd();
my $from_date = DateTime->now()->subtract('months' => 1)->ymd();

my $dsn = "DBI:mysql:database=tvseries;host=localhost";
my $dbh = DBI->connect($dsn, 'tvseries', '12345');
$dbh->do('SET NAMES utf8');

my $sql_links = "SELECT links.* FROM episodes JOIN links USING(episode_id)
    WHERE air_date >= '$from_date' AND air_date != '0000-00-00'";
my $sth_links = $dbh->prepare($sql_links);
$sth_links->execute();

my %links;
while (my $row = $sth_links->fetchrow_hashref()) {
    push @{ $links{ $row->{episode_id} } }, $row;
}

my $sql = "SELECT * FROM episodes WHERE air_date >= '$from_date' AND air_date != '0000-00-00' ORDER BY air_date";
my $sth = $dbh->prepare($sql);
$sth->execute();

my @episodes_list;
my %episodes;
while (my $row = $sth->fetchrow_hashref()) {
    $row->{old} = ($today gt $row->{air_date}) ? 1 : 0;
    if ( $links{ $row->{episode_id} } ) {
        $row->{links} = $links{ $row->{episode_id} };
    }
    
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
    .date { vertical-align: top; }
    .old { color: grey; }
    .today { font-weight: bold; }
    .weekend { background-color: #FFEEEE; }
    .day { border-bottom: 1px dotted grey; }
    .hide_link { display: none }

    a { font-size: small; color: #003E63; text-decoration: none; }
    a:visited { color: #240040; }
    a:hover { border-bottom: 1px dotted #003E63; }
}
</style>
<script src="/jquery-1.11.1.min.js"></script>
<script>
    $(document).ready(function() {
        
    });
    function show_or_hide (episode) {
        $( "."+episode ).each(function() {
            if ( $( this ).hasClass( 'hide_link' ) ) {
                $( this ).removeClass( "hide_link" );
            } else {
                $( this ).addClass( "hide_link" );
            }
            
        });
    }
</script>
</head>
<body>
<h1>TV Series</h1>

<table>
[% FOREACH day IN calendar %]
[% IF day.skip %]
    [% NEXT %]
[% END %]
<tr class="day">
    <td class="date [% IF day.old %] old[% END %][% IF day.date == today %] today[% END %][% IF day.weekend %] weekend[% END %]">[% day.date_f %]</td>
    <td>

    [% FOREACH ep IN day.episodes %]
        [% ep.series_name %]
        S[% ep.season_no %]E[% ep.episode_no %]
        [% ep.episode_name %]
        [% IF ep.links %]<a title="rutracker" href="#" onclick="show_or_hide('[% ep.episode_id %]')"><img src="rutracker.png" /></a>[% END %]
        [% IF ep.links %]
            <div class="hide_link [% ep.episode_id %]">
                [% FOREACH link IN ep.links %]
                    <a href="[% link.link_href %]">[% link.link_description %]</a><br>
                [% END %]
            </div>
        [% END %]
        <br>
    [% END %]
    </td>
</tr>
[% END %]
</table>

</body>
</html>