package Config::Database;
use DBI;
use utf8;

sub new {
  my $class = shift;
  my $driver   = 'Firebird';
  my $database = '/home/pepe/Documentos/firebird/gestion/gestion.fdb;ib_charset=UTF8';
  my $dsn = 'dbi:'. $driver . ':db=' . $database;
  my $userid = 'SYSDBA';
  my $password = '123';
  print("1 ++++++++++++++++++++++++++++++\n");
  print($dsn);
  print("\n2 ++++++++++++++++++++++++++++++\n");
  my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1, ib_enable_utf8 => 1 })
    or die $DBI::errstr;

  my $self = {
    _dbh => $dbh
  };

  bless $self, $class;
  return $self;
}

sub getConnection {
  my( $self ) = @_;
  return $self->{_dbh};
}
1;