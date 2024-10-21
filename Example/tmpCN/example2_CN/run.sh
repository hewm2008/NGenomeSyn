#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
##   Horizontal layout of 3 genome  #######
../../bin/NGenomeSyn	-InConfi	in1.conf	-OutPut	OUT1	

##  example the ZoomChr/RotateChr and Hight ##
##  specal Region method, SpeRegionFile and ##
##  Show Spe.region file Foramt example     ##
../../bin/NGenomeSyn	-InConfi	in2.conf	-OutPut	OUT2	
echo End Time : 
date
