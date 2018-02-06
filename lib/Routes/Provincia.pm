package Routes::Provincia;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Provincia;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar/:departamento_id' => sub {
  my $departamento_id = param('departamento_id');
  my $model= 'Model::Provincia';
  my $Provincia = $model->new();
  try {
    my  @rpta = $Provincia->listar($departamento_id);
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = 'Se ha producido un error en listar la tabla de provincias';
    my @temp = ('Se ha producido un error en listar la tabla de provincias', '' . $_);
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
  my $model= 'Model::Provincia';
  my $Provincia= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $departamento_id = $nuevo->{'departamento_id'};
        my $id_generado = $Provincia->crear($nombre, $departamento_id);
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
        my $departamento_id = $editado->{'departamento_id'};
        $Provincia->editar($id,$nombre, $departamento_id);
      }
    }
    for my $eliminado(@eliminados){
      $Provincia->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en las provincias", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $Provincia->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = "Se ha producido un error en guardar la tabla de provincias";
    my @temp = ("Se ha producido un error en guardar la tabla de provincias", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Provincia->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;