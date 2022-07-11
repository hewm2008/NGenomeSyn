#!D:/perl/bin/perl.exe

use strict;
use lib "E:\2.study\01.program-language\04.SVG\SVG-论坛发布\perl-SVG";
use SVG;
use FontSize;

my $svg = SVG->new('width',640,'height',480);
my $font = FontSize->new();

##header notes
$svg->title('id','document-title','-cdata','This is the title');
$svg->desc('id','document-desc', '-cdata','This is a description');
$svg->comment('comment 1','comment 2','comment 3');


##basic shapes
$svg->circle('cx',400,'cy',200,'r',100,'stroke','red','fill','green');
$svg->ellipse('cx',200,'cy',200,'rx',100,'ry',50,'stroke','red','fill','green');
$svg->line('x1',0,'y1',0,'x2',100,'y2',100,'stroke','red','stroke-width',3);
$svg->rect('x',10, 'y',20,'width',40,'height',50,'stroke','red','fill','green');
$svg->text('x',400,'y',400,'stroke','red','fill','red','-cdata','hello, world');
$svg->polygon('points',[0,0,100,0,50,50],'fill','red','stroke','green');
$svg->tag('circle', 'cx',400,'cy',200,'r',100,'stroke','red','fill','green');
$svg->tag('path', 'd', "M 0 0 L 100 0 L50 100 Z");


##how to use Font.pm
##Main supproted fonts include:
##  Courier Courier-Bold Courier-Italic Courier-BoldItalic
##  Helvetica Helvetica-Bold Helvetica-BoldOblique Helvetica-Oblique
##  Times-Bold Times-BoldItalic Times-Italic Times-Roman
##  ArialNarrow ArialNarrow-Bold ArialNarrow-Italic ArialNarrow-BoldItalic 
my $string = "Good Work";
my $font_type = "ArialNarrow";
my $font_size = 12;
my $string_width = $font->stringWidth($font_type,$font_size,$string);
my $string_height = $font->stringHeight($font_size);
$svg->text('x',10,'y',300,"fill","red",'-cdata',"String: $string; String width: $string_width; String height: $string_height;");



##indicates the hyperlink and defines where the link goes
my $anch = $svg->anchor(
         -href=>'http://www.google.com/',
    );
$anch->circle(cx=>100,cy=>100,r=>50,'fill','red');


##how to use group
#SVG transform 属性下有几个转换函数。其中的rotate用来使目标对象绕一点旋转一定的角度。rotate的格式如下：
#rotate([angle] [px,py])
#[angle] : 旋转角度。 由于屏幕坐标和数学坐标的Y轴相反，所以向左旋转为正角度值。
#[px,py] : 旋转的中心点。参数缺省默认为圆点（0,0）。
my $g1 = $svg->group("transform"=>"translate(300,400) scale(0.8) rotate(-90)");
$g1->circle('cx',400,'cy',400,'r',30,"fill",'yellow');
$g1->text('x',100,'y',100,'-cdata',"good mood","stroke","blue");



##how to use script
my $st1 = $svg->script();
$st1->CDATA(
	qq(
		function showmsg()
		{
			alert("good mood");
		}
	)
);
$svg->text('x',100,'y',100,'-cdata',"good mood","stroke","blue",'onclick','showmsg()');



##how to use style
my $stl = $svg->style(type=>"text/css");
$stl->CDATA(
	qq(
		rect {stroke:black; fill:yellow}
		rect.differe {stroke:red; fill:none}
		rect.fanw {stroke:green; fill:olive}
	)
);
$svg->rect('x',10, 'y',20,'width',40,'height',50);
$svg->rect('class','differe','x',10, 'y',120,'width',40,'height',50);
$svg->rect('class','fanw','x',10, 'y',220,'width',40,'height',50);



##how to use color linear gradient
my $gra1 = $svg->gradient(
        -type => "linear",
        id    => "gradient_1",
		gradientUnits => "userSpaceOnUse",
		x1	=>	0,
		x2	=>	100,
		
    );
$gra1->stop('offset'=>0,style=>"stop-color:red");
$gra1->stop('offset'=>1,style=>"stop-color:blue");
$svg->rect('x',0, 'y',0,'width',100,'height',20,'fill','url(#gradient_1)');




##how to use color radial gradient
my $gra1 = $svg->gradient(
        -type => "radial",
        id    => "gradient_2",
		gradientUnits => "userSpaceOnUse",
		cx	=>	100,
		cy	=>	100,
		r	=>	50,
    );
$gra1->stop('offset'=>0,style=>"stop-color:green");
$gra1->stop('offset'=>1,style=>"stop-color:red");
$svg->circle('cx',120,'cy',100,'r',50,'fill','url(#gradient_2)');


##how to use defs, only show in text, no program
##http://www.w3.org/TR/SVG/struct.html#DefsElement
##The 'defs' element is a container element for referenced elements. For understandability and accessibility reasons, it is recommended that, whenever possible, referenced elements be defined inside of a 'defs'.
##Elements that are descendants of a 'defs' are not rendered directly; they are prevented from becoming part of the rendering tree,however, that the descendants of a 'defs' are always present in the source tree and thus can always be referenced by other elements;

#	<defs>
#		<linearGradient gradientUnits="userSpaceOnUse" id="gradient_1" x1="0" x2="100">
#			<stop offset="0" style="stop-color:red" />
#			<stop offset="1" style="stop-color:blue" />
#		</linearGradient>
#	</defs>
#	<rect fill="url(#gradient_1)" height="20" width="100" x="0" y="0" />



##show how to use path
#Path Command Meaning Parameters
#M Establish origin at point specified 
#L Straight line path from current position to point specified
#H Horizontal line path from current position to point specified
#V Vertical line path from current position to point specified
#Z Straight line back to original point
#
#If the path being specified consists of many short paths, it may well be more efficient to define the path
#as relative positions from the previous current position. If the command uses a lower case letter, this
#indicates that the coordinates defined for this command are relative to the previous current position.
#
#Paths can also be defined as curves (quadratic and cubic bezier, and elliptical arcs). Probably the
#most useful is the cubic bezier. This has the initial letter C and has three coordinates as its
#parameters. A curved path is defined from the current position (either established by a Move
#command or a previous line or curve command) to the third point defined in the cubic bezier. The first
#two points define the bezier control points that give the shape of the curve (Figure 5.2). The
#positioning of the control points change the shape of the curve under the user's control as can be seen
#in Figure 5.3.
#
#<path d="M 0 0 L 100 0 L50 100 Z">
#<path d="M 0 312
#C 40 360 120 280 160 306 C 160 306 165 310 170 303
#C 180 200 220 220 260 261 C 260 261 280 273 290 268
#C 288 280 272 285 250 285 C 195 283 210 310 230 320
#C 260 340 265 385 200 391 C 150 395 30 395 0 312 Z"/>
#


print $svg->xmlify();
