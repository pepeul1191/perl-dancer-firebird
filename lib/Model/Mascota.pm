package Model::Mascota;
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

sub crear {
  my($self, $nombre, $descripcion, $nacimiento, $certificado_raza, $criador_id, $raza_id) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO mascotas (nombre, descripcion, nacimiento, certificado_raza, criador_id, raza_id) VALUES (?,?,?,?,?,?)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $descripcion);
  $sth->bind_param( 3, $nacimiento);
  $sth->bind_param( 4, $certificado_raza);
  $sth->bind_param( 5, $criador_id);
  $sth->bind_param( 6, $raza_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub editar {
  my($self, $id, $nombre, $descripcion, $nacimiento, $certificado_raza, $raza_id) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE mascotas SET nombre = ?, descripcion = ?, nacimiento = ?, certificado_raza = ?, raza_id = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $descripcion);
  $sth->bind_param( 3, $nacimiento);
  $sth->bind_param( 4, $certificado_raza);
  $sth->bind_param( 5, $raza_id);
  $sth->bind_param( 6, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub eliminar {
  my($self, $id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM mascotas WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub agregar_foto {
  my($self, $mascota_id, $mascota_foto_id) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO mascota_fotos (mascota_id, mascota_foto_id) VALUES (?,?)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $mascota_id);
  $sth->bind_param( 2, $mascota_foto_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub quitar_foto {
  my($self, $id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM mascota_fotos WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

1;
