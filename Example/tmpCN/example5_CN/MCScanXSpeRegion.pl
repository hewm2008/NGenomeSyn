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

if ($ARGV[1] =~s/\.gz$/\.gz/)
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

   my $GFFCor_mRNA="\"#8DD3C7\"";
   my $GFFCor_CDS="\"#FB8072\"";
   my $GFFCor_UTR="\"#BEBADA\"";
   my $GFFCor_RRR="\"#FFFFB3\"";


open (OA,">$OutPrefix.A.geneInfo.bed") || die "output file can't open $!" ;
open (OB,">$OutPrefix.B.geneInfo.bed") || die "output file can't open $!" ;

while(<GffA>)
{
	chomp;
	next if ($_=~s/#/#/);
	my @temp=split(/\t/);
	my $chr=$temp[0];
	my $type=$temp[2];
	my $start=$temp[3];
	my $end=$temp[4];
	if ($type =~s/CDS/CDS/)
	{
	 print OA $chr,"\t$start\t$end\tCDS\tfill=$GFFCor_CDS\tstroke=$GFFCor_CDS\n";
	}
	elsif ($type =~s/UTR/UTR/)
	{
	 print OA $chr,"\t$start\t$end\tUTR\tfill=$GFFCor_UTR\tstroke=$GFFCor_UTR\n";
	}
	else
	{
	}
	next unless ($type eq "mRNA");
	print OA $chr,"\t$start\t$end\tmRNA\tfill=$GFFCor_mRNA\tstroke=$GFFCor_mRNA\n";

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
close OA ;

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


	if ($type =~s/CDS/CDS/)
	{
	 print OB $chr,"\t$start\t$end\tCDS\tfill=$GFFCor_CDS\tstroke=$GFFCor_CDS\n";
	}
	elsif ($type =~s/UTR/UTR/)
	{
	 print OB $chr,"\t$start\t$end\tUTR\tfill=$GFFCor_UTR\tstroke=$GFFCor_UTR\n";
	}
	else
	{
	}
	next unless ($type eq "mRNA");
	print OB $chr,"\t$start\t$end\tmRNA\tfill=$GFFCor_mRNA\tstroke=$GFFCor_mRNA\n";


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
close OA ;


open (OC,">$OutPrefix.A2B.link") || die "output file can't open $!" ;

################ Do what you want to do #######################
my $AAchr=""; my $AAStart=""; my $AAEnd="";
my $BBchr=""; my $BBStart=""; my $BBEnd="";
my $Type="plus";
### Alignment 0: score=514.0 e_value=1.3e-31 N=13 Dla1.2&Dla11.2 plus
my %NowChrAA;
my %NowChrBB;
my $Alignment=0;
while(<SYS>)
{ 
	chomp ; 
	my @inf=split ;
	if ($_=~s/Alignment/Alignment/) 
	{
		$Alignment=$inf[2]; $Alignment=~s/://g;
		$Type=$inf[-1];
	}
	elsif ($_=~s/#/#/)
	{
		next;
	}
	else
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
			print OC "$AAchr\t$AAStart\t$AAEnd\t$BBchr\t$BBStart\t$BBEnd\t$Alignment\n";
		}
}

close SYS;
close OC ;


######################swimming in the sky and flying in the sea ###########################
