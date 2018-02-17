package Config::App;
use Dancer2;
use Try::Tiny;
use Model::Prueba;

our $VERSION = '0.1';

hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 1.3202, Ubuntu';
};

get '/' => sub {
  template 'index' => { 'title' => 'Gestion::App' };
};

get '/test/conexion' => sub {
  return 'Conexión Ok'
};

get '/db/listar' => sub {
  my $model= 'Model::Prueba';
  my $prueba= $model->new();
  try {
    my  @rpta = $prueba->listar();
    return to_json \@rpta;
  }
  catch {
    my %rpta = ();
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = 'Se ha producido un error en listar la tabla de pruebas';
    my @temp = ('Se ha producido un error en listar la tabla de pruebas', '' . $_);
    $rpta{'mensaje'} = [@temp];
    return to_json \%rpta;
  };
};

get 'db/crear' => sub {
  my %rpta = ();
  try {
    my $nombres = 'José Jesús';
    my $paterno = 'Valdivia';
    my $materno = 'Caballero';
    my $correo = 'pepe.valdivia.caballero@gmail.com';
    my $model = 'Model::Prueba';
    my $prueba = $model->new();
    $rpta{'id'} = $prueba->crear($nombres, $paterno, $materno, $correo);
  }
  catch {
    #warn "got dbi error: $_";
    $rpta{'tipo_mensaje'} = "error";
    $rpta{'mensaje'} = "Se ha producido un error en guardar la tabla de pruebas";
    my @temp = ("Se ha producido un error en guardar la tabla de pruebas", "" . $_);
    $rpta{'mensaje'} = [@temp];
  };
  #print("\n");print Dumper(%rpta);print("\n");
  return to_json \%rpta;
};

true;
