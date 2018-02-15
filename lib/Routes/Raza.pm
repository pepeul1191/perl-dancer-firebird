package Routes::Raza;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Raza;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar' => sub {
  my $model= 'Model::Pais';
  my $pais= $model->new();
  try {
    my  @rpta = $pais->listar();
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en listar la tabla de razas', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return Encode::decode('utf8', JSON::to_json \%rpta);
  };
};

post '/guardar' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  my @nuevos = @{$data->{"nuevos"}};
  my @editados = @{$data->{"editados"}};
  my @eliminados = @{$data->{"eliminados"}};
  my @array_nuevos;
  my %rpta = ();
  my $model= 'Model::Raza';
  my $Raza= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $nombre_cientifico = $nuevo->{'nombre_cientifico'};
        my $id_generado = $Raza->crear($nombre, $nombre_cientifico);
        my %temp = ();
        $temp{'temporal'} = $temp_id;
        $temp{'nuevo_id'} = $id_generado;
        push @array_nuevos, {%temp};
      }
    }
    for my $editado(@editados){
      if ($editado) {
        my $id = $editado->{'id'};
        my $nombre = $editado->{'nombre'};
        my $nombre_cientifico = $editado->{'nombre_cientifico'};
        $Raza->editar($id,$nombre, $nombre_cientifico);
      }
    }
    for my $eliminado(@eliminados){
      $Raza->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en las razas", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $Raza->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar la tabla de razas", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Raza->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;
