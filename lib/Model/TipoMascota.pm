package Model::TipoMascota;
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

sub commit {
  my($self) = @_;
  $self->{_dbh}->commit;
}

sub rollback {
  my($self) = @_;
  $self->{_dbh}->rollback;
}

sub listar {
  my($self) = @_;
  my $sth = $self->{_dbh}->prepare('SELECT id, nombre FROM tipo_mascotas;')
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
  my($self, $nombre, $nombre_cientifico) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO tipo_mascotas (nombre) VALUES (?)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub editar {
  my($self, $id, $nombre) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE tipo_mascotas SET nombre = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub eliminar {
  my($self, $id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM tipo_mascotas WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub raza {
  my($self, $tipo_mascota_id) = @_;
  my $sth = $self->{_dbh}->prepare('
    SELECT RA.id, RA.nombre AS raza FROM razas_tipo_mascotas RTM
    INNER JOIN razas RA ON RTM.raza_id = RA.id
    INNER JOIN tipo_mascotas TM ON  RTM.tipo_mascota_id = TM.id
    WHERE RTM.tipo_mascota_id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $tipo_mascota_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my @rpta;
  while (my $ref = $sth->fetchrow_hashref()) {
    push @rpta, $ref;
  }
  $sth->finish;
  return @rpta;
}

1;
