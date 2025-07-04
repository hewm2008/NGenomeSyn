package SVG::DOM;
use strict;
use warnings;

use Scalar::Util qw/weaken/;

our $VERSION = '2.78';

# this module extends SVG::Element
package SVG::Element;

#-----------------
# sub getFirstChild

sub getFirstChild {
    my $self = shift;

    if ( my @children = $self->getChildren ) {
        return $children[0];
    }
    return;
}

#-----------------
# sub getChildIndex
# return the array index of this element in the parent
# or the passed list (if there is one).

sub getChildIndex {
    my ( $self, @children ) = @_;

    unless (@children) {
        my $parent = $self->getParent();
        @children = $parent->getChildren();
        return unless @children;
    }

    for my $index ( 0 .. $#children ) {
        return $index if $children[$index] == $self;
    }

    return;
}

#-----------------
# sub getChildAtIndex
# return the element at the specified index
# (the index can be negative)

sub getChildAtIndex {
    my ( $self, $index, @children ) = @_;

    unless (@children) {
        my $parent = $self->getParent();
        @children = $parent->getChildren();
        return unless @children;
    }

    return $children[$index];
}

#-----------------
# sub getNextSibling

sub getNextSibling {
    my $self = shift;

    if ( my $parent = $self->getParent ) {
        my @children = $parent->getChildren();
        my $index    = $self->getChildIndex(@children);
        if ( defined $index and scalar(@children) > $index ) {
            return $children[ $index + 1 ];
        }
    }

    return;
}

#-----------------
# sub getPreviousSibling

sub getPreviousSibling {
    my $self = shift;

    if ( my $parent = $self->getParent ) {
        my @children = $parent->getChildren();
        my $index    = $self->getChildIndex(@children);
        if ($index) {
            return $children[ $index - 1 ];
        }
    }

    return;
}

#-----------------
# sub getLastChild

sub getLastChild {
    my $self = shift;

    if ( my @children = $self->getChildren ) {
        return $children[-1];
    }

    return;
}

#-----------------
# sub getChildren

sub getChildren {
    my $self = shift;

    if ( $self->{-childs} ) {
        if (wantarray) {
            return @{ $self->{-childs} };
        }
        return $self->{-childs};
    }

    return;
}
*getChildElements = \&getChildren;
*getChildNodes    = \&getChildren;

#-----------------

sub hasChildren {
    my $self = shift;

    if ( exists $self->{-childs} ) {
        if ( scalar @{ $self->{-childs} } ) {
            return 1;
        }
    }

    return 0;
}
*hasChildElements = \&hasChildren;
*hasChildNodes    = \&hasChildren;

#-----------------
# sub getParent / getParentElement
# return the ref of the parent of the current node

sub getParent {
    my $self = shift;

    if ( $self->{-parent} ) {
        return $self->{-parent};
    }

    return;
}
*getParentElement = \&getParent;
*getParentNode    = \&getParent;

#-----------------
# sub getParents / getParentElements

sub getParents {
    my $self = shift;

    my $parent = $self->{-parent};
    return unless $parent;

    my @parents;
    while ($parent) {
        push @parents, $parent;
        $parent = $parent->{-parent};
    }

    return @parents;
}
*getParentElements = \&getParents;
*getParentNodes    = \&getParents;
*getAncestors      = \&getParents;

#-----------------
# sub isAncestor

sub isAncestor {
    my ( $self, $descendant ) = @_;

    my @parents = $descendant->getParents();
    foreach my $parent (@parents) {
        return 1 if $parent == $self;
    }

    return 0;
}

#-----------------
# sub isDescendant

sub isDescendant {
    my ( $self, $ancestor ) = @_;

    my @parents = $self->getParents();
    foreach my $parent (@parents) {
        return 1 if $parent == $ancestor;
    }

    return 0;
}

#-----------------
# sub getSiblings

sub getSiblings {
    my $self = shift;

    if ( my $parent = $self->getParent ) {
        return $parent->getChildren();
    }

    return;
}

#-----------------
# sub hasSiblings

sub hasSiblings {
    my $self = shift;

    if ( my $parent = $self->getParent ) {
        my $siblings = scalar( $parent->getChildren );
        return 1 if $siblings >= 2;
    }

    return;
}

#-----------------
# sub getElementName / getType

sub getElementName {
    my $self = shift;

    if ( exists $self->{-name} ) {
        return $self->{-name};
    }

    return;
}
*getType        = \&getElementName;
*getElementType = \&getElementName;
*getTagName     = \&getElementName;
*getTagType     = \&getElementName;
*getNodeName    = \&getElementName;
*getNodeType    = \&getElementName;

#-----------------
# sub getElements
# get all elements of the specified type
# if none is specified, get all elements in document.

sub getElements {
    my ( $self, $element ) = @_;

    return unless exists $self->{-docref};
    return unless exists $self->{-docref}->{-elist};

    my $elist = $self->{-docref}->{-elist};
    if ( defined $element ) {
        if ( exists $elist->{$element} ) {
            return wantarray ? @{ $elist->{$element} } : $elist->{$element};
        }
        return;
    }
    else {
        my @elements;
        foreach my $element_type ( keys %$elist ) {
            push @elements, @{ $elist->{$element_type} };
        }
        return wantarray ? @elements : \@elements;
    }
}

# forces the use of the second argument for element name
sub getElementsByName {
    return shift->getElements(shift);
}
*getElementsByType = \&getElementsByName;

#-----------------
sub getElementNames {
    my $self = shift;

    my @types = keys %{ $self->{-docref}->{-elist} };

    return wantarray ? @types : \@types;
}
*getElementTypes = \&getElementNames;

#-----------------
# sub getElementID

sub getElementID {
    my $self = shift;

    if ( exists $self->{id} ) {
        return $self->{id};
    }

    return;
}

#-----------------
# sub getElementByID / getElementbyID

sub getElementByID {
    my ( $self, $id ) = @_;

    return unless defined($id);
    my $idlist = $self->{-docref}->{-idlist};
    if ( exists $idlist->{$id} ) {
        return $idlist->{$id};
    }

    return;
}
*getElementbyID = \&getElementByID;

#-----------------
# sub getAttribute
# see also SVG::attrib()

sub getAttribute {
    my ( $self, $attr ) = @_;

    if ( exists $self->{$attr} ) {
        return $self->{$attr};
    }

    return;
}

#-----------------
# sub getAttributes

sub getAttributes {
    my $self = shift;

    my $out = {};
    foreach my $i ( keys %$self ) {
        $out->{$i} = $self->{$i} unless $i =~ /^-/;
    }

    return wantarray ? %{$out} : $out;
}

#-----------------
# sub setAttribute

sub setAttributes {
    my ( $self, $attr ) = @_;
    foreach my $i ( keys %$attr ) {
        $self->attrib( $i, $attr->{$i} );
    }
}

#-----------------
# sub setAttribute

sub setAttribute {
    my ( $self, $att, $val ) = @_;
    $self->attrib( $att, $val );
}

#-----------------
# sub getCDATA / getCdata / getData

sub getCDATA {
    my $self = shift;

    if ( exists $self->{-cdata} ) {
        return $self->{-cdata};
    }

    return;
}
*getCdata = \&getCDATA;
*getData  = \&getCDATA;

# ----------------
# 2005-12-30 - Martin Owens, apply greater DOM specification (write)
# http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/level-one-core.html

# ----------------
# sub document
sub document {
    my ($self) = @_;
    return $self->{-docref};
}

# DOM specified method names
*createElement   = \&tag;
*firstChild      = \&getFirstChild;
*lastChild       = \&getLastChild;
*previousSibling = \&getPreviousSibling;
*nextSibling     = \&getNextSibling;

# ----------------
# sub insertBefore
sub insertBefore {
    my ( $self, $newChild, $refChild ) = @_;
    return $self->appendElement($newChild) if not $refChild;
    my $index = $self->findChildIndex($refChild);
    return 0 if $index < 0;    # NO_FOUND_ERR
    return $self->insertAtIndex( $newChild, $index );
}
*insertChildBefore   = \&insertBefore;
*insertNodeBefore    = \&insertBefore;
*insertElementBefore = \&insertBefore;

# ----------------
# sub insertAfter
sub insertAfter {
    my ( $self, $newChild, $refChild ) = @_;
    return $self->appendElement($newChild) if not $refChild;
    my $index = $self->findChildIndex($refChild);
    return 0 if $index < 0;    # NO_FOUND_ERR
    return $self->insertAtIndex( $newChild, $index + 1 );
}
*insertChildAfter   = \&insertAfter;
*insertNodeAfter    = \&insertAfter;
*insertElementAfter = \&insertAfter;

# ----------------
# sub insertSiblingAfter (Not in W3C DOM)
sub insertSiblingAfter {
    my ( $self, $newChild ) = @_;
    return $self->getParent->insertAfter( $newChild, $self )
        if $self->getParent;
    return 0;
}

# ----------------
# sub insertSiblingBefore (Not in W3C DOM)
sub insertSiblingBefore {
    my ( $self, $newChild ) = @_;
    return $self->getParent->insertBefore( $newChild, $self )
        if $self->getParent;
    return 0;
}

# ----------------
# sub replaceChild
sub replaceChild {
    my ( $self, $newChild, $oldChild ) = @_;

    # Replace newChild if it is in this list of children already
    $self->removeChild($newChild) if $newChild->{-parent} eq $self;

    # We need the index of the node to replace
    my $index = $self->findChildIndex($oldChild);
    return 0 if ( $index < 0 );    # NOT_FOUND_ERR
                                   # Replace and bind new node with its family
    $self->removeChildAtIndex($index);
    $self->insertChildAtIndex($index);
    return $oldChild;
}
*replaceElement = \&replaceChild;
*replaceNode    = \&replaceChild;

# ----------------
# sub removeChild
sub removeChild {
    my ( $self, $oldChild ) = @_;
    my $index = $self->findChildIndex($oldChild);
    return 0 if ( $index < 0 );    # NOT_FOUND_ERR
    return $self->removeChildAtIndex($index);
}
*removeElement = \&removeChild;
*removeNode    = \&removeChild;

# ----------------
# sub appendChild
sub appendChild {
    my ( $self, $element ) = @_;
    my $index
        = ( defined $self->{-childs} && scalar @{ $self->{-childs} } ) || 0;
    $self->insertAtIndex( $element, $index );
    return 1;
}
*appendElement = \&appendChild;
*appendNode    = \&appendChild;

# ----------------
# sub cloneNode
sub cloneNode {
    my ( $self, $deep ) = @_;
    my $clone = new SVG::Element;
    foreach my $key ( keys( %{$self} ) ) {
        next if $key eq '-childs' or $key eq '-parent';
        if ( $key eq '-docref' ) {

          # need to forge a docref based on the docref of the template element
            foreach my $dockey ( keys( %{ $self->{-docref} } ) ) {
                next
                    if $dockey eq '-childs'
                    or $dockey eq '-parent'
                    or $dockey eq '-idlist'
                    or $dockey eq '-elist'
                    or $dockey eq '-document'
                    or $dockey eq '-docref';
                $clone->{-docref}->{$dockey} = $self->{-docref}->{$dockey};
            }
        }
        else {
            $clone->{$key} = $self->{$key};
        }
    }

    # We need to clone the children if deep is specified.
    if ($deep) {
        foreach my $child ( @{ $self->{-childs} } ) {
            my $childClone = $child->cloneNode($deep);
            $clone->appendChild($childClone);
        }
    }

    return $clone;
}
*cloneElement = \&cloneNode;

# ---------------------------------------
#    NONE DOM Supporting methodss

# ----------------
# sub findChildIndex
sub findChildIndex {
    my ( $self, $refChild ) = @_;

    my $index = 0;
    foreach my $child ( @{ $self->{-childs} } ) {
        if ( $child eq $refChild ) {
            return $index;    # Child found
        }
        $index++;
    }

    return -1;                # Child not found
}

# ---------------
# sub insertAtIndex
sub insertAtIndex {
    my ( $self, $newChild, $index ) = @_;

    # add child
    splice @{ $self->{-childs} }, $index, 0, $newChild;

    # update parent and document reference
    $newChild->{-docref} = $self->{-docref};
    weaken( $newChild->{-docref} );
    $newChild->{-parent} = $self;
    weaken( $newChild->{-parent} );

    # update ID and element list
    if ( defined( $newChild->{id} ) ) {
        $self->{-docref}->{-idlist}->{ $newChild->{id} } = $newChild;
    }
    $self->{-docref}->{-elist} = {}
        unless ( defined $self->{-docref}->{-elist} );
    $self->{-docref}->{-elist}->{ $newChild->{-name} } = []
        unless ( defined $self->{-docref}->{-elist}->{ $newChild->{-name} } );
    unshift @{ $self->{-docref}->{-elist}->{ $newChild->{-name} } },
        $newChild;

    return 1;
}
*insertChildAtIndex = \&insertAtIndex;

# ----------------
# sub removeChildAtIndex
sub removeChildAtIndex {
    my ( $self, $index ) = @_;

    # remove child
    my $oldChild = splice @{ $self->{-childs} }, $index, 1;
    if ( not @{ $self->{-childs} } ) {
        delete $self->{-childs};
    }

    # update parent and document reference
    $oldChild->{-docref} = undef;
    $oldChild->{-parent} = undef;

    # update ID and element list
    if ( defined( $oldChild->{id} )
        && exists $self->{-docref}->{-idlist}->{ $oldChild->{id} } )
    {
        delete $self->{-docref}->{-idlist}->{ $oldChild->{id} };
    }
    if ( exists $self->{-docref}->{-elist}->{ $oldChild->{-name} } ) {
        delete $self->{-docref}->{-elist}->{ $oldChild->{-name} };
    }

    return $oldChild;
}
*removeAtIndex = \&removeChildAtIndex;

#-------------------------------------------------------------------------------

=pod

=head1 NAME

SVG::DOM - A library of DOM (Document Object Model) methods for SVG objects.

=head1 SUMMARY

SVG::DOM provides a selection of methods for accessing and manipulating SVG
elements through DOM-like methods such as getElements, getChildren, getNextSibling
and so on.

=head1 SYNOPSIS

    my $svg=new SVG(id=>"svg_dom_synopsis", width=>"100", height=>"100");
    my %attributes=$svg->getAttributes;

    my $group=$svg->group(id=>"group_1");
    my $name=$group->getElementName;
    my $id=$group->getElementID;

    $group->circle(id=>"circle_1", cx=>20, cy=>20, r=>5, fill=>"red");
    my $rect=$group->rect(id=>"rect_1", x=>10, y=>10, width=>20, height=>30);
    my $width=$rect->getAttribute("width");

    my $has_children=$group->hasChildren();
    my @children=$group->getChildren();

    my $kid=$group->getFirstChild();
    do {
        print $kid->xmlify();
    } while ($kid=$kid->getNextSibling);

    my @ancestors=$rect->getParents();
    my $is_ancestor=$group->isAncestor($rect);
    my $is_descendant=$rect->isDescendant($svg);

    my @rectangles=$svg->getElements("rect");
    my $allelements_arrayref=$svg->getElements();

    $group->insertBefore($newChild,$rect);
    $group->insertAfter($newChild,$rect);
    $rect = $group->replaceChild($newChild,$rect);
    $group->removeChild($newChild);
    my $newRect = $rect->cloneNode($deep);

    ...and so on...

=head1 METHODS

=head2 @elements = $obj->getElements($element_name)

Return a list of all elements with the specified name (i.e. type) in the document. If
no element name is provided, returns a list of all elements in the document.
In scalar context returns an array reference.

=head2 @children = $obj->getChildren()

Return a list of all children defined on the current node, or undef if there are no children.
In scalar context returns an array reference.

Alias: getChildElements(), getChildNodes()

=head2 @children = $obj->hasChildren()

Return 1 if the current node has children, or 0 if there are no children.

Alias: hasChildElements, hasChildNodes()

=head2 $ref = $obj->getFirstChild()

Return the first child element of the current node, or undef if there are no children.

=head2 $ref = $obj->getLastChild()

Return the last child element of the current node, or undef if there are no children.

=head2 $ref = $obj->getSiblings()

Return a list of all children defined on the parent node, containing the current node.

=head2 $ref = $obj->getNextSibling()

Return the next child element of the parent node, or undef if this is the last child.

=head2 $ref = $obj->getPreviousSibling()

Return the previous child element of the parent node, or undef if this is the first child.

=head2 $index = $obj->getChildIndex()

Return the place of this element in the parent node's list of children, starting from 0.

=head2 $element = $obj->getChildAtIndex($index)

Returns the child element at the specified index in the parent node's list of children.

=head2 $ref = $obj->getParentElement()

Return the parent of the current node.

Alias: getParent()

=head2 @refs = $obj->getParentElements()

Return a list of the parents of the current node, starting from the immediate parent. The
last member of the list should be the document element.

Alias: getParents()

=head2 $name = $obj->getElementName()

Return a string containing the name (i.e. the type, not the ID) of an element.

Alias: getType(), getTagName(), getNodeName()

=head2 $ref = $svg->getElementByID($id)

Alias: getElementbyID()

Return a reference to the element which has ID $id, or undef if no element with this ID exists.

=head2 $id = $obj->getElementID()

Return a string containing the ID of the current node, or undef if it has no ID.

=head2 $ref = $obj->getAttributes()

Return a hash reference of attribute names and values for the current node.

=head2 $value = $obj->getAttribute($name);

Return the string value attribute value for an attribute of name $name.

=head2 $ref = $obj->setAttributes({name1=>$value1,name2=>undef,name3=>$value3})

Set a set of attributes. If $value is undef, deletes the attribute.

=head2 $value = $obj->setAttribute($name,$value);

Set attribute $name to $value. If $value is undef, deletes the attribute.

=head2 $cdata = $obj->getCDATA()

Return the canonical data (i.e. textual content) of the current node.

Alias: getCdata(), getData()

=head2 $boolean = $obj->isAncestor($element)

Returns 1 if the current node is an ancestor of the specified element, otherwise 0.

=head2 $boolean = $obj->isDescendant($element)

Returns 1 if the current node is a descendant of the specified element, otherwise 0.

=head2 $boolean = $obj->insertBefore( $element, $child );

Returns 1 if $element was successfully inserted before $child in $obj

=head2 $boolean = $obj->insertAfter( $element, $child );

Returns 1 if $element was successfully inserted after $child in $obj

=head2 $boolean = $obj->insertSiblingBefore( $element );

Returns 1 if $element was successfully inserted before $obj

=head2 $boolean = $obj->insertSiblingAfter( $element );

Returns 1 if $element was successfully inserted after $obj

=head2 $element = $obj->replaceChild( $element, $child );

Returns $child if $element successfully replaced $child in $obj

=head2 $element = $obj->removeChild( $child );

Returns $child if it was removed successfully from $obj

=head2 $element = $obj->cloneNode( $deep );

Returns a new $element clone of $obj, without parents or children. If deep is set to 1, all children are included recursively.

=head1 AUTHOR

Ronan Oger, ronan@roitsystems.com
Martin Owens, doctormo@postmaster.co.uk

=head1 SEE ALSO

perl(1), L<SVG>, L<SVG::XML>, L<SVG::Element>, L<SVG::Parser>

L<http://www.roitsystems.com/> ROIT Systems: Commercial SVG perl solutions
L<http://www.w3c.org/Graphics/SVG/> SVG at the W3C

=cut

1;
