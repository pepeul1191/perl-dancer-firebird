package Routes::Criador;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Criador;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

1;
