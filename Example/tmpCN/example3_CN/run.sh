#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
###   Example for ZoomRegion and  StyleUpDown funtion ####
../../bin/NGenomeSyn	-InConfi	in1.conf	-OutPut	OUT1

###  "DownDown", "UpUp", "DownUp","UpDown","line" for test link link styles
../../bin/NGenomeSyn	-InConfi	in2.conf	-OutPut	OUT2	
echo End Time : 
date
