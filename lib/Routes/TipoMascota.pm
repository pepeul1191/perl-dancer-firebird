package Routes::TipoMascota;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::TipoMascota;
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
    my @temp = ('Se ha producido un error en listar la tabla de tipos de mascotas', '' . $_);
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
  my $model= 'Model::TipoMascota';
  my $TipoMascota= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $id_generado = $TipoMascota->crear($nombre);
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
        $TipoMascota->editar($id,$nombre);
      }
    }
    for my $eliminado(@eliminados){
      $TipoMascota->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en las tipos de mascotas", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $TipoMascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar la tabla de tipos de mascotas", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $TipoMascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

get '/raza/:tipo_mascota_id' => sub {
  my $model= 'Model::TipoMascota';
  my $tipo_mascota_id = param('tipo_mascota_id');
  my $TipoMascota = $model->new();
  try {
    my  @rpta = $TipoMascota->raza($tipo_mascota_id);
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en listar las razas de dicho tipo de mascota', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return Encode::decode('utf8', JSON::to_json \%rpta);
  };
};

post '/asociar_raza' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  my @nuevos = @{$data->{"nuevos"}};
  my @eliminados = @{$data->{"eliminados"}};
  my $tipo_mascota_id = $data->{"extra"}->{'tipo_mascota_id'};
  my @array_nuevos;
  my %rpta = ();
  my $model= 'Model::TipoMascota';
  my $TipoMascota= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $raza_id = $nuevo->{'raza_id'};
        my $id_generado = $TipoMascota->asociar_raza($raza_id, $tipo_mascota_id);
        my %temp = ();
        $temp{'temporal'} = $temp_id;
        $temp{'nuevo_id'} = $id_generado;
        push @array_nuevos, {%temp};
      }
    }
    for my $eliminado(@eliminados){
      $TipoMascota->desasociar_raza($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado la asociación/deasociación de las razas al tipo de mascota", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $TipoMascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en asociar/deasociar las razas al tipo de mascota", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $TipoMascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;
