#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
###   Example for ZoomRegion and  StyleUpDown funtion ####
../../bin/NGenomeSyn	-InConf	in1.conf	-OutPut	OUT1

###  "DownDown", "UpUp", "DownUp","UpDown","line" for test link link styles
../../bin/NGenomeSyn	-InConf	in2.conf	-OutPut	OUT2	


###  in3.conf is show for stroke-dasharray="5,5"  and ShowCoordinates
../../bin/NGenomeSyn	-InConf	in3.conf	-OutPut	OUT3

echo End Time : 
date

