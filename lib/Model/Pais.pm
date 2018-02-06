package Model::Pais;
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
  my $sth = $self->{_dbh}->prepare('SELECT id, nombre FROM paises;') 
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
  my($self, $nombre) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO paises (nombre) VALUES (?)') 
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub editar {
  my($self, $id, $nombre) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE paises SET nombre = ? WHERE id = ?') 
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub eliminar {
  my($self, $id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM paises WHERE id = ?') 
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

1;