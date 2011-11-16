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
our $VERSION = '0.01';

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
	my ($self, $args) = @_;
	my $path = $args->{path} || $self->{path};
	my $ext = $args->{extension} || $self->{extension};
	return sub {
		my ($name) = @_;
		-f 
		return read_file(File::Spec->catfile($path, "$name.$ext"));
	};
}

sub render {
	my ($self, $tmpl, $tokens, $args) = @_;
	$args ||= {};
	my $cfg = { %$self, %$args };
	return Template::Mustache->render($tmpl, $tokens, mk_loader($args));
}


sub render_file {
	my ($self, $name, $tokens, $args) = @_;
	my $loader = $self->mk_loader($args);
	return Template::Mustache->render($loader->($name), $tokens, $loader);
}


	

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Template::Mustache::Simple - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Template::Mustache::Simple;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Template::Mustache::Simple, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>melo@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
