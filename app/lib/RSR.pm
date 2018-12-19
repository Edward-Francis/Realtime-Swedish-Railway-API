package RSR;

use TrafikInfo ();
use Mojo::Base 'Mojolicious';

=head1 NAME

RSR

=head1 METHODS

=head2 startup

This method will run once at server start.

=cut

sub startup {
    my $self = shift;
    $self->plugin(
        OpenAPI => { spec => $self->static->file('api.yaml')->path } );

    # add helpers
    $self->helper( trafik_info => sub { return TrafikInfo->new });
}


1;
