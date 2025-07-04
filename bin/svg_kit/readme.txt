本工具箱包含基于perl的原SVG开发模块,以及作为补充的字体功能模块FontSize.pm。同时包含集成字体程序buildInFont.pl 和格式转化程序svg2xxx.pl。示例程序svg_example.pl和test_svg.pl为您想尽的演示了各种常见的用法。
本工具箱最大的特点在于完全支持各种常用字体，以及可以近乎完美的图形格式转换。

当前收录了四大系列常用字体类型，每一系列各有四种子形式。CourierNew系列为等宽字体，其它为非等宽字体。用户可以任意选用这四种字体，其它字体在本体系中暂不支持。注意：在书写字体名时，CourierNew可以简写为Courier, TimesNewRoman可以简写为Times。

Arial系列：
Arial Arial-Bold Arial-Italic Arial-BoldItalic

ArialNarrow系列：
ArialNarrow ArialNarrow-Bold ArialNarrow-Italic ArialNarrow-BoldItalic

CourierNew系列：
CourierNew CourierNew-Bold CourierNew-Italic CourierNew-BoldItalic

TimesNewRoman系列：
TimesNewRoman TimesNewRoman-Bold TimesNewRoman-BoldItalic TimesNewRoman-Italic 


FontSize.pm 是樊伟写的一个独立的模块，补足了原SVG包没有计算字体大小功能的缺陷; 其中的字体宽度信息由Windows系统 C:\WINDOWS\Font/下字体库获得，方法是用batik-ttf2svg转化成SVG字体，然后需要人工改正font-family, horiz-adv-x即为字体宽度。 用generate_font_embed_defs.pl来生成buildInFont.pl程序中的字体库，用generate_font_width_hash.pl来生成FontSize.pm模块中的字体宽度信息库。

buildInFont.pl是李盛庭的程序，用于向SVG文件中添加字体库。为了消除图片浏览以及格式转化中的字体问题，所有生成的SVG图最好使用buildInFont.pl集成所用的字体库,同时将SVG图片转换成png格式,双份存储。四种常用字体库大小为800kb。注意：如果不向SVG图中集成字体库，那么用IE浏览时不会有问题，但用batik-rasterizer.jar转化时所有字体将显示为Arial字体。

svg_example.pl 是利用SVG包画图的示例程序，
该程序结构清楚而且功能覆盖面较全，写的时候是一个模块一个模块添加上去的，
因此最后的图上有些乱，但是不妨碍学习语法。可以将非相关部分注释掉，每次
只执行一个模块，然后对照程序和图形来学习。


batik-1.7/batik-rasterizer.jar是转化SVG到png等其他图像格式的核心软件，因为体积很大，请用户自己下载http://xmlgraphics.apache.org/batik/

Font-ttf/有一个arial字体的转化例子，用户可以用batik-1.7/batik-ttf2svg.jar自行尝试。


