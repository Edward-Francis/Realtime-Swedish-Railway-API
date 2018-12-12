use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('RSR');
$t->get_ok('/api/health')->status_is(200)->json_is({});

done_testing();
