package Config::Database;
use DBI;
use utf8;

sub new {
  my $class = shift;
  my $driver   = 'mysql';
  my $database = 'gestion';
  my $dsn = 'dbi:'. $driver . ':db=' . $database;
  my $userid = 'root';
  my $password = '123';
  my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1, ib_enable_utf8 => 1 }) or die $DBI::errstr;
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