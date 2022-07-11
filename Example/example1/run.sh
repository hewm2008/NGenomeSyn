#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
../../bin/NGenomeSyn	-InConfi	in.cofi	-OutPut	OUT	
echo End Time : 
date
