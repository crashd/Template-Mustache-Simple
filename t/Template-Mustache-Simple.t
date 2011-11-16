# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Template-Mustache-Simple.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::Most tests => 4;
BEGIN { 
	require_ok('Template::Mustache::Simple') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $tms = Template::Mustache::Simple->new();
isa_ok $tms, "Template::Mustache::Simple";

is ($tms->render("render:{{sample}}", { sample => 'success' }), 
  "render:success",
  'render_file("t/sample", { sample=>"success"})');

is ($tms->render_file("t/sample", { sample => 'success' }), 
	"render_file:success\n",
	'render_file("t/sample", { sample=>"success"})');


