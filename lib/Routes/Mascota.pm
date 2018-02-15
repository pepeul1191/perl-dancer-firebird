package Routes::Mascota;
use Dancer2;
use JSON;
use JSON::XS;
use Data::Dumper;
use Try::Tiny;
use strict;
use warnings;
use Model::Mascota;
use utf8;
use Encode;
binmode STDOUT, ':utf8';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

post '/crear' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('mascota')));
  my $nombre = $data->{"nombre"};
  my $descripcion = $data->{"descripcion"};
  my $nacimiento = $data->{"nacimiento"};
  my $certificado_raza = $data->{"certificado_raza"};
  my $criador_id = $data->{"criador_id"};
  my $raza_id = $data->{"raza_id"};
  my %rpta = ();
  my $model= 'Model::Mascota';
  my $Mascota= $model->new();
  try {
    my $id_generado = $Mascota->crear($nombre, $descripcion, $nacimiento, $certificado_raza, $criador_id, $raza_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha registrado la mascota", $id_generado);
    $rpta{'mensaje'} = [@temp];
    $Mascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar la nueva mascota", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Mascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/editar' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('mascota')));
  my $id = $data->{"id"};
  my $nombre = $data->{"nombre"};
  my $descripcion = $data->{"descripcion"};
  my $nacimiento = $data->{"nacimiento"};
  my $certificado_raza = $data->{"certificado_raza"};
  my $raza_id = $data->{"raza_id"};
  my %rpta = ();
  my $model= 'Model::Mascota';
  my $Mascota= $model->new();
  try {
    $Mascota->editar($id, $nombre, $descripcion, $nacimiento, $certificado_raza, $raza_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha editado la mascota");
    $rpta{'mensaje'} = [@temp];
    $Mascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en guardar en editar las mascota", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Mascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/agregar_foto' => sub {
  my $self = shift;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  my $mascota_id = $data->{"mascota_id"};
  my $mascota_foto_id = $data->{"mascota_foto_id"};
  my %rpta = ();
  my $model= 'Model::Mascota';
  my $Mascota= $model->new();
  try {
    my $id_generado = $Mascota->agregar_foto($mascota_id, $mascota_foto_id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha agregado una foto a la mascota", $id_generado);
    $rpta{'mensaje'} = [@temp];
    $Mascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en agregar la foto a la mascota", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Mascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};

post '/quitar_foto' => sub {
  my $self = shift;
  my $id = param('id');
  my %rpta = ();
  my $model= 'Model::Mascota';
  my $Mascota= $model->new();
  try {
    $Mascota->quitar_foto($id);
    $rpta{'tipo_mensaje'} = "success";
    my @temp = ("Se ha quitado una foto a la mascota");
    $rpta{'mensaje'} = [@temp];
    $Mascota->commit();
  } catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    my @temp = ("Se ha producido un error en quitar la foto a la mascota", "" . $_);
    $rpta{'mensaje'} = [@temp];
    $Mascota->rollback();
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return Encode::decode('utf8', JSON::to_json \%rpta);
};


1;
