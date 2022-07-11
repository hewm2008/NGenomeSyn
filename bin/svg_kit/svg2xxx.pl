#!/usr/bin/perl

=head1 Name

svg2xxx.pl  --  convert SVG figure to other formats

=head1 Description

This program convert SVG files by invoking batik-rasterizer.jar, its advantage
is caculating the fiure pixel width and pixel height automatically.

The png format is a popular format which has excellent performance on compression
rate, while tiff is the standard format for high quality figure. For comman usage,
png is good enough. The ppi decides the resolution of printed figure, 96 is enough
for common usage, and 300 for high quality.

Note that when you use --width or --height to contrain the generated figure size,
one option is enough, the other parameter will be adjusted automatically. The spirit
of converting figures is to keep the ratio of width/height. 

When you just want to convert figure of the same size, and do not print it
on a paper, you needn't care adout --ppi, --width, and --height option.

=head1 Version

  Author: Fan Wei, fanw@genomics.org.cn
  Version: 1.0,  Date: 2007-9-24
  Note:

=head1 Usage
  
  svg2xxx.pl  [options]  <in_file|in_dir>  [out_dir] 
  --type <string>   set the result figure type, png, tiff, jpeg, pdf, default=png
  --ppi <int>       set the figure resolution, default = 300 ppi
  --width <int>     set the figure width, unit is centi-meter, default = not constrained
  --height <int>    set the figure height, unit is centi-meter, default = not constrained
  --verbose         output running progress information to screen  
  --help            output help information to screen  

=head1 Exmple
 
 perl ../svg_lib/svg2xxx.pl chr10.svg
 perl ../svg_lib/svg2xxx.pl map_figure.scheme2/
 perl ../svg_lib/svg2xxx.pl -ppi 96 -height 2 map_figure.scheme2/ map_figure.scheme2.height2.ppi96 

=cut

use strict;
use Getopt::Long;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname); 
use Data::Dumper;


##get options from command line into variables and set default values
my ($Type,$Ppi,$Width,$Height);
my ($Verbose,$Help);
GetOptions(
	"type:s"=>\$Type,
	"ppi:s"=>\$Ppi,
	"width:s"=>\$Width,
	"height:s"=>\$Height,
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
$Type ||= "png";
$Ppi ||= 300;

die `pod2text $0` if (@ARGV == 0 || $Help);

my $input = shift;
my $out_dir = shift;


my @files;  ## store all svg files
my $pixel_height = $Ppi / 2.54 * $Height if(defined $Height);
my $pixel_width = $Ppi / 2.54 * $Width if(defined $Width);

if ($Type eq "pdf") {
	$Type = "application/$Type";
}elsif($Type eq "jpeg"){
	$Type = "image/$Type -q 0.99";
}else{
	$Type = "image/$Type";
}

if (-f $input) {
	push @files, $input;
}
if (-d $input) {
	$input =~ s/\/$//;
	@files = glob("$input/*.svg");
}

mkdir($out_dir) if($out_dir);

foreach my $svg_file (@files) {
	
	##embed font glyph into svg files
	my $xxx_file = $1.".xxx" if($svg_file =~ /(.+?)\.svg$/);
	my $res_file = $1.".$Type" if($svg_file =~ /(.+?)\.svg$/);
	`perl $Bin/buildInFont.pl $svg_file x $xxx_file`;
	##warn "perl $Bin/buildInFont.pl $svg_file x $xxx_file\n";
	##convert svg to other formats
	my $rasterizer_cmd = "java -mx2G -jar $Bin/batik-1.7/batik-rasterizer.jar -m $Type -dpi $Ppi $xxx_file";
	my @arryStat=stat($svg_file);
	if ($arryStat[7] >  100000000)
	{
	    $rasterizer_cmd = "java -mx10G -jar $Bin/batik-1.7/batik-rasterizer.jar -m $Type -dpi $Ppi $xxx_file";
	}
	elsif  ($arryStat[7] >  50000000 )
	{
	    $rasterizer_cmd = "java -mx5G -jar $Bin/batik-1.7/batik-rasterizer.jar -m $Type -dpi $Ppi $xxx_file";
	}

	$rasterizer_cmd .= " -h $pixel_height" if(defined $Height);
	$rasterizer_cmd .= " -w $pixel_width" if(defined $Width);
	##warn $rasterizer_cmd;
	`$rasterizer_cmd`;
	
	`mv $res_file $out_dir` if($out_dir);
	`rm $xxx_file`;
}

####################################################
################### Sub Routines ###################
####################################################
