package RSR::Controller::Stations;

use Mojo::Base 'Mojolicious::Controller';


sub list {
    my $self = shift->openapi->valid_input or return;
    $self->render( openapi => $self->trafik_info->station_list );
}

1;
