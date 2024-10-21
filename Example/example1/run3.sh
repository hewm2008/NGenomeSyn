#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
##  The real data comes from GCA_000146045 and GCA_000977955 [ see run2.sh]

##        Syri  file  Format to Link File    ####
##       note : We removed the line of the SNP/IDE  in file A to ensure that the file size was not too large
perl  ../../bin/GetTwoGenomeSyn.pl  Syri2Link  ../RealData/Yeast/R64_YJM1447.syri.out.gz     5000  ../RealData/Yeast/R64_YJM1447.link
../../bin/NGenomeSyn	-InConf	in1.conf	-OutPut	Syri

echo End Time : 
date
