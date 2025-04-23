#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2022-03-31
echo Start Time : 
date
##  The real data comes from GCA_000146045 and GCA_000977955 [ see run2.sh]

##         minimap2  paf file  Format to Link File    ####
perl  ../../bin/GetTwoGenomeSyn.pl  Paf2Link   ../RealData/Yeast/R64_YJM1447.paf     5000  ../RealData/Yeast/R64_YJM1447.link
../../bin/NGenomeSyn	-InConf	in1.conf	-OutPut	Minimap2


###    MCScanX collinearity file Format to Link File    ####
perl  ../../bin/MCScanX2Link.pl   ../RealData/Yeast/GCA_000146045.2_R64_genomic.gff.gz ../RealData/Yeast/GCA_000977955.2_Sc_YJM1447_v1_genomic.gff.gz     ../RealData/Yeast/R64_YJM1447.collinearity     OUT2
mv    OUT2.A2B.link   ../RealData/Yeast/R64_YJM1447.link
../../bin/NGenomeSyn	-InConf	in1.conf	-OutPut	MCScanX

##      For mummer ,the Coords2Link also can be run as folows ## 
###   perl ../../bin/GetTwoGenomeSyn.pl   Coords2Link  In.filter.coords 5000  OutPre.link  ###
echo End Time : 
date
