#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Plack::Builder;

# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Config::App;
use Routes::Pais;
use Routes::Departamento;
use Routes::Provincia;

builder {
    enable 'Deflater';
    Config::App->to_app;
    mount '/'      => Config::App->to_app;
    mount '/pais'      => Routes::Pais->to_app;
    mount '/departamento'      => Routes::Departamento->to_app;
    mount '/provincia'      => Routes::Provincia->to_app;
}

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use Gestion::App;
use Plack::Builder;

builder {
    enable 'Deflater';
    Gestion::App->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Gestion::App;
use Gestion::App_admin;

use Plack::Builder;

builder {
    mount '/'      => Gestion::App->to_app;
    mount '/admin'      => Gestion::App_admin->to_app;
}

=end comment

=cut

