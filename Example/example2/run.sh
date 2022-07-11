#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
../../bin/NGenomeSyn	-InConfi	in1.cofi	-OutPut	OUT1	
../../bin/NGenomeSyn	-InConfi	in2.cofi	-OutPut	OUT2	
echo End Time : 
date
