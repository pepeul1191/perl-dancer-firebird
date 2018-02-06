package Routes::Distrito;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Distrito;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar/:provincia_id' => sub {
  my $provincia_id = param('provincia_id');
  my $model= 'Model::Distrito';
  my $Distrito = $model->new();
  try {
    my  @rpta = $Distrito->listar($provincia_id);
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = 'Se ha producido un error en listar la tabla de distritos';
    my @temp = ('Se ha producido un error en listar la tabla de distritos', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return Encode::decode('utf8', JSON::to_json \%rpta);
  };
};

get '/buscar/:pais_id' => sub {
  my $pais_id = param('pais_id');
  my $nombre = Encode::encode_utf8(param('nombre'));
  my $model = 'Model::Distrito';
  my $Distrito= $model->new();
  my @rpta = $Distrito->buscar($nombre, $pais_id);
  return Encode::decode('utf8', JSON::to_json \@rpta);
};

post '/guardar' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  my @nuevos = @{$data->{"nuevos"}};
  my @editados = @{$data->{"editados"}};
  my @eliminados = @{$data->{"eliminados"}};
  my @array_nuevos;
  my %rpta = ();
  my $model= 'Model::Distrito';
  my $Distrito= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $provincia_id = $nuevo->{'provincia_id'};
        my $id_generado = $Distrito->crear($nombre, $provincia_id);
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
        my $provincia_id = $editado->{'provincia_id'};
        $Distrito->editar($id,$nombre, $provincia_id);
      }
    }
    for my $eliminado(@eliminados){
      $Distrito->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en los distritos", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $Distrito->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = "Se ha producido un error en guardar la tabla de distritos";
    my @temp = ("Se ha producido un error en guardar la tabla de distritos", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Distrito->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;