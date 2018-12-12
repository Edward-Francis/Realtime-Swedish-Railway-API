package RSR::Controller::Health;

use Mojo::Base 'Mojolicious::Controller';


=head1 NAME

RSR::Controller::Health

=head1 ENDPOINTS

=head2 healthcheck

Endpoint to check current status of the API. Returns an empty JSON object.

=cut

sub healthcheck {
    my $self = shift->openapi->valid_input or return;
    $self->render( openapi => {} );
}


1;
