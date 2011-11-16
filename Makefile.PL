use strict;
use warnings;

BEGIN { require 5.008; }
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Template::Mustache::Simple',
    ABSTRACT     => 'Simple Mustaches for nefariously Perlish disguise',
    VERSION_FROM => 'lib/Template/Mustache/Simple.pm',
    AUTHOR       => 'crashd <crashd@cpan.org>',
    META_MERGE   => {
        resources => {
            homepage   => '',
            repository => '',
            bugtracker => ''
        },
    },
    PREREQ_PM => {

        'Template::Mustache' => 'v0.5.1',

    },
    BUILD_REQUIRES => { 'Test::Most' => '0.25', },
);

