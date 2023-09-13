#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-11-23
echo Start Time : 
date
##    Get the gene pairwise Collinearity form the MScanX result ##
perl	MCScanXSpeRegion.pl	../RealData/Bacteria/GCA_000146045.2_R64_genomic.gff.gz	../RealData/Bacteria/GCA_000977955.2_Sc_YJM1447_v1_genomic.gff.gz	../RealData/Bacteria/R64_YJM1447.collinearity	R64_YJM1447.gene.pairwise

######   Show the  Region mRNA and CDS pairwise relationship  #######
../../bin/NGenomeSyn	-InConfi	in.conf	-OutPut	OUT
echo End Time : 
date
