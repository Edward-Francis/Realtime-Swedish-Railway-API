package TrafikInfo;

# IMPORTS
use Carp;
use Mojo::UserAgent ();
use Mojo::Base -base;


# ATTRIBUTES

has 'authentication_key' => sub {
    $ENV{TRAFIK_INFO_AUTH_KEY} or croak 'Trafik Info Auth key is required.';
};

has 'trafik_info_url' => sub {
    $ENV{TRAFIK_INFO_URL} or croak 'Trafik Info URL is required.';
};


# METHODS


sub station_list {
    my $self = $_[0];

    my $response = $self->_make_request(
        '<QUERY objecttype="TrainStation">
            <FILTER><EQ name="Advertised" value="true"/></FILTER>
            <INCLUDE>AdvertisedLocationName</INCLUDE>
            <INCLUDE>AdvertisedShortLocationName</INCLUDE>
            <INCLUDE>CountryCode</INCLUDE>
            <INCLUDE>LocationSignature</INCLUDE>
        </QUERY>'
    );

    my @stations = map {
        {
            name         => $_->{AdvertisedLocationName},
            short_name   => $_->{AdvertisedShortLocationName},
            country_code => $_->{CountryCode},
            code         => $_->{LocationSignature},
        }
    } @{$response->{RESPONSE}->{RESULT}->[0]->{TrainStation}};

    return \@stations;
}


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
