#!/usr/bin/perl -w
use strict;
#explanation:this program is edited to GFF2Bed 
#edit by hewm;   Wed Nov 23 11:18:27 CST 2022
#Version 1.0    hewm@genomics.org.cn 

die  "Version 1.0\t2022-11-23;\nUsage: $0 <In.gff><Out.bed>\n" unless (@ARGV ==2);

#############Befor  Start  , open the files ####################

if  ($ARGV[0] =~s/\.gz$/\.gz/)
{
	open GFF,"gzip -cd $ARGV[0] | "  || die "input $ARGV[0] file can't open $!" ;
}
else
{
	open GFF,"$ARGV[0]"  || die "input $ARGV[0] file can't open $!" ;
}

open (OA,">$ARGV[1]") || die "output file can't open $!" ;

my $GFFCor_mRNA="\"#8DD3C7\"";
my $GFFCor_CDS="\"#FB8072\"";
my $GFFCor_UTR="\"#BEBADA\"";
my $GFFCor_Other="\"#FFFFB3\"";


################ Do what you want to do #######################

while(<GFF>) 
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

}


close GFF;
close OA ;

######################swimming in the sky and flying in the sea ###########################
