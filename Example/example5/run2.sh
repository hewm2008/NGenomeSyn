#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-12-07
echo Start Time : 
date

###### get the bed file form bed, ##############
#####  if you want to ShowName of gene ,you can vi the bed add the SN=XX ###
#   perl  Data_Region/Gff2Bed.pl  ../RealData/Rices/IRGSP_Region.gff  Data_Region/IRGSP_Region.gene.gff
#   perl  Data_Region/Gff2Bed.pl  ../RealData/Rices/9311_Region.gff  Data_Region/9311_Region.gene.bed

../../bin/NGenomeSyn  -InConf in2.conf    -OutPut  OUT2

echo End Time : 
date
