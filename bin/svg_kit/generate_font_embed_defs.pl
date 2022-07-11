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



##get options from command line into variables and set default values
my ($Verbose,$Help);
GetOptions(
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
die `pod2text $0` if (@ARGV == 0 || $Help);

my $Font_dir = shift;

read_font($Font_dir);


####################################################
################### Sub Routines ###################
####################################################

sub read_font {
	my $font_dir = shift;
	
	print qq(<defs >\n);
	$font_dir =~ s/\/$//;
	foreach my $font_file (`ls $font_dir/*.svg`) {
		chomp $font_file;
		
		my $file_content;
		open IN,$font_file || die "fail $font_file;";
		while (<IN>) {
			$file_content .= $_;
		}
		close IN;

		$file_content =~ s/^.+?<defs >\s//s;
		$file_content =~ s/<\/defs>.+?$//s;
		
		print $file_content;
	}
	print qq(</defs>\n);

}

