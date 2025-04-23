#!/bin/sh
#$ -S /bin/sh
#Version1.0	  hewm@genomics.org.cn	 2022-08-18
echo Start Time : 
date

##### a example for two genome (the simplest usage) ########
### provides an integrating pipeline and processing data and visualizing    ####
  
  # wget	  -c	 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/146/045/GCA_000146045.2_R64/GCA_000146045.2_R64_genomic.fna.gz	-O   ../RealData/Bacteria/GCA_000146045.2_R64_genomic.fna.gz
  # wget	  -c	 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/977/955/GCA_000977955.2_Sc_YJM1447_v1/GCA_000977955.2_Sc_YJM1447_v1_genomic.fna.gz  -O	 ../RealData/Bacteria/GCA_000977955.2_Sc_YJM1447_v1_genomic.fna.gz


perl  ../../bin/GetTwoGenomeSyn.pl  -InGenomeA ../RealData/Bacteria/GCA_000146045.2_R64_genomic.fna.gz  -InGenomeB ../RealData/Bacteria/GCA_000977955.2_Sc_YJM1447_v1_genomic.fna.gz  -OutPrefix A2B   -MappingBin  minimap2    -BinDir    /hwfssz4/BC_PUB/Software/08.Centos7/minimap2-2.23/    -MinLenA  1000  -MinLenB 1000
   
echo End Time : 
date
