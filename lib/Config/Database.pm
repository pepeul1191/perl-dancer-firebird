package Config::Database;
use Config::Constants;
use DBI;
use utf8;

sub new {
  my $class = shift;
  my $dbh = 0;
  if(%Config::Constants::Data{'ambiente'} eq 'produccion'){
    my $driver   = 'mysql'; 
    my $database = 'gestion';
    my $dsn = 'dbi:'. $driver . ':db=' . $database;
    my $userid = 'root';
    my $password = '123';
    $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1, ib_enable_utf8 => 1 }) or die $DBI::errstr;
    $dbh->{AutoCommit} = 0;  # enable transactions, if possible
    $dbh->{RaiseError} = 1;
  }else{
    my $driver   = "SQLite";
    my $database = "db/gestion.db";
    my $dsn = "DBI:$driver:dbname=$database";
    my $userid = "";
    my $password = "";
    $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
    $dbh->{AutoCommit} = 0;  # enable transactions, if possible
    $dbh->{RaiseError} = 1;
  }
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