
###########  real data form ncbi  #################
wget	  -c	 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/146/045/GCA_000146045.2_R64/GCA_000146045.2_R64_genomic.fna.gz	 
wget	  -c	 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/977/955/GCA_000977955.2_Sc_YJM1447_v1/GCA_000977955.2_Sc_YJM1447_v1_genomic.fna.gz	 
wget      -c     https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/146/045/GCA_000146045.2_R64/GCA_000146045.2_R64_genomic.gff.gz   
wget	  -c	 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/977/955/GCA_000977955.2_Sc_YJM1447_v1/GCA_000977955.2_Sc_YJM1447_v1_genomic.gff.gz 
########## run the  GetTwoGenomeSyn.pl  to get input file for NGenomeSyn( *.len  and *.link)  #########
perl  ../../bin/GetTwoGenomeSyn.pl  -InGenomeA GCA_000146045.2_R64_genomic.fna.gz  -InGenomeB GCA_000977955.2_Sc_YJM1447_v1_genomic.fna.gz  -OutPrefix R64_YJM1447   -MappingBin  minimap2    -BinDir    /hwfssz4/BC_PUB/Software/08.Centos7/minimap2-2.23/    -MinLenA  1000  -MinLenB 1000

##############We removed the genome file fa to keep the package file size small ########
