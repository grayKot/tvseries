#!/usr/bin/perl -w
use strict;
use utf8;
use open qw( :encoding(UTF-8) :std );
use charnames qw( :full :short );
use feature qw( unicode_strings );

use Data::Dumper;
use LWP::UserAgent;
use HTTP::Cookies;
use DBI;
use URI::Encode qw(uri_encode uri_decode);
use Text::Iconv;
use Mojo::DOM;

    my $txt = $row->text;
    #$txt = $iconv->convert($txt);
    print "$txt\n";
    ($txt) = $txt =~ /^.*?\/.*?\/\s+(.*?):/;

    my $season_no = 18;
    my @episodes_ru;
    my ($episode_from, $episode_to) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$series_ru:\s*(\d+)-(\d+)/;
    if ($episode_from) {
        print "$episode_from-$episode_to\n";
    } else {
        my ($episode) = $txt =~ /$sezon_ru\s*:\s*$season_no\b.*$seriya_ru:\s*(\d+)/;
        print "$episode\n";
        
    }
    
    


1;






