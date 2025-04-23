#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
## Real data come from this website (https://ricerc.sicau.edu.cn/)
## cell  paper of rice Pan-genome article (https://www.sciencedirect.com/science/article/pii/S009286742100581X) 
##  see the [../RealData/Rices/00.Readme] to see the data preparation process
../../bin/NGenomeSyn	-InConf	in.conf	-OutPut	OUT	
echo End Time : 
date
