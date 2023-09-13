package SVG::Element;

use strict;
use warnings;

our $VERSION = '2.78';

=pod

=encoding UTF-8

=head1 NAME

SVG::Element - Generate the element bits for SVG.pm

=head1 AUTHOR

Ronan Oger, cpan@roitsystems.com

=head1 SEE ALSO

For descreption of the methods see L<SVG>

L<http://www.roitsystems.com/> ROASP.com: Serverside SVG server
L<http://www.roitsystems.com/> ROIT Systems: Commercial SVG perl solutions
L<http://www.w3c.org/Graphics/SVG/> SVG at the W3C

=cut

use SVG::XML;
use SVG::DOM;
use SVG::Extension;
use Scalar::Util qw/weaken/;

our $AUTOLOAD;

my @autosubs = qw(
    animateMotion animateColor animateTransform circle ellipse rect polyline
    path polygon line title desc defs
    altGlyph altGlyphDef altGlyphItem clipPath color-profile
    cursor definition-src font-face-format font-face-name
    font-face-src font-face-url foreignObject glyph
    glyphRef hkern marker mask metadata missing-glyph
    mpath switch symbol textPath tref tspan view vkern marker textbox
    flowText style script
    image a g
);

our %autosubs = map { $_ => 1 } @autosubs;

#-------------------------------------------------------------------------------

sub new {
    my ( $proto, $name, %attrs ) = @_;
    my $class = ref($proto) || $proto;
    my $self = { -name => $name };
    foreach my $key ( keys %attrs ) {

        #handle escapes for special elements such as anchor
        if ( $key =~ /^-/ ) {
            if ( $key eq '-href' ) {
                $self->{'xlink:href'}    = $attrs{$key};
                $self->{'xlink:type'}    = $attrs{-type} if $attrs{-type};
                $self->{'xlink:role'}    = $attrs{-role} if $attrs{-role};
                $self->{'xlink:title'}   = $attrs{-title} if $attrs{-title};
                $self->{'xlink:show'}    = $attrs{-show} if $attrs{-show};
                $self->{'xlink:arcrole'} = $attrs{-arcrole}
                    if $attrs{-arcrole};
                $self->{'xlink:actuate'} = $attrs{-actuate}
                    if $attrs{-actuate};
                next;
            }
        }
        $self->{$key} = $attrs{$key};
    }

    return bless( $self, $class );
}

#-------------------------------------------------------------------------------

sub release {
    my $self = shift;

    foreach my $key ( keys( %{$self} ) ) {
        next if $key =~ /^-/;
        if ( ref( $self->{$key} ) =~ /^SVG/ ) {
            eval { $self->{$key}->release; };
        }
        delete( $self->{$key} );
    }

    return $self;
}

sub xmlify {
    my $self = shift;
    my $ns   = $self->{-namespace} || $self->{-docref}->{-namespace} || undef;
    my $xml  = '';

    #prep the attributes
    my %attrs;
    foreach my $k ( keys( %{$self} ) ) {
        if ( $k =~ /^-/ ) { next; }
        if ( ref( $self->{$k} ) eq 'ARRAY' ) {
            $attrs{$k} = join( ', ', @{ $self->{$k} } );
        }
        elsif ( ref( $self->{$k} ) eq 'HASH' ) {
            $attrs{$k} = cssstyle( %{ $self->{$k} } );
        }
        elsif ( ref( $self->{$k} ) eq '' ) {
            $attrs{$k} = $self->{$k};
        }
    }

    #prep the tag
    if ( $self->{-comment} ) {
        $xml .= $self->xmlcomment( $self->{-comment} );
        return $xml;
    }
    elsif ( $self->{-name} eq 'document' ) {

        #write the xml header
        $xml .= $self->xmldecl unless $self->{-inline};

        $xml .= $self->xmlpi( $self->{-document}->{-pi} )
            if $self->{-document}->{-pi};

        #and write the dtd if this is inline
        $xml .= $self->dtddecl unless $self->{-inline};

        #rest of the xml
        foreach my $k ( @{ $self->{-childs} } ) {
            if ( ref($k) =~ /^SVG::Element/ ) {
                $xml .= $k->xmlify($ns);
            }
        }

        return $xml;
    }
    my $is_cdataish
        = defined $self->{-cdata}
        || defined $self->{-CDATA}
        || defined $self->{-cdata_noxmlesc};
    if ( defined $self->{-childs} || $is_cdataish ) {
        $xml .= $self->{-docref}->{-elsep}
            unless ( $self->{-inline} && $self->{-name} );
        $xml .= $self->{-docref}->{-indent} x $self->{-docref}->{-level};
        $xml .= xmltagopen_ln( $self->{-name}, $ns, %attrs );
        $self->{-docref}->{-level}++;
        foreach my $k ( @{ $self->{-childs} } ) {
            if ( ref($k) =~ /^SVG::Element/ ) {
                $xml .= $k->xmlify($ns);
            }
        }

        if ( defined $self->{-cdata} ) {
            $xml .= $self->xmlescp( $self->{-cdata} );
        }
        if ( defined $self->{-CDATA} ) {
            $xml .= '<![CDATA[' . $self->{-CDATA} . ']]>';
        }
        if ( defined $self->{-cdata_noxmlesc} ) {
            $xml .= $self->{-cdata_noxmlesc};
        }

        #return without writing the tag out if it the document tag
        $self->{-docref}->{-level}--;
        unless ($is_cdataish) {
            $xml .= $self->{-docref}->{-elsep};
            $xml .= $self->{-docref}->{-indent} x $self->{-docref}->{-level};
        }
        $xml .= xmltagclose_ln( $self->{-name}, $ns );
    }
    else {
        $xml .= $self->{-docref}->{-elsep};
        $xml .= $self->{-docref}->{-indent} x $self->{-docref}->{-level};
        $xml .= xmltag_ln( $self->{-name}, $ns, %attrs );
    }

    #return the finished tag
    return $xml;
}

sub perlify {
    my $self = shift;
    my $code = '';

    #prep the attributes
    my %attrs;
    foreach my $k ( keys( %{$self} ) ) {
        next if $k =~ /^-/;
        if ( ref( $self->{$k} ) eq 'ARRAY' ) {
            $attrs{$k} = join( ', ', @{ $self->{$k} } );
        }
        elsif ( ref( $self->{$k} ) eq 'HASH' ) {
            $attrs{$k} = cssstyle( %{ $self->{$k} } );
        }
        elsif ( ref( $self->{$k} ) eq '' ) {
            $attrs{$k} = $self->{$k};
        }
    }

    if ( $self->{-comment} ) {
        $code .= "->comment($self->{-comment})";
        return $code;
    }
    elsif ( $self->{-pi} ) {
        $code .= "->pi($self->{-pi})";
        return $code;
    }
    elsif ( $self->{-name} eq 'document' ) {

        #write the xml header
        #$xml .= $self->xmldecl;
        #and write the dtd if this is inline
        #$xml .= $self->dtddecl unless $self->{-inline};
        foreach my $k ( @{ $self->{-childs} } ) {
            if ( ref($k) =~ /^SVG::Element/ ) {
                $code .= $k->perlify();
            }
        }
        return $code;
    }

    if ( defined $self->{-childs} ) {
        $code .= $self->{-docref}->{-elsep};
        $code .= $self->{-docref}->{-indent} x $self->{-docref}->{-level};
        $code
            .= $self->{-name} . '('
            . ( join ', ', ( map {"$_=>'$attrs{$_}'"} sort keys %attrs ) )
            . ')';
        if ( $self->{-cdata} ) {
            $code .= "->cdata($self->{-cdata})";
        }
        elsif ( $self->{-CDATA} ) {
            $code .= "->CDATA($self->{-CDATA})";
        }
        elsif ( $self->{-cdata_noxmlesc} ) {
            $code .= "->cdata_noxmlesc($self->{-cdata_noxmlesc})";
        }

        $self->{-docref}->{-level}++;
        foreach my $k ( @{ $self->{-childs} } ) {
            if ( ref($k) =~ /^SVG::Element/ ) {
                $code .= $k->perlify();
            }
        }
        $self->{-docref}->{-level}--;
    }
    else {
        $code .= $self->{-docref}->{-elsep};
        $code .= $self->{-docref}->{-indent} x $self->{-docref}->{-level};
        $code
            .= $self->{-name} . '('
            . ( join ', ', ( map {"$_=>'$attrs{$_}'"} sort keys %attrs ) )
            . ')';
    }

    return $code;
}
*toperl = \&perlify;

sub addchilds {
    my $self = shift;
    push @{ $self->{-childs} }, @_;
    return $self;
}

sub tag {
    my ( $self, $name, %attrs ) = @_;

    unless ( $self->{-parent} ) {

        #traverse down the tree until you find a non-document entry
        while ( $self->{-document} ) { $self = $self->{-document} }
    }
    my $tag = new SVG::Element( $name, %attrs );

    #define the element namespace
    $tag->{-namespace} = $attrs{-namespace} if ( $attrs{-namespace} );

    #add the tag to the document element
    $tag->{-docref} = $self->{-docref};
    weaken( $tag->{-docref} );

    #create the empty idlist hash ref unless it already exists
    $tag->{-docref}->{-idlist} = {}
        unless ( defined $tag->{-docref}->{-idlist} );

    #verify that the current id is unique. compain on exception
    #>>>TBD: add -strictids option to disable this check if desired
    if ( $tag->{id} ) {
        if ( $self->getElementByID( $tag->{id} ) ) {
            $self->error( $tag->{id} => 'ID already exists in document' );
            return;
        }
    }

    #add the current id reference to the document id hash
    if ( defined( $tag->{id} ) ) {
        $tag->{-docref}->{-idlist}->{ $tag->{id} } = $tag;
    }

    #create the empty idlist hash ref unless it already exists
    $tag->{-docref}->{-elist} = {}
        unless ( defined $tag->{-docref}->{-elist} );

    #create the empty idlist hash ref unless it already exists
    $tag->{-docref}->{-elist}->{ $tag->{-name} } = []
        unless ( defined $tag->{-docref}->{-elist}->{ $tag->{-name} } );

#add the current element ref to the corresponding element-hash array
# -elist is a hash of element names. key name is element, content is object ref.

    # add the reference to $tag to the array of refs that belong to the
    # key $tag->{-name}.
    unshift @{ $tag->{-docref}->{-elist}->{ $tag->{-name} } }, $tag;

    # attach element to the DOM of the document
    $tag->{-parent} = $self;
    weaken( $tag->{-parent} );
    $tag->{-parentname} = $self->{-name};
    $self->addchilds($tag);

    return ($tag);
}

*element = \&tag;

sub anchor {
    my ( $self, %attrs ) = @_;
    my $an = $self->tag( 'a', %attrs );

    #$an->{'xlink:href'}=$attrs{-href} if(defined $attrs{-href});
    #$an->{'target'}=$attrs{-target} if(defined $attrs{-target});
    return ($an);
}

sub svg {
    my ( $self, %attrs ) = @_;
    my $svg = $self->tag( 'svg', %attrs );
    $svg->{'height'} = '100%' unless ( $svg->{'height'} );
    $svg->{'width'}  = '100%' unless ( $svg->{'width'} );
    return ($svg);
}

sub rectangle {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'rect', %attrs );
}

#sub image {
#    my ($self,%attrs)=@_;
#    my $im=$self->tag('image',%attrs);
#    #$im->{'xlink:href'}=$attrs{-href} if(defined $attrs{-href});
#    return $im;
#}

sub use {
    my ( $self, %attrs ) = @_;
    my $u = $self->tag( 'use', %attrs );
    $u->{'xlink:href'} = $attrs{-href} if ( defined $attrs{-href} );
    return $u;
}

sub text {
    my ( $self, %attrs ) = @_;
    my $pre = '';
    $pre = $attrs{-type} || 'std';
    my %get_pre = (
        std  => 'text',
        path => 'textPath',
        span => 'tspan',
    );

    $pre = $get_pre{ lc($pre) };
    my $text = $self->tag( $pre, %attrs );
    $text->{'xlink:href'} = $attrs{-href}   if ( defined $attrs{-href} );
    $text->{'target'}     = $attrs{-target} if ( defined $attrs{-target} );
    return ($text);
}

sub comment {
    my ( $self, @text ) = @_;
    my $tag = $self->tag('comment');
    $tag->{-comment} = [@text];
    return $tag;
}

sub pi {
    my ( $self, @text ) = @_;
    return $self->{-document}->{-pi} unless scalar @text;
    my @pi;
    @pi = @{ $self->{-document}->{-pi} } if $self->{-document}->{-pi};
    unshift( @text, @pi ) if @pi;
    $self->{-document}->{-pi} = \@text;
    my $tag = $self->tag('pi');
    return $tag;
}

=pod

=head2 get_path

Documented as L<SVG/get_path>.

=cut

sub get_path {
    my ( $self, %attrs ) = @_;

    my $type = $attrs{-type} || 'path';
    my @x    = @{ $attrs{x} };
    my @y    = @{ $attrs{y} };
    my $points;

    # we need a path-like point string returned
    if ( lc($type) eq 'path' ) {
        my $char = 'M';
        $char = ' m '
            if ( defined $attrs{-relative} && lc( $attrs{-relative} ) );
        while (@x) {

            #scale each value
            my $x = shift @x;
            my $y = shift @y;

            #append the scaled value to the graph
            $points .= "$char $x $y ";
            $char = ' L ';
            $char = ' l '
                if ( defined $attrs{-relative}
                && lc( $attrs{-relative} ) );
        }
        $points .= ' z '
            if ( defined $attrs{-closed} && lc( $attrs{-closed} ) );
        my %out = ( d => $points );
        return \%out;
    }
    elsif ( lc($type) =~ /^poly/ ) {
        while (@x) {

            #scale each value
            my $x = shift @x;
            my $y = shift @y;

            #append the scaled value to the graph
            $points .= "$x,$y ";
        }
    }
    my %out = ( points => $points );
    return \%out;
}

sub make_path {
    my ( $self, %attrs ) = @_;
    return get_path(%attrs);
}

sub set_path {
    my ( $self, %attrs ) = @_;
    return get_path(%attrs);
}

sub animate {
    my ( $self, %attrs ) = @_;
    my %rtr    = %attrs;
    my $method = $rtr{'-method'};    # Set | Transform | Motion | Color

    $method = lc($method);

    # we do not want this to pollute the generation of the tag
    delete $rtr{-method};            #bug report from briac.

    my %animation_method = (
        transform => 'animateTransform',
        motion    => 'animateMotion',
        color     => 'animateColor',
        set       => 'set',
        attribute => 'animate',
    );

    my $name = $animation_method{$method} || 'animate';

    #list of legal entities for each of the 5 methods of animations
    my %legal = (
        animate => q{ begin dur  end  min  max  restart  repeatCount
              repeatDur  fill  attributeType attributeName additive
              accumulate calcMode  values  keyTimes  keySplines
              from  to  by },
        animateTransform => q{ begin dur  end  min  max  restart  repeatCount
              repeatDur  fill  additive  accumulate calcMode  values
              keyTimes  keySplines  from  to  by calcMode path keyPoints
              rotate origin type attributeName attributeType },
        animateMotion => q{ begin dur  end  min  max  restart  repeatCount
              repeatDur  fill  additive  accumulate calcMode  values
              to  by keyTimes keySplines  from  path  keyPoints
              rotate  origin },
        animateColor => q{ begin dur  end  min  max  restart  repeatCount
              repeatDur  fill  additive  accumulate calcMode  values
              keyTimes  keySplines  from  to  by },
        set => q{ begin dur  end  min  max  restart  repeatCount  repeatDur
              fill to },
    );

    foreach my $k ( keys %rtr ) {
        next if ( $k =~ /\-/ );

        if ( $legal{$name} !~ /\b$k\b/ ) {
            $self->error( "$name.$k" => 'Illegal animation command' );
        }
    }

    return $self->tag( $name, %rtr );
}

sub group {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'g', %attrs );
}

sub STYLE {
    my ( $self, %attrs ) = @_;

    $self->{style} = $self->{style} || {};
    foreach my $k ( keys %attrs ) {
        $self->{style}->{$k} = $attrs{$k};
    }

    return $self;
}

sub mouseaction {
    my ( $self, %attrs ) = @_;

    $self->{mouseaction} = $self->{mouseaction} || {};
    foreach my $k ( keys %attrs ) {
        $self->{mouseaction}->{$k} = $attrs{$k};
    }

    return $self;
}

sub attrib {
    my ( $self, $name, $val ) = @_;

    #verify that the current id is unique. compain on exception
    if ( $name eq 'id' ) {
        if ( $self->getElementByID($val) ) {
            $self->error( $val => 'ID already exists in document' );
            return;
        }
    }

    if ( not defined $val ) {
        if ( scalar(@_) == 2 ) {

            # two arguments only - retrieve
            return $self->{$name};
        }
        else {

            # 3rd argument is undef - delete
            delete $self->{$name};
        }
    }
    else {

        # 3 defined arguments - set
        $self->{$name} = $val;
    }

    return $self;
}
*attr      = \&attrib;
*attribute = \&attrib;

sub cdata {
    my ( $self, @txt ) = @_;
    $self->{-cdata} = join( ' ', @txt );
    return ($self);
}

sub CDATA {
    my ( $self, @txt ) = @_;
    $self->{-CDATA} = join( '\n', @txt );
    return ($self);
}

sub cdata_noxmlesc {
    my ( $self, @txt ) = @_;
    $self->{-cdata_noxmlesc} = join( '\n', @txt );
    return ($self);
}

sub filter {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'filter', %attrs );
}

sub fe {
    my ( $self, %attrs ) = @_;

    return 0 unless ( $attrs{'-type'} );
    my %allowed = (
        blend            => 'feBlend',
        colormatrix      => 'feColorMatrix',
        componenttrans   => 'feComponentTrans',
        Componenttrans   => 'feComponentTrans',
        composite        => 'feComposite',
        convolvematrix   => 'feConvolveMatrix',
        diffuselighting  => 'feDiffuseLighting',
        displacementmap  => 'feDisplacementMap',
        distantlight     => 'feDistantLight',
        flood            => 'feFlood',
        funca            => 'feFuncA',
        funcb            => 'feFuncB',
        funcg            => 'feFuncG',
        funcr            => 'feFuncR',
        gaussianblur     => 'feGaussianBlur',
        image            => 'feImage',
        merge            => 'feMerge',
        mergenode        => 'feMergeNode',
        morphology       => 'feMorphology',
        offset           => 'feOffset',
        pointlight       => 'fePointLight',
        specularlighting => 'feSpecularLighting',
        spotlight        => 'feSpotLight',
        tile             => 'feTile',
        turbulence       => 'feTurbulence',
    );

    my $key = lc( $attrs{'-type'} );
    my $fe_name = $allowed{ lc($key) } || 'error:illegal_filter_element';
    delete $attrs{'-type'};

    return $self->tag( $fe_name, %attrs );
}

sub pattern {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'pattern', %attrs );
}

sub set {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'set', %attrs );
}

sub stop {
    my ( $self, %attrs ) = @_;
    return $self->tag( 'stop', %attrs );
}

sub gradient {
    my ( $self, %attrs ) = @_;

    my $type = $attrs{'-type'} || 'linear';
    unless ( $type =~ /^(linear|radial)$/ ) {
        $type = 'linear';
    }
    delete $attrs{'-type'};

    return $self->tag( $type . 'Gradient', %attrs );
}

#-------------------------------------------------------------------------------
# Internal methods

sub error {
    my ( $self, $command, $error ) = @_;

    if ( $self->{-docref}->{-raiseerror} ) {
        die "$command: $error\n";
    }
    elsif ( $self->{-docref}->{-printerror} ) {
        print STDERR "$command: $error\n";
    }

    $self->{errors}{$command} = $error;
}

# This AUTOLOAD method is activated when '-auto' is passed to SVG.pm
sub autoload {
    my $self = shift;
    my ( $package, $sub ) = ( $AUTOLOAD =~ /(.*)::([^:]+)$/ );

    if ( $sub eq 'DESTROY' ) {
        return $self->release();
    }
    else {

        # the import routine may call us with a tag name involving '-'s
        my $tag = $sub;
        $sub =~ tr/-/_/;

      # N.B.: The \ on \@_ makes sure that the incoming arguments are
      # used and not the ones passed when the subroutine was created.
      # eval "sub $package\:\:$sub (\$;\@) { return shift->tag('$tag',\@_) }";
      #per rt.perl.org comment by slaven.

        if ( !$package->can($sub) ) {
            ## no critic (TestingAndDebugging::ProhibitNoStrict)
            no strict 'refs';
            *{ $package . '::' . $sub }
                = sub { return shift->tag( $tag, @_ ) };
        }
        return $self->$sub(@_) if $self;
    }
}

#-------------------------------------------------------------------------------
# GD Routines

sub colorAllocate {
    my ( $self, $red, $green, $blue ) = @_;
    return 'rgb(' . int($red) . ',' . int($green) . ',' . int($blue) . ')';
}

#-------------------------------------------------------------------------------

1;
