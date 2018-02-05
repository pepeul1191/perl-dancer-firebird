## Perl Dancer

Instalación de paquetes de CPANM

    $ sudo apt-get install cpanminus libdbd-firebird-perl libmysqlclient-dev
    $ curl -L http://cpanmin.us | perl - --sudo Dancer2
    $ sudo cpanm Plack::Middleware::Deflater DBD::Firebird JSON JSON::Create JSON::XS Crypt::MCrypt Try::Tiny Plack::Loader::Shotgun Plack::Handler::Starman

Arrancar Dancer:

    $ plackup -r bin/app.psgi

Arrancar Dancer con autoreload luego de hacer cambios:

    $ plackup -L Shotgun bin/app.psgi


Arrancar en modo de producción con workers:

    $ plackup -E deployment -s Starman --workers=50 -p 5000 -a bin/app.psgi

Para imprimir variables:

    #print("\nA\n");print($url);print("\nB\n");
    #print("\n");print Dumper(%temp);print("\n");

### Migraciones

Ejecutar migración

    $ sequel -m path/to/migrations postgres://host/database
    $ sequel -m path/to/migrations sqlite://db/db_estaciones.db
    $ sequel -m path/to/migrations mysql://root:123@localhost/gestion

Ejecutar el 'down' de las migraciones de la última a la primera:

    $ sequel -m db/migrations -M 0 mysql://root:123@localhost/gestion

Ejecutar el 'up' de las migraciones hasta un versión especifica:

    $ sequel -m db/migrations -M #version mysql://root:123@localhost/gestion

Crear Vista de distrito/provincia/departamento

    >> CREATE VIEW "vw_distrito_provincia_departamento" AS select "DI"."id" AS "id",concat("DI"."nombre",', ',"PR"."nombre",', ',"DE"."nombre") AS "nombre" from (("tb_distrito" "DI" join "tb_provincia" "PR" on(("DI"."id_provincia" = "PR"."id"))) join "tb_departamento" "DE" on(("PR"."id_departamento" = "DE"."id"))) limit 2000;

Tipos de Datos de Columnas

+ :string=>String
+ :integer=>Integer
+ :date=>Date
+ :datetime=>[Time, DateTime].freeze, 
+ :time=>Sequel::SQLTime, 
+ :boolean=>[TrueClass, FalseClass].freeze, 
+ :float=>Float
+ :decimal=>BigDecimal
+ :blob=>Sequel::SQL::Blob

---

Fuentes:

+ http://blog.endpoint.com/2015/01/cleaner-redirection-in-perl-dancer.html
+ http://search.cpan.org/~xsawyerx/Dancer2-0.200002/lib/Dancer2/Manual/Deployment.pod
+ http://search.cpan.org/dist/Dancer/lib/Dancer/Deployment.pod
+ https://stackoverflow.com/questions/17144583/dbd-mysql-installed-but-still-error-install-drivermysql-failed-cant-locate