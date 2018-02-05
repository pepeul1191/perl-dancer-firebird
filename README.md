## Perl Dancer

Instalación de paquetes de CPANM

    $ sudo apt install cpanminus libdbd-firebird-perl
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

---

Fuentes:

+ http://blog.endpoint.com/2015/01/cleaner-redirection-in-perl-dancer.html
+ http://search.cpan.org/~xsawyerx/Dancer2-0.200002/lib/Dancer2/Manual/Deployment.pod
+ http://search.cpan.org/dist/Dancer/lib/Dancer/Deployment.pod
+ https://stackoverflow.com/questions/17144583/dbd-mysql-installed-but-still-error-install-drivermysql-failed-cant-locate