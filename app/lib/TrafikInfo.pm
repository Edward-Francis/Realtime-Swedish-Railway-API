package TrafikInfo;

use Carp;
use Mojo::Base -base;

# ATTRIBUTES

has 'authentication_key' => sub {
    $ENV{AUTENTICATION_KEY} or croak 'Authentication key is required.';
};

has 'trafik_info_url' => sub {
    $ENV{TRAFIK_INFO_URL} or croak 'Trafik Info URL is required.';
};

1;
