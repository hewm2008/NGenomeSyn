#!/usr/bin/perl

=head1 Name

generate_font_width_hash.pl  -- generate font width hash for Font.pm

=head1 Description

useful information for each character:
$ref->{defs}{font}{font-face}{font-family}
$ref->{defs}{font}{glyph}[0]{unicode}
$ref->{defs}{font}{glyph}[0]{horiz-adv-x}
$ref->{defs}{font}{horiz-adv-x}

=head1 Version

  Author: Fan Wei, fanw@genomics.org.cn
  Version: 1.0,  Date: 2006-12-6
  Note:

=head1 Usage

  --verbose   output running progress information to screen  
  --help      output help information to screen  

=head1 Exmple



=cut

use strict;
use Getopt::Long;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname); 
use Data::Dumper;
use XML::Simple;


##get options from command line into variables and set default values
my ($Verbose,$Help);
GetOptions(
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
die `pod2text $0` if (@ARGV == 0 || $Help);

my $Font_dir = shift;

my %Font;

read_font($Font_dir, \%Font);

print Dumper \%Font;


####################################################
################### Sub Routines ###################
####################################################

sub read_font {
	my $font_dir = shift;
	my $font_p = shift;
	
	$font_dir =~ s/\/$//;
	foreach my $font_file (`ls $font_dir/*.svg`) {
		chomp $font_file;
		my $ref = XMLin($font_file);
		my $font_family = $ref->{defs}{font}{'font-face'}{'font-family'};
		my $font_width = $ref->{defs}{font}{'horiz-adv-x'};
		my $graph_p = $ref->{defs}{font}{glyph};
		foreach my $p (@$graph_p) {
			my $char = $p->{unicode}; 
			my $width = $p->{'horiz-adv-x'};
			$font_p->{$font_family}{$char} = (defined $width) ? $width : $font_width;
		}
	}

}

