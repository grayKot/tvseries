#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use LWP::Simple;
use JSON;

my $api_key = 'api_key=0f154eb1af78f30e6b5712b4ebf6dc28';
my $url_base = 'https://api.themoviedb.org/3/';

# SP
# FG
# AD
my @tv = qw(2190 1434 1433);


foreach my $tv (@tv) {
    my $url = $url_base."tv/$tv?$api_key";
    my $json = get($url);
    my $data = from_json($json);
    
    print $url;
}


# https://api.themoviedb.org/3/tv/2190?api_key=0f154eb1af78f30e6b5712b4ebf6dc28&query=South%20Park