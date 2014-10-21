#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use LWP::Simple;
use JSON;
use DBI;

my $api_key = 'api_key=0f154eb1af78f30e6b5712b4ebf6dc28';
my $url_base = 'https://api.themoviedb.org/3/';

my $dsn = "DBI:mysql:database=tvseries;host=localhost";
my $dbh = DBI->connect($dsn, 'tvseries', '12345');

# SP
# FG
# AD
# BB
my @tv = qw(2190 1434 1433 32726 456);



foreach my $tv_id (@tv) {
    warn "update tv_id: $tv_id";
    my $url = $url_base."tv/$tv_id?$api_key";
    my $json = get($url);
    my $tv_data = from_json($json);
    
    foreach my $season (1..2) {
        my $season_no = $tv_data->{seasons}->[-$season]->{season_number};
        warn "update season_no: $season_no";
        
        my $url = $url_base."tv/$tv_id/season/$season_no?$api_key";
        my $json = get($url);
        my $season_data = from_json($json);
        
        my $sql = "DELETE FROM episodes WHERE tv_id=? AND season_no=?";
        $dbh->do($sql, undef, $tv_id, $season_no);
        
        $sql = "INSERT INTO episodes (episode_id, tv_id, season_no, episode_no, series_name, episode_name, air_date) VALUES (?,?,?,?,?,?,?)";
        my $sth = $dbh->prepare($sql);

        foreach my $episode ( @{ $season_data->{episodes} } ) {
            warn "update episode: $episode->{id}";
            $sth->execute(
                $episode->{id},
                $tv_id,
                $season_no,
                $episode->{episode_number},
                $tv_data->{name},
                $episode->{name},
                $episode->{air_date} || '9999-99-99',
            );
        }
    }
    1;

}

# Search tv
# search/tv?$api_key&query=Aouth%20Park


# https://api.themoviedb.org/3/search/tv?api_key=0f154eb1af78f30e6b5712b4ebf6dc28&query=bob%27s%20burgers