#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
## A special example shows that there are large insertions and deletions in this region, and the related genes in it are very likely to be important genes for breed differentiation  ##
##  This analysis is the most important analysis and display in the pan-genome   ##

## the SpeFile can be generated like  Gff2Bed.pl ##
## also can [ cp Data_SpeRegion/IRGSP_InDelRegion.bed    Data_SpeRegion/IRGSP.bed] ##

perl Data_SpeRegion/Gff2Bed.pl  Data_SpeRegion/IRGSP_Region.gff  Data_SpeRegion/IRGSP.bed

#An important Region is lost some breeds (pan-genome frequently analysis)
../../bin/NGenomeSyn	-InConfi	in.conf	-OutPut	OUT	
echo End Time : 
date
