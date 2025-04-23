
# NGenomeSyn
An easy-to-use and flexible tool for pretty visualization of syntenic relationships on any number of genomes

###  1 Introduction

</br>    <p align="center"> ���ĵ�readme�п�����<b>�ϰ汾��readme</b>  ,��Ӧ���µ�ʹ��˵�������Ӧ�汾����� ���ĵ�ʹ���ֲ�pdf   ��or ֱ�Ӳ鿴Ӣ�ĵ�readme </p> </br>

<b>NGenomeSyn</b> ���ڻ��ڶ�������鹲���Թ�ϵ�Ŀ��ӹ��ߣ��Զ����������������λ�ã�������������ת�Ƕ� �ȣ������ɫ���ﵽ����һ�ۿ������ɣ�ʶ������ ���Ҹ��ֿ����Լ���� �����޸���ز�����
</br>
</br>���㣺
</br>1  ������������(Ŀǰ����20��������ȡ��)
</br>2  ��������������Լ���˳�� ��ɫ�ȵ�����
</br>3  ��������������ƶ� ��ת ������������
</br>4  ZoomRegion���ܣ�����ָ���Ŵ�ĳһ������
</br>
</br>����3  ���Ե�����ز��� ���Գ��� ������  �����  �ı��� �ȵ���ϣ����潫�п����������Щ������

</br>�����Ǹ�һЩ�л��������������õģ�����С�׿����������ˡ�
</br>
</br><b>NGenomeSyn</b> ,It is a visual tool based on the collinear relationship of multiple genomes, which independently arranges the positions, expansion and contraction, rotation angles, etc. of multiple genomes, combined with colors, to quickly see the rules and identify the results at a glance. And various can be combined by themselves to freely modify the relevant parameters


###  2 Download and Install
------------
The <b>new version</b> will be updated and maintained in <b>[hewm2008/NGenomeSyn](https://github.com/hewm2008/NGenomeSyn)</b>, please click below website to download the latest version
</br><p align="center"><b>[hewm2008/NGenomeSyn](https://github.com/hewm2008/NGenomeSyn)</b></p>

<b> 2.1. linux/MaxOS&nbsp;&nbsp;&nbsp;   [Download](https://github.com/hewm2008/NGenomeSyn/archive/v1.42.tar.gz)</b>
  
  </br> <b>2.2 Pre-install</b>
  </br> NGenomeSyn is for Linux/Unix/macOS. Before installing,please make sure the following pre-requirements are ready to use.
  </br> 1) [Perl](https://www.perl.org/) with the [SVG.pm](https://metacpan.org/release/SVG) in Perl should be installed. SVG is not necessary,We have provided a built-in SVG module in the package.
  </br> 2) [convert](https://linux.die.net/man/1/convert) command is recommended to be pre-installed, although it is not required

</br> <b>2.3 Install</b>
</br> Users can install it with the following commands:
<pre>
        git clone https://github.com/hewm2008/NGenomeSyn.git
        cd NGenomeSyn;	chmod 755 -R bin/*
        ./bin/NGenomeSyn  -h 
</pre>


###  3 Parameter description
------------
</br><b>3.1 NGenomeSyn</b>
</br><b>3.1.1 Main parameter</b>

```php
        Usage: NGenomeSyn  -InConf  in.cofi -OutPut OUT

                -InConf      <s> : InPut Configuration File
                -OutPut      <s> : OutPut svg file result

                -help              See more help *Manual.pdf
                                   [hewm2008 v1.42]

```
</br> brief description for function:
<pre>
	   # �÷���circos���ƣ���Ҫһ�������ļ�һ��,�����pdf����Ҫ���ܽ�������
	1  �����������飨Ŀǰ����12��������ȡ����
	2  ��������������Լ���˳�� ��ɫ�ȵ�����
	3  ��������������ƶ� ��ת ������������
	
	����3  ���Ե�����ز��� ���Գ��� ������  �����  �ı��� �ȵ���ϣ����潫�п����������Щ������
	   ����[GetTwoGenomeSyn.pl](https://zhuanlan.zhihu.com/p/515695482)����
</pre>

</br><b>3.1.2 Other parameters</b>
```php
     �����ļ��������ʽ��  pdf.��ҪΪchr start end ���������� �ĸ�ʽ
     ����link���������ʽ��  pdf.��ҪΪchrA  startA enda chrB startB endB   �ȵ��������� �ĸ�ʽ

```

</br><b>3.2.2 Detail parameters</b>
```php
	#  �����pdf
##################################### ȫ�ֲ��� #######################################################
SetParaFor = global
GenomeInfoFile1=RefA.len
###### Format (chr Start End ...��������)  chr˳������ļ�һ�� ����End Start ������chr���򻥲�
##  �������� ��fill=red stroke-width=0  stroke=black stroke-opacity=1 fill-opacity=1 �ȵȿ��Բ�ͬ�в�ͬ����
GenomeInfoFile2=RefB.len  ##  GenomeInfoFile X  �ͱ�ʾ�� X��������

LinkFileRef1VsRef2=RefA_RefB.link  

####### Format (chrA StartA EndA chrB StartB End ...��������)
#  ���Զ��Ref1VsRef2   LinkFileRef2VsRef1 ��


##Main = "main_Figure"  ##  the Fig Name  :MainRatioFontSize MainCor ShiftMainX  ShiftMainY 
## font-size 

################################ Figure ############################################################

##############################     ���� �� ͼƬ �������� #################################
#body=1200   ##   Ĭ����1200����������С����  ���⣺up/down/left/right) = (55,25,100,120); #CanvasHeightRitao=1.0 CanvasWidthRitao=1.0
##RotatePng   = 0  ##  ��Figure������ת�ĽǶ�

SetParaFor = Genome1  #  GenomeALL/GenomeX  X��X��������

#ZoomChr=1.0          ## chr���� �ȴ� ��С or ����
#RotateChr=30         ## chr����� ˳ʱ�� ��ת  xx ��
#ShiftX=0
#ShiftY=0             ##������������ƶ�,Ҳ����ֱ����MoveToX MoveToY 

#ChrWidth=20          ## ���������chr���ڻ����Ŀ��
#LinkWidth=180        ## ������������һ��link�ĸ߶�
#ChrSpacing=10        ## ���������chr֮��Ŀ�϶
#NormalizedScale=0    ## ���Լ��ı��  �൱�û�������Ĭ�ϵĻ������Ƿ�ȳ�

#SpeRegionFile=        ## �ļ�,����ر�����[��ʽchr start End ��xx=yy�����Ե�]
#ZoomRegion           ## Zoom the specific Region,format (ZoomRegion=chr2:1000:5000)

##�����������õ��Ĳ��� EndCurveRadian=3/ �ȵ�
## GenomeNameRatio GenomeName
## 坐标显示相关 ShowCoordinates=1     ## Show Coordinates . with other para [ScaleNum=10 ScaleUpDown ScaleUnit LabelUnit  LablefontsizeRatio  RotateAxisText NoShowLabel ]

SetParaFor = Genome2  #  GenomeX  X��X��������


SetParaFor=Link1  #  �Ե�X�� Link X  File �������� LinkALL :������link������
#StyleUpDown=           ## UpDown  DownUp  UpUP DownDown line  ������ʽ  lineΪֱ��
#Reverse=1              ## ����link
#HeightRatio=1.0        ## links�ĸ߱���  ����or��С
####  fill/ stroke/stroke-opacity/fill-opacity/stroke-width   ����

....  #�ȵ�


```

</br><b>3.3 Output files</b>
<pre>
out.svg: Output plot in SVG format
out.png: Output plot in png format
</pre>


###  4 Examples
------------

</br>See more detailed usage in the&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[Chinese Documentation](https://github.com/hewm2008/NGenomeSyn/blob/main/NGenomeSyn_manual_Chinese.pdf)</b>
</br>See more detailed usage in the&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[English Documentation](https://github.com/hewm2008/NGenomeSyn/blob/main/NGenomeSyn_manual_English.pdf)</b>
</br>See the example directory and  Manual.pdf for more detail.
</br>��������  Manual.pdf for more detail �����ʵ�������ã����ڽ���ĳЩ��ַ�ͷ�һЩ�̳�
</br></br> 
../../bin/NGenomeSyn       -InConf        in.cofi -OutPut OUT
</br>  Ŀ¼  <b> [[Example/example\*/](https://github.com/hewm2008/NGenomeSyn/tree/main/Example)] </b>�����������������ͽű��÷���

</br> �����ṩ��6��ʵ�������õ���������������ͼ��


|  <b>Example</b>               |                                                 <b>Description</b>                                                |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------|
|  <i><b>example1</b></i>       |   An integrating <b>pipeline</b> and processing data and visualizing of two genomes for the simplest usage        |
|  <i><b>example2</b></i>       |   Horizontal layout of 3 or more genomes,  genome layout adjustment and special region <b>highlight</b>           |
|  <i><b>example3 </b></i>      |  Link settings, five link styles, genome layout adjustment for particular shape (triangle)                        |
|  <i><b>example4</b></i>       |  <b>ZoomRegion</b> function of local <b>gene structure</b>(CDS mRNA) collinearity                                 |
|  <i><b>example5</b></i>       |  The comprehensive configuration for horizontal layout of more than three genomes (>3)  |
|  <i><b>example6</b></i>       |  quick identification of genetic deletion in some breeds (pan-genome frequently analysis) to <b>solve biological</b> problems |


</br>

���в������ݾ�������ʵ���ݣ����ǽ������[[Example/RealData](https://github.com/hewm2008/NGenomeSyn/tree/main/Example/RealData)]Ŀ¼�£�����
�ļ� (00.ReadMe)j�������е����ݵ� ���ص�URL


* Example 1)����������Ĭ��
����ף�Ĭ�Ͼ��С�  run2.sh���������� 
![Minimap2.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example1/Minimap2.png)
![MCScanX.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example1/MCScanX.png)

* Example 2) ����(N��)������Ĭ�� 
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT1.png)

* Example 2)����(N��)������Ĭ��  ���� ��ת��
��ת ������������
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT2.png)

![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT3.png)


* Example 3)����(N��)������Ĭ��  ���� ��ת��
UpUp DownDown����������ͼ
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example3/OUT1.png)
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example3/OUT3.png)

* Example 4)  ��������
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example4/OUT.png)
�����ݿ��Գ���ͼ
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example4/PMID34990066Fig2.png)

* Example 5)  �ֲ�����ṹ�����Ժ�ZoomRegion����
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example5/OUT1.png)
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example5/OUT2.png)

* Example 6) ��������ѧ�ݳ��÷������鿴Ʒ��֮��Ĳ����ȱʧ��Ѱ����������
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example6/OUT.png)


</br> In fact, NGenomeSyn is not only designed for the visualization of genomic synteny and genomic features, but also for other relationships among any data with a similar input format. For example, a user ([lian xu et 2022](https://www.nature.com/articles/s41597-022-01783-8)) used NGenomeSyn for visualization clusters with similar gene expression patterns (generated by Mfuzz software) between other four datasets and the reference dataset and revealed conserved expression patterns of differential expression genes among different datasets.

![realityData.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/RealData/Other/realityData.png)


###  5 Advantages

</br>�ٶȿ죬���ڴ�
</br>�������Ҷ�����϶���
</br>��perl���������У��ⰲװ


###  6 An example image generated by NGenomeSyn.

------------



###  7 Discussing
------------
- [:email:](https://github.com/hewm2008/NGenomeSyn) hewm2008@gmail.com / hewm2008@qq.com
- join the<b><i> QQ Group : 125293663</b></i>

######################swimming in the sky and flying in the sea #############################



