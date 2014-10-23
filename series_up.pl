#!/usr/bin/perl -w
use strict;
use utf8;
use open qw( :encoding(UTF-8) :std );
use charnames qw( :full :short );
use feature qw( unicode_strings );

use Data::Dumper;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Cookies;
use URI::Encode qw(uri_encode uri_decode);
use Mojo::DOM;
use JSON;
use DBI;

my $api_key = 'api_key=0f154eb1af78f30e6b5712b4ebf6dc28';
my $url_base = 'https://api.themoviedb.org/3/';

my $dsn = "DBI:mysql:database=tvseries;host=localhost";
my $dbh = DBI->connect($dsn, 'tvseries', '12345');
$dbh->do('SET NAMES utf8');

# connect rutracker
my $cookie_jar = HTTP::Cookies->new();
my $ua = LWP::UserAgent->new(
    agent => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36',
    cookie_jar => $cookie_jar,
);
$ua->default_header( referer => 'http://login.rutracker.org/forum/login.php' );

my %form = (
    redirect       => 'index.php',
    login_username => 'graykot',
    login_password => 'k0ttortor',
    login          => '%C2%F5%EE%E4',
);
my $response = $ua->post('http://login.rutracker.org/forum/login.php', \%form);

$cookie_jar->scan( sub {
    my @args = @_;
    my $domain_index = 4;
    $args[$domain_index] =~ s/^.//;  
    $cookie_jar->set_cookie( @args );
} );
# connect rutracker

my $sezon_ru = 'Сезон';
my $series_ru = 'Серии';
my $seriya_ru = 'Серия';


# SP
# FG
# AD
# BB
my @tv = qw(2190 1434 1433 32726 456);



foreach my $tv_id (@tv) {
    print "update tv_id: $tv_id\n";
    my $url = $url_base."tv/$tv_id?$api_key";
    my $json = get($url);
    my $tv_data = from_json($json);
    
    foreach my $season (1..2) {
        my $season_no = $tv_data->{seasons}->[-$season]->{season_number};
        print "update season_no: $season_no\n";
        
        my $url = $url_base."tv/$tv_id/season/$season_no?$api_key";
        my $json = get($url);
        my $season_data = from_json($json);

        my %links;
        # rutracker get
        my $query = "nm=$tv_data->{name} $sezon_ru $season_no&o=1&s=2";
        my $url_search = 'http://rutracker.org/forum/tracker.php?'.uri_encode($query);
        
        my $response = $ua->get($url_search);
        my $html = $response->decoded_content();
        
        my $dom = Mojo::DOM->new($html);
            
        foreach my $element ( $dom->find('#tor-tbl tr.hl-tr td.t-title div.t-title a')->each ) {
            my $txt = $element->text;
            my $href = $element->attr('href');
            $href =~ s/^\.\///;
            $href = "http://rutracker.org/forum/$href";
            
            print "$txt\n";
        
            my ($episode_from, $episode_to) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$series_ru:\s*(\d+)-(\d+)/;
            if ($episode_from) {
                print "$episode_from-$episode_to\n";
            } else {
                my ($episode_from) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$seriya_ru:\s*(\d+)/;
                if($episode_from) {
                    $episode_to = $episode_from;
                    print "$episode_from\n";
                }
            }
            
            if ($episode_from) {
                foreach my $ep ($episode_from..$episode_to) {
                    push @{ $links{$ep} }, { link => $href, description => $txt };
                }
            }
            
        }
        # rutracker get
        
        my $sql = "DELETE episodes, links
            FROM episodes LEFT JOIN links USING(episode_id)
            WHERE tv_id=? AND season_no=?";
        $dbh->do($sql, undef, $tv_id, $season_no);
        
        $sql = "INSERT INTO episodes (episode_id, tv_id, season_no,
            episode_no, series_name, episode_name, air_date)
            VALUES (?,?,?,?,?,?,?)";
        my $sth = $dbh->prepare($sql);

        my $sql_links = "INSERT INTO links (link_provider, episode_id, link_href, link_description)
            VALUES (?,?,?,?)";
        my $sth_links = $dbh->prepare($sql_links);

        foreach my $episode ( @{ $season_data->{episodes} } ) {
            print "update episode: $episode->{id}\n";
            $sth->execute(
                $episode->{id},
                $tv_id,
                $season_no,
                $episode->{episode_number},
                $tv_data->{name},
                $episode->{name},
                $episode->{air_date} || '9999-99-99',
            );
            
            foreach my $link ( @{ $links{ $episode->{episode_number} } } ) {
                $sth_links->execute(
                    'rutracker',
                    $episode->{id},
                    $link->{link},
                    $link->{description},
                );                
            }
            
            
            
            
        }
    }
    1;

}

# Search tv
# search/tv?$api_key&query=Aouth%20Park


# https://api.themoviedb.org/3/search/tv?api_key=0f154eb1af78f30e6b5712b4ebf6dc28&query=bob%27s%20burgers