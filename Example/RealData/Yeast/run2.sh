#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.cn	2022-11-22
echo Start Time : 
date
#######  the file [R64_YJM1447.collinearity] is generated by  MCScanX pipleine #####
perl	MCScanX2Link.pl	GCA_000146045.2_R64_genomic.gff.gz	GCA_000977955.2_Sc_YJM1447_v1_genomic.gff.gz	R64_YJM1447.collinearity	MCScanX	
echo End Time : 
date
