package Model::Prueba;
use Config::Database;

sub new {
  my $class = shift;
  my $db = 'Config::Database';
  my $odb= $db->new();
  my $dbh = $odb->getConnection();
  my $self = {
    _dbh => $dbh
  };
  bless $self, $class;
  return $self;
}

sub listar {
  my($self) = @_;
  my $sth = $self->{_dbh}->prepare('SELECT id, nombres, paterno, materno, correo FROM pruebas') 
    or die "prepare statement failed: $dbh->errstr()";
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my @rpta;
  while (my $ref = $sth->fetchrow_hashref()) {
    push @rpta, $ref;
  }
  $sth->finish;
  return @rpta;
}

sub crear {
  my($self, $nombres, $paterno, $materno, $correo) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO pruebas (nombres, paterno, materno, correo) VALUES (?, ?, ?, ?)') 
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombres);
  $sth->bind_param( 2, $paterno);
  $sth->bind_param( 3, $materno);
  $sth->bind_param( 4, $correo);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  #my $id_generated = $self->{_dbh}->firebird_insertid;
  return $id_generated;
}

1;