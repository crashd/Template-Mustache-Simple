package Template::Mustache::Simple;

use strict; use warnings; use 5.10.0;
use version 0.77; our $VERSION = qv("v1.00_01");
use Cwd;
require Template::Mustache;
require Exporter;
require File::Spec;

our @ISA = qw/Exporter/;
our %EXPORT_TAGS = ( 'all' => [ qw/render render_file mk_loader/ ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw//;

sub new {
	my $class = shift;
	my $self = {
		path => getcwd(),
		extension => 'mustache',
		@_
	};
	return bless $self, $class;
}

sub read_file {
    my ($filename) = @_;
    return '' unless -f $filename;
    local *FILE;
    open FILE, $filename or die "Cannot read from file $filename!";
    sysread(FILE, my $data, -s FILE);
    close FILE;
    return $data;
}

sub mk_loader {
	my ($self, $path, $extension) = @_;
	$path		  ||= $self->{path};
	$extension	  ||= $self->{extension};
	return sub {
		my ($name) = @_;
		-f 
		return read_file(File::Spec->catfile($path, "$name.$extension"));
	};
}

sub render {
	my ($self, $tmpl, $tokens, $args) = @_;
	my $loader = $self->mk_loader(
		$args && $args->{path}, 
		$args && $args->{extension});
	return Template::Mustache->render($tmpl, $tokens, $loader);
}


sub render_file {
	my ($self, $name, $tokens, $args) = @_;
	my $loader = $self->mk_loader(
		$args && $args->{path}, 
		$args && $args->{extension});
	return Template::Mustache->render($loader->($name), $tokens, $loader);
}


	

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Template::Mustache::Simple - Simple Mustaches for nefariously Perlish disguise

=head1 SYNOPSIS

  use Template::Mustache::Simple; 
  
  \# configure a mustache template parser with optional params
  \#
  \# path       : base path where the templates and partials are stored,
  \#              defaults to current working directory
  \# 
  \# extension  : template extension, defaults to "mustache"
  \#
  my $mustache = Template::Mustache::Simple->new({
	path         => "~/htdocs/templates", \# default is current working dir
	extension    => "stache"              \# default is "mustache"
  }):

  \# render using string template, $tokens contains template variables
  my $disguise1 = $mustache->render($template, $hashref, $args);

  \# render from template name, will be prefixed by configured base path
  \# param, and suffixed with configured extensions, ie:
  \# 
  \#    "$path/$name.$extension"
  \#
  my $disguise2 = $mustache->render_file($name, $tokens, [ $args ]);


  \# with the optional $args hashref, the path and extension can be changed
  \# for this call only
  my $disguise3 = $mustache->render_file($name, $tokens, {path => "../tmpl"});

  \# passing an $args hashref works for string template rendering too. a
  \# path and/or extension passed in here will be used for loading partials
  my $disguise4 = $mustache->render($template, $tokens, {path => "../tmpl"});

=head1 DESCRIPTION

A tiny wrapper over Template::Mustache

=head2 EXPORT

None by default.

=head1 SEE ALSO

  Template::Mustache

=head1 AUTHOR

crashd

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by crashd

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
