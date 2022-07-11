#!/usr/bin/perl -w
use strict;
use lib "/hwfssz4/BC_PUB/Software/03.Soft_ALL/PerlInfo/lib/perl5/";
use Getopt::Long;
use FindBin qw($Bin $RealBin);
use Data::Dumper;


sub  usage2
{
	print STDERR <<USAGE;

	Version:1.35         hewm2008\@gmail.com

	Usage: GetTwoGenomeSyn  -InGenomeA RefA.fa -InGenomeB RefB.fa -OutPrefix Out\n

		Options

		-InGenomeA      <s> : InPut Ref AA seq fa
		-InGenomeB      <s> : InPut Ref BB seq fa
		-OutPrefix      <s> : OutPut file prefix 

		-MinLenA        <s> : The min length of seq for RefA
		-MinLenB        <s> : The min length of seq for RefB

		-MinAlgLen      <s> : Set the minimum alignment length [5000]
		-BinDir         <s> : The Dir of minimap2/mummer Bin Dir[\$PATH]
		-MappingBin     <s> : minimap2 or mummer to use for mapping[mummer]
		-NumThreads     <n> : number of threads [6]

		-help               : Show more help with *Manual.pdf

USAGE
}

sub  usage
{
	print STDERR <<USAGE;

	Version:1.35         hewm2008\@gmail.com

	Usage: GetTwoGenomeSyn  -InGenomeA RefA.fa -InGenomeB RefB.fa -OutPrefix Out\n

		Options

		-InGenomeA      <s> : InPut Ref AA seq fa
		-InGenomeB      <s> : InPut Ref BB seq fa
		-OutPrefix      <s> : OutPut file prefix 

		-MinLenA        <s> : The min length of seq for RefA[5000000]
		-MinLenB        <s> : The min length of seq for RefB[5000000]

		-MinAlgLen      <s> : Set the minimum alignment length [5000]
		-BinDir         <s> : The Dir of minimap2/mummer Bin Dir[\$PATH]
		-MappingBin     <s> : minimap2 or mummer to use for mapping[minimap2]

		-help               : Show more help

USAGE
}

sub  Paf2Syn 
{
	my $InPutFile=shift;
	my $MinAlgLen=shift;
	my $OutPreFile=shift;
	open (CS,"$InPutFile") || die "input file can't open $!";
	open (OUTSYN,">$OutPreFile") || die "input file can't open $!";
	while(<CS>)
	{
		chomp ;
		my @inf=split ;
		next if  ($inf[9]<$MinAlgLen);
		if ($inf[4] eq "-")
		{
			print OUTSYN "$inf[0]\t$inf[2]\t$inf[3]\t$inf[5]\t$inf[8]\t$inf[7]\n";
		}
		else
		{
			print OUTSYN "$inf[0]\t$inf[2]\t$inf[3]\t$inf[5]\t$inf[7]\t$inf[8]\n";
		}
	}
	close OUTSYN;
	close CS;
}

sub  Coords2Syn
{
	my $coords=shift;
	my $syn=shift;

	open (CS,"$coords") || die "input file can't open $!";
	open (OUTSYN,">$syn") || die "input file can't open $!";
	<CS>;<CS>;<CS>;<CS>;<CS>;
	while(<CS>)
	{
		chomp ;
		my @inf=split ;
		next if  ($inf[6]<90);
		print OUTSYN "$inf[-2]\t$inf[0]\t$inf[1]\t$inf[-1]\t$inf[3]\t$inf[4]\n";
	}
	close OUTSYN;
	close CS;
}

if($#ARGV<0)
{
	usage ;exit(1) ;
}

if ($ARGV[0] eq "Paf2Syn")
{
	Paf2Syn($ARGV[1],$ARGV[2],$ARGV[3]);
	exit(0);
}

if ($ARGV[0] eq "Coords2Syn")
{
	Coords2Syn($ARGV[1],$ARGV[2]);
	exit(0);
}


my $InGenomeA;
my $InGenomeB;
my $help;
my $OutPrefix;
my $MinLenA;
my $MinLenB;
my $BinDir;
my $MinAlgLen;
my $MappingSoft="mummer";
my $NumThreads=6;

GetOptions(
	"InGenomeA:s"=>\$InGenomeA,
	"InGenomeB:s"=>\$InGenomeB,
	"OutPrefix:s"=>\$OutPrefix,
	"MinLenA:s"=>\$MinLenA,
	"MinLenB:s"=>\$MinLenB,
	"BinDir:s"=>\$BinDir,
	"MinAlgLen:s"=>\$MinAlgLen,
	"MappingBin:s"=>\$MappingSoft,
	"NumThreads:s"=>\$NumThreads,
	"help"=>\$help,
);


#############swimming in the sky and flying in the sea #########

if (  defined($help)  )
{
	usage2 ;
	exit(1) ;
}
if ( (!defined($InGenomeA))  || (!defined($InGenomeB))   ||  (!defined($OutPrefix)) )
{
	usage ;
	print "\t\tMust Para [-InGenomeA]  or [-InGenomeB] or [-OutPrefix] must be in \n\n";
	exit(1) ;
}

$MinLenA||=5000000;
$MinLenB||=5000000;
$MinAlgLen||=5000;
######################swimming in the sky and flying in the sea ########################

my $nucmer="/usr/bin/nucmer";
my $deltaFilter="/usr/bin/delta-filter";
my $showcoords="/usr/bin/show-coords";
my $minimap2="/usr/bin/minimap2";

if (($MappingSoft eq "mummer")  or ($MappingSoft eq "nucmer"))
{
# mummer-4.0.0/bin/nucmer
# mummer-4.0.0/bin/delta-filter
# mummer-4.0.0/bin/show-coords
	if  ( !(-e $nucmer) )
	{
		$nucmer=`which nucmer  2> /dev/null `;chomp $nucmer;
	}
	if  ( !(-e $deltaFilter) )
	{
		$deltaFilter=`which delta-filter  2> /dev/null `;chomp $deltaFilter;
	}

	if  ( !(-e $showcoords) )
	{
		$showcoords=`which show-coords  2> /dev/null `;chomp $showcoords;
	}

	if (defined $BinDir)
	{
		my $tmp="$BinDir/nucmer";
		if (-e $tmp) {$nucmer=$tmp;}

		$tmp="$BinDir/delta-filter";
		if (-e $tmp) {$deltaFilter=$tmp;}

		$tmp="$BinDir/show-coords";
		if (-e $tmp) {$showcoords=$tmp;}
	}

	if  ( !(-e $showcoords) )
	{
		print "\tCan't find the  mummer [show-coords] at \$PATH or \$BinDir\n";
		print "\tplease Check at it\n";exit;
	}

	if  ( !(-e $deltaFilter) )
	{
		print "\tCan't find the  mummer [delta-Filter] at \$PATH or \$BinDir\n";
		print "\tplease Check at it\n";exit;
	}
	if  ( !(-e $nucmer) )
	{
		print "\tCan't find the  mummer [nucmer] at \$PATH or \$BinDir\n";
		print "\tplease Check at it\n";exit;
	}

	my $NumVer=`$nucmer   -V `;  chomp $NumVer ;
	my @ccc=split /\./,$NumVer;
	if ($ccc[0] <4 )
	{
		print "found the $nucmer version is $NumVer < 4.0 , we need the 4.0\n";
		print "\tplease Check at it\n";exit;
	}

}
else
{
	if  ( !(-e $minimap2) )
	{
		$minimap2=`which minimap2  2> /dev/null `;chomp $minimap2;
	}

	if (defined $BinDir)
	{
		my $tmp="$BinDir/minimap2";
		if (-e $tmp) {$minimap2=$tmp;}
	}

	if  ( !(-e $minimap2) )
	{
		print "\tCan't find the [ minimap2 ] at \$PATH or \$BinDir\n";
		print "\tplease Check at it\n";exit;
	}


}





my $NGenomeSyn="$Bin/../NGenomeSyn";
if  ( !(-e $NGenomeSyn) )
{
	$NGenomeSyn="$Bin/NGenomeSyn";
	if  ( !(-e $NGenomeSyn) )
	{
		print "\tCan't find the [NGenomeSyn] at [ $Bin/..]\n";
		print "\tplease Check at it\n";exit;
	}
}

######################swimming in the sky and flying in the sea ###########################

$/=">";
open (IA,"$InGenomeA") || die "input file can't open $!";
open (OUTA,">$OutPrefix.A.fa") || die "input file can't open $!";
<IA>;
my %hashChrA=();
while(<IA>)
{
	chomp ;
	my @inf=split /\n/ ;
	my $seq=join("",@inf[1..$#inf]);
	my $len=length($seq);
	next if ($len<$MinLenA);
	my @ID=split /\s+/,$inf[0];
	print OUTA ">$ID[0]\n$seq\n";
	$hashChrA{$ID[0]}=$len;
}
close IA;
close OUTA;

open (IB,"$InGenomeB") || die "input file can't open $!";
open (OUTB,">$OutPrefix.B.fa") || die "input file can't open $!";
open (OUTBL,">$OutPrefix.B.chr.len") || die "input file can't open $!";
my %hashChrB=();
<IB>;
while(<IB>)
{
	chomp ;
	my @inf=split /\n/ ;
	my $seq=join("",@inf[1..$#inf]);
	my $len=length($seq);
	next if ($len<$MinLenB);
	my @ID=split /\s+/,$inf[0];
	print OUTB ">$ID[0]\n$seq\n";
	$hashChrB{$ID[0]}=$len;
}
close IB;
close OUTB;
close OUTBL;
$/="\n";

my @ChrArry=sort  keys  %hashChrA;
if (@ChrArry)
{
	my $NumChr=$#ChrArry+1;
	if ($NumChr >168 )
	{
		print "\tWarning : there are tow many Seq(A) for synteny, I Suggest you can Increase the length of the Para [-MinLenA]\n";
	}
}
else
{
	print "\tWarning : there are no Seq(A) for synteny, I Suggest you can reduce the length of the Para [-MinLenA]\n";
	exit ;
}


my $sedSort=1;
my %tmpChrSort;

foreach my $k (@ChrArry)
{
	my $chr=$k;
	$chr=~s/^chromosome//;
	$chr=~s/^Chromosome//;
	$chr=~s/^Chr//;
	$chr=~s/^CHR//;
	$chr=~s/^chr//;
	$chr=~s/^LG//;
	$chr=~s/^lg//;
	if ($chr eq  'X' )  {$chr=23;}
	elsif ($chr eq  'Y' )  {$chr=24;}
	if ( $chr =~ /^\d+$/ )
	{
		$tmpChrSort{$k}=$chr;
	}
	else
	{
		$sedSort=0;
		last;
	}
}
if ($sedSort==1)
{
	@ChrArry=sort {$tmpChrSort{$a} <=>$tmpChrSort{$b} } keys  %tmpChrSort;
}

open (OUTAL,">$OutPrefix.A.chr.len") || die "input file can't open $!";
foreach my $This (0..$#ChrArry)
{
	my $chr=$ChrArry[$This];
	print OUTAL "$chr\t1\t$hashChrA{$chr}\n";
}
close OUTAL;


@ChrArry=();
@ChrArry=sort  keys  %hashChrB;
if (@ChrArry)
{
	my $NumChr=$#ChrArry+1;
	if ($NumChr >168 )
	{
		print "\tWarning : there are tow many Seq(B) for synteny, I Suggest you can Increase the length of the Para [-MinLenB]\n";
	}
}
else
{
	print "\tWarning : there are no Seq(B) for synteny, I Suggest you can reduce the length of the Para [-MinLenB]\n";
	exit ;
}




$sedSort=1;
%tmpChrSort=();

foreach my $k (@ChrArry)
{
	my $chr=$k;
	$chr=~s/^chromosome//;
	$chr=~s/^Chromosome//;
	$chr=~s/^Chr//;
	$chr=~s/^CHR//;
	$chr=~s/^chr//;
	$chr=~s/^LG//;
	$chr=~s/^lg//;
	if ($chr eq  'X' )  {$chr=23;}
	elsif ($chr eq  'Y' )  {$chr=24;}
	if ( $chr =~ /^\d+$/ )
	{
		$tmpChrSort{$k}=$chr;
	}
	else
	{
		$sedSort=0;
		last;
	}
}
if ($sedSort==1)
{
	@ChrArry=sort {$tmpChrSort{$a} <=>$tmpChrSort{$b} } keys  %tmpChrSort;
}

open (OUTBL,">$OutPrefix.B.chr.len") || die "input file can't open $!";
foreach my $This (0..$#ChrArry)
{
	my $chr=$ChrArry[$This];
	print OUTBL "$chr\t1\t$hashChrB{$chr}\n";
}
close OUTBL;






######################swimming in the sky and flying in the sea ###########################

if (($MappingSoft eq "mummer")  or ($MappingSoft eq "nucmer"))
{

#mummer-4.0.0/bin/nucmer  --mum --mincluster 500 -t 30  Ref.AAfa   RefBB.fa     -p   OUT
#mummer-4.0.0/bin/delta-filter   -1 -i 90 -l 2000 OUT.delta >  OUT.filter1.delta 
#mummer-4.0.0/bin/show-coords -c -r  OUT.filter1.delta   >  OUT.filter1.coords

	open (OUTSH,">$OutPrefix.mapping.sh") || die "input file can't open $!";
	print OUTSH  "$nucmer   --mum     --mincluster 500 -t $NumThreads   $OutPrefix.A.fa  $OutPrefix.B.fa    -p $OutPrefix \n";
	print OUTSH  "$deltaFilter   -1 -i 90 -l $MinAlgLen   $OutPrefix.delta  >  $OutPrefix.filter.delta \n";
	print OUTSH  "$showcoords -c -r   $OutPrefix.filter.delta     >  $OutPrefix.filter.coords\n";
	print OUTSH  "perl  $0  Coords2Syn   $OutPrefix.filter.coords  $OutPrefix.syn  \n";
	close OUTSH;
	
	system ("sh   $OutPrefix.mapping.sh  ");

}
else
{
	open (OUTSH,">$OutPrefix.mapping.sh") || die "input file can't open $!";
	print OUTSH  "$minimap2 -x asm5 -t $NumThreads $OutPrefix.B.fa  $OutPrefix.A.fa > $OutPrefix.paf \n";
	print OUTSH  "perl  $0  Paf2Syn   $OutPrefix.paf    $MinAlgLen   $OutPrefix.syn  \n";
	close OUTSH ;
	system ("sh   $OutPrefix.mapping.sh  ");
}




my @AA=split /\//,$InGenomeA;
my @BB=split /\//,$InGenomeB;
my @AAA=split /\./,$AA[-1];
my @BBB=split /\./,$BB[-1];

open (CON, ">$OutPrefix.cofi") || die "input file can't open $!";

my $cofi= <<USAGE;

SetParaFor = global
GenomeInfoFile1=$OutPrefix.A.chr.len
GenomeInfoFile2=$OutPrefix.B.chr.len
LinkFileRef1VsRef2=$OutPrefix.syn
SetParaFor = Genome1
GenomeName=$AAA[0]
SetParaFor = Genome2
GenomeName=$BBB[0]

USAGE
print CON  $cofi;
close CON;


system ("  $NGenomeSyn  -InConfi   $OutPrefix.cofi   -OutPut    $OutPrefix.svg    ");
print "\tALL done, see the xxx.png . you can optimized drawing by [NGenomeSyn] software\n";
print "\t     optimized: [Filter] and [Merge] small syn blocks to big syn block\n\n";

######################swimming in the sky and flying in the sea ###########################

