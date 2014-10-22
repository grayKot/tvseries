#!/usr/bin/perl -w
use strict;
use utf8;
use open qw( :encoding(UTF-8) :std );
use charnames qw( :full :short );
use feature     qw< unicode_strings >;

use Data::Dumper;
use LWP::UserAgent;
use HTTP::Cookies;
use DBI;
use URI::Encode qw(uri_encode uri_decode);
use Text::Iconv;
use Mojo::DOM;

my $cookie_jar = HTTP::Cookies->new();

my $ua = LWP::UserAgent->new(
    agent => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36',
    #requests_redirectable => ['GET', 'HEAD', 'POST'],
    cookie_jar => $cookie_jar,
);
$ua->default_header( referer => 'http://login.rutracker.org/forum/login.php' );
#$ua->add_handler("request_send",  sub { shift->dump; return });
#$ua->add_handler("response_done", sub { shift->dump; return });

my %form = (
    redirect       => 'index.php',
    login_username => '',
    login_password => '',
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
#print uri_decode('%D1%81%D0%B5%D0%B7%D0%BE%D0%BD'), "\n";
#print uri_encode('сезон');

my $query = "nm=South Park $sezon_ru 18&0=1&s=2";
my $url_search = 'http://rutracker.org/forum/tracker.php?'.uri_encode($query);

$response = $ua->get($url_search);
my $iconv = Text::Iconv->new("WINDOWS-1251", "UTF-8");

#my $html = $response->content;
my $html = $response->decoded_content();
#$html = $iconv->convert($html);

my $dom = Mojo::DOM->new($html);

foreach my $row ( $dom->find('#tor-tbl tr.hl-tr td.t-title div.t-title a')->each ) {
    my $txt = $row->text;
    #$txt = $iconv->convert($txt);
    print "$txt\n";
    ($txt) = $txt =~ /^.*?\/.*?\/\s+(.*?):/;
    print "$txt\n";
    print length($txt), "\n";
    print "$sezon_ru\n";
    print length($sezon_ru),"\n";
    if ($txt =~ /$sezon_ru/) {
        print "Ok\n";
    }
    
    
}

1;






