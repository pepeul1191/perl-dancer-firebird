package Routes::Pais;
use Dancer2;
use JSON;
use JSON::XS 'decode_json';
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Pais;
use utf8;
use Encode qw( encode_utf8 );

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar' => sub {
  my $model= 'Model::Pais';
  my $pais= $model->new();
  try {
    my  @rpta = $pais->listar();
    return to_json \@rpta;
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = 'Se ha producido un error en listar la tabla de paises';
    my @temp = ('Se ha producido un error en listar la tabla de paises', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return to_json \%rpta;
  };
};

1;