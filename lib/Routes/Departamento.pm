package Routes::Departamento;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Departamento;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/listar/:pais_id' => sub {
  my $model= 'Model::Departamento';
  my $pais_id = param('pais_id');
  my $Departamento = $model->new();
  try {
    my  @rpta = $Departamento->listar($pais_id);
    return Encode::decode('utf8', JSON::to_json \@rpta);
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en listar la tabla de departamentos', '' . $_);
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
  my $model= 'Model::Departamento';
  my $Departamento= $model->new();
  try {
    for my $nuevo(@nuevos){
      if ($nuevo) {
        my $temp_id = $nuevo->{'id'};
        my $nombre = $nuevo->{'nombre'};
        my $pais_id = $nuevo->{'pais_id'};
        my $id_generado = $Departamento->crear($nombre, $pais_id);
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
        my $pais_id = $editado->{'pais_id'};
        $Departamento->editar($id,$nombre, $pais_id);
      }
    }
    for my $eliminado(@eliminados){
      $Departamento->eliminar($eliminado);
    }
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado los cambios en los departamentos", [@array_nuevos]);
    $rpta{'mensaje'} = [@temp];
    $Departamento->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar la tabla de departamentos", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Departamento->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;