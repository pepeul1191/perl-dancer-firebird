package Routes::EstadoCriador;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::EstadoCriador;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar' => sub {
  my $model= 'Model::EstadoCriador';
  my $EstadoCriador = $model->new();
  try {
    my  @rpta = $EstadoCriador->listar();
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en listar la tabla de estado de criadores', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return Encode::decode('utf8', JSON::to_json \%rpta);
  };
};

1;
