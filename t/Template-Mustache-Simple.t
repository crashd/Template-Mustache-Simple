use strict;
use warnings;

use Test::Most tests => 4;
BEGIN { require_ok('Template::Mustache::Simple') };

my $tms = Template::Mustache::Simple->new();
isa_ok $tms, "Template::Mustache::Simple";

is ($tms->render("render:{{sample}}", { sample => 'success' }), 
  "render:success",
  'render("render:{{sample}}", { sample=>"success"})');

is ($tms->render_file("t/sample", { sample => 'success' }), 
	"render_file:success\n", # Template::Mustache adds a newline
	'render_file("t/sample", { sample=>"success"})');


