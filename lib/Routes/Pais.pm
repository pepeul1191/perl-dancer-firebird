package Routes::Pais;
use Dancer2;
use JSON;
use JSON::XS 'decode_json';
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
#use Model::Item;
use utf8;
use Encode qw( encode_utf8 );

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar' => sub {
  return 'pais/listar';
};

1;