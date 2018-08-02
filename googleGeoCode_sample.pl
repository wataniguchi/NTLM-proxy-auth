#!/usr/bin/perl -w
#
# Usage:
#  echo 1428 Whisperwood Dr., Columbus GA. | perl googleGeoCode_sample.pl
#
use strict;
use warnings;
use LWP::UserAgent;
use LWP::Authen::Ntlm;
use Authen::NTLM;
ntlmv2(1);
ntlm_host('WORKSTATION');
use URI::Escape;
use Encode 'decode';
use Encode 'encode';
use JSON;

my $user = 'DOMAIN\USER';
my $pass = 'PASSWORD';
my $http_proxy = 'connect://PROXY.SERVER.FQDN:8080';
my $appid = "APPID";
my $ua = LWP::UserAgent->new(ssl_opts => {verify_hostname => 0},
			     keep_alive => 1);
$ua->proxy([qw(http https)], $http_proxy);
$ua->credentials('PROXY.SERVER.FQDN:8080', '', $user, $pass);

while (<>) {
    chomp;
    my @r = geocode({key => $_, appid => $appid});
    print join("\t", @r, $_)."\n";
}
sub geocode {
    my ($args_ref) = @_;
    my $ek = URI::Escape::uri_escape($args_ref->{key});
    my $murl =
        "https://maps.googleapis.com/maps/api/geocode/json"
        ."?address=$ek&key=$args_ref->{appid}";
    print $murl;
    my $r = $ua->get($murl)->content;
    print $r;
    my $data = decode_json($r);
    return (encode('UTF-8',$data->{result}{address})||"");
}
