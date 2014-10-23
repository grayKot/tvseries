#!/usr/bin/perl -w
use strict;
use utf8;
use open qw( :encoding(UTF-8) :std );
use charnames qw( :full :short );
use feature qw( unicode_strings );

use DBI;
use Data::Dumper;
use LWP::UserAgent;
use HTTP::Cookies;
use URI::Encode qw(uri_encode uri_decode);
use Mojo::DOM;

#use Text::Iconv;
#my $iconv = Text::Iconv->new("WINDOWS-1251", "UTF-8");
#$html = $iconv->convert($html);

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

$response = $ua->get('http://rutracker.org/forum/index.php');

my $sezon_ru = 'Сезон';
my $series_ru = 'Серии';
my $seriya_ru = 'Серия';

my $query = "nm=South Park $sezon_ru 18&0=1&s=2";
my $url_search = 'http://rutracker.org/forum/tracker.php?'.uri_encode($query);

$response = $ua->get($url_search);
my $html = $response->decoded_content();

my $dom = Mojo::DOM->new($html);
my $season_no = 18;
    
foreach my $element ( $dom->find('#tor-tbl tr.hl-tr td.t-title div.t-title a')->each ) {
    my $txt = $element->text;
    my $href = $element->attr('href');
    print "$txt\n";

    my @episodes_ru;
    my ($episode_from, $episode_to) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$series_ru:\s*(\d+)-(\d+)/;
    if ($episode_from) {
        print "$episode_from-$episode_to\n";
    } else {
        my ($episode) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$seriya_ru:\s*(\d+)/;
        print "$episode\n";
    }
}

1;






