#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin $RealBin);
#explanation:this program is edited to  MCScanX2Link
#edit by hewm;   Fri Nov 18 10:51:18 CST 2022
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2022-11-18;\nUsage: $0 <InA.gff><InB.gff><A2B.collinearity><Out>\n" unless (@ARGV ==4);

#############Befor  Start  , open the files ####################

if  ($ARGV[0] =~s/\.gz$/\.gz/)
{
	open GffA,"gzip -cd $ARGV[0] | "  || die "input $ARGV[0] file can't open $!" ;
}
else
{
	open GffA,"$ARGV[0]"  || die "input $ARGV[0] file can't open $!" ;
}

if  ($ARGV[1] =~s/\.gz$/\.gz/)
{
	open GffB,"gzip -cd $ARGV[1] | "  || die "input $ARGV[1] file can't open $!" ;
}
else
{
	open GffB,"$ARGV[1]"  || die "input $ARGV[1] file can't open $!" ;
}

if  ($ARGV[2] =~s/\.gz$/\.gz/)
{
	open SYS,"gzip -cd $ARGV[2] | "  || die "input $ARGV[2] file can't open $!" ;
}
else
{
	open SYS,"$ARGV[2]"  || die "input $ARGV[2] file can't open $!" ;
}

my $OutPrefix=$ARGV[3];


my %mRNAAAChr=();
my %mRNAAAStart=();
my %mRNAAAEnd=();
my %ChrLengAA=();


while(<GffA>)
{
	chomp;
	next if ($_=~s/#/#/);
	my @temp=split(/\t/);
	my $chr=$temp[0];
	my $type=$temp[2];
	my $start=$temp[3];
	my $end=$temp[4];

	next unless ($type eq "mRNA");

	my $ID="";
	$ID = $1 if  ($temp[8]=~/ID=([^;]+)\;/) ;
	if (  (!defined($ID)) || ($ID eq "" ) )
	{
		$ID = $1 if  ($temp[8]=~/ID=([^;]+)/);
		if  (  (!defined($ID)) || ($ID eq "" ) )
		{
			$ID = $1 if  ($temp[8]=~/Parent=([^;]+)\;/);
			if (  (!defined($ID))  || ($ID eq "" )  )
			{
				$ID = $1 if  ($temp[8]=~/Parent=([^;]+)/);
				if (  (!defined($ID))  || ($ID eq "" )  ) 
				{
					my @tmp=split /\;/,$temp[8];
					my @ttt=split /\=/,$tmp[0];
					$ID=$ttt[-1];
				}
			}
		}
	}

	$mRNAAAChr{$ID}=$chr;
	$mRNAAAStart{$ID}=$start;
	$mRNAAAEnd{$ID}=$end;

	if (!exists $ChrLengAA{$chr} )
	{
		$ChrLengAA{$chr}=$end;
	}
	elsif ( $ChrLengAA{$chr} < $end)
	{
		$ChrLengAA{$chr}=$end;
	}



}
close(GffA);

my %mRNABBChr=();
my %mRNABBStart=();
my %mRNABBEnd=();
my %ChrLengBB=();


while(<GffB>)
{
	chomp;
	next if ($_=~s/#/#/);
	my @temp=split(/\t/);
	my $chr=$temp[0];
	my $type=$temp[2];
	my $start=$temp[3];
	my $end=$temp[4];

	next unless ($type eq "mRNA");

	my $ID="";

	$ID = $1 if  ($temp[8]=~/ID=([^;]+)\;/) ;
	if (  (!defined($ID)) || ($ID eq "" ) )
	{
		$ID = $1 if  ($temp[8]=~/ID=([^;]+)/);
		if  (  (!defined($ID)) || ($ID eq "" ) )
		{
			$ID = $1 if  ($temp[8]=~/Parent=([^;]+)\;/);
			if (  (!defined($ID))  || ($ID eq "" )  )
			{
				$ID = $1 if  ($temp[8]=~/Parent=([^;]+)/);
				if (  (!defined($ID))  || ($ID eq "" )  ) 
				{
					my @tmp=split /\;/,$temp[8];
					my @ttt=split /\=/,$tmp[0];
					$ID=$ttt[-1];
				}
			}
		}
	}



	$mRNABBChr{$ID}=$chr;
	$mRNABBStart{$ID}=$start;
	$mRNABBEnd{$ID}=$end;

	if (!exists $ChrLengBB{$chr})
	{
		$ChrLengBB{$chr}=$end;
	}
	elsif ( $ChrLengBB{$chr} < $end)
	{
		$ChrLengBB{$chr}=$end;
	}



}
close(GffA);



open (OA,">$OutPrefix.A.len") || die "output file can't open $!" ;
open (OB,">$OutPrefix.B.len") || die "output file can't open $!" ;
open (OC,">$OutPrefix.A2B.link") || die "output file can't open $!" ;

################ Do what you want to do #######################
my $AAchr=""; my $AAStart=""; my $AAEnd="";
my $BBchr=""; my $BBStart=""; my $BBEnd="";
my $Type="plus";
### Alignment 0: score=514.0 e_value=1.3e-31 N=13 Dla1.2&Dla11.2 plus
my %NowChrAA;
my %NowChrBB;

while(<SYS>)
{ 
	chomp ; 
	my @inf=split ;
	if ($_=~s/Alignment/Alignment/) 
	{
		if  ($AAchr ne "")
		{
			if  ($Type eq "plus")
			{
				print OC "$AAchr\t$AAStart\t$AAEnd\t$BBchr\t$BBStart\t$BBEnd\n";
			}
			else
			{
				print OC "$AAchr\t$AAStart\t$AAEnd\t$BBchr\t$BBEnd\t$BBStart\n";
			}
		}
		$AAchr="";  $AAStart="";  $AAEnd="";
		$BBchr="";  $BBStart="";  $BBEnd="";
		$Type=$inf[-1];
	}
	elsif ($_=~s/#/#/)
	{
		next;
	}
	else
	{
		#0-  7:        evm.TU.FRAGSCAFF_129.493        evm.TU.FRAGSCAFF_458.357          2e-25
		if ($AAchr eq "")
		{
			if  (!exists $mRNAAAChr{$inf[-3]} )
			{
				print "the gene ID $inf[-3] in the A2B.collinearity can not match at the A.Gff File\n";
				#	exit;
			}
			if  (!exists $mRNABBChr{$inf[-2]} )
			{
				print "the gene ID $inf[-2] in the A2B.collinearity can not match at the B.Gff File\n";
				# exit;
			}

			$AAchr=$mRNAAAChr{$inf[-3]};
			$AAStart=$mRNAAAStart{$inf[-3]};
			$AAEnd=$mRNAAAEnd{$inf[-3]};

			$BBchr=$mRNABBChr{$inf[-2]};
			$BBStart=$mRNABBStart{$inf[-2]};
			$BBEnd=$mRNABBEnd{$inf[-2]};

			$NowChrAA{$AAchr}++;
			$NowChrBB{$BBchr}++;

		}
		else
		{
			if ($AAStart> $mRNAAAStart{$inf[-3]} ) {$AAStart=$mRNAAAStart{$inf[-3]};}
			if ($AAEnd<$mRNAAAEnd{$inf[-3]}) {$AAEnd=$mRNAAAEnd{$inf[-3]};}

			if ($BBStart>$mRNABBStart{$inf[-2]})  {$BBStart=$mRNABBStart{$inf[-2]};}
			if ($BBEnd<$mRNABBEnd{$inf[-2]}) {$BBEnd=$mRNABBEnd{$inf[-2]};}			
		}
	}
}

close SYS;
if  ($Type eq "plus")
{
	print OC "$AAchr\t$AAStart\t$AAEnd\t$BBchr\t$BBStart\t$BBEnd\n";
}
else
{
	print OC "$AAchr\t$AAStart\t$AAEnd\t$BBchr\t$BBEnd\t$BBStart\n";
}

close OC ;

foreach my $chr (sort keys  %NowChrAA)
{
	my $aa=$ChrLengAA{$chr}+100;
	print OA "$chr\t1\t$aa\n";
}
close OA ;

foreach my $chr (sort keys  %NowChrBB)
{
	my $aa=$ChrLengBB{$chr}+100;
	print OB "$chr\t1\t$aa\n";
}
close OB ;



my @AA=split /\//,$ARGV[0];
my @BB=split /\//,$ARGV[1];
my @AAA=split /\./,$AA[-1];
my @BBB=split /\./,$BB[-1];

open (CON, ">$OutPrefix.conf") || die "input file can't open $!";

my $conf= <<USAGE;

SetParaFor = global
GenomeInfoFile1=$ARGV[3].A.len
GenomeInfoFile2=$ARGV[3].B.len
LinkFileRef1VsRef2=$ARGV[3].A2B.link
SetParaFor = Genome1
NormalizedScale=1
GenomeName=$AAA[0]
SetParaFor = Genome2
GenomeName=$BBB[0]
NormalizedScale=1

USAGE
print CON  $conf;
close CON;

my $NGenomeSyn="$Bin/../../../bin/NGenomeSyn";
if  ( !(-e $NGenomeSyn) )
{
	$NGenomeSyn="$Bin/NGenomeSyn";
	if  ( !(-e $NGenomeSyn) )
	{
		 $NGenomeSyn=`which NGenomeSyn  2> /dev/null `;chomp $NGenomeSyn;
	}
	if  ( !(-e $NGenomeSyn) )
	{
		print "\tCan't find the [NGenomeSyn],please run the follow command :\n";
		print "\t$NGenomeSyn  -InConfi   $OutPrefix.conf   -OutPut    $OutPrefix.svg \n";
	}
}

if  ( (-e $NGenomeSyn) )
{
	print "\t$NGenomeSyn  -InConfi   $OutPrefix.conf   -OutPut    $OutPrefix.svg \n";
	system ("$NGenomeSyn  -InConfi   $OutPrefix.conf   -OutPut    $OutPrefix.svg ");
}


######################swimming in the sky and flying in the sea ###########################
