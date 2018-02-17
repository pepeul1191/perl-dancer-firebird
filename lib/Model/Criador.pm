package Model::Criador;
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
  my($self, $nombres, $apellidos, $telefono, $distrito_id, $usuario_id) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO criadores (nombres, apellidos, telefono, distrito_id, usuario_id, estado_criador_id) VALUES (?,?,?,?,?,1)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombres);
  $sth->bind_param( 2, $apellidos);
  $sth->bind_param( 3, $telefono);
  $sth->bind_param( 4, $distrito_id);
  $sth->bind_param( 5, $usuario_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub editar {
  my($self, $id, $nombres, $apellidos, $telefono, $distrito_id) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE criadores SET nombres = ?, apellidos = ?, telefono = ?, distrito_id = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombres);
  $sth->bind_param( 2, $apellidos);
  $sth->bind_param( 3, $telefono);
  $sth->bind_param( 4, $distrito_id);
  $sth->bind_param( 5, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub cambiar_estado {
  my($self, $id, $estado_criador_id) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE criadores SET estado_criador_id = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $estado_criador_id);
  $sth->bind_param( 2, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub cambiar_foto {
  my($self, $id, $foto_criador_id) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE criadores SET foto_criador_id = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $foto_criador_id);
  $sth->bind_param( 2, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub existe_seguir {
  my($self, $mascota_id, $criador_id) = @_;
  my $sth = $self->{_dbh}->prepare('SELECT COUNT(*) AS cantidad FROM seguidores WHERE mascota_id = ? AND criador_id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $mascota_id);
  $sth->bind_param( 2, $criador_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $rpta;
  while (my $ref = $sth->fetchrow_hashref()) {
    $rpta = $ref->{'cantidad'};
  }
  $sth->finish;
  return $rpta;
}

sub seguir_mascota {
  my($self, $mascota_id, $criador_id) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO seguidores (mascota_id, criador_id) VALUES (?,?)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $mascota_id);
  $sth->bind_param( 2, $criador_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub dejar_seguir_mascota {
  my($self, $mascota_id, $criador_id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM seguidores WHERE mascota_id = ? AND criador_id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $mascota_id);
  $sth->bind_param( 2, $criador_id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

1;
