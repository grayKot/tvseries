#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Cookies;
use HTTP::Request;
use JSON;
use DBI;


use open IN => ":encoding(utf8)", OUT => ":utf8";


my $ua = LWP::UserAgent->new;
$ua->default_header('Accept-Encoding' => scalar HTTP::Message::decodable());

$ua->add_handler("request_send",  sub { shift->dump; return });
$ua->add_handler("response_done", sub { shift->dump; return });

  $ua->get("http://www.example.com");
  
  