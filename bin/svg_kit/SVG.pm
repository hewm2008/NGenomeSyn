package SVG;

use strict;
use warnings;

use SVG::XML;
use parent qw(SVG::Element SVG::Extension);
use Scalar::Util qw/weaken/;

our $VERSION = '2.78';

=pod

=encoding UTF-8

=head1 NAME

SVG - Perl extension for generating Scalable Vector Graphics (SVG) documents.

=head1 SYNOPSIS

    #!/usr/bin/perl
    use strict;
    use warnings;
    use SVG;

    # create an SVG object
    my $svg= SVG->new( width => 200, height => 200);

    # use explicit element constructor to generate a group element
    my $y = $svg->group(
        id => 'group_y',
        style => {
            stroke => 'red',
            fill   => 'green'
        },
    );

    # add a circle to the group
    $y->circle( cx => 100, cy => 100, r => 50, id => 'circle_in_group_y' );

    # or, use the generic 'tag' method to generate a group element by name
    my $z = $svg->tag('g',
                    id    => 'group_z',
                    style => {
                        stroke => 'rgb(100,200,50)',
                        fill   => 'rgb(10,100,150)'
                    }
                );

    # create and add a circle using the generic 'tag' method
    $z->tag('circle', cx => 50, cy => 50, r => 100, id => 'circle_in_group_z');

    # create an anchor on a rectangle within a group within the group z
    my $k = $z->anchor(
        id      => 'anchor_k',
        -href   => 'http://test.hackmare.com/',
        target => 'new_window_0'
    )->rectangle(
        x     => 20, y      => 50,
        width => 20, height => 30,
        rx    => 10, ry     => 5,
        id    => 'rect_k_in_anchor_k_in_group_z'
    );

    # now render the SVG object, implicitly use svg namespace
    print $svg->xmlify;

    # or render a child node of the SVG object without rendering the entire object
    print $k->xmlify; #renders the anchor $k above containing a rectangle, but does not
                      #render any of the ancestor nodes of $k


    # or, explicitly use svg namespace and generate a document with its own DTD
    print $svg->xmlify(-namespace=>'svg');

    # or, explicitly use svg namespace and generate an inline docunent
    print $svg->xmlify(
        -namespace => "svg",
        -pubid => "-//W3C//DTD SVG 1.0//EN",
        -inline   => 1
    );


See the other modules in this distribution:
L<SVG::DOM>,
L<SVG::XML>,
L<SVG::Element>,
L<SVG::Parser>,
L<SVG::Extension>

=head2 Converting SVG to PNG and other raster image formats

The B<convert> command of L<http://www.imagemagick.org/> (also via L<Image::Magick> ) can convert SVG files to PNG
and other formats.

L<Image::LibRSVG> can convert SVG to other format.

=head1 EXAMPLES

examples/circle.pl generates the following image:

  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
  <svg height="200" width="200" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <title >I am a title</title>
  <g id="group_y" style="fill: green; stroke: red">
  <circle cx="100" cy="100" id="circle_in_group_y" r="50" />
  <!-- This is a comment -->
  </g>
  </svg>

That you can either embed directly into HTML or can include it using:

   <object data="file.svg" type="image/svg+xml"></object>

=for HTML <p><img src="http://szabgab.com/img/SVG/circle.png" alt="SVG example circle" /></p>

(The image was converted to png using L<Image::LibRSVG>. See the svg2png.pl script in the examples directory.)

=for HTML <p><img src="http://perlmaven.com/img/svg/circle.svg" alt="SVG example circle" /></p>

See also the B<examples> directory in this distribution which contain several fully documented examples.

=head1 DESCRIPTION

SVG is a 100% Perl module which generates a nested data structure containing the
DOM representation of an SVG (Scalable Vector Graphics) image. Using SVG, you
can generate SVG objects, embed other SVG instances into it, access the DOM
object, create and access javascript, and generate SMIL animation content.

=head2 General Steps to generating an SVG document

Generating SVG is a simple three step process:

=over 4

=item 1 Construct a new SVG object with L<"new">.

=item 2 Call element constructors such as L<"circle"> and L<"path"> to create SVG elements.

=item 3 Render the SVG object into XML using the L<"xmlify"> method.

=back

The L<"xmlify"> method takes a number of optional arguments that control how SVG
renders the object into XML, and in particular determine whether a standalone
SVG document or an inline SVG document fragment is generated:

=head2 -standalone

A complete SVG document with its own associated DTD. A namespace for the SVG
elements may be optionally specified.

=head2 -inline

An inline SVG document fragment with no DTD that be embedded within other XML
content. As with standalone documents, an alternate namespace may be specified.

No XML content is generated until the third step is reached. Up until this
point, all constructed element definitions reside in a DOM-like data structure
from which they can be accessed and modified.

=head2 EXPORTS

None. However, SVG permits both options and additional element methods to be
specified in the import list. These options and elements are then available
for all SVG instances that are created with the L<"new"> constructor. For example,
to change the indent string to two spaces per level:

    use SVG (-indent => "  ");

With the exception of -auto, all options may also be specified to the L<"new">
constructor. The currently supported options and their default value are:

    # processing options
    -auto       => 0,       # permit arbitrary autoloading of all unrecognised elements
    -printerror => 1,       # print error messages to STDERR
    -raiseerror => 1,       # die on errors (implies -printerror)

    # rendering options
    -indent     => "\t",    # what to indent with
    -elsep      => "\n",    # element line (vertical) separator
                            #     (note that not all agents ignor trailing blanks)
    -nocredits  => 0,       # enable/disable credit note comment
    -namespace  => '',      # The root element's (and it's children's) namespace prefix

    # XML and Doctype declarations
    -inline     => 0,       # inline or stand alone
    -docroot    => 'svg',   # The document's root element
    -version    => '1.0',
    -extension  => '',
    -encoding   => 'UTF-8',
    -xml_svg    => 'http://www.w3.org/2000/svg',   # the svg xmlns attribute
    -xml_xlink  => 'http://www.w3.org/1999/xlink', # the svg tag xmlns:xlink attribute
    -standalone => 'yes',
    -pubid      => "-//W3C//DTD SVG 1.0//EN",      # formerly -identifier
    -sysid      => 'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd', # the system id

SVG also allows additional element generation methods to be specified in the
import list. For example to generate 'star' and 'planet' element methods:

    use SVG qw(star planet);

or:

    use SVG ("star","planet");

This will add 'star' to the list of elements supported by SVG.pm (but not of
course other SVG parsers...). Alternatively the '-auto' option will allow
any unknown method call to generate an element of the same name:

    use SVG (-auto => 1, "star", "planet");

Any elements specified explicitly (as 'star' and 'planet' are here) are
predeclared; other elements are defined as and when they are seen by Perl. Note
that enabling '-auto' effectively disables compile-time syntax checking for
valid method names.

    use SVG (
        -auto       => 0,
        -indent     => "  ",
        -raiseerror  => 0,
        -printerror => 1,
        "star", "planet", "moon"
    );

=head2 Default SVG tag

The Default SVG tag will generate the following XML:

  $svg = SVG->new;
  print $svg->xmlify;

Resulting XML snippet:

  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
  <svg height="100%" width="100%" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <!--
        Generated using the Perl SVG Module V2.50
          by Ronan Oger
        Info: http://www.roitsystems.com/
      -->

=head1 METHODS

SVG provides both explicit and generic element constructor methods. Explicit
generators are generally (with a few exceptions) named for the element they
generate. If a tag method is required for a tag containing hyphens, the method
name replaces the hyphen with an underscore. ie: to generate tag <column-heading id="new">
you would use method $svg->column_heading(id=>'new').


All element constructors take a hash of element attributes and options;
element attributes such as 'id' or 'border' are passed by name, while options for the
method (such as the type of an element that supports multiple alternate forms)
are passed preceded by a hyphen, e.g '-type'. Both types may be freely
intermixed; see the L<"fe"> method and code examples throughout the documentation
for more examples.

=head2 new (constructor)

$svg = SVG->new(%attributes)

Creates a new SVG object. Attributes of the document SVG element be passed as
an optional list of key value pairs. Additionally, SVG options (prefixed with
a hyphen) may be set on a per object basis:

    my $svg1 = SVG->new;

    my $svg2 = SVG->new(id => 'document_element');

    my $svg3 = SVG->new(
        -printerror => 1,
        -raiseerror => 0,
        -indent     => '  ',
        -docroot => 'svg', #default document root element (SVG specification assumes svg). Defaults to 'svg' if undefined
        -sysid      => 'abc', #optional system identifyer
        -pubid      => "-//W3C//DTD SVG 1.0//EN", #public identifyer default value is "-//W3C//DTD SVG 1.0//EN" if undefined
        -namespace => 'mysvg',
        -inline   => 1
        id          => 'document_element',
        width       => 300,
        height      => 200,
    );

B<SVG instance represents the document and not the C<E<lt>svgE<gt>> root element.>

Default SVG options may also be set in the import list. See L<"EXPORTS"> above
for more on the available options.

Furthermore, the following options:


    -version
    -encoding
    -standalone
    -namespace Defines the document or element level namespace. The order of assignment priority is element,document .
    -inline
    -identifier
    -nostub
    -dtd (standalone)

may also be set in xmlify, overriding any corresponding values set in the SVG->new declaration


=head2 xmlify (alias: to_xml render serialise serialize)

$string = $svg->xmlify(%attributes);

Returns xml representation of svg document.

B<XML Declaration>

    Name               Default Value
    -version           '1.0'
    -encoding          'UTF-8'
    -standalone        'yes'
    -namespace         'svg'                - namespace for elements
    -inline            '0' - If '1', then this is an inline document.
    -pubid             '-//W3C//DTD SVG 1.0//EN';
    -dtd (standalone)  'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd'


=head2 tag (alias: element)

$tag = $svg->tag($name, %attributes)

Generic element generator. Creates the element named $name with the attributes
specified in %attributes. This method is the basis of most of the explicit
element generators.

    my $tag = $svg->tag('g', transform=>'rotate(-45)');


=head2 anchor

$tag = $svg->anchor(%attributes)

Generate an anchor element. Anchors are put around objects to make them
'live' (i.e. clickable). It therefore requires a drawn object or group element
as a child.

=head3 optional anchor attributes

the following attributes are expected for anchor tags (any any tags which use -href links):

=head2 -href    required

=head2 -type    optional

=head2 -role    optional

=head2 -title   optional

=head2 -show    optional

=head2 -arcrole optional

=head2 -actuate optional

=head2 target   optional

For more information on the options, refer to the w3c XLink specification at
L<http://www.w3.org/TR/xlink/>

B<Example:>

    # generate an anchor
    $tag = $SVG->anchor(
         -href=>'http://here.com/some/simpler/SVG.SVG'
         -title => 'new window 2 example title',
         -actuate => 'onLoad',
         -show=> 'embed',

    );

for more information about the options above, refer to Link  section in the SVG recommendation: L<http://www.w3.org/TR/SVG11/linking.html#Links>

    # add a circle to the anchor. The circle can be clicked on.
    $tag->circle(cx => 10, cy => 10, r => 1);

    # more complex anchor with both URL and target
    $tag = $SVG->anchor(
          -href   => 'http://somewhere.org/some/other/page.html',
          target => 'new_window'
    );


    # generate an anchor
    $tag = $svg->anchor(
        -href=>'http://here.com/some/simpler/svg.svg'
    );
    # add a circle to the anchor. The circle can be clicked on.
    $tag->circle(cx => 10, cy => 10, r => 1);

    # more complex anchor with both URL and target
    $tag = $svg->anchor(
          -href   => 'http://somewhere.org/some/other/page.html',
          target => 'new_window'
    );

=head2 circle

$tag = $svg->circle(%attributes)

Draw a circle at (cx,cy) with radius r.

    my $tag = $svg->circle(cx => 4, cy => 2, r => 1);

=head2 ellipse

$tag = $svg->ellipse(%attributes)

Draw an ellipse at (cx,cy) with radii rx,ry.

    use SVG;

    # create an SVG object
    my $svg= SVG->new( width => 200, height => 200);

    my $tag = $svg->ellipse(
        cx => 10,
        cy => 10,
        rx => 5,
        ry => 7,
        id => 'ellipse',
        style => {
            'stroke'         => 'red',
            'fill'           => 'green',
            'stroke-width'   => '4',
            'stroke-opacity' => '0.5',
            'fill-opacity'   => '0.2',
        }
    );

See The B<example/ellipse.pl>

=for HTML <p><img src="http://perlmaven.com/img/svg/ellipse.svg" alt="SVG example ellipse" /></p>

=head2 rectangle (alias: rect)

$tag = $svg->rectangle(%attributes)

Draw a rectangle at (x,y) with width 'width' and height 'height' and side radii
'rx' and 'ry'.

    $tag = $svg->rectangle(
        x      => 10,
        y      => 20,
        width  => 4,
        height => 5,
        rx     => 5.2,
        ry     => 2.4,
        id     => 'rect_1'
    );

=head2 image

 $tag = $svg->image(%attributes)

Draw an image at (x,y) with width 'width' and height 'height' linked to image
resource '-href'. See also L<"use">.

    $tag = $svg->image(
        x       => 100,
        y       => 100,
        width   => 300,
        height  => 200,
        '-href' => "image.png", #may also embed SVG, e.g. "image.svg"
        id      => 'image_1'
    );

B<Output:>

    <image xlink:href="image.png" x="100" y="100" width="300" height="200"/>

=head2 use

$tag = $svg->use(%attributes)

Retrieve the content from an entity within an SVG document and apply it at
(x,y) with width 'width' and height 'height' linked to image resource '-href'.

    $tag = $svg->use(
        x       => 100,
        y       => 100,
        width   => 300,
        height  => 200,
        '-href' => "pic.svg#image_1",
        id      => 'image_1'
    );

B<Output:>

    <use xlink:href="pic.svg#image_1" x="100" y="100" width="300" height="200"/>

According to the SVG specification, the 'use' element in SVG can point to a
single element within an external SVG file.

=head2 polygon

$tag = $svg->polygon(%attributes)

Draw an n-sided polygon with vertices at points defined by a string of the form
'x1,y1,x2,y2,x3,y3,... xy,yn'. The L<"get_path"> method is provided as a
convenience to generate a suitable string from coordinate data.

    # a five-sided polygon
    my $xv = [0, 2, 4, 5, 1];
    my $yv = [0, 0, 2, 7, 5];

    my $points = $svg->get_path(
        x     =>  $xv,
        y     =>  $yv,
        -type =>'polygon'
    );

    my $poly = $svg->polygon(
        %$points,
        id    => 'pgon1',
        style => \%polygon_style
    );

SEE ALSO:

L<"polyline">, L<"path">, L<"get_path">.

=head2 polyline

$tag = $svg->polyline(%attributes)

Draw an n-point polyline with points defined by a string of the form
'x1,y1,x2,y2,x3,y3,... xy,yn'. The L<"get_path"> method is provided as a
convenience to generate a suitable string from coordinate data.

    # a 10-pointsaw-tooth pattern
    my $xv = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    my $yv = [0, 1, 0, 1, 0, 1, 0, 1, 0, 1];

    my $points = $svg->get_path(
        x       => $xv,
        y       => $yv,
        -type   => 'polyline',
        -closed => 'true' #specify that the polyline is closed.
    );

    my $tag = $svg->polyline (
        %$points,
        id    =>'pline_1',
        style => {
            'fill-opacity' => 0,
            'stroke'       => 'rgb(250,123,23)'
        }
    );

=head2 line

$tag = $svg->line(%attributes)

Draw a straight line between two points (x1,y1) and (x2,y2).

    my $tag = $svg->line(
        id => 'l1',
        x1 =>  0,
        y1 => 10,
        x2 => 10,
        y2 =>  0,
    );

To draw multiple connected lines, use L<"polyline">.

=head2 text

$text = $svg->text(%attributes)->cdata();

$text_path = $svg->text(-type=>'path');
$text_span = $text_path->text(-type=>'span')->cdata('A');
$text_span = $text_path->text(-type=>'span')->cdata('B');
$text_span = $text_path->text(-type=>'span')->cdata('C');

Define the container for a text string to be drawn in the image.

B<Input:>

    -type     = path type (path | polyline | polygon)
    -type     = text element type  (path | span | normal [default])

    my $text1 = $svg->text(
        id => 'l1',
        x  => 10,
        y  => 10
    )->cdata('hello, world');

    my $text2 = $svg->text(
        id     => 'l1',
        x      => 10,
        y      => 10,
        -cdata => 'hello, world',
    );

    my $text = $svg->text(
        id    => 'tp',
        x     => 10,
        y     => 10,
        -type => path,
    )
      ->text(id=>'ts' -type=>'span')
      ->cdata('hello, world');

SEE ALSO:

L<"desc">, L<"cdata">.

=head2 title

$tag = $svg->title(%attributes)

Generate the title of the image.

    my $tag = $svg->title(id=>'document-title')->cdata('This is the title');

=head2 desc

$tag = $svg->desc(%attributes)

Generate the description of the image.

    my $tag = $svg->desc(id=>'document-desc')->cdata('This is a description');

=head2 comment

$tag = $svg->comment(@comments)

Generate the description of the image.

    my $tag = $svg->comment('comment 1','comment 2','comment 3');

=head2 pi (Processing Instruction)

$tag = $svg->pi(@pi)

Generate a set of processing instructions

    my $tag = $svg->pi('instruction one','instruction two','instruction three');

    returns:
      <lt>?instruction one?<gt>
      <lt>?instruction two?<gt>
      <lt>?instruction three?<gt>

=head2 script

$tag = $svg->script(%attributes)

Generate a script container for dynamic (client-side) scripting using
ECMAscript, Javascript or other compatible scripting language.

    my $tag = $svg->script(-type=>"text/ecmascript");
    #or my $tag = $svg->script();
    #note that type ecmascript is not Mozilla compliant

    # populate the script tag with cdata
    # be careful to manage the javascript line ends.
    # Use qq{text} or q{text} as appropriate.
    # make sure to use the CAPITAL CDATA to poulate the script.
    $tag->CDATA(qq{
        function d() {
        //simple display function
          for(cnt = 0; cnt < d.length; cnt++)
            document.write(d[cnt]);//end for loop
        document.write("<BR>");//write a line break
        }
    });

=head2 path

$tag = $svg->path(%attributes)

Draw a path element. The path vertices may be provided as a parameter or
calculated using the L<"get_path"> method.

    # a 10-pointsaw-tooth pattern drawn with a path definition
    my $xv = [0,1,2,3,4,5,6,7,8,9];
    my $yv = [0,1,0,1,0,1,0,1,0,1];

    $points = $svg->get_path(
        x => $xv,
        y => $yv,
        -type   => 'path',
        -closed => 'true'  #specify that the polyline is closed
    );

    $tag = $svg->path(
        %$points,
        id    => 'pline_1',
        style => {
            'fill-opacity' => 0,
            'fill'   => 'green',
            'stroke' => 'rgb(250,123,23)'
        }
    );


SEE ALSO: L<"get_path">.

=head2 get_path

$path = $svg->get_path(%attributes)

Returns the text string of points correctly formatted to be incorporated into
the multi-point SVG drawing object definitions (path, polyline, polygon)

B<Input:> attributes including:

    -type     = path type (path | polyline | polygon)
    x         = reference to array of x coordinates
    y         = reference to array of y coordinates

B<Output:> a hash reference consisting of the following key-value pair:

    points    = the appropriate points-definition string
    -type     = path|polygon|polyline
    -relative = 1 (define relative position rather than absolute position)
    -closed   = 1 (close the curve - path and polygon only)

    #generate an open path definition for a path.
    my ($points,$p);
    $points = $svg->get_path(x=&gt\@x,y=&gt\@y,-relative=&gt1,-type=&gt'path');

    #add the path to the SVG document
    my $p = $svg->path(%$path, style=>\%style_definition);

    #generate an closed path definition for a a polyline.
    $points = $svg->get_path(
        x=>\@x,
        y=>\@y,
        -relative=>1,
        -type=>'polyline',
        -closed=>1
    ); # generate a closed path definition for a polyline

    # add the polyline to the SVG document
    $p = $svg->polyline(%$points, id=>'pline1');

B<Aliases:> get_path set_path


=head2 animate

$tag = $svg->animate(%attributes)

Generate an SMIL animation tag. This is allowed within any nonempty tag. Refer
to the W3C for detailed information on the subtleties of the animate SMIL
commands.

B<Inputs:> -method = Transform | Motion | Color

  my $an_ellipse = $svg->ellipse(
      cx     => 30,
      cy     => 150,
      rx     => 10,
      ry     => 10,
      id     => 'an_ellipse',
      stroke => 'rgb(130,220,70)',
      fill   =>'rgb(30,20,50)'
  );

  $an_ellipse-> animate(
      attributeName => "cx",
      values        => "20; 200; 20",
      dur           => "10s",
      repeatDur     => 'indefinite'
  );

  $an_ellipse-> animate(
      attributeName => "rx",
      values        => "10;30;20;100;50",
      dur           => "10s",
      repeatDur     => 'indefinite',
  );

  $an_ellipse-> animate(
      attributeName => "ry",
      values        => "30;50;10;20;70;150",
      dur           => "15s",
      repeatDur     => 'indefinite',
  );

  $an_ellipse-> animate(
      attributeName=>"rx",values=>"30;75;10;100;20;20;150",
      dur=>"20s", repeatDur=>'indefinite');

  $an_ellipse-> animate(
      attributeName=>"fill",values=>"red;green;blue;cyan;yellow",
      dur=>"5s", repeatDur=>'indefinite');

  $an_ellipse-> animate(
      attributeName=>"fill-opacity",values=>"0;1;0.5;0.75;1",
      dur=>"20s",repeatDur=>'indefinite');

  $an_ellipse-> animate(
      attributeName=>"stroke-width",values=>"1;3;2;10;5",
      dur=>"20s",repeatDur=>'indefinite');

=head2 group

$tag = $svg->group(%attributes)

Define a group of objects with common properties. Groups can have style,
animation, filters, transformations, and mouse actions assigned to them.

    $tag = $svg->group(
        id        => 'xvs000248',
        style     => {
            'font'      => [ qw( Arial Helvetica sans ) ],
            'font-size' => 10,
            'fill'      => 'red',
        },
        transform => 'rotate(-45)'
    );

=head2 defs

$tag = $svg->defs(%attributes)

define a definition segment. A Defs requires children when defined using SVG.pm

    $tag = $svg->defs(id  =>  'def_con_one',);

=head2 style

$svg->tag('style', %styledef);

Sets/Adds style-definition for the following objects being created.

Style definitions apply to an object and all its children for all properties for
which the value of the property is not redefined by the child.

  $tag = $SVG->style(%attributes)

Generate a style container for inline or xlink:href based styling instructions

    my $tag = $SVG->style(type=>"text/css");

    # Populate the style tag with cdata.
    # Be careful to manage the line ends.
    # Use qq{text}, where text is the script

    $tag1->CDATA(qq{
        rect     fill:red;stroke:green;
        circle   fill:red;stroke:orange;
        ellipse  fill:none;stroke:yellow;
        text     fill:black;stroke:none;
    });

    # Create a external CSS stylesheet reference
    my $tag2 = $SVG->style(type=>"text/css", -href="/resources/example.css");

=pod


=head2 mouseaction

$svg->mouseaction(%attributes)

Sets/Adds mouse action definitions for tag

=head2 attrib

  $svg->attrib($name, $value)

Sets/Adds attributes of an element.

Retrieve an attribute:

    $svg->attrib($name);

Set a scalar attribute:

    $SVG->attrib $name, $value

Set a list attribute:

    $SVG->attrib $name, \@value

Set a hash attribute (i.e. style definitions):

    $SVG->attrib $name, \%value

Remove an attribute:

    $svg->attrib($name,undef);

B<Aliases:> attr attribute

Sets/Replaces attributes for a tag.

=head2 cdata

$svg->cdata($text)

Sets cdata to $text. SVG.pm allows you to set cdata for any tag. If the tag is
meant to be an empty tag, SVG.pm will not complain, but the rendering agent will
fail. In the SVG DTD, cdata is generally only meant for adding text or script
content.

    $svg->text(
        style => {
            'font'      => 'Arial',
            'font-size' => 20
        })->cdata('SVG.pm is a perl module on CPAN!');

    my $text = $svg->text( style => { 'font' => 'Arial', 'font-size' => 20 } );
    $text->cdata('SVG.pm is a perl module on CPAN!');

B<Result:>

    <text style="font: Arial; font-size: 20">SVG.pm is a perl module on CPAN!</text>

SEE ALSO:

L<"CDATA">, L<"desc">, L<"title">, L<"text">, L<"script">.

=head2 cdata_noxmlesc

 $script = $svg->script();
 $script->cdata_noxmlesc($text);

Generates cdata content for text and similar tags which do not get xml-escaped.
In othe words, does not parse the content and inserts the exact string into the cdata location.

=head2 CDATA

 $script = $svg->script();
 $script->CDATA($text);

Generates a <![CDATA[ ... ]]> tag with the contents of $text rendered exactly as supplied. SVG.pm allows you to set cdata for any tag. If the tag is
meant to be an empty tag, SVG.pm will not complain, but the rendering agent will
fail. In the SVG DTD, cdata is generally only meant for adding text or script
content.

      my $text = qq{
        var SVGDoc;
        var groups = new Array();
        var last_group;

        /*****
        *
        *   init
        *
        *   Find this SVG's document element
        *   Define members of each group by id
        *
        *****/
        function init(e) {
            SVGDoc = e.getTarget().getOwnerDocument();
            append_group(1, 4, 6); // group 0
            append_group(5, 4, 3); // group 1
            append_group(2, 3);    // group 2
        }};
        $svg->script()->CDATA($text);


B<Result:>

    E<lt>script E<gt>
      <gt>![CDATA[
        var SVGDoc;
        var groups = new Array();
        var last_group;

        /*****
        *
        *   init
        *
        *   Find this SVG's document element
        *   Define members of each group by id
        *
        *****/
        function init(e) {
            SVGDoc = e.getTarget().getOwnerDocument();
            append_group(1, 4, 6); // group 0
            append_group(5, 4, 3); // group 1
            append_group(2, 3);    // group 2
        }
        ]]E<gt>

SEE ALSO: L<"cdata">, L<"script">.

=head2 xmlescp and xmlescape

$string = $svg->xmlescp($string)
$string = $svg->xmlesc($string)
$string = $svg->xmlescape($string)

SVG module does not xml-escape characters that are incompatible with the XML specification. B<xmlescp> and B<xmlescape> provides this functionality. It is a helper function which generates an XML-escaped string for reserved characters such as ampersand, open and close brackets, etcetera.

The behaviour of xmlesc is to apply the following transformation to the input string $s:

    $s=~s/&(?!#(x\w\w|\d+?);)/&amp;/g;
    $s=~s/>/&gt;/g;
    $s=~s/</&lt;/g;
    $s=~s/\"/&quot;/g;
    $s=~s/\'/&apos;/g;
    $s=~s/([\x00-\x08\x0b\x1f])/''/eg;
    $s=~s/([\200-\377])/'&#'.ord($1).';'/ge;


=head2 filter

$tag = $svg->filter(%attributes)

Generate a filter. Filter elements contain L<"fe"> filter sub-elements.

    my $filter = $svg->filter(
        filterUnits=>"objectBoundingBox",
        x=>"-10%",
        y=>"-10%",
        width=>"150%",
        height=>"150%",
        filterUnits=>'objectBoundingBox'
    );

    $filter->fe();

SEE ALSO: L<"fe">.

=head2 fe

$tag = $svg->fe(-type=>'type', %attributes)

Generate a filter sub-element. Must be a child of a L<"filter"> element.

    my $fe = $svg->fe(
        -type     => 'DiffuseLighting'  # required - element name omitting 'fe'
        id        => 'filter_1',
        style     => {
            'font'      => [ qw(Arial Helvetica sans) ],
            'font-size' => 10,
            'fill'      => 'red',
        },
        transform => 'rotate(-45)'
    );

Note that the following filter elements are currently supported:
Also note that the elelemts are defined in lower case in the module, but as of version 2.441, any case combination is allowed.


=head2 * feBlend

=head2 * feColorMatrix

=head2 * feComponentTransfer

=head2 * feComposite

=head2 * feConvolveMatrix

=head2 * feDiffuseLighting

=head2 * feDisplacementMap

=head2 * feDistantLight

=head2 * feFlood

=head2 * feFuncA

=head2 * feFuncB

=head2 * feFuncG

=head2 * feFuncR

=head2 * feGaussianBlur

=head2 * feImage

=head2 * feMerge

=head2 * feMergeNode

=head2 * feMorphology

=head2 * feOffset

=head2 * fePointLight

=head2 * feSpecularLighting

=head2 * feSpotLight

=head2 * feTile

=head2 * feTurbulence


SEE ALSO: L<"filter">.

=head2 pattern

$tag = $svg->pattern(%attributes)

Define a pattern for later reference by url.


    my $pattern = $svg->pattern(
        id     => "Argyle_1",
        width  => "50",
        height => "50",
        patternUnits        => "userSpaceOnUse",
        patternContentUnits => "userSpaceOnUse"
    );

=head2 set

$tag = $svg->set(%attributes)

Set a definition for an SVG object in one section, to be referenced in other
sections as needed.

    my $set = $svg->set(
        id     => "Argyle_1",
        width  => "50",
        height => "50",
        patternUnits        => "userSpaceOnUse",
        patternContentUnits => "userSpaceOnUse"
    );

=head2 stop

$tag = $svg->stop(%attributes)

Define a stop boundary for L<"gradient">

   my $pattern = $svg->stop(
       id     => "Argyle_1",
       width  => "50",
       height => "50",
       patternUnits        => "userSpaceOnUse",
       patternContentUnits => "userSpaceOnUse"
   );

=head2 gradient

$tag = $svg->gradient(%attributes)

Define a color gradient. Can be of type B<linear> or B<radial>

    my $gradient = $svg->gradient(
        -type => "linear",
        id    => "gradient_1"
    );

=head1 GENERIC ELEMENT METHODS

The following elements are generically supported by SVG:


=head2 * altGlyph

=head2 * altGlyphDef

=head2 * altGlyphItem

=head2 * clipPath

=head2 * color-profile

=head2 * cursor

=head2 * definition-src

=head2 * font-face-format

=head2 * font-face-name

=head2 * font-face-src

=head2 * font-face-url

=head2 * foreignObject

=head2 * glyph

=head2 * glyphRef

=head2 * hkern

=head2 * marker

=head2 * mask

=head2 * metadata

=head2 * missing-glyph

=head2 * mpath

=head2 * switch

=head2 * symbol

=head2 * tref

=head2 * view

=head2 * vkern

See e.g. L<"pattern"> for an example of the use of these methods.

=head1 METHODS IMPORTED BY SVG::DOM

The following L<SVG::DOM> elements are accessible through SVG:

=head2 * getChildren

=head2 * getFirstChild

=head2 * getNextChild

=head2 * getLastChild

=head2 * getParent

=head2 * getParentElement

=head2 * getSiblings

=head2 * getElementByID

=head2 * getElementID

=head2 * getElements

=head2 * getElementName

=head2 * getType

=head2 * getAttributes

=head2 * getAttribute

=head2 * setAttributes

=head2 * setAttribute

=head2 * insertBefore

=head2 * insertAfter

=head2 * insertSiblingBefore

=head2 * insertSiblingAfter

=head2 * replaceChild

=head2 * removeChild

=head2 * cloneNode


=cut

#-------------------------------------------------------------------------------

my %default_attrs = (

    # processing options
    -auto       => 0,    # permit arbitrary autoloads (only at import)
    -printerror => 1,    # print error messages to STDERR
    -raiseerror => 1,    # die on errors (implies -printerror)

    # rendering options
    -indent    => "\t",    # what to indent with
    -elsep     => "\n",    # element line (vertical) separator
    -nocredits => 0,       # enable/disable credit note comment
    -namespace =>
        '',    # The root element's (and it's children's) namespace prefix

    # XML and Doctype declarations
    -inline    => 0,                             # inline or stand alone
    -docroot   => 'svg',                         # The document's root element
    -version   => '1.0',
    -extension => '',
    -encoding  => 'UTF-8',
    -xml_svg   => 'http://www.w3.org/2000/svg',
    -xml_xlink => 'http://www.w3.org/1999/xlink',
    -standalone => 'yes',
    -pubid      => '-//W3C//DTD SVG 1.0//EN',    # formerly -identifier
    -sysid => 'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd',
);

sub import {
    my $package = shift;

    my $attr = undef;
    foreach (@_) {
        if ($attr) {
            $default_attrs{$attr} = $_;
            undef $attr;
        }
        elsif ( exists $default_attrs{$_} ) {
            $attr = $_;
        }
        else {
            /^-/ and die "Unknown attribute '$_' in import list\n";
            $SVG::Element::autosubs{$_}
                = 1;    # add to list of autoloadable tags
        }
    }

    # switch on AUTOLOADer, if asked.
    if ( $default_attrs{'-auto'} ) {
        *SVG::Element::AUTOLOAD = \&SVG::Element::autoload;
    }

    # predeclare any additional elements asked for by the user
    foreach my $sub ( keys %SVG::Element::autosubs ) {
        $SVG::Element::AUTOLOAD = ("SVG::Element::$sub");
        SVG::Element::autoload();
    }

    delete $default_attrs{-auto};    # -auto is only allowed here, not in new

    return ();
}

#-------------------------------------------------------------------------------

=pod

=head1 Methods

SVG provides both explicit and generic element constructor methods. Explicit
generators are generally (with a few exceptions) named for the element they
generate. If a tag method is required for a tag containing hyphens, the method
name replaces the hyphen with an underscore. ie: to generate tag <column-heading id="new">
you would use method $svg->column_heading(id=>'new').


All element constructors take a hash of element attributes and options;
element attributes such as 'id' or 'border' are passed by name, while options for the
method (such as the type of an element that supports multiple alternate forms)
are passed preceded by a hyphen, e.g '-type'. Both types may be freely
intermixed; see the L<"fe"> method and code examples throughout the documentation
for more examples.

=head2 new (constructor)

$svg = SVG->new(%attributes)

Creates a new SVG object. Attributes of the document SVG element be passed as
an optional list of key value pairs. Additionally, SVG options (prefixed with
a hyphen) may be set on a per object basis:

    my $svg1 = SVG->new;

    my $svg2 = SVG->new(id => 'document_element');

    my $svg3 = SVG->new(
        -printerror => 1,
        -raiseerror => 0,
        -indent     => '  ',
        -elsep      => "\n",  # element line (vertical) separator
        -docroot    => 'svg', # default document root element (SVG specification assumes svg). Defaults to 'svg' if undefined
        -xml_xlink  => 'http://www.w3.org/1999/xlink', # required by Mozilla's embedded SVG engine
        -sysid      => 'abc', # optional system identifier
        -pubid      => "-//W3C//DTD SVG 1.0//EN", # public identifier default value is "-//W3C//DTD SVG 1.0//EN" if undefined
        -namespace  => 'mysvg',
        -inline     => 1
        id          => 'document_element',
        width       => 300,
        height      => 200,
    );

Default SVG options may also be set in the import list. See L<"EXPORTS"> above
for more on the available options.

Furthermore, the following options:

    -version
    -encoding
    -standalone
    -namespace
    -inline
    -pubid (formerly -identifier)
    -sysid (standalone)

may also be set in xmlify, overriding any corresponding values set in the SVG->new declaration

=cut

#-------------------------------------------------------------------------------
#
# constructor for the SVG data model.
#
# the new constructor creates a new data object with a document tag at its base.
# this document tag then has either:
#     a child entry parent with its child svg generated (when -inline = 1)
# or
#     a child entry svg created.
#
# Because the new method returns the $self reference and not the
# latest child to be created, a hash key -document with the reference to the hash
# entry of its already-created child. hence the document object has a -document reference
# to parent or svg if inline is 1 or 0, and parent will have a -document entry
# pointing to the svg child.
#
# This way, the next tag constructor will descend the
# tree until it finds no more tags with -document, and will add
# the next tag object there.
# refer to the SVG::tag method

sub new {
    my ( $proto, %attrs ) = @_;

    my $class = ref $proto || $proto;
    my $self;

    # establish defaults for unspecified attributes
    foreach my $attr ( keys %default_attrs ) {
        $attrs{$attr} = $default_attrs{$attr} unless exists $attrs{$attr};
    }
    $self = $class->SUPER::new('document');
    if ( not $self->{-docref} ) {
        $self->{-docref} = $self;
        weaken( $self->{-docref} );
    }
    unless ( $attrs{-namespace} ) {
        $attrs{'xmlns'} = $attrs{'xmlns'} || $attrs{'-xml_svg'};
    }
    $attrs{'xmlns:xlink'}
        = $attrs{'xmlns:xlink'}
        || $attrs{'-xml_xlink'}
        || 'http://www.w3.org/1999/xlink';
    $attrs{'xmlns:svg'}
        = $attrs{'xmlns:svg'}
        || $attrs{'-xml_svg'}
        || 'http://www.w3.org/2000/svg';

    $self->{-level} = 0;
    $self->{$_} = $attrs{$_} foreach keys %default_attrs;

    # create SVG object according to nostub attribute
    my $svg;
    unless ( $attrs{-nostub} ) {
        $svg = $self->svg(%attrs);
        $self->{-document} = $svg;
        weaken( $self->{-document} );
    }

    # add -attributes to SVG object
    #    $self->{-elrefs}->{$self}->{name} = 'document';
    #    $self->{-elrefs}->{$self}->{id} = '';

    return $self;
}

#-------------------------------------------------------------------------------

=pod

=head2 xmlify  (alias: to_xml render serialize serialise )

$string = $svg->xmlify(%attributes);

Returns xml representation of svg document.

B<XML Declaration>

    Name               Default Value
    -version           '1.0'
    -encoding          'UTF-8'
    -standalone        'yes'
    -namespace         'svg' - namespace prefix for elements.
                               Can also be used in any element method to over-ride
                               the current namespace prefix. Make sure to have
                               declared the prefix before using it.
    -inline            '0' - If '1', then this is an inline document.
    -pubid             '-//W3C//DTD SVG 1.0//EN';
    -sysid             'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd'

=cut

sub xmlify {
    my ( $self, %attrs ) = @_;

    my ( $decl, $ns );

    my $credits = '';

    # Give the module and myself credit unless explicitly turned off
    unless ( $self->{-docref}->{-nocredits}
        or $self->{-docref}{-creditsinserted} )
    {
        $self->comment(
            "\n\tGenerated using the Perl SVG Module V$VERSION\n\tby Ronan Oger\n\tInfo: http://www.roitsystems.com/\n"
        );
        $self->{-docref}{-creditsinserted} = 1;
    }

    foreach my $key ( keys %attrs ) {
        next if $key !~ /^-/;
        $self->{$key} = $attrs{$key};
    }

    foreach my $key ( keys %$self ) {
        next if $key !~ /^-/;
        $attrs{$key} ||= $self->{$key};
    }

    return $self->SUPER::xmlify( $self->{-namespace} );
}

*render    = \&xmlify;
*to_xml    = \&xmlify;
*serialise = \&xmlify;
*serialize = \&xmlify;

=head2 perlify ()

return the perl code which generates the SVG document as it currently exists.

=cut

sub perlify {
    return shift->SUPER::perlify();
}

=head2 toperl ()

Alias for method perlify()

=cut

*toperl = \&perlify;

1;

=pod

=head1 AUTHOR

Ronan Oger, RO IT Systemms GmbH, cpan@roitsystems.com

=head1 MAINTAINER

L<Gabor Szabo|http://szabgab.com/>

=head1 CREDITS

I would like to thank the following people for contributing to this module with
patches, testing, suggestions, and other nice tidbits:

Peter Wainwright, Excellent ideas, beta-testing, writing SVG::Parser and much of SVG::DOM.
Fredo, http://www.penguin.at0.net/~fredo/ - provided example code and initial feedback for early SVG.pm versions and the idea of a simplified svg generator.
Adam Schneider,
Brial Pilpré,
Ian Hickson
Steve Lihn,
Allen Day
Martin Owens - SVG::DOM improvements in version 3.34

=head1 COPYRIGHT & LICENSE

Copyright 2001- Ronan Oger

The modules in the SVG distribution are distributed under the same license
as Perl itself. It is provided free of warranty and may be re-used freely.

=head1 ARTICLES

L<SVG using Perl|http://szabgab.com/svg-using-perl.html>

L<SVG - Scalable Vector Graphics with Perl|http://perlmaven.com/scalable-vector-graphics-with-perl>

L<Combining SVG and PSGI|http://perlmaven.com/combining-svg-and-psgi>

=head1 SEE ALSO

L<SVG::DOM>,
L<SVG::XML>,
L<SVG::Element>,
L<SVG::Parser>,
L<SVG::Extension>

For Commercial Perl/SVG development, refer to the following sites:
L<ROASP.com: Serverside SVG server|http://www.roitsystems.com/>,
L<ROIT Systems: Commercial SVG perl solutions|http://www.roitsystems.com/>,
L<SVG at the W3C|http://www.w3c.org/Graphics/SVG/>

=cut
