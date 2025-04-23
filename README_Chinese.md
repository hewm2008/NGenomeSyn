
# NGenomeSyn
An easy-to-use and flexible tool for pretty visualization of syntenic relationships on any number of genomes

###  1 Introduction

</br>    <p align="center"> 中文的readme有可能是<b>老版本的readme</b>  ,对应最新的使用说明请见对应版本里面的 中文的使用手册pdf   ，or 直接查看英文的readme </p> </br>

<b>NGenomeSyn</b> 是于基于多个基因组共线性关系的可视工具，对多个基因组自主排列位置，扩长收缩，旋转角度 等，结合颜色，达到快速一眼看出规律，识别结果。 并且各种可以自己组合 自由修改相关参数。
</br>
</br>亮点：
</br>1  任意多个基因组(目前我限20个，可以取消)
</br>2  各个基因组可以自己调顺序 颜色等等属性
</br>3  各个基因组可以移动 旋转 扩长和收缩等
</br>4  ZoomRegion功能，可以指定放大某一个区域
</br>
</br>其中3  可以调好相关参数 可以出现 三角形  五角形  四边形 等等组合（后面将有空升组调定这些参数）

</br>程序是给一些有基础的生信朋友用的，若是小白看不懂就算了。
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
	   # 用法和circos相似，主要一个配置文件一样,具体见pdf，简要功能介绍如下
	1  任意多个基因组（目前我限12个，可以取消）
	2  各个基因组可以自己调顺序 颜色等等属性
	3  各个基因组可以移动 旋转 扩长和收缩等
	
	其中3  可以调好相关参数 可以出现 三角形  五角形  四边形 等等组合（后面将有空升组调定这些参数）
	   更多[GetTwoGenomeSyn.pl](https://zhuanlan.zhihu.com/p/515695482)参数
</pre>

</br><b>3.1.2 Other parameters</b>
```php
     输入文件基因组格式见  pdf.主要为chr start end 等其它属性 的格式
     输入link件基因组格式见  pdf.主要为chrA  startA enda chrB startB endB   等等其它属性 的格式

```

</br><b>3.2.2 Detail parameters</b>
```php
	#  具体见pdf
##################################### 全局参数 #######################################################
SetParaFor = global
GenomeInfoFile1=RefA.len
###### Format (chr Start End ...其它属性)  chr顺序和这文件一致 若是End Start 则这条chr反向互补
##  其它属性 如fill=red stroke-width=0  stroke=black stroke-opacity=1 fill-opacity=1 等等可以不同行不同属性
GenomeInfoFile2=RefB.len  ##  GenomeInfoFile X  就表示有 X个基因组

LinkFileRef1VsRef2=RefA_RefB.link  

####### Format (chrA StartA EndA chrB StartB End ...其它属性)
#  可以多次Ref1VsRef2   LinkFileRef2VsRef1 等


##Main = "main_Figure"  ##  the Fig Name  :MainRatioFontSize MainCor ShiftMainX  ShiftMainY 
## font-size 

################################ Figure ############################################################

##############################     画布 和 图片 参数配置 #################################
#body=1200   ##   默认是1200，主画布大小设置  另外：up/down/left/right) = (55,25,100,120); #CanvasHeightRitao=1.0 CanvasWidthRitao=1.0
##RotatePng   = 0  ##  对Figure进行旋转的角度

SetParaFor = Genome1  #  GenomeALL/GenomeX  X第X个基因组

#ZoomChr=1.0          ## chr长度 等大 缩小 or 扩大
#RotateChr=30         ## chr的起点 顺时针 旋转  xx 度
#ShiftX=0
#ShiftY=0             ##对这个基因组移动,也可以直接用MoveToX MoveToY 

#ChrWidth=20          ## 这个基因组chr的在画布的宽度
#LinkWidth=180        ## 这个基因组和下一个link的高度
#ChrSpacing=10        ## 这个基因组chr之间的空隙
#NormalizedScale=0    ## 用自己的标尺  相当该基因组与默认的基因组是否等长

#SpeRegionFile=        ## 文件,表记特别区域[格式chr start End （xx=yy加属性等]
#ZoomRegion           ## Zoom the specific Region,format (ZoomRegion=chr2:1000:5000)

##其它当很少用到的参数 EndCurveRadian=3/ 等等
## GenomeNameRatio GenomeName
## 鍧愭爣鏄剧ず鐩稿叧 ShowCoordinates=1     ## Show Coordinates . with other para [ScaleNum=10 ScaleUpDown ScaleUnit LabelUnit  LablefontsizeRatio  RotateAxisText NoShowLabel ]

SetParaFor = Genome2  #  GenomeX  X第X个基因组


SetParaFor=Link1  #  对第X个 Link X  File 进行设置 LinkALL :对所有link起作用
#StyleUpDown=           ## UpDown  DownUp  UpUP DownDown line  五种形式  line为直线
#Reverse=1              ## 反向link
#HeightRatio=1.0        ## links的高比例  扩大or缩小
####  fill/ stroke/stroke-opacity/fill-opacity/stroke-width   可设

....  #等等


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
</br>具体见这儿  Manual.pdf for more detail 里面的实例和配置，后期将在某些网址释放一些教程
</br></br> 
../../bin/NGenomeSyn       -InConf        in.cofi -OutPut OUT
</br>  目录  <b> [[Example/example\*/](https://github.com/hewm2008/NGenomeSyn/tree/main/Example)] </b>　里面有输入和输出和脚本用法。

</br> 如下提供了6个实例，均用到真正的数据作的图。


|  <b>Example</b>               |                                                 <b>Description</b>                                                |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------|
|  <i><b>example1</b></i>       |   An integrating <b>pipeline</b> and processing data and visualizing of two genomes for the simplest usage        |
|  <i><b>example2</b></i>       |   Horizontal layout of 3 or more genomes,  genome layout adjustment and special region <b>highlight</b>           |
|  <i><b>example3 </b></i>      |  Link settings, five link styles, genome layout adjustment for particular shape (triangle)                        |
|  <i><b>example4</b></i>       |  <b>ZoomRegion</b> function of local <b>gene structure</b>(CDS mRNA) collinearity                                 |
|  <i><b>example5</b></i>       |  The comprehensive configuration for horizontal layout of more than three genomes (>3)  |
|  <i><b>example6</b></i>       |  quick identification of genetic deletion in some breeds (pan-genome frequently analysis) to <b>solve biological</b> problems |


</br>

所有测试数据均来自真实数据，我们将其放在[[Example/RealData](https://github.com/hewm2008/NGenomeSyn/tree/main/Example/RealData)]目录下，并且
文件 (00.ReadMe)j里面有列到数据的 下载的URL


* Example 1)两个基因组默认
最简易，默认居中。  run2.sh里面有流程 
![Minimap2.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example1/Minimap2.png)
![MCScanX.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example1/MCScanX.png)

* Example 2) 三个(N个)基因组默认 
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT1.png)

* Example 2)三个(N个)基因组默认  排列 旋转等
旋转 第三个基因组
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT2.png)

![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example2/OUT3.png)


* Example 3)三个(N个)基因组默认  排列 旋转等
UpUp DownDown和三角型作图
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example3/OUT1.png)
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example3/OUT3.png)

* Example 4)  任意排列
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example4/OUT.png)
有数据可以出下图
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example4/PMID34990066Fig2.png)

* Example 5)  局部基因结构共线性和ZoomRegion功能
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example5/OUT1.png)
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example5/OUT2.png)

* Example 6) 泛基因组学演常用分析，查看品种之间的插入和缺失，寻找生物意义
![out.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/example6/OUT.png)


</br> In fact, NGenomeSyn is not only designed for the visualization of genomic synteny and genomic features, but also for other relationships among any data with a similar input format. For example, a user ([lian xu et 2022](https://www.nature.com/articles/s41597-022-01783-8)) used NGenomeSyn for visualization clusters with similar gene expression patterns (generated by Mfuzz software) between other four datasets and the reference dataset and revealed conserved expression patterns of differential expression genes among different datasets.

![realityData.png](https://github.com/hewm2008/NGenomeSyn/blob/main/Example/RealData/Other/realityData.png)


###  5 Advantages

</br>速度快，少内存
</br>可以自我定义组合多层次
</br>有perl即可以运行，免安装


###  6 An example image generated by NGenomeSyn.

------------



###  7 Discussing
------------
- [:email:](https://github.com/hewm2008/NGenomeSyn) hewm2008@gmail.com / hewm2008@qq.com
- join the<b><i> QQ Group : 125293663</b></i>

######################swimming in the sky and flying in the sea #############################



