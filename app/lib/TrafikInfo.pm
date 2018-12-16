package TrafikInfo;

use Carp;
use Mojo::Base -base;

# ATTRIBUTES

has 'authentication_key' => sub {
    $ENV{AUTENTICATION_KEY} or croak 'Authentication key is required.';
};


1;
