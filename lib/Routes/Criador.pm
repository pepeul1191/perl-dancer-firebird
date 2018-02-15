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

post '/crear' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('criador')));
  my $nombres = $data->{"nombres"};
  my $apellidos = $data->{"apellidos"};
  my $telefono = $data->{"telefono"};
  my $correo = $data->{"correo"};
  my $distrito_id = $data->{"distrito_id"};
  my $usuario_id = $data->{"usuario_id"};
  my %rpta = ();
  my $model= 'Model::Criador';
  my $Criador= $model->new();
  try {
    my $id_generado = $Criador->crear($nombres, $apellidos, $telefono, $correo, $distrito_id, $usuario_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado el criador", $id_generado);
    $rpta{'mensaje'} = [@temp];
    $Criador->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar en nuevo criador", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Criador->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/editar' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('criador')));
  my $id = $data->{"id"};
  my $nombres = $data->{"nombres"};
  my $apellidos = $data->{"apellidos"};
  my $telefono = $data->{"telefono"};
  my $correo = $data->{"correo"};
  my $distrito_id = $data->{"distrito_id"};
  my %rpta = ();
  my $model= 'Model::Criador';
  my $Criador= $model->new();
  try {
    $Criador->editar($id, $nombres, $apellidos, $telefono, $correo, $distrito_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha editado el criador");
    $rpta{'mensaje'} = [@temp];
    $Criador->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar en editar al criador", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Criador->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/cambiar_estado' => sub {
  my $self = shift;
  my $criador_id = param('criador_id');
  my $estado_criador_id = param('estado_criador_id');
  my %rpta = ();
  my $model= 'Model::Criador';
  my $Criador= $model->new();
  try {
    $Criador->cambiar_estado($criador_id, $estado_criador_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha cambiado el estado del criador");
    $rpta{'mensaje'} = [@temp];
    $Criador->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en cambiar el estado del criador", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Criador->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/cambiar_foto' => sub {
  my $self = shift;
  my $criador_id = param('criador_id');
  my $foto_criador_id = param('foto_criador_id');
  my %rpta = ();
  my $model= 'Model::Criador';
  my $Criador= $model->new();
  try {
    $Criador->cambiar_foto($criador_id, $foto_criador_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha cambiado la foto del criador");
    $rpta{'mensaje'} = [@temp];
    $Criador->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en cambiar la foto del criador", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Criador->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

1;
