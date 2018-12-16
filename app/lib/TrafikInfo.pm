package TrafikInfo;

# IMPORTS
use Carp;
use Mojo::UserAgent ();
use Mojo::Base -base;


# ATTRIBUTES

has 'authentication_key' => sub {
    $ENV{AUTENTICATION_KEY} or croak 'Authentication key is required.';
};

has 'trafik_info_url' => sub {
    $ENV{TRAFIK_INFO_URL} or croak 'Trafik Info URL is required.';
};


# PRIVATE METHODS

sub _make_request {
    my ( $self, $query ) = @_;

    # create payload
    my $login = sprintf '<LOGIN authenticationkey="%s"/>', $self->authentication_key;
    my $payload = sprintf '<REQUEST>%s%s</REQUEST>', $login, $query;

    # make request
    my $ua = Mojo::UserAgent->new;
    my $tx = $ua->post( $self->trafik_info_url => $payload );
    my $res = $tx->res;

    if ( $res->is_error ) {
        croak sprintf 'Request failed (%s): %s',
            $res->code, $res->body;
    }

    return $res->json;
}

1;
