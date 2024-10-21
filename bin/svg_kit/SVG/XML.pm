package SVG::XML;
use strict;
use warnings;

our $VERSION = '2.78';

=pod

=head1 NAME

SVG::XML - Handle the XML generation bits for SVG.pm

=head1 AUTHOR

Ronan Oger, cpan@roitsystems.com

=head1 SEE ALSO

L<SVG>,
L<SVG::DOM>,
L<SVG::Element>,
L<SVG::Parser>,
L<SVG::Extension>

For Commercial Perl/SVG development, refer to the following sites:
L<ROASP.com: Serverside SVG server|http://www.roitsystems.com/>,
L<ROIT Systems: Commercial SVG perl solutions|http://www.roitsystems.com/>,
L<SVG at the W3C|http://www.w3c.org/Graphics/SVG/>

=cut

use Exporter;
use vars qw(@ISA @EXPORT);
@ISA = ('Exporter');

@EXPORT = qw(
    xmlesc
    xmlescape
    xmlescp
    cssstyle
    xmlattrib
    xmlcomment
    xmlpi
    xmltag
    xmltagopen
    xmltagclose
    xmltag_ln
    xmltagopen_ln
    xmltagclose_ln
    processtag
    xmldecl
    dtddecl
);

sub xmlescp {
    my ( $self, $s ) = @_;

    $s = '0' unless defined $s;
    $s = join( ', ', @{$s} ) if ( ref($s) eq 'ARRAY' );

    # Special XML entities are escaped
    $s =~ s/&(?!#(x\w\w|\d+?);)/&amp;/g;
    $s =~ s/>/&gt;/g;
    $s =~ s/</&lt;/g;
    $s =~ s/\"/&quot;/g;
    $s =~ s/\'/&apos;/g;

    # Backtick is just a regular XML citizen
    #$s=~s/\`/&apos;/g;

    # Invalid XML characters are removed, not just escaped: \x00-\x08\x0b\x1f
    # Tabs (\x09) and newlines (\x0a) are valid.
    while ( $s =~ s/([\x00-\x08\x0b\x1f])/''/e ) {
        my $char = q{'\\x} . sprintf( '%02X', ord($1) ) . q{'};
        $self->error( $char => 'This forbidden XML character was removed' );
    }

    # Per suggestion from Adam Schneider
    $s =~ s/([\200-\377])/'&#'.ord($1).';'/ge;

    return $s;
}

*xmlesc = \&xmlescp;

*xmlescape = \&xmlescp;

sub cssstyle {
    my %attrs = @_;
    return ( join( '; ', map { qq($_: ) . $attrs{$_} } sort keys(%attrs) ) );
}

# Per suggestion from Adam Schneider
sub xmlattrib {
    my %attrs = @_;
    return '' unless ( scalar( keys %attrs ) );
    return (
        ' '
            . join( ' ',
            map { qq($_=") . $attrs{$_} . q(") } sort keys(%attrs) )
    );
}

sub xmltag {
    my ( $name, $ns, %attrs ) = @_;
    $ns = $ns ? "$ns:" : '';
    my $at = xmlattrib(%attrs) || '';
    return qq(<$ns$name$at />);
}

sub xmltag_ln {
    my ( $name, $ns, %attrs ) = @_;
    return xmltag( $name, $ns, %attrs );
}

sub xmltagopen {
    my ( $name, $ns, %attrs ) = @_;
    $ns = $ns ? "$ns:" : '';
    my $at = xmlattrib(%attrs) || '';
    return qq(<$ns$name$at>);
}

sub xmltagopen_ln {
    my ( $name, $ns, %attrs ) = @_;
    return xmltagopen( $name, $ns, %attrs );
}

sub xmlcomment {
    my ( $self, $r_comment ) = @_;
    my $ind = $self->{-docref}->{-elsep}
        . $self->{-docref}->{-indent} x $self->{-docref}->{-level};
    return ( $ind . join( $ind, map {qq(<!-- $_ -->)} @$r_comment ) );
}

sub xmlpi {
    my ( $self, $r_pi ) = @_;
    my $ind = $self->{-docref}->{-elsep}
        . $self->{-docref}->{-indent} x $self->{-docref}->{-level};
    return ( join( $ind, map {qq(<?$_?>)} @$r_pi ) );
}

*processinginstruction = \&xmlpi;

sub xmltagclose {
    my ( $name, $ns ) = @_;
    $ns = $ns ? "$ns:" : '';
    return qq(</$ns$name>);
}

sub xmltagclose_ln {
    my ( $name, $ns ) = @_;
    return xmltagclose( $name, $ns );
}

sub dtddecl {
    my $self = shift;
    my $docroot = $self->{-docroot} || 'svg';
    my $id;

    if ( $self->{-pubid} ) {
        $id = 'PUBLIC "' . $self->{-pubid} . '"';
        $id .= ' "' . $self->{-sysid} . '"' if ( $self->{-sysid} );
    }
    elsif ( $self->{-sysid} ) {
        $id = 'SYSTEM "' . $self->{-sysid} . '"';
    }
    else {
        $id
            = 'PUBLIC "-//W3C//DTD SVG 1.0//EN"'
            . $self->{-docref}->{-elsep}
            . "\"$self->{-docref}->{-dtd}\"";
    }

    my $at = join( ' ', ( $docroot, $id ) );

    #>>>TBD: add internal() method to return this
    my $extension
        = ( exists $self->{-internal} )
        ? $self->{-internal}->render()
        : q{};
    if ( exists $self->{-extension} and $self->{-extension} ) {
        $extension
            .= $self->{-docref}{-elsep}
            . $self->{-extension}
            . $self->{-docref}{-elsep};
    }
    $extension = ' [' . $self->{-docref}{-elsep} . $extension . ']'
        if $extension;

    return qq[$self->{-docref}{-elsep}<!DOCTYPE $at$extension>];
}

sub xmldecl {
    my $self = shift;

    my $version    = $self->{-version}    || '1.0';
    my $encoding   = $self->{-encoding}   || 'UTF-8';
    my $standalone = $self->{-standalone} || 'yes';

    return
        qq{<?xml version="$version" encoding="$encoding" standalone="$standalone"?>};
}

#-------------------------------------------------------------------------------

1;
