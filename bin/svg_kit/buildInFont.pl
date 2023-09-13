#!/usr/bin/perl -w
#Author:Li Shengting
#E-mail:lishengting@genomics.org.cn
#Program Date:2002-12-2015:53
#Last Update:2006-11-14 0:19
#Describe:add fonts defs to svg for batik
my $ver=1.00; #
use strict;
#use diagnostics;
#use Getopt::Long;

######################################################################################################################
#	Usage
######################################################################################################################
my $usage=<<"USAGE";
#$ver Usage: buildInFont <svg_file> <font_file|x> <out_svg> [font-name]
USAGE
my $argvNumber=3;
die $usage if (@ARGV<$argvNumber);
undef($usage);
undef($argvNumber);
######################################################################################################################
#my %opts;
#GetOptions(\%opts,"a!","b:s");
######################################################################################################################
#	Constant
######################################################################################################################
#use constant PI => 3.1415926535897932384626433832795;
######################################################################################################################
#	Variable
######################################################################################################################
my ($svgF,$fontF,$outSvg)=@ARGV;
my ($font,$defs);
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	Begin
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
open(F,"$svgF") || die "Can't open $svgF!\n";
open(O,">$outSvg") || die "Can't write $outSvg!\n";
if ($fontF eq "x") {
	$fontF=$0;
}
$defs=0;
while (<F>) {
	next if (/<Author>/);
	next if (/<E-mail>/);
	next if (/<Version>/);
	next if (/<Drawer>/);
	next if (/<Date>/);
	print O;
	if (/<svg/) {
		open(FONT,"$fontF") || die "Can't open $fontF!\n";
		while ($font=<FONT>) {
			if ($font=~/<defs\s+>/) {
				$defs=1;
			}
			if ($defs) {
				print O $font;
			}
			if ($font=~/<\/defs>/) {
				$defs=0;
			}
		}
	}
}
close(F);
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	Subprogram
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	End
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
=pod
<defs >
<font horiz-adv-x="980" ><font-face
    font-family="Arial-Bold"
    units-per-em="2048"
    panose-1="2 11 7 4 2 2 2 2 2 4"
    ascent="1854"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1536" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="569" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="682" d="M257 378L184 1122V1466H488V1122L416 378H257ZM196 0V281H477V0H196Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="971" d="M165 945L112 1218V1466H418V1218L372 945H165ZM616 945L563 1218V1466H869V1218L823 945H616Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1139" d="M154 365H18V585H198L258 880H18V1101H303L382 1491H606L527 1101H748L825 1491H1057L977 1101H1115V880H932L872 585H1115V365H827L748 -25H525L602 365H380L301 -25H75L154 365ZM483 880L424
585H646L704 880H483Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1139" d="M489 217V636Q293 692 202 805T110 1081Q110 1245 213 1356T489 1485V1584H634V1485Q793 1466 887 1377T1007 1137L754 1104Q731 1222 634 1264V873Q874 808 961 705T1048 439Q1048 258 939 134T634
-18V-205H489V-23Q316 -2 208 106T70 411L331 439Q347 359 391 301T489 217ZM489 1267Q430 1247 395 1199T360 1093Q360 1040 392 995T489 921V1267ZM634 203Q709 217 756 272T803 403Q803 470 764 518T634 593V203Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1821" d="M89 1104Q89 1301 175 1396T410 1491Q563 1491 649 1397T736 1104Q736 907 650 812T415 717Q262 717 176 811T89 1104ZM308 1106Q308 963 341 914Q366 878 410 878Q455 878 480 914Q512 963 512
1106Q512 1249 480 1297Q455 1334 410 1334Q366 1334 341 1298Q308 1249 308 1106ZM624 -56H416L1197 1491H1399L624 -56ZM1078 329Q1078 526 1164 621T1401 716Q1552 716 1638 621T1725 329Q1725 131 1639 36T1404 -59Q1251 -59 1165 36T1078 329ZM1297 330Q1297
187 1330 139Q1355 102 1399 102Q1444 102 1468 138Q1501 187 1501 330Q1501 473 1469 522Q1444 558 1399 558Q1354 558 1330 522Q1297 473 1297 330Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1479" d="M1446 179L1276 -38Q1151 23 1036 130Q947 50 847 12T609 -26Q335 -26 197 128Q90 247 90 402Q90 543 174 655T425 851Q350 940 312 1020T274 1173Q274 1306 380 1398T684 1491Q874 1491
981 1394T1088 1157Q1088 1068 1035 988T821 807L1025 538Q1061 602 1087 705L1341 647Q1303 512 1275 450T1215 345Q1262 301 1336 249T1446 179ZM681 976L757 1034Q841 1099 841 1163Q841 1217 801 1255T691 1293Q624 1293 586 1260T548 1182Q548 1130 612 1056L681
976ZM571 671Q474 622 426 553T378 412Q378 321 437 264T597 206Q663 206 724 232T857 318L571 671Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="487" d="M145 945L92 1218V1466H398V1218L352 945H145Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M613 -431H420Q267 -200 187 49T107 531Q107 820 206 1078Q292 1302 424 1491H616Q479 1188 428 976T376 525Q376 361 406 189T490 -138Q525 -240 613 -431Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M69 -431Q152 -253 186 -158T249 61T292 296T306 525Q306 763 255 975T67 1491H258Q409 1276 492 1035T576 546Q576 337 510 98Q435 -170 263 -431H69Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="797" d="M245 792L94 909Q166 990 244 1064Q275 1094 283 1102Q258 1106 140 1135Q55 1156 28 1166L87 1342Q218 1289 321 1225Q297 1388 297 1491H475Q475 1418 448 1223Q468 1231 534 1262Q624 1303 700
1332L753 1151Q642 1126 496 1102L616 967Q652 926 673 900L520 799L385 1022Q324 914 245 792Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1196" d="M469 211V592H85V855H469V1236H725V855H1110V592H725V211H469Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="569" d="M140 281H421V80Q421 -42 400 -112T321 -239T172 -327L117 -211Q202 -183 238 -134T276 0H140V281Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M65 391V672H617V391H65Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="569" d="M147 0V281H428V0H147Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M-3 -25L360 1491H571L204 -25H-3Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1139" d="M562 1472Q775 1472 895 1320Q1038 1140 1038 723Q1038 307 894 125Q775 -25 562 -25Q348 -25 217 139T86 726Q86 1140 230 1322Q349 1472 562 1472ZM562 1239Q511 1239 471 1207T409 1090Q380 981
380 723Q380 465 406 369T471 240T562 208Q613 208 653 240T715 357Q744 465 744 723Q744 981 718 1077T653 1206T562 1239Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1139" d="M806 0H525V1059Q371 915 162 846V1101Q272 1137 401 1237T578 1472H806V0Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1139" d="M1036 261V0H51Q67 148 147 280T463 632Q653 809 696 872Q754 959 754 1044Q754 1138 704 1188T564 1239Q476 1239 424 1186T364 1010L84 1038Q109 1270 241 1371T571 1472Q788 1472 912 1355T1036
1064Q1036 965 1001 876T888 688Q837 623 704 501T536 339T478 261H1036Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1139" d="M77 389L349 422Q362 318 419 263T557 208Q644 208 703 274T763 452Q763 558 706 620T567 682Q513 682 438 661L469 890Q583 887 643 939T703 1079Q703 1153 659 1197T542 1241Q470 1241 419 1191T357
1045L98 1089Q125 1222 179 1301T331 1426T550 1472Q757 1472 882 1340Q985 1232 985 1096Q985 903 774 788Q900 761 975 667T1051 440Q1051 247 910 111T559 -25Q360 -25 229 89T77 389Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1139" d="M638 0V295H38V541L674 1472H910V542H1092V295H910V0H638ZM638 542V1043L301 542H638Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1139" d="M91 377L371 406Q383 311 442 256T578 200Q666 200 727 271T788 487Q788 622 728 689T570 757Q449 757 353 650L125 683L269 1446H1012V1183H482L438 934Q532 981 630 981Q817 981 947 845T1077 492Q1077
311 972 169Q829 -25 575 -25Q372 -25 244 84T91 377Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1139" d="M1039 1107L767 1077Q757 1161 715 1201T606 1241Q517 1241 456 1161T378 828Q483 952 639 952Q815 952 940 818T1066 472Q1066 247 934 111T595 -25Q373 -25 230 147T87 713Q87 1116 236 1294T623
1472Q790 1472 899 1379T1039 1107ZM402 494Q402 357 465 283T609 208Q687 208 739 269T791 469Q791 612 735 678T595 745Q514 745 458 682T402 494Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1139" d="M87 1185V1446H1048V1242Q929 1125 806 906T619 441T555 0H284Q291 304 409 620T726 1185H87Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1139" d="M328 791Q219 837 170 917T120 1094Q120 1258 234 1365T560 1472Q769 1472 884 1365T1000 1094Q1000 992 947 913T798 791Q920 742 983 648T1047 431Q1047 228 918 101T573 -26Q373 -26 240 79Q83
203 83 419Q83 538 142 637T328 791ZM386 1074Q386 990 433 943T560 896Q640 896 688 943T736 1075Q736 1154 689 1201T563 1249Q482 1249 434 1201T386 1074ZM360 446Q360 330 419 265T568 200Q655 200 712 262T769 443Q769 546 711 608T564 671Q461 671 411 600T360
446Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1139" d="M93 339L365 369Q375 286 417 246T528 206Q615 206 676 286T754 618Q648 495 489 495Q316 495 191 628T65 976Q65 1199 197 1335T535 1472Q758 1472 901 1300T1044 732Q1044 330 895 152T507 -26Q335
-26 229 65T93 339ZM729 953Q729 1089 667 1164T522 1239Q444 1239 393 1178T341 976Q341 834 397 768T537 701Q618 701 673 765T729 953Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="682" d="M201 781V1062H482V781H201ZM201 0V281H482V0H201Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="682" d="M193 781V1062H474V781H193ZM193 281H474V80Q474 -42 453 -112T374 -239T225 -327L170 -211Q255 -183 291 -133T329 0H193V281Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1196" d="M1100 167L95 604V846L1100 1281V996L399 728L1100 450V167Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1196" d="M85 816V1074H1110V816H85ZM85 372V631H1110V372H85Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1196" d="M95 166V449L797 725L95 998V1279L1101 844V604L95 166Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1251" d="M751 378H496Q495 433 495 445Q495 569 536 649T700 829T847 960Q884 1009 884 1068Q884 1150 819 1208T642 1267Q535 1267 463 1206T364 1020L106 1052Q117 1231 258 1356T630 1481Q872 1481
1015 1355T1158 1060Q1158 967 1106 884T881 658Q792 584 771 539T751 378ZM496 0V281H777V0H496Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1997" d="M1777 19H1990Q1890 -184 1683 -299Q1446 -431 1105 -431Q775 -431 535 -320T178 9T61 483Q61 764 194 1006T558 1370T1086 1492Q1338 1492 1534 1394T1833 1116T1937 721Q1937 466 1780 260Q1583 0
1275 0Q1192 0 1150 29T1094 114Q976 0 822 0Q656 0 547 114T437 419Q437 654 569 848Q729 1084 979 1084Q1157 1084 1242 948L1267 1059H1531L1380 342Q1366 274 1366 254Q1366 229 1377 217T1405 204Q1453 204 1529 262Q1631 338 1694 466T1757 731Q1757 977
1579 1142T1082 1308Q811 1308 623 1198T339 887T243 469Q243 258 349 85T648 -167T1089 -247Q1328 -247 1500 -181T1777 19ZM696 430Q696 303 747 243T875 183Q932 183 982 211Q1020 231 1057 274Q1110 335 1148 452T1187 670Q1187 783 1135 843T1002 904Q916
904 843 838T733 648T696 430Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1479" d="M1471 0H1149L1021 333H435L314 0H0L571 1466H884L1471 0ZM926 580L724 1124L526 580H926Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1479" d="M150 1466H736Q910 1466 995 1452T1148 1391T1261 1269T1306 1097Q1306 994 1251 908T1100 779Q1234 740 1306 646T1378 425Q1378 325 1332 231T1205 80T1006 10Q932 2 649 0H150V1466ZM446 1222V883H640Q813
883 855 888Q931 897 974 940T1018 1055Q1018 1123 981 1165T869 1217Q825 1222 616 1222H446ZM446 639V247H720Q880 247 923 256Q989 268 1030 314T1072 439Q1072 505 1040 551T948 618T685 639H446Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1479" d="M1087 539L1374 448Q1308 208 1155 92T765 -25Q473 -25 285 174T97 720Q97 1086 286 1288T783 1491Q1052 1491 1220 1332Q1320 1238 1370 1062L1077 992Q1051 1106 969 1172T768 1238Q605 1238 504 1121T402
742Q402 464 502 346T762 228Q880 228 965 303T1087 539Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M148 1466H689Q872 1466 968 1438Q1097 1400 1189 1303T1329 1066T1377 719Q1377 538 1332 407Q1277 247 1175 148Q1098 73 967 31Q869 0 705 0H148V1466ZM444 1218V247H665Q789 247 844 261Q916 279
963 322T1041 463T1071 732Q1071 902 1041 993T957 1135T820 1204Q758 1218 577 1218H444Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M149 0V1466H1236V1218H445V893H1181V646H445V247H1264V0H149Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M151 0V1466H1156V1218H447V871H1059V623H447V0H151Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1593" d="M831 539V786H1469V202Q1376 112 1200 44T842 -25Q612 -25 441 71T184 347T98 738Q98 967 194 1145T475 1418Q616 1491 826 1491Q1099 1491 1252 1377T1450 1060L1156 1005Q1125 1113 1040 1175T826 1238Q632
1238 518 1115T403 750Q403 489 519 359T823 228Q916 228 1009 264T1170 353V539H831Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M150 0V1466H446V889H1026V1466H1322V0H1026V641H446V0H150Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="569" d="M140 0V1466H436V0H140Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1139" d="M678 1466H973V538Q973 356 941 258Q898 130 785 53T487 -25Q270 -25 153 96T35 453L314 485Q319 359 351 307Q399 228 497 228Q596 228 637 284T678 519V1466Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1479" d="M153 0V1466H449V815L1047 1466H1445L893 895L1475 0H1092L689 688L449 443V0H153Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1251" d="M157 0V1454H453V247H1189V0H157Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1706" d="M145 0V1466H588L854 466L1117 1466H1561V0H1286V1154L995 0H710L420 1154V0H145Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M152 0V1466H440L1040 487V1466H1315V0H1018L427 956V0H152Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1593" d="M89 724Q89 948 156 1100Q206 1212 292 1301T482 1433Q619 1491 798 1491Q1122 1491 1316 1290T1511 731Q1511 376 1318 176T802 -25Q475 -25 282 174T89 724ZM394 734Q394 485 509 357T801 228Q978 228
1091 355T1205 738Q1205 990 1095 1114T801 1238Q618 1238 506 1113T394 734Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1366" d="M149 0V1466H624Q894 1466 976 1444Q1102 1411 1187 1301T1272 1015Q1272 880 1223 788T1099 644T945 574Q839 553 638 553H445V0H149ZM445 1218V802H607Q782 802 841 825T933 897T967 1011Q967 1091
920 1143T801 1208Q748 1218 588 1218H445Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1593" d="M1329 186Q1438 108 1566 62L1457 -147Q1390 -127 1326 -92Q1312 -85 1129 38Q985 -25 810 -25Q472 -25 281 174T89 733Q89 1092 281 1291T802 1491Q1128 1491 1319 1292T1510 733Q1510 543 1457 399Q1417
289 1329 186ZM1091 353Q1148 420 1176 515T1205 733Q1205 987 1093 1112T800 1238Q619 1238 507 1112T394 733Q394 476 506 349T791 221Q855 221 912 242Q822 301 729 334L812 503Q958 453 1091 353Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1479" d="M150 0V1466H773Q1008 1466 1114 1427T1285 1286T1349 1055Q1349 890 1252 783T962 647Q1058 591 1120 524T1289 286L1468 0H1114L900 319Q786 490 744 534T655 595T506 612H446V0H150ZM446 846H665Q878
846 931 864T1014 926T1044 1036Q1044 1110 1005 1155T893 1213Q857 1218 677 1218H446V846Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1366" d="M74 477L362 505Q388 360 467 292T682 224Q825 224 897 284T970 426Q970 478 940 514T833 578Q781 596 596 642Q358 701 262 787Q127 908 127 1082Q127 1194 190 1291T373 1440T662 1491Q938 1491 1077
1370T1224 1047L928 1034Q909 1147 847 1196T659 1246Q530 1246 457 1193Q410 1159 410 1102Q410 1050 454 1013Q510 966 726 915T1045 810T1207 661T1266 427Q1266 301 1196 191T998 28T679 -26Q401 -26 252 102T74 477Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M479 0V1218H44V1466H1209V1218H775V0H479Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M147 1466H443V672Q443 483 454 427Q473 337 544 283T740 228Q866 228 930 279T1007 406T1020 655V1466H1316V696Q1316 432 1292 323T1204 139T1031 20T749 -25Q539 -25 431 23T259 149T176 312Q147 438
147 684V1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1366" d="M523 0L-1 1466H320L691 381L1050 1466H1364L839 0H523Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1933" d="M357 0L7 1466H310L531 459L799 1466H1151L1408 442L1633 1466H1931L1575 0H1261L969 1096L678 0H357Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1366" d="M0 0L501 765L47 1466H393L687 995L975 1466H1318L862 754L1363 0H1006L681 507L355 0H0Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1366" d="M534 0V617L-3 1466H344L689 886L1027 1466H1368L829 615V0H534Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M22 0V267L792 1218H109V1466H1182V1236L379 247H1213V0H22Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="682" d="M146 -413V1466H644V1245H413V-192H644V-413H146Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M-3 1491H204L571 -25H360L-3 1491Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="682" d="M536 1466V-413H38V-192H269V1247H38V1466H536Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="1196" d="M115 692L491 1491H714L1080 692H796L598 1181L401 692H115Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1139" d="M-19 -405V-223H1149V-405H-19Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M495 1192H318L42 1491H357L495 1192Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1139" d="M357 738L102 784Q145 938 250 1012T562 1086Q750 1086 842 1042T971 929T1009 677L1006 349Q1006 209 1019 143T1070 0H792Q781 28 765 83Q758 108 755 116Q683 46 601 11T426 -24Q262 -24 168 65T73
290Q73 380 116 450T236 558T460 624Q657 661 733 693V721Q733 802 693 836T542 871Q467 871 425 842T357 738ZM733 510Q679 492 562 467T409 418Q354 379 354 319Q354 260 398 217T510 174Q586 174 655 224Q706 262 722 317Q733 353 733 454V510Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1251" d="M135 0V1466H416V938Q546 1086 724 1086Q918 1086 1045 946T1172 542Q1172 270 1043 123T728 -24Q637 -24 549 21T396 156V0H135ZM414 554Q414 389 466 310Q539 198 660 198Q753 198 818 277T884 528Q884
710 818 790T649 871Q548 871 481 793T414 554Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="1139" d="M1073 748L796 698Q782 781 733 823T604 865Q499 865 437 793T374 550Q374 361 437 283T608 205Q688 205 739 250T811 407L1087 360Q1044 170 922 73T595 -24Q362 -24 224 123T85 530Q85 793 224 939T600
1086Q794 1086 908 1003T1073 748Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1251" d="M1121 0H860V156Q795 65 707 21T528 -24Q345 -24 215 123T84 535Q84 805 211 945T532 1086Q710 1086 840 938V1466H1121V0ZM371 554Q371 384 418 308Q486 198 608 198Q705 198 773 280T841 527Q841 710
775 790T606 871Q506 871 439 792T371 554Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="1139" d="M762 338L1042 291Q988 137 872 57T580 -24Q303 -24 170 157Q65 302 65 523Q65 787 203 936T552 1086Q789 1086 926 930T1057 450H353Q356 325 421 256T583 186Q649 186 694 222T762 338ZM778 622Q775
744 715 807T569 871Q477 871 417 804Q357 737 358 622H778Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="682" d="M24 1062H180V1142Q180 1276 208 1342T313 1449T507 1491Q627 1491 742 1455L704 1259Q637 1275 575 1275Q514 1275 488 1247T461 1137V1062H671V841H461V0H180V841H24V1062Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1251" d="M121 -70L442 -109Q450 -165 479 -186Q519 -216 605 -216Q715 -216 770 -183Q807 -161 826 -112Q839 -77 839 17V172Q713 0 521 0Q307 0 182 181Q84 324 84 537Q84 804 212 945T532 1086Q729 1086 857
913V1062H1120V109Q1120 -79 1089 -172T1002 -318T853 -401T616 -431Q346 -431 233 -339T120 -104Q120 -90 121 -70ZM372 553Q372 384 437 306T599 227Q702 227 773 307T844 546Q844 711 776 791T604 871Q503 871 438 793T372 553Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1251" d="M427 1466V927Q563 1086 752 1086Q849 1086 927 1050T1044 958T1098 834T1113 623V0H832V561Q832 728 816 773T760 844T658 871Q588 871 533 837T453 735T427 532V0H146V1466H427Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M147 1206V1466H428V1206H147ZM147 0V1062H428V0H147Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="569" d="M141 1206V1466H422V1206H141ZM422 1062V33Q422 -170 396 -253T294 -384T101 -431Q59 -431 11 -424T-94 -401L-45 -161Q-25 -165 -8 -167T25 -170Q68 -170 95 -152T132 -107T141 49V1062H422Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1139" d="M137 0V1466H418V688L747 1062H1093L730 674L1119 0H816L549 477L418 340V0H137Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M147 0V1466H428V0H147Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1821" d="M126 1062H385V917Q524 1086 716 1086Q818 1086 893 1044T1016 917Q1086 1002 1167 1044T1340 1086Q1457 1086 1538 1039T1659 899Q1688 831 1688 679V0H1407V607Q1407 765 1378 811Q1339 871 1258 871Q1199
871 1147 835T1072 730T1049 510V0H768V582Q768 737 753 782T707 849T621 871Q556 871 504 836T430 735T407 516V0H126V1062Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1251" d="M1113 0H832V542Q832 714 814 764T756 843T658 871Q585 871 527 831T448 725T426 481V0H145V1062H406V906Q545 1086 756 1086Q849 1086 926 1053T1042 967T1097 849T1113 660V0Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1251" d="M82 546Q82 686 151 817T346 1017T629 1086Q870 1086 1024 930T1178 534Q1178 293 1023 135T631 -24Q485 -24 353 42T151 235T82 546ZM370 531Q370 373 445 289T630 205Q740 205 814 289T889 533Q889
689 815 773T630 857Q520 857 445 773T370 531Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1251" d="M139 1062H401V906Q452 986 539 1036T732 1086Q917 1086 1046 941T1175 537Q1175 271 1045 124T730 -24Q642 -24 571 11T420 131V-404H139V1062ZM417 549Q417 370 488 285T661 199Q759 199 824 277T889
535Q889 702 822 783T656 864Q553 864 485 785T417 549Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1251" d="M841 -404V130Q786 59 704 18T527 -24Q346 -24 229 112Q91 271 91 543Q91 799 220 942T542 1086Q648 1086 725 1041T863 905V1062H1122V-404H841ZM850 544Q850 707 784 786T617 866Q515 866 447 785T378
528Q378 353 444 276T607 198Q704 198 777 285T850 544Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="797" d="M416 0H135V1062H396V911Q463 1018 516 1052T638 1086Q734 1086 823 1033L736 788Q665 834 604 834Q545 834 504 802T440 684T416 328V0Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="1139" d="M48 303L330 346Q348 264 403 222T557 179Q666 179 721 219Q758 247 758 294Q758 326 738 347Q717 367 644 384Q304 459 213 521Q87 607 87 760Q87 898 196 992T534 1086Q752 1086 858 1015T1004 805L739
756Q722 818 675 851T539 884Q428 884 380 853Q348 831 348 796Q348 766 376 745Q414 717 638 666T952 541Q1040 466 1040 332Q1040 186 918 81T557 -24Q340 -24 214 64T48 303Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="682" d="M634 1062V838H442V410Q442 280 447 259T472 223T520 209Q559 209 633 236L657 18Q559 -24 435 -24Q359 -24 298 1T209 67T169 177Q160 226 160 375V838H31V1062H160V1273L442 1437V1062H634Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1251" d="M846 0V159Q788 74 694 25T494 -24Q387 -24 302 23T179 155T141 390V1062H422V574Q422 350 437 300T494 220T598 190Q670 190 727 229T805 327T826 614V1062H1107V0H846Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1139" d="M439 0L11 1062H306L506 520L564 339Q587 408 593 430Q607 475 623 520L825 1062H1114L692 0H439Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1593" d="M345 0L9 1062H282L481 366L664 1062H935L1112 366L1315 1062H1592L1251 0H981L798 683L618 0H345Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1139" d="M12 0L395 547L28 1062H371L559 770L757 1062H1087L727 559L1120 0H775L559 329L341 0H12Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1139" d="M14 1062H313L567 308L815 1062H1106L731 40L664 -145Q627 -238 594 -287T517 -366T410 -414T266 -431Q185 -431 107 -414L82 -194Q148 -207 201 -207Q299 -207 346 -150T418 -3L14 1062Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="1024" d="M34 0V219L432 676Q530 788 577 835Q528 832 448 831L73 829V1062H951V863L545 395L402 240Q519 247 547 247H982V0H34Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="797" d="M60 410V650Q133 654 170 672T234 732T271 839Q279 887 279 1006Q279 1200 297 1276T362 1399T499 1473Q560 1491 691 1491H744V1252Q633 1252 602 1240T555 1202T540 1114Q540 1051 531 875Q526
776 505 715T452 613T352 530Q411 496 448 451T506 340T532 166Q539 0 539 -46Q539 -112 555 -138T603 -177T744 -191V-431H691Q556 -431 484 -410T363 -338T296 -215T279 17Q279 201 263 256Q241 336 197 370T60 410Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="573" d="M176 -431V1491H399V-431H176Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="797" d="M729 410Q656 406 619 388T556 328T518 221Q510 173 510 55Q510 -139 493 -216T428 -339T290 -413Q229 -431 98 -431H45V-191Q152 -191 185 -178T233 -139T249 -52T258 181Q263 285 285 347T343
453T437 530Q363 578 329 624Q282 690 265 792Q254 862 249 1100Q248 1175 236 1200T191 1238T45 1252V1491H98Q233 1491 305 1470T426 1399T492 1275T510 1043Q510 860 525 804Q547 724 592 690T729 650V410Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1196" d="M67 519V778Q194 916 363 916Q426 916 479 904T669 836T856 780Q912 780 985 814T1129 924V654Q1083 606 1001 564T830 522Q780 522 733 534T582 591Q428 658 340 658Q200 658 67 519Z" />
<hkern g1="space" g2="A" k="76" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Alphatonos" k="76" />
<hkern g1="space" g2="Alpha" k="76" />
<hkern g1="space" g2="Delta" k="76" />
<hkern g1="space" g2="Lambda" k="76" />
<hkern g1="space" g2="Upsilon" k="37" />
<hkern g1="space" g2="Upsilondieresis" k="37" />
<hkern g1="one" g2="one" k="113" />
<hkern g1="A" g2="space" k="76" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="113" />
<hkern g1="A" g2="Y" k="188" />
<hkern g1="A" g2="v" k="76" />
<hkern g1="A" g2="w" k="37" />
<hkern g1="A" g2="y" k="76" />
<hkern g1="A" g2="quoteright" k="113" />
<hkern g1="F" g2="comma" k="227" />
<hkern g1="F" g2="period" k="227" />
<hkern g1="F" g2="A" k="113" />
<hkern g1="L" g2="space" k="37" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="152" />
<hkern g1="L" g2="W" k="113" />
<hkern g1="L" g2="Y" k="188" />
<hkern g1="L" g2="y" k="76" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="P" g2="space" k="37" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="76" />
<hkern g1="T" g2="comma" k="227" />
<hkern g1="T" g2="hyphen" k="113" />
<hkern g1="T" g2="period" k="227" />
<hkern g1="T" g2="colon" k="227" />
<hkern g1="T" g2="semicolon" k="227" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="152" />
<hkern g1="T" g2="c" k="152" />
<hkern g1="T" g2="e" k="152" />
<hkern g1="T" g2="i" k="37" />
<hkern g1="T" g2="o" k="152" />
<hkern g1="T" g2="r" k="113" />
<hkern g1="T" g2="s" k="152" />
<hkern g1="T" g2="u" k="152" />
<hkern g1="T" g2="w" k="152" />
<hkern g1="T" g2="y" k="152" />
<hkern g1="V" g2="comma" k="188" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="188" />
<hkern g1="V" g2="colon" k="113" />
<hkern g1="V" g2="semicolon" k="113" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="113" />
<hkern g1="V" g2="e" k="113" />
<hkern g1="V" g2="i" k="37" />
<hkern g1="V" g2="o" k="152" />
<hkern g1="V" g2="r" k="113" />
<hkern g1="V" g2="u" k="76" />
<hkern g1="V" g2="y" k="76" />
<hkern g1="W" g2="comma" k="113" />
<hkern g1="W" g2="hyphen" k="41" />
<hkern g1="W" g2="period" k="113" />
<hkern g1="W" g2="colon" k="37" />
<hkern g1="W" g2="semicolon" k="37" />
<hkern g1="W" g2="A" k="113" />
<hkern g1="W" g2="a" k="76" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="18" />
<hkern g1="W" g2="o" k="37" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="37" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="227" />
<hkern g1="Y" g2="hyphen" k="113" />
<hkern g1="Y" g2="period" k="227" />
<hkern g1="Y" g2="colon" k="152" />
<hkern g1="Y" g2="semicolon" k="152" />
<hkern g1="Y" g2="A" k="188" />
<hkern g1="Y" g2="a" k="113" />
<hkern g1="Y" g2="e" k="113" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="152" />
<hkern g1="Y" g2="p" k="113" />
<hkern g1="Y" g2="q" k="152" />
<hkern g1="Y" g2="u" k="113" />
<hkern g1="Y" g2="v" k="113" />
<hkern g1="f" g2="quoteright" k="-37" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="76" />
<hkern g1="w" g2="period" k="76" />
<hkern g1="y" g2="comma" k="152" />
<hkern g1="y" g2="period" k="152" />
<hkern g1="quoteleft" g2="quoteleft" k="76" />
<hkern g1="quoteright" g2="space" k="113" />
<hkern g1="quoteright" g2="s" k="76" />
<hkern g1="quoteright" g2="quoteright" k="76" />
<hkern g1="quotedblbase" g2="afii10051" k="205" />
<hkern g1="quotedblbase" g2="afii10060" k="205" />
<hkern g1="quotedblbase" g2="afii10036" k="180" />
<hkern g1="quotedblbase" g2="afii10041" k="207" />
<hkern g1="quotedblbase" g2="afii10044" k="180" />
<hkern g1="Gamma" g2="comma" k="225" />
<hkern g1="Gamma" g2="period" k="225" />
<hkern g1="Gamma" g2="Alpha" k="223" />
<hkern g1="Gamma" g2="Delta" k="223" />
<hkern g1="Gamma" g2="Lambda" k="223" />
<hkern g1="Gamma" g2="iotatonos" k="66" />
<hkern g1="Gamma" g2="iota" k="66" />
<hkern g1="Gamma" g2="iotadieresis" k="-94" />
<hkern g1="Theta" g2="Alpha" k="55" />
<hkern g1="Theta" g2="Delta" k="55" />
<hkern g1="Theta" g2="Lambda" k="55" />
<hkern g1="Theta" g2="Upsilon" k="57" />
<hkern g1="Theta" g2="Upsilondieresis" k="57" />
<hkern g1="Phi" g2="Alpha" k="55" />
<hkern g1="Phi" g2="Tau" k="55" />
<hkern g1="Phi" g2="Upsilon" k="57" />
<hkern g1="Phi" g2="Upsilondieresis" k="57" />
<hkern g1="delta" g2="tau" k="57" />
<hkern g1="delta" g2="chi" k="74" />
<hkern g1="delta" g2="pi" k="57" />
<hkern g1="tau" g2="alpha" k="57" />
<hkern g1="tau" g2="delta" k="57" />
<hkern g1="tau" g2="sigma" k="57" />
<hkern g1="tau" g2="phi" k="57" />
<hkern g1="tau" g2="alphatonos" k="57" />
<hkern g1="tau" g2="zeta" k="57" />
<hkern g1="tau" g2="omicron" k="57" />
<hkern g1="tau" g2="sigma1" k="57" />
<hkern g1="tau" g2="omega" k="57" />
<hkern g1="tau" g2="omegatonos" k="57" />
<hkern g1="phi" g2="tau" k="57" />
<hkern g1="phi" g2="lambda" k="25" />
<hkern g1="phi" g2="chi" k="74" />
<hkern g1="phi" g2="pi" k="57" />
<hkern g1="Alphatonos" g2="Theta" k="55" />
<hkern g1="Alphatonos" g2="Phi" k="55" />
<hkern g1="Alphatonos" g2="Omicron" k="55" />
<hkern g1="Alphatonos" g2="Tau" k="170" />
<hkern g1="Alphatonos" g2="Upsilon" k="186" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="186" />
<hkern g1="Alphatonos" g2="gamma" k="76" />
<hkern g1="Alphatonos" g2="nu" k="76" />
<hkern g1="Alphatonos" g2="chi" k="76" />
<hkern g1="Omicrontonos" g2="Upsilon" k="57" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="57" />
<hkern g1="Upsilontonos" g2="Theta" k="78" />
<hkern g1="Upsilontonos" g2="Phi" k="78" />
<hkern g1="Upsilontonos" g2="alpha" k="152" />
<hkern g1="Upsilontonos" g2="delta" k="76" />
<hkern g1="Upsilontonos" g2="sigma" k="152" />
<hkern g1="Upsilontonos" g2="phi" k="152" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-256" />
<hkern g1="Upsilontonos" g2="Alpha" k="186" />
<hkern g1="Upsilontonos" g2="Delta" k="186" />
<hkern g1="Upsilontonos" g2="Lambda" k="186" />
<hkern g1="Upsilontonos" g2="Omicron" k="78" />
<hkern g1="Upsilontonos" g2="Omega" k="78" />
<hkern g1="Upsilontonos" g2="alphatonos" k="152" />
<hkern g1="Upsilontonos" g2="etatonos" k="76" />
<hkern g1="Upsilontonos" g2="iotatonos" k="76" />
<hkern g1="Upsilontonos" g2="eta" k="76" />
<hkern g1="Upsilontonos" g2="iota" k="76" />
<hkern g1="Upsilontonos" g2="kappa" k="76" />
<hkern g1="Upsilontonos" g2="mu" k="76" />
<hkern g1="Upsilontonos" g2="omicron" k="152" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="-92" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="152" />
<hkern g1="Omegatonos" g2="Upsilon" k="57" />
<hkern g1="Omegatonos" g2="Upsilondieresis" k="57" />
<hkern g1="Alpha" g2="quoteright" k="113" />
<hkern g1="Alpha" g2="Theta" k="55" />
<hkern g1="Alpha" g2="Phi" k="55" />
<hkern g1="Alpha" g2="Omicron" k="55" />
<hkern g1="Alpha" g2="Tau" k="170" />
<hkern g1="Alpha" g2="Upsilon" k="186" />
<hkern g1="Alpha" g2="Upsilondieresis" k="186" />
<hkern g1="Alpha" g2="gamma" k="76" />
<hkern g1="Alpha" g2="nu" k="76" />
<hkern g1="Alpha" g2="chi" k="76" />
<hkern g1="Delta" g2="Theta" k="55" />
<hkern g1="Delta" g2="Omicron" k="55" />
<hkern g1="Delta" g2="Tau" k="170" />
<hkern g1="Delta" g2="Upsilon" k="186" />
<hkern g1="Delta" g2="Upsilondieresis" k="186" />
<hkern g1="Kappa" g2="Theta" k="94" />
<hkern g1="Kappa" g2="Phi" k="94" />
<hkern g1="Kappa" g2="alpha" k="47" />
<hkern g1="Kappa" g2="delta" k="47" />
<hkern g1="Kappa" g2="sigma" k="47" />
<hkern g1="Kappa" g2="phi" k="47" />
<hkern g1="Kappa" g2="Omicron" k="94" />
<hkern g1="Kappa" g2="alphatonos" k="47" />
<hkern g1="Kappa" g2="zeta" k="47" />
<hkern g1="Kappa" g2="theta" k="47" />
<hkern g1="Kappa" g2="xi" k="47" />
<hkern g1="Kappa" g2="omicron" k="47" />
<hkern g1="Kappa" g2="omega" k="47" />
<hkern g1="Kappa" g2="omicrontonos" k="47" />
<hkern g1="Kappa" g2="omegatonos" k="47" />
<hkern g1="Lambda" g2="Theta" k="55" />
<hkern g1="Lambda" g2="Omicron" k="55" />
<hkern g1="Lambda" g2="Tau" k="170" />
<hkern g1="Lambda" g2="Upsilon" k="186" />
<hkern g1="Lambda" g2="Upsilondieresis" k="186" />
<hkern g1="Omicron" g2="Alpha" k="55" />
<hkern g1="Omicron" g2="Delta" k="55" />
<hkern g1="Omicron" g2="Lambda" k="55" />
<hkern g1="Omicron" g2="Upsilon" k="57" />
<hkern g1="Omicron" g2="Upsilondieresis" k="57" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="152" />
<hkern g1="Rho" g2="Delta" k="152" />
<hkern g1="Rho" g2="Lambda" k="152" />
<hkern g1="Sigma" g2="tau" k="35" />
<hkern g1="Sigma" g2="pi" k="35" />
<hkern g1="Tau" g2="comma" k="225" />
<hkern g1="Tau" g2="hyphen" k="113" />
<hkern g1="Tau" g2="period" k="225" />
<hkern g1="Tau" g2="colon" k="225" />
<hkern g1="Tau" g2="semicolon" k="225" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="55" />
<hkern g1="Tau" g2="alpha" k="152" />
<hkern g1="Tau" g2="delta" k="84" />
<hkern g1="Tau" g2="epsilon" k="152" />
<hkern g1="Tau" g2="sigma" k="152" />
<hkern g1="Tau" g2="phi" k="152" />
<hkern g1="Tau" g2="iotadieresistonos" k="-242" />
<hkern g1="Tau" g2="Alpha" k="152" />
<hkern g1="Tau" g2="Delta" k="164" />
<hkern g1="Tau" g2="Lambda" k="152" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="152" />
<hkern g1="Tau" g2="epsilontonos" k="152" />
<hkern g1="Tau" g2="gamma" k="152" />
<hkern g1="Tau" g2="eta" k="152" />
<hkern g1="Tau" g2="iota" k="37" />
<hkern g1="Tau" g2="mu" k="152" />
<hkern g1="Tau" g2="nu" k="152" />
<hkern g1="Tau" g2="omicron" k="152" />
<hkern g1="Tau" g2="upsilon" k="152" />
<hkern g1="Tau" g2="chi" k="123" />
<hkern g1="Tau" g2="psi" k="152" />
<hkern g1="Tau" g2="iotadieresis" k="-92" />
<hkern g1="Tau" g2="upsilondieresis" k="152" />
<hkern g1="Tau" g2="omicrontonos" k="152" />
<hkern g1="Tau" g2="upsilontonos" k="152" />
<hkern g1="Upsilon" g2="comma" k="225" />
<hkern g1="Upsilon" g2="hyphen" k="113" />
<hkern g1="Upsilon" g2="period" k="225" />
<hkern g1="Upsilon" g2="colon" k="152" />
<hkern g1="Upsilon" g2="semicolon" k="152" />
<hkern g1="Upsilon" g2="Theta" k="78" />
<hkern g1="Upsilon" g2="Phi" k="78" />
<hkern g1="Upsilon" g2="alpha" k="152" />
<hkern g1="Upsilon" g2="delta" k="76" />
<hkern g1="Upsilon" g2="sigma" k="152" />
<hkern g1="Upsilon" g2="phi" k="152" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-256" />
<hkern g1="Upsilon" g2="Alpha" k="186" />
<hkern g1="Upsilon" g2="Delta" k="186" />
<hkern g1="Upsilon" g2="Lambda" k="186" />
<hkern g1="Upsilon" g2="Omicron" k="78" />
<hkern g1="Upsilon" g2="Omega" k="78" />
<hkern g1="Upsilon" g2="alphatonos" k="152" />
<hkern g1="Upsilon" g2="etatonos" k="76" />
<hkern g1="Upsilon" g2="iotatonos" k="76" />
<hkern g1="Upsilon" g2="gamma" k="84" />
<hkern g1="Upsilon" g2="eta" k="76" />
<hkern g1="Upsilon" g2="iota" k="76" />
<hkern g1="Upsilon" g2="kappa" k="76" />
<hkern g1="Upsilon" g2="mu" k="76" />
<hkern g1="Upsilon" g2="omicron" k="152" />
<hkern g1="Upsilon" g2="iotadieresis" k="-92" />
<hkern g1="Upsilon" g2="omicrontonos" k="152" />
<hkern g1="Chi" g2="omega" k="27" />
<hkern g1="Chi" g2="omegatonos" k="27" />
<hkern g1="Psi" g2="alpha" k="37" />
<hkern g1="Psi" g2="delta" k="37" />
<hkern g1="Psi" g2="sigma" k="37" />
<hkern g1="Psi" g2="phi" k="37" />
<hkern g1="Psi" g2="alphatonos" k="37" />
<hkern g1="Psi" g2="omicron" k="37" />
<hkern g1="Psi" g2="omega" k="37" />
<hkern g1="Psi" g2="omicrontonos" k="37" />
<hkern g1="Psi" g2="omegatonos" k="37" />
<hkern g1="Omega" g2="Upsilon" k="57" />
<hkern g1="Omega" g2="Upsilondieresis" k="57" />
<hkern g1="Upsilondieresis" g2="Theta" k="78" />
<hkern g1="Upsilondieresis" g2="Phi" k="78" />
<hkern g1="Upsilondieresis" g2="alpha" k="152" />
<hkern g1="Upsilondieresis" g2="delta" k="76" />
<hkern g1="Upsilondieresis" g2="sigma" k="152" />
<hkern g1="Upsilondieresis" g2="phi" k="152" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-256" />
<hkern g1="Upsilondieresis" g2="Alpha" k="186" />
<hkern g1="Upsilondieresis" g2="Delta" k="186" />
<hkern g1="Upsilondieresis" g2="Lambda" k="186" />
<hkern g1="Upsilondieresis" g2="Omicron" k="78" />
<hkern g1="Upsilondieresis" g2="Omega" k="78" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="152" />
<hkern g1="Upsilondieresis" g2="etatonos" k="76" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="76" />
<hkern g1="Upsilondieresis" g2="eta" k="76" />
<hkern g1="Upsilondieresis" g2="iota" k="76" />
<hkern g1="Upsilondieresis" g2="kappa" k="76" />
<hkern g1="Upsilondieresis" g2="mu" k="76" />
<hkern g1="Upsilondieresis" g2="omicron" k="152" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="-92" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="152" />
<hkern g1="zeta" g2="alpha" k="115" />
<hkern g1="zeta" g2="delta" k="76" />
<hkern g1="zeta" g2="sigma" k="115" />
<hkern g1="zeta" g2="tau" k="76" />
<hkern g1="zeta" g2="phi" k="115" />
<hkern g1="zeta" g2="alphatonos" k="115" />
<hkern g1="zeta" g2="etatonos" k="49" />
<hkern g1="zeta" g2="gamma" k="66" />
<hkern g1="zeta" g2="eta" k="49" />
<hkern g1="zeta" g2="theta" k="76" />
<hkern g1="zeta" g2="iota" k="49" />
<hkern g1="zeta" g2="kappa" k="49" />
<hkern g1="zeta" g2="nu" k="66" />
<hkern g1="zeta" g2="omicron" k="115" />
<hkern g1="zeta" g2="omega" k="115" />
<hkern g1="zeta" g2="omicrontonos" k="115" />
<hkern g1="zeta" g2="omegatonos" k="115" />
<hkern g1="zeta" g2="pi" k="76" />
<hkern g1="kappa" g2="alpha" k="68" />
<hkern g1="kappa" g2="delta" k="68" />
<hkern g1="kappa" g2="sigma" k="68" />
<hkern g1="kappa" g2="phi" k="68" />
<hkern g1="kappa" g2="alphatonos" k="68" />
<hkern g1="kappa" g2="zeta" k="68" />
<hkern g1="kappa" g2="theta" k="29" />
<hkern g1="kappa" g2="xi" k="68" />
<hkern g1="kappa" g2="omicron" k="68" />
<hkern g1="kappa" g2="sigma1" k="68" />
<hkern g1="kappa" g2="omega" k="68" />
<hkern g1="kappa" g2="omicrontonos" k="68" />
<hkern g1="kappa" g2="omegatonos" k="68" />
<hkern g1="lambda" g2="alpha" k="25" />
<hkern g1="lambda" g2="delta" k="25" />
<hkern g1="lambda" g2="sigma" k="25" />
<hkern g1="lambda" g2="phi" k="25" />
<hkern g1="lambda" g2="alphatonos" k="25" />
<hkern g1="lambda" g2="upsilondieresistonos" k="31" />
<hkern g1="lambda" g2="zeta" k="25" />
<hkern g1="lambda" g2="xi" k="25" />
<hkern g1="lambda" g2="omicron" k="25" />
<hkern g1="lambda" g2="sigma1" k="25" />
<hkern g1="lambda" g2="upsilon" k="31" />
<hkern g1="lambda" g2="omega" k="25" />
<hkern g1="lambda" g2="upsilondieresis" k="31" />
<hkern g1="lambda" g2="omicrontonos" k="25" />
<hkern g1="lambda" g2="upsilontonos" k="31" />
<hkern g1="lambda" g2="omegatonos" k="25" />
<hkern g1="xi" g2="alpha" k="25" />
<hkern g1="xi" g2="delta" k="25" />
<hkern g1="xi" g2="sigma" k="25" />
<hkern g1="xi" g2="phi" k="25" />
<hkern g1="xi" g2="alphatonos" k="25" />
<hkern g1="xi" g2="zeta" k="25" />
<hkern g1="xi" g2="xi" k="25" />
<hkern g1="xi" g2="omicron" k="25" />
<hkern g1="xi" g2="sigma1" k="25" />
<hkern g1="xi" g2="omicrontonos" k="25" />
<hkern g1="omicron" g2="tau" k="57" />
<hkern g1="omicron" g2="chi" k="74" />
<hkern g1="omicron" g2="pi" k="57" />
<hkern g1="rho" g2="tau" k="57" />
<hkern g1="rho" g2="pi" k="57" />
<hkern g1="chi" g2="alpha" k="74" />
<hkern g1="chi" g2="delta" k="74" />
<hkern g1="chi" g2="sigma" k="74" />
<hkern g1="chi" g2="phi" k="74" />
<hkern g1="chi" g2="alphatonos" k="74" />
<hkern g1="chi" g2="zeta" k="74" />
<hkern g1="chi" g2="omicron" k="74" />
<hkern g1="chi" g2="sigma1" k="74" />
<hkern g1="chi" g2="omega" k="43" />
<hkern g1="chi" g2="omicrontonos" k="74" />
<hkern g1="chi" g2="omegatonos" k="43" />
<hkern g1="omega" g2="tau" k="57" />
<hkern g1="omega" g2="chi" k="43" />
<hkern g1="omega" g2="pi" k="57" />
<hkern g1="omicrontonos" g2="tau" k="57" />
<hkern g1="omicrontonos" g2="chi" k="74" />
<hkern g1="omicrontonos" g2="pi" k="57" />
<hkern g1="omegatonos" g2="tau" k="57" />
<hkern g1="omegatonos" g2="chi" k="43" />
<hkern g1="omegatonos" g2="pi" k="57" />
<hkern g1="afii10052" g2="comma" k="231" />
<hkern g1="afii10052" g2="period" k="256" />
<hkern g1="afii10052" g2="colon" k="27" />
<hkern g1="afii10052" g2="semicolon" k="27" />
<hkern g1="afii10052" g2="guillemotleft" k="78" />
<hkern g1="afii10052" g2="guillemotright" k="78" />
<hkern g1="afii10058" g2="quoteright" k="205" />
<hkern g1="afii10059" g2="quoteright" k="205" />
<hkern g1="afii10017" g2="quoteright" k="104" />
<hkern g1="afii10017" g2="afii10021" k="-76" />
<hkern g1="afii10017" g2="afii10029" k="-25" />
<hkern g1="afii10017" g2="afii10032" k="27" />
<hkern g1="afii10017" g2="afii10033" k="27" />
<hkern g1="afii10017" g2="afii10035" k="51" />
<hkern g1="afii10017" g2="afii10036" k="102" />
<hkern g1="afii10017" g2="afii10037" k="78" />
<hkern g1="afii10017" g2="afii10038" k="51" />
<hkern g1="afii10017" g2="afii10041" k="156" />
<hkern g1="afii10017" g2="afii10047" k="51" />
<hkern g1="afii10017" g2="afii10065" k="-25" />
<hkern g1="afii10017" g2="afii10066" k="27" />
<hkern g1="afii10017" g2="afii10083" k="27" />
<hkern g1="afii10017" g2="afii10084" k="27" />
<hkern g1="afii10017" g2="afii10095" k="-25" />
<hkern g1="afii10018" g2="afii10017" k="78" />
<hkern g1="afii10018" g2="afii10024" k="51" />
<hkern g1="afii10018" g2="afii10025" k="27" />
<hkern g1="afii10018" g2="afii10029" k="51" />
<hkern g1="afii10018" g2="afii10035" k="27" />
<hkern g1="afii10018" g2="afii10036" k="51" />
<hkern g1="afii10018" g2="afii10037" k="51" />
<hkern g1="afii10018" g2="afii10038" k="27" />
<hkern g1="afii10018" g2="afii10039" k="51" />
<hkern g1="afii10018" g2="afii10041" k="78" />
<hkern g1="afii10018" g2="afii10044" k="78" />
<hkern g1="afii10018" g2="afii10047" k="51" />
<hkern g1="afii10018" g2="afii10049" k="51" />
<hkern g1="afii10018" g2="afii10085" k="27" />
<hkern g1="afii10019" g2="afii10017" k="102" />
<hkern g1="afii10019" g2="afii10021" k="27" />
<hkern g1="afii10019" g2="afii10024" k="78" />
<hkern g1="afii10019" g2="afii10025" k="27" />
<hkern g1="afii10019" g2="afii10029" k="51" />
<hkern g1="afii10019" g2="afii10032" k="51" />
<hkern g1="afii10019" g2="afii10035" k="78" />
<hkern g1="afii10019" g2="afii10036" k="78" />
<hkern g1="afii10019" g2="afii10037" k="78" />
<hkern g1="afii10019" g2="afii10038" k="51" />
<hkern g1="afii10019" g2="afii10039" k="78" />
<hkern g1="afii10019" g2="afii10041" k="78" />
<hkern g1="afii10019" g2="afii10044" k="102" />
<hkern g1="afii10019" g2="afii10049" k="51" />
<hkern g1="afii10019" g2="afii10084" k="27" />
<hkern g1="afii10019" g2="afii10087" k="27" />
<hkern g1="afii10019" g2="afii10089" k="78" />
<hkern g1="afii10020" g2="comma" k="231" />
<hkern g1="afii10020" g2="period" k="256" />
<hkern g1="afii10020" g2="colon" k="27" />
<hkern g1="afii10020" g2="semicolon" k="27" />
<hkern g1="afii10020" g2="guillemotleft" k="78" />
<hkern g1="afii10020" g2="guillemotright" k="78" />
<hkern g1="afii10020" g2="afii10017" k="129" />
<hkern g1="afii10020" g2="afii10021" k="51" />
<hkern g1="afii10020" g2="afii10029" k="51" />
<hkern g1="afii10020" g2="afii10032" k="27" />
<hkern g1="afii10020" g2="afii10035" k="27" />
<hkern g1="afii10020" g2="afii10065" k="27" />
<hkern g1="afii10020" g2="afii10067" k="51" />
<hkern g1="afii10020" g2="afii10069" k="78" />
<hkern g1="afii10020" g2="afii10070" k="104" />
<hkern g1="afii10020" g2="afii10074" k="51" />
<hkern g1="afii10020" g2="afii10077" k="102" />
<hkern g1="afii10020" g2="afii10078" k="78" />
<hkern g1="afii10020" g2="afii10079" k="51" />
<hkern g1="afii10020" g2="afii10080" k="102" />
<hkern g1="afii10020" g2="afii10082" k="78" />
<hkern g1="afii10020" g2="afii10085" k="78" />
<hkern g1="afii10020" g2="afii10093" k="78" />
<hkern g1="afii10020" g2="afii10094" k="78" />
<hkern g1="afii10020" g2="afii10096" k="78" />
<hkern g1="afii10020" g2="afii10097" k="78" />
<hkern g1="afii10021" g2="afii10025" k="-25" />
<hkern g1="afii10021" g2="afii10037" k="-25" />
<hkern g1="afii10021" g2="afii10038" k="27" />
<hkern g1="afii10021" g2="afii10041" k="27" />
<hkern g1="afii10021" g2="afii10070" k="-25" />
<hkern g1="afii10021" g2="afii10073" k="-51" />
<hkern g1="afii10021" g2="afii10080" k="-25" />
<hkern g1="afii10021" g2="afii10085" k="-25" />
<hkern g1="afii10024" g2="afii10025" k="-25" />
<hkern g1="afii10024" g2="afii10032" k="27" />
<hkern g1="afii10024" g2="afii10035" k="51" />
<hkern g1="afii10024" g2="afii10036" k="-51" />
<hkern g1="afii10024" g2="afii10037" k="-51" />
<hkern g1="afii10024" g2="afii10041" k="-25" />
<hkern g1="afii10024" g2="afii10044" k="-76" />
<hkern g1="afii10024" g2="afii10065" k="-25" />
<hkern g1="afii10024" g2="afii10080" k="27" />
<hkern g1="afii10025" g2="afii10024" k="51" />
<hkern g1="afii10025" g2="afii10029" k="51" />
<hkern g1="afii10025" g2="afii10032" k="27" />
<hkern g1="afii10025" g2="afii10035" k="51" />
<hkern g1="afii10025" g2="afii10036" k="78" />
<hkern g1="afii10025" g2="afii10037" k="78" />
<hkern g1="afii10025" g2="afii10038" k="51" />
<hkern g1="afii10025" g2="afii10041" k="78" />
<hkern g1="afii10025" g2="afii10049" k="51" />
<hkern g1="afii10028" g2="afii10025" k="-76" />
<hkern g1="afii10028" g2="afii10035" k="27" />
<hkern g1="afii10028" g2="afii10036" k="-51" />
<hkern g1="afii10028" g2="afii10037" k="-51" />
<hkern g1="afii10028" g2="afii10038" k="27" />
<hkern g1="afii10028" g2="afii10041" k="-51" />
<hkern g1="afii10028" g2="afii10047" k="-25" />
<hkern g1="afii10028" g2="afii10065" k="-25" />
<hkern g1="afii10028" g2="afii10073" k="-25" />
<hkern g1="afii10028" g2="afii10083" k="27" />
<hkern g1="afii10029" g2="afii10065" k="-51" />
<hkern g1="afii10030" g2="afii10065" k="-25" />
<hkern g1="afii10030" g2="afii10083" k="27" />
<hkern g1="afii10030" g2="afii10089" k="27" />
<hkern g1="afii10032" g2="afii10017" k="51" />
<hkern g1="afii10032" g2="afii10021" k="27" />
<hkern g1="afii10032" g2="afii10024" k="27" />
<hkern g1="afii10032" g2="afii10029" k="51" />
<hkern g1="afii10032" g2="afii10037" k="51" />
<hkern g1="afii10032" g2="afii10039" k="78" />
<hkern g1="afii10032" g2="afii10049" k="27" />
<hkern g1="afii10032" g2="afii10069" k="51" />
<hkern g1="afii10032" g2="afii10077" k="27" />
<hkern g1="afii10034" g2="comma" k="283" />
<hkern g1="afii10034" g2="period" k="307" />
<hkern g1="afii10034" g2="colon" k="27" />
<hkern g1="afii10034" g2="semicolon" k="27" />
<hkern g1="afii10034" g2="afii10017" k="180" />
<hkern g1="afii10034" g2="afii10021" k="129" />
<hkern g1="afii10034" g2="afii10024" k="27" />
<hkern g1="afii10034" g2="afii10025" k="27" />
<hkern g1="afii10034" g2="afii10029" k="129" />
<hkern g1="afii10034" g2="afii10030" k="27" />
<hkern g1="afii10034" g2="afii10032" k="27" />
<hkern g1="afii10034" g2="afii10035" k="51" />
<hkern g1="afii10034" g2="afii10036" k="27" />
<hkern g1="afii10034" g2="afii10037" k="27" />
<hkern g1="afii10034" g2="afii10038" k="27" />
<hkern g1="afii10034" g2="afii10039" k="78" />
<hkern g1="afii10034" g2="afii10049" k="51" />
<hkern g1="afii10034" g2="afii10065" k="27" />
<hkern g1="afii10034" g2="afii10069" k="129" />
<hkern g1="afii10034" g2="afii10070" k="51" />
<hkern g1="afii10034" g2="afii10080" k="51" />
<hkern g1="afii10034" g2="afii10097" k="27" />
<hkern g1="afii10035" g2="afii10017" k="51" />
<hkern g1="afii10035" g2="afii10021" k="27" />
<hkern g1="afii10035" g2="afii10025" k="27" />
<hkern g1="afii10035" g2="afii10029" k="51" />
<hkern g1="afii10035" g2="afii10030" k="27" />
<hkern g1="afii10035" g2="afii10032" k="51" />
<hkern g1="afii10035" g2="afii10036" k="51" />
<hkern g1="afii10035" g2="afii10037" k="27" />
<hkern g1="afii10035" g2="afii10039" k="78" />
<hkern g1="afii10035" g2="afii10041" k="51" />
<hkern g1="afii10035" g2="afii10044" k="27" />
<hkern g1="afii10035" g2="afii10047" k="27" />
<hkern g1="afii10035" g2="afii10065" k="-25" />
<hkern g1="afii10035" g2="afii10066" k="27" />
<hkern g1="afii10035" g2="afii10072" k="-25" />
<hkern g1="afii10035" g2="afii10083" k="27" />
<hkern g1="afii10035" g2="afii10086" k="27" />
<hkern g1="afii10035" g2="afii10089" k="27" />
<hkern g1="afii10036" g2="comma" k="205" />
<hkern g1="afii10036" g2="period" k="231" />
<hkern g1="afii10036" g2="colon" k="27" />
<hkern g1="afii10036" g2="semicolon" k="27" />
<hkern g1="afii10036" g2="guillemotleft" k="51" />
<hkern g1="afii10036" g2="afii10017" k="129" />
<hkern g1="afii10036" g2="afii10021" k="51" />
<hkern g1="afii10036" g2="afii10024" k="-51" />
<hkern g1="afii10036" g2="afii10029" k="51" />
<hkern g1="afii10036" g2="afii10032" k="51" />
<hkern g1="afii10036" g2="afii10038" k="78" />
<hkern g1="afii10036" g2="afii10049" k="27" />
<hkern g1="afii10036" g2="afii10065" k="51" />
<hkern g1="afii10036" g2="afii10067" k="78" />
<hkern g1="afii10036" g2="afii10070" k="102" />
<hkern g1="afii10036" g2="afii10074" k="78" />
<hkern g1="afii10036" g2="afii10076" k="78" />
<hkern g1="afii10036" g2="afii10077" k="129" />
<hkern g1="afii10036" g2="afii10078" k="104" />
<hkern g1="afii10036" g2="afii10080" k="129" />
<hkern g1="afii10036" g2="afii10081" k="27" />
<hkern g1="afii10036" g2="afii10082" k="78" />
<hkern g1="afii10036" g2="afii10083" k="129" />
<hkern g1="afii10036" g2="afii10085" k="78" />
<hkern g1="afii10036" g2="afii10087" k="78" />
<hkern g1="afii10036" g2="afii10091" k="27" />
<hkern g1="afii10036" g2="afii10093" k="27" />
<hkern g1="afii10036" g2="afii10094" k="27" />
<hkern g1="afii10036" g2="afii10096" k="27" />
<hkern g1="afii10036" g2="afii10097" k="51" />
<hkern g1="afii10037" g2="comma" k="231" />
<hkern g1="afii10037" g2="period" k="256" />
<hkern g1="afii10037" g2="colon" k="51" />
<hkern g1="afii10037" g2="semicolon" k="51" />
<hkern g1="afii10037" g2="guillemotleft" k="78" />
<hkern g1="afii10037" g2="guillemotright" k="78" />
<hkern g1="afii10037" g2="afii10017" k="154" />
<hkern g1="afii10037" g2="afii10021" k="104" />
<hkern g1="afii10037" g2="afii10029" k="78" />
<hkern g1="afii10037" g2="afii10032" k="51" />
<hkern g1="afii10037" g2="afii10038" k="78" />
<hkern g1="afii10037" g2="afii10047" k="27" />
<hkern g1="afii10037" g2="afii10049" k="51" />
<hkern g1="afii10037" g2="afii10066" k="51" />
<hkern g1="afii10037" g2="afii10067" k="78" />
<hkern g1="afii10037" g2="afii10068" k="78" />
<hkern g1="afii10037" g2="afii10069" k="129" />
<hkern g1="afii10037" g2="afii10070" k="129" />
<hkern g1="afii10037" g2="afii10072" k="27" />
<hkern g1="afii10037" g2="afii10073" k="102" />
<hkern g1="afii10037" g2="afii10074" k="78" />
<hkern g1="afii10037" g2="afii10075" k="78" />
<hkern g1="afii10037" g2="afii10076" k="78" />
<hkern g1="afii10037" g2="afii10077" k="129" />
<hkern g1="afii10037" g2="afii10078" k="102" />
<hkern g1="afii10037" g2="afii10079" k="78" />
<hkern g1="afii10037" g2="afii10080" k="129" />
<hkern g1="afii10037" g2="afii10081" k="78" />
<hkern g1="afii10037" g2="afii10082" k="78" />
<hkern g1="afii10037" g2="afii10083" k="129" />
<hkern g1="afii10037" g2="afii10087" k="51" />
<hkern g1="afii10037" g2="afii10088" k="78" />
<hkern g1="afii10037" g2="afii10090" k="78" />
<hkern g1="afii10037" g2="afii10091" k="78" />
<hkern g1="afii10037" g2="afii10096" k="78" />
<hkern g1="afii10037" g2="afii10097" k="102" />
<hkern g1="afii10038" g2="afii10017" k="51" />
<hkern g1="afii10038" g2="afii10021" k="104" />
<hkern g1="afii10038" g2="afii10029" k="78" />
<hkern g1="afii10038" g2="afii10036" k="78" />
<hkern g1="afii10038" g2="afii10037" k="78" />
<hkern g1="afii10038" g2="afii10038" k="27" />
<hkern g1="afii10038" g2="afii10041" k="27" />
<hkern g1="afii10038" g2="afii10049" k="53" />
<hkern g1="afii10038" g2="afii10077" k="51" />
<hkern g1="afii10039" g2="afii10025" k="27" />
<hkern g1="afii10039" g2="afii10032" k="53" />
<hkern g1="afii10039" g2="afii10035" k="78" />
<hkern g1="afii10039" g2="afii10038" k="78" />
<hkern g1="afii10039" g2="afii10047" k="51" />
<hkern g1="afii10039" g2="afii10080" k="27" />
<hkern g1="afii10039" g2="afii10085" k="27" />
<hkern g1="afii10040" g2="afii10065" k="-76" />
<hkern g1="afii10040" g2="afii10070" k="-25" />
<hkern g1="afii10040" g2="afii10080" k="-25" />
<hkern g1="afii10043" g2="afii10065" k="-25" />
<hkern g1="afii10044" g2="quoteright" k="205" />
<hkern g1="afii10044" g2="afii10049" k="78" />
<hkern g1="afii10046" g2="quoteright" k="154" />
<hkern g1="afii10046" g2="afii10017" k="51" />
<hkern g1="afii10046" g2="afii10021" k="27" />
<hkern g1="afii10046" g2="afii10024" k="78" />
<hkern g1="afii10046" g2="afii10025" k="51" />
<hkern g1="afii10046" g2="afii10029" k="78" />
<hkern g1="afii10046" g2="afii10030" k="51" />
<hkern g1="afii10046" g2="afii10032" k="27" />
<hkern g1="afii10046" g2="afii10035" k="51" />
<hkern g1="afii10046" g2="afii10036" k="207" />
<hkern g1="afii10046" g2="afii10039" k="104" />
<hkern g1="afii10046" g2="afii10041" k="154" />
<hkern g1="afii10046" g2="afii10047" k="78" />
<hkern g1="afii10046" g2="afii10049" k="78" />
<hkern g1="afii10047" g2="afii10021" k="51" />
<hkern g1="afii10047" g2="afii10024" k="51" />
<hkern g1="afii10047" g2="afii10025" k="27" />
<hkern g1="afii10047" g2="afii10029" k="78" />
<hkern g1="afii10047" g2="afii10038" k="27" />
<hkern g1="afii10047" g2="afii10039" k="51" />
<hkern g1="afii10047" g2="afii10049" k="51" />
<hkern g1="afii10047" g2="afii10069" k="27" />
<hkern g1="afii10047" g2="afii10072" k="-25" />
<hkern g1="afii10047" g2="afii10077" k="51" />
<hkern g1="afii10048" g2="afii10017" k="51" />
<hkern g1="afii10048" g2="afii10021" k="51" />
<hkern g1="afii10048" g2="afii10024" k="51" />
<hkern g1="afii10048" g2="afii10029" k="78" />
<hkern g1="afii10048" g2="afii10035" k="27" />
<hkern g1="afii10048" g2="afii10036" k="51" />
<hkern g1="afii10048" g2="afii10039" k="78" />
<hkern g1="afii10048" g2="afii10041" k="27" />
<hkern g1="afii10048" g2="afii10069" k="51" />
<hkern g1="afii10048" g2="afii10072" k="-25" />
<hkern g1="afii10048" g2="afii10077" k="51" />
<hkern g1="afii10065" g2="afii10073" k="-25" />
<hkern g1="afii10065" g2="afii10089" k="51" />
<hkern g1="afii10066" g2="afii10069" k="51" />
<hkern g1="afii10066" g2="afii10072" k="27" />
<hkern g1="afii10066" g2="afii10073" k="27" />
<hkern g1="afii10066" g2="afii10077" k="51" />
<hkern g1="afii10066" g2="afii10078" k="27" />
<hkern g1="afii10066" g2="afii10083" k="27" />
<hkern g1="afii10066" g2="afii10085" k="27" />
<hkern g1="afii10066" g2="afii10087" k="51" />
<hkern g1="afii10066" g2="afii10089" k="51" />
<hkern g1="afii10066" g2="afii10092" k="27" />
<hkern g1="afii10066" g2="afii10095" k="27" />
<hkern g1="afii10066" g2="afii10097" k="27" />
<hkern g1="afii10067" g2="afii10065" k="27" />
<hkern g1="afii10067" g2="afii10066" k="27" />
<hkern g1="afii10067" g2="afii10070" k="27" />
<hkern g1="afii10067" g2="afii10072" k="27" />
<hkern g1="afii10067" g2="afii10077" k="27" />
<hkern g1="afii10067" g2="afii10078" k="27" />
<hkern g1="afii10067" g2="afii10080" k="27" />
<hkern g1="afii10067" g2="afii10083" k="51" />
<hkern g1="afii10067" g2="afii10084" k="27" />
<hkern g1="afii10067" g2="afii10085" k="51" />
<hkern g1="afii10067" g2="afii10086" k="27" />
<hkern g1="afii10067" g2="afii10089" k="78" />
<hkern g1="afii10067" g2="afii10092" k="51" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="comma" k="180" />
<hkern g1="afii10068" g2="period" k="205" />
<hkern g1="afii10068" g2="afii10069" k="78" />
<hkern g1="afii10068" g2="afii10077" k="51" />
<hkern g1="afii10068" g2="afii10080" k="27" />
<hkern g1="afii10068" g2="afii10083" k="27" />
<hkern g1="afii10069" g2="afii10073" k="-25" />
<hkern g1="afii10069" g2="afii10083" k="27" />
<hkern g1="afii10069" g2="afii10085" k="-25" />
<hkern g1="afii10069" g2="afii10092" k="27" />
<hkern g1="afii10070" g2="afii10066" k="27" />
<hkern g1="afii10070" g2="afii10072" k="27" />
<hkern g1="afii10070" g2="afii10078" k="27" />
<hkern g1="afii10070" g2="afii10083" k="27" />
<hkern g1="afii10070" g2="afii10084" k="27" />
<hkern g1="afii10070" g2="afii10085" k="27" />
<hkern g1="afii10070" g2="afii10087" k="27" />
<hkern g1="afii10070" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10065" k="-25" />
<hkern g1="afii10072" g2="afii10070" k="27" />
<hkern g1="afii10072" g2="afii10073" k="-25" />
<hkern g1="afii10072" g2="afii10080" k="51" />
<hkern g1="afii10072" g2="afii10083" k="27" />
<hkern g1="afii10072" g2="afii10089" k="51" />
<hkern g1="afii10073" g2="afii10065" k="27" />
<hkern g1="afii10073" g2="afii10066" k="51" />
<hkern g1="afii10073" g2="afii10070" k="27" />
<hkern g1="afii10073" g2="afii10072" k="27" />
<hkern g1="afii10073" g2="afii10073" k="27" />
<hkern g1="afii10073" g2="afii10077" k="27" />
<hkern g1="afii10073" g2="afii10078" k="51" />
<hkern g1="afii10073" g2="afii10080" k="51" />
<hkern g1="afii10073" g2="afii10083" k="51" />
<hkern g1="afii10073" g2="afii10085" k="51" />
<hkern g1="afii10073" g2="afii10086" k="27" />
<hkern g1="afii10073" g2="afii10089" k="78" />
<hkern g1="afii10073" g2="afii10092" k="51" />
<hkern g1="afii10076" g2="afii10077" k="-25" />
<hkern g1="afii10076" g2="afii10080" k="27" />
<hkern g1="afii10076" g2="afii10083" k="27" />
<hkern g1="afii10076" g2="afii10086" k="27" />
<hkern g1="afii10076" g2="afii10089" k="27" />
<hkern g1="afii10076" g2="afii10095" k="27" />
<hkern g1="afii10077" g2="afii10066" k="27" />
<hkern g1="afii10077" g2="afii10070" k="27" />
<hkern g1="afii10077" g2="afii10080" k="27" />
<hkern g1="afii10077" g2="afii10083" k="27" />
<hkern g1="afii10077" g2="afii10085" k="27" />
<hkern g1="afii10077" g2="afii10089" k="51" />
<hkern g1="afii10078" g2="afii10065" k="27" />
<hkern g1="afii10078" g2="afii10066" k="27" />
<hkern g1="afii10078" g2="afii10073" k="27" />
<hkern g1="afii10078" g2="afii10080" k="27" />
<hkern g1="afii10078" g2="afii10083" k="27" />
<hkern g1="afii10078" g2="afii10085" k="27" />
<hkern g1="afii10078" g2="afii10086" k="27" />
<hkern g1="afii10078" g2="afii10095" k="27" />
<hkern g1="afii10080" g2="afii10069" k="27" />
<hkern g1="afii10080" g2="afii10072" k="27" />
<hkern g1="afii10080" g2="afii10073" k="27" />
<hkern g1="afii10080" g2="afii10077" k="51" />
<hkern g1="afii10080" g2="afii10078" k="27" />
<hkern g1="afii10080" g2="afii10083" k="27" />
<hkern g1="afii10080" g2="afii10084" k="51" />
<hkern g1="afii10080" g2="afii10085" k="27" />
<hkern g1="afii10080" g2="afii10087" k="51" />
<hkern g1="afii10080" g2="afii10089" k="51" />
<hkern g1="afii10080" g2="afii10095" k="27" />
<hkern g1="afii10080" g2="afii10097" k="27" />
<hkern g1="afii10082" g2="afii10069" k="51" />
<hkern g1="afii10082" g2="afii10072" k="27" />
<hkern g1="afii10082" g2="afii10073" k="27" />
<hkern g1="afii10082" g2="afii10077" k="51" />
<hkern g1="afii10082" g2="afii10078" k="27" />
<hkern g1="afii10082" g2="afii10084" k="27" />
<hkern g1="afii10082" g2="afii10085" k="27" />
<hkern g1="afii10082" g2="afii10087" k="27" />
<hkern g1="afii10082" g2="afii10089" k="51" />
<hkern g1="afii10082" g2="afii10095" k="27" />
<hkern g1="afii10082" g2="afii10097" k="27" />
<hkern g1="afii10083" g2="afii10065" k="-25" />
<hkern g1="afii10083" g2="afii10066" k="27" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="53" />
<hkern g1="afii10083" g2="afii10092" k="27" />
<hkern g1="afii10084" g2="comma" k="154" />
<hkern g1="afii10084" g2="period" k="180" />
<hkern g1="afii10084" g2="afii10069" k="27" />
<hkern g1="afii10084" g2="afii10072" k="-25" />
<hkern g1="afii10084" g2="afii10077" k="27" />
<hkern g1="afii10084" g2="afii10080" k="27" />
<hkern g1="afii10084" g2="afii10083" k="27" />
<hkern g1="afii10084" g2="afii10085" k="-51" />
<hkern g1="afii10085" g2="comma" k="154" />
<hkern g1="afii10085" g2="period" k="180" />
<hkern g1="afii10085" g2="colon" k="27" />
<hkern g1="afii10085" g2="semicolon" k="27" />
<hkern g1="afii10085" g2="guillemotright" k="-51" />
<hkern g1="afii10085" g2="afii10065" k="27" />
<hkern g1="afii10085" g2="afii10069" k="51" />
<hkern g1="afii10085" g2="afii10070" k="27" />
<hkern g1="afii10085" g2="afii10072" k="-25" />
<hkern g1="afii10085" g2="afii10073" k="27" />
<hkern g1="afii10085" g2="afii10077" k="27" />
<hkern g1="afii10085" g2="afii10078" k="27" />
<hkern g1="afii10085" g2="afii10080" k="51" />
<hkern g1="afii10085" g2="afii10082" k="27" />
<hkern g1="afii10085" g2="afii10083" k="51" />
<hkern g1="afii10085" g2="afii10084" k="-25" />
<hkern g1="afii10085" g2="afii10086" k="27" />
<hkern g1="afii10085" g2="afii10087" k="-25" />
<hkern g1="afii10085" g2="afii10095" k="27" />
<hkern g1="afii10085" g2="afii10097" k="27" />
<hkern g1="afii10086" g2="afii10066" k="27" />
<hkern g1="afii10086" g2="afii10069" k="27" />
<hkern g1="afii10086" g2="afii10070" k="27" />
<hkern g1="afii10086" g2="afii10077" k="51" />
<hkern g1="afii10086" g2="afii10078" k="27" />
<hkern g1="afii10086" g2="afii10080" k="27" />
<hkern g1="afii10086" g2="afii10084" k="27" />
<hkern g1="afii10086" g2="afii10085" k="27" />
<hkern g1="afii10086" g2="afii10089" k="51" />
<hkern g1="afii10086" g2="afii10097" k="27" />
<hkern g1="afii10087" g2="afii10066" k="27" />
<hkern g1="afii10087" g2="afii10070" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="51" />
<hkern g1="afii10087" g2="afii10083" k="51" />
<hkern g1="afii10087" g2="afii10085" k="-25" />
<hkern g1="afii10087" g2="afii10086" k="27" />
<hkern g1="afii10087" g2="afii10089" k="51" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10065" k="-25" />
<hkern g1="afii10088" g2="afii10073" k="-25" />
<hkern g1="afii10088" g2="afii10083" k="27" />
<hkern g1="afii10091" g2="afii10065" k="-25" />
<hkern g1="afii10091" g2="afii10080" k="27" />
<hkern g1="afii10094" g2="afii10084" k="180" />
<hkern g1="afii10094" g2="afii10089" k="180" />
<hkern g1="afii10095" g2="afii10066" k="27" />
<hkern g1="afii10095" g2="afii10069" k="27" />
<hkern g1="afii10095" g2="afii10072" k="27" />
<hkern g1="afii10095" g2="afii10073" k="27" />
<hkern g1="afii10095" g2="afii10077" k="51" />
<hkern g1="afii10095" g2="afii10078" k="27" />
<hkern g1="afii10095" g2="afii10083" k="27" />
<hkern g1="afii10095" g2="afii10084" k="27" />
<hkern g1="afii10095" g2="afii10087" k="27" />
<hkern g1="afii10095" g2="afii10097" k="27" />
<hkern g1="afii10096" g2="afii10066" k="27" />
<hkern g1="afii10096" g2="afii10069" k="27" />
<hkern g1="afii10096" g2="afii10072" k="27" />
<hkern g1="afii10096" g2="afii10077" k="51" />
<hkern g1="afii10096" g2="afii10078" k="27" />
<hkern g1="afii10096" g2="afii10083" k="27" />
<hkern g1="afii10096" g2="afii10084" k="51" />
<hkern g1="afii10096" g2="afii10087" k="51" />
<hkern g1="afii10096" g2="afii10089" k="78" />
<hkern g1="afii10096" g2="afii10095" k="27" />
<hkern g1="afii10110" g2="comma" k="154" />
<hkern g1="afii10110" g2="period" k="180" />
<hkern g1="afii10110" g2="colon" k="27" />
<hkern g1="afii10110" g2="semicolon" k="27" />
<hkern g1="afii10110" g2="guillemotleft" k="51" />
<hkern g1="afii10050" g2="comma" k="129" />
<hkern g1="afii10050" g2="period" k="154" />
<hkern g1="afii10050" g2="colon" k="27" />
<hkern g1="afii10050" g2="semicolon" k="27" />
<hkern g1="afii10050" g2="guillemotleft" k="51" />
<hkern g1="afii10050" g2="guillemotright" k="51" />
<hkern g1="pi" g2="alpha" k="57" />
<hkern g1="pi" g2="delta" k="57" />
<hkern g1="pi" g2="sigma" k="57" />
<hkern g1="pi" g2="phi" k="57" />
<hkern g1="pi" g2="alphatonos" k="57" />
<hkern g1="pi" g2="zeta" k="57" />
<hkern g1="pi" g2="lambda" k="76" />
<hkern g1="pi" g2="omicron" k="57" />
<hkern g1="pi" g2="sigma1" k="57" />
<hkern g1="pi" g2="omega" k="57" />
<hkern g1="pi" g2="omegatonos" k="57" />
</font>

<font horiz-adv-x="980" ><font-face
    font-family="Arial-BoldItalic"
    units-per-em="2048"
    panose-1="2 11 7 4 2 2 2 9 2 4"
    ascent="1854"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1536" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="569" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="682" d="M418 373H260L350 1121L422 1466H723L646 1095L418 373ZM184 277H468L410 0H126L184 277Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="971" d="M310 945L315 1218L368 1466H674L621 1218L517 945H310ZM674 945L679 1218L732 1466H1038L985 1218L881 945H674Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1139" d="M154 365H18V585H198L258 880H18V1101H303L382 1491H606L527 1101H748L825 1491H1057L977 1101H1115V880H932L872 585H1115V365H827L748 -25H525L602 365H380L301 -25H75L154 365ZM483 880L424
585H646L704 880H483Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1139" d="M429 -10Q286 25 194 139T90 426L343 439Q362 267 476 215L568 657Q409 727 336 837T262 1068Q262 1176 320 1277T486 1435T690 1492L743 1491L761 1577H904L882 1474Q1011 1442 1089 1350T1180
1115L934 1102Q916 1213 837 1257L754 859Q932 787 1009 680T1087 434Q1087 242 944 108T569 -27L532 -203H389L429 -10ZM623 918L699 1281Q614 1282 558 1228T501 1098Q501 986 623 918ZM699 596L615 195Q728 204 789 265T851 410Q851 465 823 505T699 596Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1821" d="M186 1011Q186 1202 289 1346T577 1491Q703 1491 778 1411T854 1188Q854 1070 803 951T662 777T463 721Q339 721 263 799T186 1011ZM397 988Q397 937 419 914T479 890Q551 890 599 998T648 1228Q648
1272 625 1296T565 1321Q523 1321 490 1287T427 1152T397 988ZM485 -63H254L1476 1491H1706L485 -63ZM1102 229Q1102 420 1205 565T1493 710Q1619 710 1694 630T1770 407Q1770 289 1719 170T1578 -5T1379 -60Q1255 -60 1179 18T1102 229ZM1312 207Q1312 156 1334
133T1395 109Q1467 109 1515 217T1564 446Q1564 491 1541 515T1481 540Q1439 540 1406 506T1342 371T1312 207Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1479" d="M1239 638L1446 514Q1417 458 1371 393T1284 290Q1341 229 1430 154L1249 -34Q1215 -16 1163 27T1074 108Q1002 51 893 13T658 -25Q430 -25 300 95T170 391Q170 502 221 597T355 761Q414
810 547 881Q482 1022 482 1127Q482 1281 594 1386T891 1491Q1049 1491 1141 1408T1234 1212Q1234 1117 1155 1007T893 804Q950 708 1035 584Q1086 508 1117 475Q1168 526 1239 638ZM789 1000Q907 1060 955 1121Q989 1165 989 1210Q989 1251 962 1277T886 1304Q826
1304 786 1263T746 1154Q746 1090 789 1000ZM651 679Q453 580 453 418Q453 326 512 267T669 208Q788 208 914 291Q763 475 651 679Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="487" d="M310 945L315 1218L368 1466H674L621 1218L517 945H310Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M491 -431H296Q214 -240 175 -45T135 314Q135 518 200 723T401 1142Q486 1278 674 1491H892Q701 1267 598 1070T443 641T392 187Q392 37 414 -105T491 -431Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M241 1491H436Q518 1301 557 1105T597 747Q597 543 532 338T331 -82Q245 -218 58 -431H-160Q30 -207 133 -11T288 417T339 873Q339 1024 317 1165T241 1491Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="797" d="M245 792L94 909Q166 990 244 1064Q275 1094 283 1102Q258 1106 140 1135Q55 1156 28 1166L87 1342Q218 1289 321 1225Q297 1388 297 1491H475Q475 1418 448 1223Q468 1231 534 1262Q624 1303 700
1332L753 1151Q642 1126 496 1102L616 967Q652 926 673 900L520 799L385 1022Q324 914 245 792Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1196" d="M469 211V592H85V855H469V1236H725V855H1110V592H725V211H469Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="569" d="M146 277H435L387 48Q346 -150 256 -232T21 -318L49 -185Q121 -169 160 -128T219 0H87L146 277Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M137 667H694L636 390H79L137 667Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="569" d="M148 277H432L374 0H90L148 277Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M-89 -25L637 1491H837L112 -25H-89Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1139" d="M132 477Q132 698 207 925Q299 1202 443 1337T763 1472Q941 1472 1055 1343T1170 968Q1170 743 1087 493T861 109T541 -25Q363 -25 248 104T132 477ZM414 419Q414 301 452 253T550 205Q630 205 692
279Q775 378 839 669Q890 900 890 1035Q890 1145 852 1193T753 1242Q677 1242 618 1169Q531 1063 468 796Q414 565 414 419Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1139" d="M243 842L297 1098Q668 1260 871 1475H1046L737 0H448L661 1016Q571 958 454 910T243 842Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1139" d="M541 1009L260 1051Q294 1255 418 1363T730 1472Q935 1472 1052 1361T1169 1079Q1169 992 1133 905T1015 721Q956 653 822 529T645 359T561 262H1069L1015 0H124Q138 108 187 205T311 387T582 658Q730
800 769 843Q839 921 865 978T891 1081Q891 1155 848 1201T737 1247Q669 1247 618 1196T541 1009Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1139" d="M104 383L379 416Q396 299 440 254T559 209Q657 209 721 275T786 444Q786 534 734 586T594 639Q572 639 548 635L598 874Q613 872 627 872Q742 872 802 930T862 1089Q862 1160 822 1201T715 1242Q653
1242 604 1197T526 1041L264 1093Q314 1255 403 1342Q538 1472 735 1472Q937 1472 1042 1360T1147 1090Q1147 976 1080 884T896 749Q989 700 1033 622T1077 459Q1077 297 962 161Q805 -25 557 -25Q371 -25 251 81T104 383Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1139" d="M633 299H56L106 539L899 1466H1147L954 543H1132L1081 299H903L840 0H570L633 299ZM684 543L779 1000L392 543H684Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1139" d="M130 420L409 445Q408 425 408 415Q408 313 453 262T572 211Q674 211 757 308T841 578Q841 680 794 732T669 784Q613 784 561 758T459 679L223 697L446 1446H1183L1129 1184H642L575 958Q617 977 659
986T742 996Q910 996 1018 883T1126 580Q1126 428 1051 281T841 54T560 -25Q373 -25 253 96T130 420Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1139" d="M1179 1108L910 1086Q902 1173 869 1208T778 1243Q705 1243 648 1185Q567 1102 518 917Q611 978 715 978Q885 978 995 862T1105 546Q1105 387 1028 246T836 39T593 -26Q470 -26 372 35T220 215T166
531Q166 924 340 1198T799 1472Q963 1472 1060 1382T1179 1108ZM442 431Q442 315 488 260T602 205Q686 205 746 283Q827 388 827 565Q827 679 782 733T672 788Q617 788 561 747T474 615T442 431Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1139" d="M212 1181L267 1446H1234L1191 1242Q1099 1168 988 1020T783 688T628 339Q545 111 525 0H252Q270 110 337 302Q419 538 542 758T839 1181H212Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1139" d="M440 807Q363 858 325 924T286 1072Q286 1166 340 1263T501 1416T745 1472Q941 1472 1051 1370T1161 1112Q1161 1002 1099 921T913 785Q1003 730 1047 652T1092 472Q1092 306 986 170Q832 -26 565
-26Q371 -26 253 88T135 380Q135 527 217 643T440 807ZM549 1053Q549 984 591 942T700 899Q777 899 835 957T894 1094Q894 1165 851 1209T741 1253Q662 1253 606 1195T549 1053ZM421 375Q421 293 466 246T583 199Q694 199 754 297T815 510Q815 584 769 631T650
679Q560 679 491 596T421 375Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1139" d="M130 338L399 360Q407 274 440 239T531 204Q604 204 660 261Q742 344 790 529Q697 469 594 469Q424 469 314 584T204 900Q204 1124 345 1298T719 1472Q925 1472 1034 1322T1143 916Q1143 521 969 248T509
-25Q342 -25 242 70T130 338ZM867 1016Q867 1132 821 1186T707 1241Q623 1241 563 1163Q482 1058 482 881Q482 767 527 713T637 658Q692 658 748 700T835 832T867 1016Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="682" d="M366 1062H649L591 784H308L366 1062ZM202 277H486L428 0H144L202 277Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="682" d="M371 1062H655L597 784H313L371 1062ZM208 277H497L449 48Q408 -150 318 -232T83 -318L111 -185Q183 -169 222 -128T281 0H149L208 277Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1196" d="M1100 167L95 604V846L1100 1281V996L399 728L1100 450V167Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1196" d="M85 816V1074H1110V816H85ZM85 372V631H1110V372H85Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1196" d="M95 166V449L797 725L95 998V1279L1101 844V604L95 166Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1251" d="M700 366H442Q462 500 525 598T780 862Q941 1003 969 1048T998 1135Q998 1197 949 1238T799 1280Q687 1280 616 1219T515 1024L252 1070Q303 1265 449 1378T804 1491Q1022 1491 1144 1383T1266
1123Q1266 1035 1214 948T929 667Q783 545 749 497T700 366ZM412 277H696L638 0H354L412 277Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1997" d="M1777 19H1990Q1890 -184 1683 -299Q1446 -431 1105 -431Q775 -431 535 -320T178 9T61 483Q61 764 194 1006T558 1370T1086 1492Q1338 1492 1534 1394T1833 1116T1937 721Q1937 466 1780 260Q1583 0
1275 0Q1192 0 1150 29T1094 114Q976 0 822 0Q656 0 547 114T437 419Q437 654 569 848Q729 1084 979 1084Q1157 1084 1242 948L1267 1059H1531L1380 342Q1366 274 1366 254Q1366 229 1377 217T1405 204Q1453 204 1529 262Q1631 338 1694 466T1757 731Q1757 977
1579 1142T1082 1308Q811 1308 623 1198T339 887T243 469Q243 258 349 85T648 -167T1089 -247Q1328 -247 1500 -181T1777 19ZM696 430Q696 303 747 243T875 183Q932 183 982 211Q1020 231 1057 274Q1110 335 1148 452T1187 670Q1187 783 1135 843T1002 904Q916
904 843 838T733 648T696 430Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1479" d="M1044 324H463L287 0H-23L806 1466H1141L1379 0H1093L1044 324ZM1007 568L922 1158L568 568H1007Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1479" d="M82 0L389 1466H890Q1053 1466 1118 1456Q1226 1441 1301 1396T1415 1276T1454 1110Q1454 988 1386 899T1176 763Q1289 732 1352 653T1416 473Q1416 341 1341 223T1134 52T773 0H82ZM566 874H796Q951
874 1019 896T1121 968T1155 1075Q1155 1131 1123 1167T1032 1215Q999 1221 873 1221H639L566 874ZM433 236H724Q907 236 969 259T1069 337T1107 451Q1107 524 1053 571T873 619H513L433 236Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1479" d="M1146 528L1450 482Q1361 235 1183 105T766 -26Q497 -26 346 136T194 606Q194 856 295 1063T577 1381T969 1491Q1207 1491 1354 1364T1527 1016L1238 988Q1214 1116 1146 1173T963 1231Q838 1231 730
1155T556 918T491 595Q491 419 575 323T786 227Q903 227 1000 303T1146 528Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M89 0L396 1466H791Q956 1466 1002 1461Q1093 1452 1164 1424T1294 1346T1395 1224T1461 1061T1484 858Q1484 621 1394 438T1166 146Q1061 62 895 22Q801 0 606 0H89ZM440 236H593Q759 236 833 256T970
333Q1059 414 1120 549T1181 867Q1181 1023 1131 1101T1006 1206Q954 1224 821 1224H646L440 236Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M84 0L390 1466H1477L1426 1221H641L571 888H1330L1279 643H520L428 245H1281L1229 0H84Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M80 0L387 1466H1413L1361 1221H637L563 869H1273L1222 624H512L382 0H80Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1593" d="M900 783H1556L1424 154Q1308 79 1140 27T796 -25Q524 -25 379 98Q181 266 181 585Q181 799 266 995Q368 1231 556 1361T998 1491Q1252 1491 1405 1373T1609 1029L1328 997Q1291 1121 1209 1184T1001
1247Q855 1247 733 1171T542 936T473 589Q473 404 557 316T803 227Q900 227 1002 254T1178 320L1223 538H849L900 783Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M1095 655H528L391 0H89L396 1466H697L579 900H1146L1265 1466H1566L1260 0H958L1095 655Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="569" d="M71 0L378 1466H679L373 0H71Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1139" d="M932 1466H1228L1043 578Q969 225 849 100T480 -25Q269 -25 164 72T59 336Q59 371 64 414L343 444Q337 400 337 371Q337 301 377 264T500 227Q616 227 663 295Q698 347 748 588L932 1466Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1479" d="M81 0L387 1466H689L559 843L1237 1466H1641L983 891L1466 0H1125L763 698L478 449L384 0H81Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1251" d="M92 0L399 1466H700L445 245H1191L1140 0H92Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1706" d="M927 0H641L588 1225L355 0H83L389 1466H819L864 439L1364 1466H1799L1492 0H1217L1506 1216L927 0Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M1256 0H975L579 985L373 0H92L398 1466H680L1077 485L1282 1466H1562L1256 0Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1593" d="M179 575Q179 705 218 849Q269 1042 373 1184T637 1408T999 1491Q1271 1491 1438 1322T1606 874Q1606 642 1497 425T1201 91T778 -26Q573 -26 434 67T237 297T179 575ZM477 581Q477 430 569 328T811 226Q933
226 1045 306T1231 550T1305 869Q1305 1042 1212 1140T975 1239Q754 1239 616 1033T477 581Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1366" d="M385 0H83L390 1466H986Q1145 1466 1237 1429T1384 1305T1438 1098Q1438 987 1395 882T1290 714T1155 619T961 569Q890 559 695 559H502L385 0ZM552 802H645Q884 802 964 832T1090 928T1136 1073Q1136
1126 1113 1160T1047 1209T857 1225H641L552 802Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1593" d="M1078 29Q1008 2 933 -12T778 -26Q510 -26 345 141T179 579Q179 800 282 1026T572 1371T999 1491Q1271 1491 1438 1323T1605 874Q1605 660 1516 464T1276 146Q1372 52 1478 -8L1336 -195Q1196 -127 1078
29ZM1103 355Q1194 447 1249 593T1305 868Q1305 1042 1212 1140T975 1239Q876 1239 792 1194T638 1062T523 849T478 595Q478 424 572 326T814 227Q855 227 900 233Q916 236 919 239T923 248Q923 256 893 284Q830 344 759 370L869 538Q1004 470 1103 355Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1479" d="M392 0H90L397 1466H1048Q1216 1466 1309 1432T1460 1305T1518 1082Q1518 895 1406 774T1067 623Q1125 571 1176 486Q1277 314 1401 0H1077Q1038 124 924 387Q862 529 792 578Q749 607 642 607H519L392
0ZM565 827H725Q968 827 1047 856T1172 947T1217 1077Q1217 1157 1152 1197Q1112 1221 979 1221H647L565 827Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1366" d="M130 475L417 490Q423 353 464 305Q530 227 708 227Q856 227 922 280T988 408Q988 473 934 518Q896 551 726 625T477 748T353 877T308 1062Q308 1247 442 1369T830 1491Q1088 1491 1229 1370T1385 1048L1096
1035Q1085 1140 1020 1196T828 1252Q703 1252 650 1208T596 1097Q596 1034 645 993Q694 951 862 878Q1115 769 1184 701Q1287 601 1287 444Q1287 250 1134 113T706 -25Q517 -25 379 38T183 215T130 475Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M722 0H420L676 1221H246L297 1466H1452L1401 1221H977L722 0Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M391 1466H692L526 670L485 474Q481 449 481 427Q481 340 544 284T729 227Q838 227 909 268T1019 390T1098 665L1266 1466H1567L1400 664Q1347 411 1278 277T1069 59T715 -25Q459 -25 323 100T187 423Q187
464 194 512Q198 544 229 694L391 1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1366" d="M817 0H495L232 1466H533L719 357L1326 1466H1625L817 0Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1933" d="M1478 0H1173L1140 1072L606 0H295L240 1466H535L548 440L1051 1466H1378L1412 451L1895 1466H2187L1478 0Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1366" d="M328 0H-62L585 742L221 1466H536L679 1191Q686 1176 777 988Q783 978 790 961Q912 1110 995 1205L1226 1466H1605L934 694L1295 0H955L845 221Q759 396 731 472Q692 413 530 228L328 0Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1366" d="M821 0H520L639 571L235 1466H556L738 1052Q803 903 825 837Q862 902 911 975L1050 1169L1257 1466H1607L935 543L821 0Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M51 0L99 231L943 1221H260L311 1466H1368L1324 1236L471 240Q607 243 628 243Q724 243 893 245H1239L1188 0H51Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="682" d="M554 -190L509 -404H20L411 1466H899L853 1243H634L335 -190H554Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M387 -25L160 1491H361L588 -25H387Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="682" d="M232 1252L277 1466H768L377 -404H-114L-67 -180H154L453 1252H232Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="1196" d="M115 692L491 1491H714L1080 692H796L598 1181L401 692H115Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1139" d="M-19 -405V-223H1149V-405H-19Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M274 1499H550L678 1200H484L274 1499Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1139" d="M487 761L207 785Q255 927 374 1007T691 1087Q896 1087 994 1005T1092 803Q1092 755 1084 701T1024 417Q982 227 982 151Q982 83 1006 0H727Q710 58 706 120Q643 50 561 13T396 -25Q264 -25 178 61T92
284Q92 436 186 527T524 637Q729 654 798 678Q816 738 816 774Q816 820 779 851T669 882Q592 882 548 851T487 761ZM760 495Q734 488 691 482Q475 456 409 406Q362 370 362 309Q362 259 398 225T493 190Q558 190 615 221T701 302T752 457L760 495Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1251" d="M74 0L380 1466H668L565 976Q644 1036 712 1061T862 1087Q1030 1087 1131 975T1232 647Q1232 502 1185 366T1058 144T891 17T707 -25Q479 -25 372 175L335 0H74ZM461 433Q461 326 521 259T664 192Q736
192 801 244T910 410T954 640Q954 753 896 817T754 882Q646 882 568 782Q461 645 461 433Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="1139" d="M802 400L1081 355Q1012 169 877 72T564 -25Q361 -25 242 96T123 429Q123 602 195 756T412 998T730 1087Q918 1087 1030 989T1156 731L883 702Q873 791 829 833T712 875Q629 875 557 813T447 628T408
396Q408 302 454 251T569 200Q638 200 702 250T802 400Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1251" d="M1063 0H791L815 115Q737 40 662 8T491 -25Q326 -25 224 87T121 420Q121 675 265 881T646 1087Q860 1087 967 917L1082 1466H1369L1063 0ZM400 432Q400 318 457 254T599 190Q677 190 744 243T852 407T893
618Q893 733 831 804T688 875Q562 875 481 735T400 432Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="1139" d="M1116 442H396Q395 425 395 416Q395 310 455 245T603 180Q746 180 826 328L1083 285Q1008 130 883 53T601 -25Q387 -25 253 110T119 469Q119 687 240 857Q405 1087 711 1087Q906 1087 1021 967T1136 629Q1136
525 1116 442ZM874 617Q875 636 875 646Q875 764 822 823T680 882Q591 882 521 815T425 617H874Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="682" d="M822 1062L778 852H575L397 0H110L288 852H128L172 1062H332L355 1171Q383 1305 408 1352Q442 1416 509 1453T686 1491Q818 1491 964 1443L908 1238Q805 1273 741 1273Q692 1273 668 1242Q652 1222 635
1137L619 1062H822Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1251" d="M67 -56L370 -100Q370 -146 385 -169T433 -209T525 -226Q616 -226 671 -190Q712 -162 738 -100Q754 -61 779 70L789 120Q640 -4 481 -4Q325 -4 225 106T125 428Q125 615 193 771T384 1007T635 1087Q741
1087 829 1031T966 874L1006 1062H1275L1091 177Q1046 -36 1015 -127T944 -272T843 -362T699 -415T519 -431Q294 -431 179 -354T64 -98Q64 -79 67 -56ZM405 457Q405 336 459 273T596 209Q671 209 741 266T849 428T887 631Q887 744 826 813T685 882Q608 882 544
821T437 633Q405 535 405 457Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1251" d="M373 0H86L393 1466H680L570 944Q667 1020 751 1053T931 1087Q1060 1087 1135 1013T1210 819Q1210 755 1182 621L1052 0H765L898 633Q919 736 919 765Q919 818 886 850T796 882Q724 882 658 832Q572 766
527 670Q502 617 461 421L373 0Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M388 1466H675L621 1206H334L388 1466ZM304 1062H591L369 0H82L304 1062Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="569" d="M390 1466H678L624 1206H336L390 1466ZM306 1062H594L405 163Q325 -222 268 -304Q182 -431 -8 -431Q-126 -431 -224 -399L-179 -162Q-110 -179 -63 -179Q-5 -179 30 -134T122 182L306 1062Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1139" d="M77 0L384 1466H671L511 703L885 1062H1258L831 676L1058 0H771L625 491L431 319L364 0H77Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M80 0L387 1466H673L367 0H80Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1821" d="M295 1062H565L538 933Q696 1087 870 1087Q990 1087 1055 1037T1138 899Q1193 979 1296 1033T1510 1087Q1637 1087 1708 1019T1779 839Q1779 784 1751 649L1615 0H1328L1464 649Q1489 771 1489 787Q1489
831 1463 856T1383 882Q1276 882 1192 769Q1131 688 1088 482L987 0H700L834 642Q857 753 857 786Q857 828 829 855T750 882Q703 882 653 854T566 777T501 651Q489 615 462 488L360 0H73L295 1062Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1251" d="M308 1062H580L552 924Q654 1012 742 1049T929 1087Q1060 1087 1135 1012T1211 813Q1211 757 1178 601L1053 0H766L892 603Q920 738 920 764Q920 819 888 850T797 882Q734 882 657 829T536 689Q504 627
464 436L373 0H86L308 1062Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1251" d="M124 441Q124 736 290 911T728 1087Q963 1087 1095 958T1227 609Q1227 351 1062 163T620 -25Q470 -25 354 35T181 205T124 441ZM942 646Q942 748 883 809T729 871Q636 871 564 814T452 647T412 445Q412
331 474 264T630 197Q748 197 828 298Q942 441 942 646Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1251" d="M295 1062H567L544 953Q631 1025 707 1056T870 1087Q1037 1087 1138 972T1240 629Q1240 342 1065 144Q915 -25 710 -25Q499 -25 391 146L276 -405H-11L295 1062ZM468 453Q468 329 528 261T671 192Q742
192 808 243T917 414T961 636Q961 755 904 818T759 882Q677 882 610 824T505 652T468 453Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1251" d="M1016 1062H1280L974 -405H687L790 90Q714 28 647 2T495 -25Q326 -25 224 88T122 417Q122 588 191 750T382 999T648 1087Q878 1087 981 895L1016 1062ZM399 422Q399 315 457 252T597 189Q670 189 738
238T848 402T891 621Q891 740 830 807T689 875Q623 875 555 823T443 652T399 422Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="797" d="M288 1062H556L513 856Q663 1087 838 1087Q900 1087 971 1056L861 821Q822 835 778 835Q704 835 628 779T508 630T423 333L353 0H66L288 1062Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="1139" d="M45 297L323 341Q360 253 415 217T565 180Q663 180 722 224Q763 254 763 297Q763 326 742 349Q720 371 623 403Q363 489 301 539Q204 617 204 743Q204 869 298 960Q429 1087 687 1087Q892 1087 997 1012T1130
809L865 763Q844 821 797 850Q733 889 643 889Q553 889 514 859T474 790Q474 750 514 724Q539 708 675 668Q885 607 956 548Q1056 465 1056 348Q1056 197 929 86T571 -25Q341 -25 216 59T45 297Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="682" d="M154 849L198 1062H338L373 1232L702 1430L625 1062H800L756 849H580L487 404Q462 283 462 266Q462 233 483 215T559 196Q578 196 654 203L609 -10Q535 -25 457 -25Q305 -25 236 33T167 196Q167 245 204
422L293 849H154Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1251" d="M302 1062H589L458 433Q434 320 434 292Q434 246 468 213T555 180Q593 180 630 194T706 238T776 306T834 406Q853 452 875 556L981 1062H1268L1046 0H778L808 144Q632 -25 425 -25Q294 -25 219 50T144
251Q144 306 178 470L302 1062Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1139" d="M613 0H366L153 1062H435L510 599Q541 411 547 349Q555 366 616 478T692 614L956 1062H1266L613 0Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1593" d="M1192 0H922L870 676L546 0H280L147 1062H402L476 350L807 1062H1068L1104 350L1433 1062H1721L1192 0Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1139" d="M571 298L307 0H-45L446 544L176 1062H481L636 759L905 1062H1254L761 511L1029 0H724L571 298Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1139" d="M171 1062H457L529 533Q556 329 559 247Q615 410 713 591L967 1062H1271L615 -104Q534 -249 488 -307T376 -398T218 -431Q127 -431 13 -399L38 -185Q90 -200 139 -200Q271 -200 356 0L171 1062Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="1024" d="M34 0L75 194L657 838H182L229 1062H1062L1027 891L440 232H951L902 0H34Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="797" d="M82 410L134 650Q207 654 249 672T328 735T386 839T435 1026Q473 1209 512 1286T605 1405T755 1474Q818 1491 948 1491H1000L949 1252Q835 1252 798 1238T743 1193Q729 1172 698 1046Q642 824
623 776Q587 689 538 635T400 530Q459 491 487 436T515 290Q515 255 503 183Q470 -12 462 -48T453 -108Q453 -135 467 -154T510 -182T635 -191L583 -431H530Q392 -431 324 -409T219 -334T182 -200Q182 -133 217 26T252 239Q252 326 215 365T82 410Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="573" d="M176 -431V1491H399V-431H176Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="797" d="M688 410Q599 406 548 374T459 271T386 26T311 -225T218 -344T69 -413Q5 -431 -125 -431H-178L-126 -191Q-18 -191 21 -176T80 -130Q94 -109 125 14Q180 234 197 278Q232 365 286 426T422 530Q356
579 331 630T306 770Q306 806 318 876Q350 1068 359 1107T368 1174Q368 1201 356 1218T315 1243T186 1252L238 1491H291Q429 1491 497 1469T602 1395T639 1262Q639 1194 604 1035T569 822Q569 735 606 695T740 650L688 410Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1196" d="M67 519V778Q138 855 222 890Q283 916 367 916Q430 916 488 901T697 824Q797 783 855 783Q998 783 1129 924V654Q1081 604 998 562T837 520Q786 520 735 533T582 591Q428 658 340 658Q200 658 67 519Z" />
<hkern g1="space" g2="A" k="76" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Alphatonos" k="76" />
<hkern g1="space" g2="Alpha" k="76" />
<hkern g1="space" g2="Delta" k="76" />
<hkern g1="space" g2="Lambda" k="76" />
<hkern g1="space" g2="Upsilon" k="37" />
<hkern g1="space" g2="Upsilondieresis" k="37" />
<hkern g1="one" g2="one" k="152" />
<hkern g1="A" g2="space" k="76" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="113" />
<hkern g1="A" g2="Y" k="152" />
<hkern g1="A" g2="quoteright" k="113" />
<hkern g1="F" g2="comma" k="227" />
<hkern g1="F" g2="period" k="227" />
<hkern g1="F" g2="A" k="113" />
<hkern g1="L" g2="space" k="37" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="113" />
<hkern g1="L" g2="W" k="113" />
<hkern g1="L" g2="Y" k="152" />
<hkern g1="L" g2="quoteright" k="152" />
<hkern g1="P" g2="space" k="76" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="T" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="37" />
<hkern g1="T" g2="comma" k="152" />
<hkern g1="T" g2="hyphen" k="113" />
<hkern g1="T" g2="period" k="152" />
<hkern g1="T" g2="colon" k="152" />
<hkern g1="T" g2="semicolon" k="152" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="76" />
<hkern g1="T" g2="c" k="76" />
<hkern g1="T" g2="e" k="76" />
<hkern g1="T" g2="i" k="37" />
<hkern g1="T" g2="o" k="76" />
<hkern g1="T" g2="r" k="37" />
<hkern g1="T" g2="s" k="76" />
<hkern g1="T" g2="u" k="37" />
<hkern g1="T" g2="w" k="76" />
<hkern g1="T" g2="y" k="76" />
<hkern g1="V" g2="comma" k="188" />
<hkern g1="V" g2="hyphen" k="76" />
<hkern g1="V" g2="period" k="188" />
<hkern g1="V" g2="colon" k="76" />
<hkern g1="V" g2="semicolon" k="76" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="76" />
<hkern g1="V" g2="e" k="76" />
<hkern g1="V" g2="i" k="76" />
<hkern g1="V" g2="o" k="76" />
<hkern g1="V" g2="r" k="37" />
<hkern g1="V" g2="u" k="37" />
<hkern g1="V" g2="y" k="37" />
<hkern g1="W" g2="comma" k="152" />
<hkern g1="W" g2="hyphen" k="76" />
<hkern g1="W" g2="period" k="152" />
<hkern g1="W" g2="colon" k="76" />
<hkern g1="W" g2="semicolon" k="76" />
<hkern g1="W" g2="A" k="113" />
<hkern g1="W" g2="a" k="37" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="18" />
<hkern g1="W" g2="o" k="37" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="37" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="188" />
<hkern g1="Y" g2="hyphen" k="152" />
<hkern g1="Y" g2="period" k="188" />
<hkern g1="Y" g2="colon" k="113" />
<hkern g1="Y" g2="semicolon" k="113" />
<hkern g1="Y" g2="A" k="152" />
<hkern g1="Y" g2="a" k="76" />
<hkern g1="Y" g2="e" k="76" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="76" />
<hkern g1="Y" g2="p" k="76" />
<hkern g1="Y" g2="q" k="76" />
<hkern g1="Y" g2="u" k="76" />
<hkern g1="Y" g2="v" k="76" />
<hkern g1="f" g2="f" k="37" />
<hkern g1="f" g2="quoteright" k="-37" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="113" />
<hkern g1="v" g2="period" k="113" />
<hkern g1="w" g2="comma" k="76" />
<hkern g1="w" g2="period" k="76" />
<hkern g1="y" g2="comma" k="76" />
<hkern g1="y" g2="period" k="76" />
<hkern g1="quoteleft" g2="quoteleft" k="76" />
<hkern g1="quoteright" g2="space" k="76" />
<hkern g1="quoteright" g2="s" k="37" />
<hkern g1="quoteright" g2="t" k="-37" />
<hkern g1="quoteright" g2="quoteright" k="76" />
<hkern g1="quotedblbase" g2="afii10051" k="231" />
<hkern g1="quotedblbase" g2="afii10060" k="256" />
<hkern g1="quotedblbase" g2="afii10036" k="231" />
<hkern g1="quotedblbase" g2="afii10041" k="129" />
<hkern g1="quotedblbase" g2="afii10044" k="205" />
<hkern g1="Gamma" g2="comma" k="225" />
<hkern g1="Gamma" g2="period" k="225" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-266" />
<hkern g1="Gamma" g2="Alpha" k="178" />
<hkern g1="Gamma" g2="Delta" k="178" />
<hkern g1="Gamma" g2="Lambda" k="178" />
<hkern g1="Gamma" g2="iota" k="37" />
<hkern g1="Gamma" g2="iotadieresis" k="-131" />
<hkern g1="Theta" g2="Alpha" k="57" />
<hkern g1="Theta" g2="Upsilon" k="82" />
<hkern g1="Theta" g2="Upsilondieresis" k="82" />
<hkern g1="Phi" g2="Alpha" k="57" />
<hkern g1="Phi" g2="Upsilon" k="111" />
<hkern g1="Phi" g2="Upsilondieresis" k="111" />
<hkern g1="delta" g2="gamma" k="37" />
<hkern g1="delta" g2="chi" k="57" />
<hkern g1="delta" g2="pi" k="35" />
<hkern g1="tau" g2="phi" k="-29" />
<hkern g1="tau" g2="omega" k="-29" />
<hkern g1="tau" g2="omegatonos" k="-29" />
<hkern g1="phi" g2="gamma" k="37" />
<hkern g1="phi" g2="lambda" k="57" />
<hkern g1="phi" g2="chi" k="57" />
<hkern g1="phi" g2="pi" k="35" />
<hkern g1="Alphatonos" g2="space" k="76" />
<hkern g1="Alphatonos" g2="Theta" k="117" />
<hkern g1="Alphatonos" g2="Phi" k="117" />
<hkern g1="Alphatonos" g2="Omicron" k="117" />
<hkern g1="Alphatonos" g2="Tau" k="188" />
<hkern g1="Alphatonos" g2="Upsilon" k="252" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="252" />
<hkern g1="Alphatonos" g2="gamma" k="59" />
<hkern g1="Alphatonos" g2="nu" k="59" />
<hkern g1="Alphatonos" g2="chi" k="59" />
<hkern g1="Omicrontonos" g2="Upsilon" k="82" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="82" />
<hkern g1="Upsilontonos" g2="alpha" k="76" />
<hkern g1="Upsilontonos" g2="delta" k="76" />
<hkern g1="Upsilontonos" g2="sigma" k="76" />
<hkern g1="Upsilontonos" g2="phi" k="76" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-266" />
<hkern g1="Upsilontonos" g2="Alpha" k="182" />
<hkern g1="Upsilontonos" g2="Delta" k="135" />
<hkern g1="Upsilontonos" g2="Lambda" k="113" />
<hkern g1="Upsilontonos" g2="alphatonos" k="76" />
<hkern g1="Upsilontonos" g2="etatonos" k="76" />
<hkern g1="Upsilontonos" g2="iotatonos" k="76" />
<hkern g1="Upsilontonos" g2="eta" k="76" />
<hkern g1="Upsilontonos" g2="iota" k="76" />
<hkern g1="Upsilontonos" g2="kappa" k="76" />
<hkern g1="Upsilontonos" g2="mu" k="76" />
<hkern g1="Upsilontonos" g2="omicron" k="76" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="-131" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="76" />
<hkern g1="Alpha" g2="space" k="76" />
<hkern g1="Alpha" g2="quoteright" k="113" />
<hkern g1="Alpha" g2="Theta" k="117" />
<hkern g1="Alpha" g2="Phi" k="117" />
<hkern g1="Alpha" g2="Omicron" k="117" />
<hkern g1="Alpha" g2="Tau" k="188" />
<hkern g1="Alpha" g2="Upsilon" k="252" />
<hkern g1="Alpha" g2="Upsilondieresis" k="252" />
<hkern g1="Alpha" g2="gamma" k="59" />
<hkern g1="Alpha" g2="nu" k="59" />
<hkern g1="Alpha" g2="chi" k="59" />
<hkern g1="Delta" g2="space" k="76" />
<hkern g1="Delta" g2="Theta" k="43" />
<hkern g1="Delta" g2="Omicron" k="43" />
<hkern g1="Delta" g2="Tau" k="188" />
<hkern g1="Delta" g2="Upsilon" k="252" />
<hkern g1="Delta" g2="Upsilondieresis" k="252" />
<hkern g1="Kappa" g2="Theta" k="147" />
<hkern g1="Kappa" g2="Phi" k="147" />
<hkern g1="Kappa" g2="alpha" k="39" />
<hkern g1="Kappa" g2="delta" k="39" />
<hkern g1="Kappa" g2="sigma" k="39" />
<hkern g1="Kappa" g2="phi" k="39" />
<hkern g1="Kappa" g2="Omicron" k="147" />
<hkern g1="Kappa" g2="alphatonos" k="39" />
<hkern g1="Kappa" g2="zeta" k="39" />
<hkern g1="Kappa" g2="theta" k="39" />
<hkern g1="Kappa" g2="xi" k="39" />
<hkern g1="Kappa" g2="omicron" k="39" />
<hkern g1="Kappa" g2="omega" k="39" />
<hkern g1="Kappa" g2="omicrontonos" k="39" />
<hkern g1="Kappa" g2="omegatonos" k="39" />
<hkern g1="Lambda" g2="space" k="76" />
<hkern g1="Lambda" g2="Theta" k="43" />
<hkern g1="Lambda" g2="Omicron" k="43" />
<hkern g1="Lambda" g2="Tau" k="188" />
<hkern g1="Lambda" g2="Upsilon" k="252" />
<hkern g1="Lambda" g2="Upsilondieresis" k="252" />
<hkern g1="Omicron" g2="Alpha" k="57" />
<hkern g1="Omicron" g2="Upsilon" k="82" />
<hkern g1="Omicron" g2="Upsilondieresis" k="82" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="152" />
<hkern g1="Rho" g2="Delta" k="152" />
<hkern g1="Rho" g2="Lambda" k="152" />
<hkern g1="Sigma" g2="tau" k="49" />
<hkern g1="Tau" g2="comma" k="152" />
<hkern g1="Tau" g2="hyphen" k="113" />
<hkern g1="Tau" g2="period" k="152" />
<hkern g1="Tau" g2="colon" k="152" />
<hkern g1="Tau" g2="semicolon" k="152" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="76" />
<hkern g1="Tau" g2="delta" k="76" />
<hkern g1="Tau" g2="epsilon" k="76" />
<hkern g1="Tau" g2="sigma" k="76" />
<hkern g1="Tau" g2="phi" k="76" />
<hkern g1="Tau" g2="iotadieresistonos" k="-281" />
<hkern g1="Tau" g2="Alpha" k="152" />
<hkern g1="Tau" g2="Delta" k="92" />
<hkern g1="Tau" g2="Lambda" k="92" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="76" />
<hkern g1="Tau" g2="epsilontonos" k="76" />
<hkern g1="Tau" g2="gamma" k="55" />
<hkern g1="Tau" g2="eta" k="37" />
<hkern g1="Tau" g2="iota" k="37" />
<hkern g1="Tau" g2="mu" k="37" />
<hkern g1="Tau" g2="nu" k="76" />
<hkern g1="Tau" g2="omicron" k="76" />
<hkern g1="Tau" g2="upsilon" k="37" />
<hkern g1="Tau" g2="chi" k="76" />
<hkern g1="Tau" g2="psi" k="55" />
<hkern g1="Tau" g2="iotadieresis" k="-131" />
<hkern g1="Tau" g2="upsilondieresis" k="37" />
<hkern g1="Tau" g2="omicrontonos" k="76" />
<hkern g1="Tau" g2="upsilontonos" k="37" />
<hkern g1="Upsilon" g2="comma" k="186" />
<hkern g1="Upsilon" g2="hyphen" k="152" />
<hkern g1="Upsilon" g2="period" k="186" />
<hkern g1="Upsilon" g2="colon" k="113" />
<hkern g1="Upsilon" g2="semicolon" k="113" />
<hkern g1="Upsilon" g2="alpha" k="76" />
<hkern g1="Upsilon" g2="delta" k="76" />
<hkern g1="Upsilon" g2="sigma" k="76" />
<hkern g1="Upsilon" g2="phi" k="76" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-266" />
<hkern g1="Upsilon" g2="Alpha" k="182" />
<hkern g1="Upsilon" g2="Delta" k="135" />
<hkern g1="Upsilon" g2="Lambda" k="113" />
<hkern g1="Upsilon" g2="alphatonos" k="76" />
<hkern g1="Upsilon" g2="etatonos" k="76" />
<hkern g1="Upsilon" g2="iotatonos" k="76" />
<hkern g1="Upsilon" g2="gamma" k="43" />
<hkern g1="Upsilon" g2="eta" k="76" />
<hkern g1="Upsilon" g2="iota" k="76" />
<hkern g1="Upsilon" g2="kappa" k="76" />
<hkern g1="Upsilon" g2="mu" k="76" />
<hkern g1="Upsilon" g2="omicron" k="76" />
<hkern g1="Upsilon" g2="iotadieresis" k="-131" />
<hkern g1="Upsilon" g2="omicrontonos" k="76" />
<hkern g1="Chi" g2="omega" k="70" />
<hkern g1="Chi" g2="omegatonos" k="70" />
<hkern g1="Psi" g2="alpha" k="41" />
<hkern g1="Psi" g2="delta" k="57" />
<hkern g1="Psi" g2="sigma" k="41" />
<hkern g1="Psi" g2="phi" k="41" />
<hkern g1="Psi" g2="alphatonos" k="41" />
<hkern g1="Psi" g2="theta" k="35" />
<hkern g1="Psi" g2="omicron" k="41" />
<hkern g1="Psi" g2="omega" k="41" />
<hkern g1="Psi" g2="omicrontonos" k="41" />
<hkern g1="Psi" g2="omegatonos" k="41" />
<hkern g1="Omega" g2="Upsilon" k="82" />
<hkern g1="Omega" g2="Upsilondieresis" k="82" />
<hkern g1="Upsilondieresis" g2="alpha" k="76" />
<hkern g1="Upsilondieresis" g2="delta" k="76" />
<hkern g1="Upsilondieresis" g2="sigma" k="76" />
<hkern g1="Upsilondieresis" g2="phi" k="76" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-266" />
<hkern g1="Upsilondieresis" g2="Alpha" k="182" />
<hkern g1="Upsilondieresis" g2="Delta" k="135" />
<hkern g1="Upsilondieresis" g2="Lambda" k="113" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="76" />
<hkern g1="Upsilondieresis" g2="etatonos" k="76" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="76" />
<hkern g1="Upsilondieresis" g2="eta" k="76" />
<hkern g1="Upsilondieresis" g2="iota" k="76" />
<hkern g1="Upsilondieresis" g2="kappa" k="76" />
<hkern g1="Upsilondieresis" g2="mu" k="76" />
<hkern g1="Upsilondieresis" g2="omicron" k="76" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="-131" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="76" />
<hkern g1="zeta" g2="alpha" k="221" />
<hkern g1="zeta" g2="delta" k="74" />
<hkern g1="zeta" g2="sigma" k="221" />
<hkern g1="zeta" g2="tau" k="57" />
<hkern g1="zeta" g2="phi" k="221" />
<hkern g1="zeta" g2="alphatonos" k="221" />
<hkern g1="zeta" g2="etatonos" k="78" />
<hkern g1="zeta" g2="gamma" k="57" />
<hkern g1="zeta" g2="eta" k="78" />
<hkern g1="zeta" g2="theta" k="43" />
<hkern g1="zeta" g2="iota" k="78" />
<hkern g1="zeta" g2="kappa" k="78" />
<hkern g1="zeta" g2="nu" k="57" />
<hkern g1="zeta" g2="omicron" k="221" />
<hkern g1="zeta" g2="omega" k="221" />
<hkern g1="zeta" g2="omicrontonos" k="221" />
<hkern g1="zeta" g2="omegatonos" k="221" />
<hkern g1="zeta" g2="pi" k="57" />
<hkern g1="kappa" g2="alpha" k="78" />
<hkern g1="kappa" g2="delta" k="78" />
<hkern g1="kappa" g2="sigma" k="78" />
<hkern g1="kappa" g2="phi" k="78" />
<hkern g1="kappa" g2="alphatonos" k="78" />
<hkern g1="kappa" g2="zeta" k="78" />
<hkern g1="kappa" g2="theta" k="78" />
<hkern g1="kappa" g2="xi" k="78" />
<hkern g1="kappa" g2="omicron" k="78" />
<hkern g1="kappa" g2="sigma1" k="78" />
<hkern g1="kappa" g2="omega" k="78" />
<hkern g1="kappa" g2="omicrontonos" k="78" />
<hkern g1="kappa" g2="omegatonos" k="78" />
<hkern g1="lambda" g2="alpha" k="29" />
<hkern g1="lambda" g2="delta" k="29" />
<hkern g1="lambda" g2="sigma" k="29" />
<hkern g1="lambda" g2="phi" k="29" />
<hkern g1="lambda" g2="alphatonos" k="29" />
<hkern g1="lambda" g2="upsilondieresistonos" k="39" />
<hkern g1="lambda" g2="zeta" k="29" />
<hkern g1="lambda" g2="xi" k="29" />
<hkern g1="lambda" g2="omicron" k="29" />
<hkern g1="lambda" g2="sigma1" k="29" />
<hkern g1="lambda" g2="upsilon" k="39" />
<hkern g1="lambda" g2="omega" k="29" />
<hkern g1="lambda" g2="upsilondieresis" k="39" />
<hkern g1="lambda" g2="omicrontonos" k="29" />
<hkern g1="lambda" g2="upsilontonos" k="39" />
<hkern g1="lambda" g2="omegatonos" k="29" />
<hkern g1="xi" g2="alpha" k="43" />
<hkern g1="xi" g2="delta" k="43" />
<hkern g1="xi" g2="sigma" k="43" />
<hkern g1="xi" g2="phi" k="43" />
<hkern g1="xi" g2="alphatonos" k="43" />
<hkern g1="xi" g2="zeta" k="43" />
<hkern g1="xi" g2="xi" k="43" />
<hkern g1="xi" g2="omicron" k="43" />
<hkern g1="xi" g2="sigma1" k="43" />
<hkern g1="xi" g2="omicrontonos" k="43" />
<hkern g1="omicron" g2="tau" k="35" />
<hkern g1="omicron" g2="gamma" k="37" />
<hkern g1="omicron" g2="chi" k="57" />
<hkern g1="omicron" g2="pi" k="35" />
<hkern g1="rho" g2="chi" k="57" />
<hkern g1="rho" g2="pi" k="35" />
<hkern g1="chi" g2="alpha" k="29" />
<hkern g1="chi" g2="delta" k="29" />
<hkern g1="chi" g2="sigma" k="29" />
<hkern g1="chi" g2="phi" k="29" />
<hkern g1="chi" g2="alphatonos" k="29" />
<hkern g1="chi" g2="zeta" k="29" />
<hkern g1="chi" g2="omicron" k="29" />
<hkern g1="chi" g2="sigma1" k="29" />
<hkern g1="chi" g2="omega" k="29" />
<hkern g1="chi" g2="omicrontonos" k="29" />
<hkern g1="chi" g2="omegatonos" k="29" />
<hkern g1="omega" g2="gamma" k="37" />
<hkern g1="omega" g2="chi" k="57" />
<hkern g1="omega" g2="pi" k="35" />
<hkern g1="omicrontonos" g2="gamma" k="37" />
<hkern g1="omicrontonos" g2="chi" k="57" />
<hkern g1="omicrontonos" g2="pi" k="35" />
<hkern g1="omegatonos" g2="gamma" k="37" />
<hkern g1="omegatonos" g2="chi" k="57" />
<hkern g1="omegatonos" g2="pi" k="35" />
<hkern g1="afii10052" g2="comma" k="205" />
<hkern g1="afii10052" g2="period" k="205" />
<hkern g1="afii10058" g2="quoteright" k="205" />
<hkern g1="afii10059" g2="quoteright" k="205" />
<hkern g1="afii10017" g2="quoteright" k="154" />
<hkern g1="afii10017" g2="afii10021" k="-76" />
<hkern g1="afii10017" g2="afii10025" k="78" />
<hkern g1="afii10017" g2="afii10029" k="-25" />
<hkern g1="afii10017" g2="afii10032" k="102" />
<hkern g1="afii10017" g2="afii10033" k="51" />
<hkern g1="afii10017" g2="afii10035" k="102" />
<hkern g1="afii10017" g2="afii10036" k="207" />
<hkern g1="afii10017" g2="afii10037" k="129" />
<hkern g1="afii10017" g2="afii10038" k="129" />
<hkern g1="afii10017" g2="afii10041" k="102" />
<hkern g1="afii10017" g2="afii10047" k="102" />
<hkern g1="afii10017" g2="afii10065" k="-25" />
<hkern g1="afii10017" g2="afii10066" k="51" />
<hkern g1="afii10017" g2="afii10070" k="51" />
<hkern g1="afii10017" g2="afii10080" k="51" />
<hkern g1="afii10017" g2="afii10083" k="51" />
<hkern g1="afii10017" g2="afii10085" k="51" />
<hkern g1="afii10017" g2="afii10086" k="51" />
<hkern g1="afii10018" g2="afii10017" k="78" />
<hkern g1="afii10018" g2="afii10021" k="-25" />
<hkern g1="afii10018" g2="afii10024" k="27" />
<hkern g1="afii10018" g2="afii10025" k="27" />
<hkern g1="afii10018" g2="afii10029" k="-25" />
<hkern g1="afii10018" g2="afii10032" k="27" />
<hkern g1="afii10018" g2="afii10035" k="27" />
<hkern g1="afii10018" g2="afii10036" k="78" />
<hkern g1="afii10018" g2="afii10037" k="51" />
<hkern g1="afii10018" g2="afii10038" k="53" />
<hkern g1="afii10018" g2="afii10039" k="27" />
<hkern g1="afii10018" g2="afii10041" k="27" />
<hkern g1="afii10018" g2="afii10044" k="102" />
<hkern g1="afii10018" g2="afii10047" k="51" />
<hkern g1="afii10018" g2="afii10049" k="51" />
<hkern g1="afii10018" g2="afii10077" k="-25" />
<hkern g1="afii10018" g2="afii10085" k="27" />
<hkern g1="afii10018" g2="afii10097" k="-25" />
<hkern g1="afii10019" g2="afii10017" k="78" />
<hkern g1="afii10019" g2="afii10024" k="51" />
<hkern g1="afii10019" g2="afii10025" k="51" />
<hkern g1="afii10019" g2="afii10032" k="51" />
<hkern g1="afii10019" g2="afii10035" k="51" />
<hkern g1="afii10019" g2="afii10036" k="129" />
<hkern g1="afii10019" g2="afii10037" k="129" />
<hkern g1="afii10019" g2="afii10038" k="78" />
<hkern g1="afii10019" g2="afii10039" k="78" />
<hkern g1="afii10019" g2="afii10044" k="129" />
<hkern g1="afii10019" g2="afii10049" k="51" />
<hkern g1="afii10019" g2="afii10085" k="27" />
<hkern g1="afii10019" g2="afii10087" k="27" />
<hkern g1="afii10019" g2="afii10089" k="78" />
<hkern g1="afii10020" g2="comma" k="129" />
<hkern g1="afii10020" g2="period" k="129" />
<hkern g1="afii10020" g2="afii10017" k="104" />
<hkern g1="afii10020" g2="afii10021" k="51" />
<hkern g1="afii10020" g2="afii10025" k="27" />
<hkern g1="afii10020" g2="afii10029" k="27" />
<hkern g1="afii10020" g2="afii10032" k="27" />
<hkern g1="afii10020" g2="afii10049" k="27" />
<hkern g1="afii10020" g2="afii10065" k="27" />
<hkern g1="afii10020" g2="afii10067" k="104" />
<hkern g1="afii10020" g2="afii10069" k="27" />
<hkern g1="afii10020" g2="afii10070" k="102" />
<hkern g1="afii10020" g2="afii10074" k="78" />
<hkern g1="afii10020" g2="afii10077" k="78" />
<hkern g1="afii10020" g2="afii10078" k="51" />
<hkern g1="afii10020" g2="afii10079" k="51" />
<hkern g1="afii10020" g2="afii10080" k="102" />
<hkern g1="afii10020" g2="afii10082" k="51" />
<hkern g1="afii10020" g2="afii10085" k="51" />
<hkern g1="afii10020" g2="afii10093" k="51" />
<hkern g1="afii10020" g2="afii10094" k="51" />
<hkern g1="afii10020" g2="afii10096" k="51" />
<hkern g1="afii10020" g2="afii10097" k="51" />
<hkern g1="afii10021" g2="afii10038" k="27" />
<hkern g1="afii10021" g2="afii10041" k="-51" />
<hkern g1="afii10021" g2="afii10073" k="-25" />
<hkern g1="afii10021" g2="afii10085" k="-51" />
<hkern g1="afii10022" g2="afii10025" k="27" />
<hkern g1="afii10022" g2="afii10029" k="-25" />
<hkern g1="afii10022" g2="afii10083" k="-25" />
<hkern g1="afii10024" g2="afii10025" k="27" />
<hkern g1="afii10024" g2="afii10032" k="27" />
<hkern g1="afii10024" g2="afii10035" k="27" />
<hkern g1="afii10024" g2="afii10041" k="-76" />
<hkern g1="afii10024" g2="afii10044" k="-25" />
<hkern g1="afii10024" g2="afii10065" k="-25" />
<hkern g1="afii10024" g2="afii10070" k="27" />
<hkern g1="afii10024" g2="afii10080" k="27" />
<hkern g1="afii10024" g2="afii10085" k="27" />
<hkern g1="afii10025" g2="afii10024" k="51" />
<hkern g1="afii10025" g2="afii10032" k="51" />
<hkern g1="afii10025" g2="afii10035" k="51" />
<hkern g1="afii10025" g2="afii10036" k="78" />
<hkern g1="afii10025" g2="afii10037" k="78" />
<hkern g1="afii10025" g2="afii10038" k="51" />
<hkern g1="afii10025" g2="afii10041" k="-51" />
<hkern g1="afii10025" g2="afii10049" k="51" />
<hkern g1="afii10025" g2="afii10069" k="27" />
<hkern g1="afii10025" g2="afii10077" k="-25" />
<hkern g1="afii10028" g2="afii10032" k="27" />
<hkern g1="afii10028" g2="afii10035" k="27" />
<hkern g1="afii10028" g2="afii10036" k="-25" />
<hkern g1="afii10028" g2="afii10038" k="78" />
<hkern g1="afii10028" g2="afii10041" k="-102" />
<hkern g1="afii10028" g2="afii10070" k="78" />
<hkern g1="afii10028" g2="afii10073" k="51" />
<hkern g1="afii10028" g2="afii10080" k="78" />
<hkern g1="afii10028" g2="afii10083" k="78" />
<hkern g1="afii10028" g2="afii10085" k="27" />
<hkern g1="afii10028" g2="afii10095" k="51" />
<hkern g1="afii10029" g2="afii10038" k="27" />
<hkern g1="afii10029" g2="afii10065" k="-25" />
<hkern g1="afii10029" g2="afii10085" k="-25" />
<hkern g1="afii10030" g2="afii10041" k="-76" />
<hkern g1="afii10030" g2="afii10065" k="-25" />
<hkern g1="afii10030" g2="afii10085" k="-25" />
<hkern g1="afii10030" g2="afii10089" k="27" />
<hkern g1="afii10032" g2="afii10017" k="78" />
<hkern g1="afii10032" g2="afii10021" k="27" />
<hkern g1="afii10032" g2="afii10024" k="78" />
<hkern g1="afii10032" g2="afii10029" k="27" />
<hkern g1="afii10032" g2="afii10037" k="129" />
<hkern g1="afii10032" g2="afii10039" k="51" />
<hkern g1="afii10032" g2="afii10041" k="-51" />
<hkern g1="afii10032" g2="afii10049" k="51" />
<hkern g1="afii10032" g2="afii10078" k="-25" />
<hkern g1="afii10032" g2="afii10097" k="-25" />
<hkern g1="afii10034" g2="comma" k="256" />
<hkern g1="afii10034" g2="period" k="256" />
<hkern g1="afii10034" g2="colon" k="27" />
<hkern g1="afii10034" g2="semicolon" k="27" />
<hkern g1="afii10034" g2="guillemotright" k="51" />
<hkern g1="afii10034" g2="afii10017" k="129" />
<hkern g1="afii10034" g2="afii10021" k="78" />
<hkern g1="afii10034" g2="afii10024" k="78" />
<hkern g1="afii10034" g2="afii10025" k="78" />
<hkern g1="afii10034" g2="afii10029" k="51" />
<hkern g1="afii10034" g2="afii10036" k="78" />
<hkern g1="afii10034" g2="afii10037" k="78" />
<hkern g1="afii10034" g2="afii10039" k="78" />
<hkern g1="afii10034" g2="afii10049" k="51" />
<hkern g1="afii10034" g2="afii10069" k="27" />
<hkern g1="afii10034" g2="afii10070" k="27" />
<hkern g1="afii10034" g2="afii10080" k="27" />
<hkern g1="afii10035" g2="afii10017" k="51" />
<hkern g1="afii10035" g2="afii10025" k="51" />
<hkern g1="afii10035" g2="afii10036" k="78" />
<hkern g1="afii10035" g2="afii10037" k="78" />
<hkern g1="afii10035" g2="afii10039" k="27" />
<hkern g1="afii10035" g2="afii10041" k="-25" />
<hkern g1="afii10035" g2="afii10044" k="102" />
<hkern g1="afii10035" g2="afii10047" k="51" />
<hkern g1="afii10035" g2="afii10065" k="-51" />
<hkern g1="afii10035" g2="afii10072" k="-25" />
<hkern g1="afii10035" g2="afii10073" k="-25" />
<hkern g1="afii10035" g2="afii10089" k="27" />
<hkern g1="afii10036" g2="comma" k="78" />
<hkern g1="afii10036" g2="period" k="78" />
<hkern g1="afii10036" g2="afii10017" k="78" />
<hkern g1="afii10036" g2="afii10024" k="-51" />
<hkern g1="afii10036" g2="afii10030" k="-25" />
<hkern g1="afii10036" g2="afii10032" k="27" />
<hkern g1="afii10036" g2="afii10038" k="27" />
<hkern g1="afii10036" g2="afii10047" k="-25" />
<hkern g1="afii10036" g2="afii10067" k="78" />
<hkern g1="afii10036" g2="afii10070" k="78" />
<hkern g1="afii10036" g2="afii10074" k="78" />
<hkern g1="afii10036" g2="afii10076" k="51" />
<hkern g1="afii10036" g2="afii10077" k="51" />
<hkern g1="afii10036" g2="afii10078" k="51" />
<hkern g1="afii10036" g2="afii10080" k="78" />
<hkern g1="afii10036" g2="afii10081" k="27" />
<hkern g1="afii10036" g2="afii10082" k="51" />
<hkern g1="afii10036" g2="afii10083" k="78" />
<hkern g1="afii10036" g2="afii10085" k="51" />
<hkern g1="afii10036" g2="afii10087" k="51" />
<hkern g1="afii10036" g2="afii10091" k="51" />
<hkern g1="afii10036" g2="afii10093" k="27" />
<hkern g1="afii10036" g2="afii10094" k="27" />
<hkern g1="afii10036" g2="afii10096" k="27" />
<hkern g1="afii10036" g2="afii10097" k="27" />
<hkern g1="afii10037" g2="comma" k="154" />
<hkern g1="afii10037" g2="period" k="154" />
<hkern g1="afii10037" g2="colon" k="51" />
<hkern g1="afii10037" g2="semicolon" k="51" />
<hkern g1="afii10037" g2="afii10017" k="154" />
<hkern g1="afii10037" g2="afii10021" k="78" />
<hkern g1="afii10037" g2="afii10025" k="27" />
<hkern g1="afii10037" g2="afii10029" k="27" />
<hkern g1="afii10037" g2="afii10032" k="27" />
<hkern g1="afii10037" g2="afii10038" k="78" />
<hkern g1="afii10037" g2="afii10047" k="27" />
<hkern g1="afii10037" g2="afii10049" k="27" />
<hkern g1="afii10037" g2="afii10066" k="51" />
<hkern g1="afii10037" g2="afii10067" k="102" />
<hkern g1="afii10037" g2="afii10068" k="78" />
<hkern g1="afii10037" g2="afii10069" k="51" />
<hkern g1="afii10037" g2="afii10070" k="102" />
<hkern g1="afii10037" g2="afii10072" k="27" />
<hkern g1="afii10037" g2="afii10073" k="78" />
<hkern g1="afii10037" g2="afii10074" k="78" />
<hkern g1="afii10037" g2="afii10075" k="51" />
<hkern g1="afii10037" g2="afii10076" k="51" />
<hkern g1="afii10037" g2="afii10077" k="78" />
<hkern g1="afii10037" g2="afii10078" k="51" />
<hkern g1="afii10037" g2="afii10079" k="51" />
<hkern g1="afii10037" g2="afii10080" k="129" />
<hkern g1="afii10037" g2="afii10081" k="51" />
<hkern g1="afii10037" g2="afii10082" k="51" />
<hkern g1="afii10037" g2="afii10083" k="102" />
<hkern g1="afii10037" g2="afii10087" k="51" />
<hkern g1="afii10037" g2="afii10088" k="51" />
<hkern g1="afii10037" g2="afii10090" k="51" />
<hkern g1="afii10037" g2="afii10091" k="51" />
<hkern g1="afii10037" g2="afii10096" k="51" />
<hkern g1="afii10037" g2="afii10097" k="51" />
<hkern g1="afii10038" g2="afii10017" k="78" />
<hkern g1="afii10038" g2="afii10021" k="51" />
<hkern g1="afii10038" g2="afii10029" k="51" />
<hkern g1="afii10038" g2="afii10030" k="-25" />
<hkern g1="afii10038" g2="afii10036" k="129" />
<hkern g1="afii10038" g2="afii10037" k="129" />
<hkern g1="afii10038" g2="afii10041" k="-51" />
<hkern g1="afii10038" g2="afii10049" k="78" />
<hkern g1="afii10038" g2="afii10077" k="27" />
<hkern g1="afii10039" g2="afii10025" k="-25" />
<hkern g1="afii10039" g2="afii10032" k="27" />
<hkern g1="afii10039" g2="afii10035" k="27" />
<hkern g1="afii10039" g2="afii10038" k="51" />
<hkern g1="afii10039" g2="afii10047" k="27" />
<hkern g1="afii10039" g2="afii10080" k="78" />
<hkern g1="afii10039" g2="afii10085" k="27" />
<hkern g1="afii10040" g2="afii10065" k="-51" />
<hkern g1="afii10043" g2="afii10065" k="-51" />
<hkern g1="afii10043" g2="afii10085" k="-51" />
<hkern g1="afii10044" g2="quoteright" k="205" />
<hkern g1="afii10044" g2="afii10049" k="51" />
<hkern g1="afii10046" g2="quoteright" k="180" />
<hkern g1="afii10046" g2="afii10017" k="51" />
<hkern g1="afii10046" g2="afii10024" k="51" />
<hkern g1="afii10046" g2="afii10025" k="51" />
<hkern g1="afii10046" g2="afii10030" k="27" />
<hkern g1="afii10046" g2="afii10032" k="78" />
<hkern g1="afii10046" g2="afii10035" k="78" />
<hkern g1="afii10046" g2="afii10036" k="205" />
<hkern g1="afii10046" g2="afii10039" k="51" />
<hkern g1="afii10046" g2="afii10041" k="78" />
<hkern g1="afii10046" g2="afii10047" k="78" />
<hkern g1="afii10046" g2="afii10049" k="78" />
<hkern g1="afii10047" g2="afii10021" k="27" />
<hkern g1="afii10047" g2="afii10024" k="51" />
<hkern g1="afii10047" g2="afii10025" k="51" />
<hkern g1="afii10047" g2="afii10029" k="51" />
<hkern g1="afii10047" g2="afii10039" k="51" />
<hkern g1="afii10047" g2="afii10049" k="78" />
<hkern g1="afii10048" g2="afii10017" k="78" />
<hkern g1="afii10048" g2="afii10024" k="51" />
<hkern g1="afii10048" g2="afii10036" k="104" />
<hkern g1="afii10048" g2="afii10039" k="27" />
<hkern g1="afii10048" g2="afii10041" k="-25" />
<hkern g1="afii10065" g2="afii10077" k="-25" />
<hkern g1="afii10065" g2="afii10085" k="27" />
<hkern g1="afii10065" g2="afii10089" k="78" />
<hkern g1="afii10065" g2="afii10095" k="27" />
<hkern g1="afii10066" g2="afii10072" k="27" />
<hkern g1="afii10066" g2="afii10073" k="27" />
<hkern g1="afii10066" g2="afii10077" k="27" />
<hkern g1="afii10066" g2="afii10078" k="27" />
<hkern g1="afii10066" g2="afii10085" k="51" />
<hkern g1="afii10066" g2="afii10087" k="51" />
<hkern g1="afii10066" g2="afii10089" k="78" />
<hkern g1="afii10066" g2="afii10092" k="104" />
<hkern g1="afii10066" g2="afii10095" k="27" />
<hkern g1="afii10067" g2="afii10065" k="27" />
<hkern g1="afii10067" g2="afii10066" k="51" />
<hkern g1="afii10067" g2="afii10069" k="51" />
<hkern g1="afii10067" g2="afii10070" k="51" />
<hkern g1="afii10067" g2="afii10072" k="27" />
<hkern g1="afii10067" g2="afii10073" k="27" />
<hkern g1="afii10067" g2="afii10078" k="51" />
<hkern g1="afii10067" g2="afii10080" k="51" />
<hkern g1="afii10067" g2="afii10083" k="51" />
<hkern g1="afii10067" g2="afii10084" k="27" />
<hkern g1="afii10067" g2="afii10085" k="78" />
<hkern g1="afii10067" g2="afii10086" k="51" />
<hkern g1="afii10067" g2="afii10089" k="102" />
<hkern g1="afii10067" g2="afii10092" k="129" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="comma" k="27" />
<hkern g1="afii10068" g2="period" k="27" />
<hkern g1="afii10068" g2="afii10065" k="27" />
<hkern g1="afii10068" g2="afii10069" k="78" />
<hkern g1="afii10068" g2="afii10070" k="51" />
<hkern g1="afii10068" g2="afii10073" k="51" />
<hkern g1="afii10068" g2="afii10078" k="51" />
<hkern g1="afii10068" g2="afii10080" k="51" />
<hkern g1="afii10068" g2="afii10083" k="51" />
<hkern g1="afii10068" g2="afii10097" k="27" />
<hkern g1="afii10069" g2="afii10073" k="27" />
<hkern g1="afii10070" g2="afii10065" k="-25" />
<hkern g1="afii10070" g2="afii10066" k="-25" />
<hkern g1="afii10070" g2="afii10069" k="-25" />
<hkern g1="afii10070" g2="afii10072" k="27" />
<hkern g1="afii10070" g2="afii10077" k="-25" />
<hkern g1="afii10070" g2="afii10080" k="-25" />
<hkern g1="afii10070" g2="afii10083" k="-25" />
<hkern g1="afii10070" g2="afii10085" k="27" />
<hkern g1="afii10070" g2="afii10086" k="-25" />
<hkern g1="afii10070" g2="afii10087" k="27" />
<hkern g1="afii10070" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10065" k="-25" />
<hkern g1="afii10072" g2="afii10066" k="-25" />
<hkern g1="afii10072" g2="afii10085" k="-25" />
<hkern g1="afii10072" g2="afii10089" k="27" />
<hkern g1="afii10072" g2="afii10092" k="-25" />
<hkern g1="afii10073" g2="afii10066" k="27" />
<hkern g1="afii10073" g2="afii10069" k="27" />
<hkern g1="afii10073" g2="afii10070" k="27" />
<hkern g1="afii10073" g2="afii10073" k="27" />
<hkern g1="afii10073" g2="afii10078" k="27" />
<hkern g1="afii10073" g2="afii10080" k="27" />
<hkern g1="afii10073" g2="afii10083" k="27" />
<hkern g1="afii10073" g2="afii10085" k="78" />
<hkern g1="afii10073" g2="afii10086" k="27" />
<hkern g1="afii10073" g2="afii10089" k="102" />
<hkern g1="afii10073" g2="afii10092" k="102" />
<hkern g1="afii10076" g2="afii10065" k="-25" />
<hkern g1="afii10076" g2="afii10066" k="-25" />
<hkern g1="afii10076" g2="afii10077" k="-51" />
<hkern g1="afii10076" g2="afii10085" k="-25" />
<hkern g1="afii10076" g2="afii10089" k="27" />
<hkern g1="afii10076" g2="afii10095" k="-25" />
<hkern g1="afii10077" g2="afii10066" k="27" />
<hkern g1="afii10077" g2="afii10070" k="27" />
<hkern g1="afii10077" g2="afii10080" k="27" />
<hkern g1="afii10077" g2="afii10083" k="27" />
<hkern g1="afii10077" g2="afii10085" k="27" />
<hkern g1="afii10077" g2="afii10086" k="27" />
<hkern g1="afii10077" g2="afii10089" k="51" />
<hkern g1="afii10078" g2="afii10073" k="27" />
<hkern g1="afii10080" g2="afii10065" k="-25" />
<hkern g1="afii10080" g2="afii10072" k="27" />
<hkern g1="afii10080" g2="afii10085" k="51" />
<hkern g1="afii10080" g2="afii10087" k="51" />
<hkern g1="afii10080" g2="afii10089" k="102" />
<hkern g1="afii10080" g2="afii10095" k="27" />
<hkern g1="afii10082" g2="afii10072" k="27" />
<hkern g1="afii10082" g2="afii10073" k="27" />
<hkern g1="afii10082" g2="afii10077" k="27" />
<hkern g1="afii10082" g2="afii10078" k="27" />
<hkern g1="afii10082" g2="afii10085" k="53" />
<hkern g1="afii10082" g2="afii10087" k="51" />
<hkern g1="afii10082" g2="afii10089" k="102" />
<hkern g1="afii10082" g2="afii10095" k="27" />
<hkern g1="afii10083" g2="afii10072" k="27" />
<hkern g1="afii10083" g2="afii10073" k="27" />
<hkern g1="afii10083" g2="afii10085" k="27" />
<hkern g1="afii10083" g2="afii10086" k="27" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="78" />
<hkern g1="afii10083" g2="afii10092" k="51" />
<hkern g1="afii10084" g2="comma" k="27" />
<hkern g1="afii10084" g2="period" k="27" />
<hkern g1="afii10084" g2="afii10069" k="27" />
<hkern g1="afii10084" g2="afii10070" k="27" />
<hkern g1="afii10084" g2="afii10072" k="27" />
<hkern g1="afii10084" g2="afii10073" k="51" />
<hkern g1="afii10084" g2="afii10077" k="27" />
<hkern g1="afii10084" g2="afii10078" k="27" />
<hkern g1="afii10084" g2="afii10080" k="27" />
<hkern g1="afii10084" g2="afii10083" k="27" />
<hkern g1="afii10084" g2="afii10085" k="51" />
<hkern g1="afii10084" g2="afii10095" k="51" />
<hkern g1="afii10085" g2="comma" k="78" />
<hkern g1="afii10085" g2="period" k="78" />
<hkern g1="afii10085" g2="afii10066" k="-25" />
<hkern g1="afii10085" g2="afii10072" k="-25" />
<hkern g1="afii10085" g2="afii10073" k="-25" />
<hkern g1="afii10085" g2="afii10087" k="-25" />
<hkern g1="afii10085" g2="afii10097" k="-25" />
<hkern g1="afii10086" g2="afii10085" k="51" />
<hkern g1="afii10086" g2="afii10089" k="78" />
<hkern g1="afii10087" g2="afii10065" k="27" />
<hkern g1="afii10087" g2="afii10066" k="27" />
<hkern g1="afii10087" g2="afii10070" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="51" />
<hkern g1="afii10087" g2="afii10083" k="51" />
<hkern g1="afii10087" g2="afii10086" k="51" />
<hkern g1="afii10087" g2="afii10089" k="51" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10065" k="27" />
<hkern g1="afii10088" g2="afii10070" k="78" />
<hkern g1="afii10088" g2="afii10073" k="27" />
<hkern g1="afii10088" g2="afii10080" k="78" />
<hkern g1="afii10088" g2="afii10083" k="78" />
<hkern g1="afii10088" g2="afii10085" k="27" />
<hkern g1="afii10091" g2="afii10070" k="51" />
<hkern g1="afii10091" g2="afii10080" k="51" />
<hkern g1="afii10094" g2="afii10084" k="51" />
<hkern g1="afii10094" g2="afii10089" k="205" />
<hkern g1="afii10095" g2="afii10066" k="27" />
<hkern g1="afii10095" g2="afii10070" k="27" />
<hkern g1="afii10095" g2="afii10072" k="27" />
<hkern g1="afii10095" g2="afii10073" k="27" />
<hkern g1="afii10095" g2="afii10078" k="51" />
<hkern g1="afii10095" g2="afii10080" k="27" />
<hkern g1="afii10095" g2="afii10083" k="27" />
<hkern g1="afii10095" g2="afii10086" k="27" />
<hkern g1="afii10095" g2="afii10087" k="51" />
<hkern g1="afii10096" g2="afii10066" k="27" />
<hkern g1="afii10096" g2="afii10069" k="27" />
<hkern g1="afii10096" g2="afii10070" k="27" />
<hkern g1="afii10096" g2="afii10072" k="51" />
<hkern g1="afii10096" g2="afii10077" k="27" />
<hkern g1="afii10096" g2="afii10078" k="27" />
<hkern g1="afii10096" g2="afii10080" k="27" />
<hkern g1="afii10096" g2="afii10083" k="27" />
<hkern g1="afii10096" g2="afii10084" k="27" />
<hkern g1="afii10096" g2="afii10086" k="27" />
<hkern g1="afii10096" g2="afii10087" k="51" />
<hkern g1="afii10096" g2="afii10089" k="129" />
<hkern g1="afii10096" g2="afii10095" k="51" />
<hkern g1="afii10110" g2="comma" k="78" />
<hkern g1="afii10110" g2="period" k="78" />
<hkern g1="afii10110" g2="colon" k="27" />
<hkern g1="afii10110" g2="semicolon" k="27" />
<hkern g1="afii10050" g2="comma" k="51" />
<hkern g1="afii10050" g2="period" k="51" />
<hkern g1="pi" g2="phi" k="-29" />
<hkern g1="pi" g2="omega" k="-29" />
<hkern g1="pi" g2="omegatonos" k="-29" />
</font>

<font horiz-adv-x="904" ><font-face
    font-family="Arial-Italic"
    units-per-em="2048"
    panose-1="2 11 6 4 2 2 2 9 2 4"
    ascent="1854"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1536" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="569" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="569" d="M229 370L340 1166L403 1466H622L554 1141L342 370H229ZM115 0L158 205H362L319 0H115Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="727" d="M277 947L289 1221L341 1466H547L494 1221L389 947H277ZM608 947L620 1221L672 1466H878L825 1221L720 947H608Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1139" d="M103 -25L190 401H21V550H220L294 913H21V1062H324L411 1491H561L474 1062H789L876 1491H1027L940 1062H1113V913H910L835 550H1113V401H805L718 -25H568L654 401H340L253 -25H103ZM370 550H684L759
913H444L370 550Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1139" d="M454 -13Q308 17 211 135T105 424L287 435Q296 315 349 240T485 136L601 689Q483 740 430 783Q356 842 317 922T278 1086Q278 1244 407 1365T727 1487Q733 1487 767 1486L783 1564H883L864 1473Q1000
1439 1078 1350T1173 1112L1000 1103Q986 1192 947 1245T833 1324L728 821Q930 738 1005 640T1081 422Q1081 308 1014 194T835 27T579 -26Q569 -26 551 -25L515 -196H416L454 -13ZM636 861L737 1341Q660 1344 594 1314T492 1225T456 1098Q456 1022 493 967T636
861ZM692 650L581 119Q716 114 808 199T900 403Q900 481 858 538T692 650Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1821" d="M286 -54L1497 1491H1661L455 -54H286ZM199 1015Q199 1056 217 1141T272 1293T352 1400T448 1459T566 1478Q707 1478 779 1407T852 1197Q852 1082 804 954T671 767T468 707Q337 707 268 781T199
1015ZM353 982Q353 898 384 863T469 828Q532 828 583 876T664 1033T694 1218Q694 1285 660 1321T571 1357Q513 1357 464 1311T384 1163T353 982ZM1093 254Q1093 295 1111 380T1166 532T1246 639T1342 698T1460 717Q1601 717 1673 646T1746 436Q1746 321 1698 193T1565
6T1362 -54Q1231 -54 1162 20T1093 254ZM1247 220Q1247 137 1278 102T1363 66Q1426 66 1477 114T1558 270T1588 456Q1588 524 1554 560T1465 596Q1407 596 1358 550T1278 402T1247 220Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1366" d="M1016 143Q891 41 802 5T605 -32Q405 -32 283 85T161 381Q161 497 206 586T342 747Q411 801 546 862Q494 977 483 1016Q469 1072 469 1136Q469 1220 516 1306T649 1442T836 1491Q977 1491
1063 1409T1150 1210Q1150 1111 1076 1014T785 807Q916 570 1037 418Q1110 507 1176 627L1334 546Q1268 407 1151 274Q1216 191 1320 74L1184 -35Q1082 52 1016 143ZM719 942Q866 1017 929 1096Q973 1150 973 1206Q973 1265 933 1305T834 1346Q764 1346 711 1290T657
1155Q657 1060 719 942ZM911 282Q724 527 620 721Q484 657 426 597Q345 513 345 402Q345 288 422 210T612 131Q763 131 911 282Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="391" d="M260 947L272 1221L324 1466H530L477 1221L372 947H260Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M330 -431Q173 -87 173 276Q173 518 236 726T430 1139Q516 1275 705 1491H846Q729 1366 599 1139T409 693T350 253Q350 -77 465 -431H330Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M406 1491Q564 1147 564 785Q564 542 501 334T307 -79Q220 -215 32 -431H-109Q7 -305 138 -78T327 367T386 808Q386 1138 271 1491H406Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="797" d="M64 1197L110 1339Q269 1283 341 1242Q322 1423 321 1491H466Q463 1392 443 1243Q546 1295 679 1339L725 1197Q598 1155 476 1141Q537 1088 648 952L528 867Q470 946 391 1082Q317 941 261 867L143
952Q259 1095 309 1141Q180 1166 64 1197Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1196" d="M513 237V639H114V807H513V1206H683V807H1082V639H683V237H513Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="569" d="M111 0L154 205H360L323 26Q289 -135 218 -210T49 -296L66 -217Q185 -184 223 0H111Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M95 440L133 621H685L648 440H95Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="569" d="M118 0L161 205H366L322 0H118Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M-104 -24L684 1491H841L53 -24H-104Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1139" d="M145 481Q145 667 200 859T324 1166T465 1346T608 1441T765 1472Q933 1472 1045 1347T1158 986Q1158 743 1080 505Q988 223 824 82Q698 -25 537 -25Q372 -25 259 104T145 481ZM320 435Q320 300 365
224Q426 119 546 119Q651 119 737 214Q861 348 923 606T986 1029Q986 1187 926 1257T766 1327Q694 1327 632 1290T512 1163Q431 1036 371 783Q320 567 320 435Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1139" d="M493 0L725 1107Q575 989 303 918L337 1082Q472 1136 603 1223T801 1375Q841 1415 877 1472H982L675 0H493Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1139" d="M120 0Q148 131 197 219T329 387T645 654Q787 767 839 821Q914 899 948 974Q971 1025 971 1085Q971 1186 900 1256T724 1327Q621 1327 544 1256T434 1026L257 1052Q283 1247 408 1359T721 1472Q846
1472 947 1420T1100 1274T1151 1080Q1151 934 1047 799Q983 715 671 468Q537 362 472 294T373 166H1029L994 0H120Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1139" d="M112 384L288 406Q308 252 376 186T556 119Q690 119 787 215T885 435Q885 543 812 613T616 684Q602 684 558 680L589 831Q615 827 639 827Q794 827 877 902T961 1088Q961 1189 893 1258T725 1327Q628
1327 551 1257T451 1057L273 1093Q317 1274 442 1373T738 1472Q918 1472 1029 1363T1141 1095Q1141 979 1081 893T899 749Q985 698 1027 626T1070 461Q1070 264 923 120T570 -25Q371 -25 249 86T112 384Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1139" d="M612 0L691 374H93L131 553L952 1466H1100L905 534H1111L1078 374H872L793 0H612ZM724 534L852 1146L306 534H724Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1139" d="M143 419L327 437Q325 398 325 390Q325 324 358 257T449 155T571 119Q655 119 742 177T883 346T937 566Q937 689 865 763T674 837Q595 837 525 799T393 685L235 696L456 1446H1172L1137 1280H580L470
907Q532 952 597 974T732 997Q900 997 1008 886T1116 582Q1116 413 1042 271T839 52T559 -25Q433 -25 336 32T191 189T142 389Q142 399 143 419Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1139" d="M412 850Q488 913 563 944T713 976Q880 976 989 862T1098 555Q1098 306 936 128Q796 -25 596 -25Q414 -25 293 108T171 489Q171 710 249 946Q309 1127 397 1244T585 1417T810 1472Q960 1472 1055 1379T1163
1111L995 1095Q981 1214 928 1267T797 1320Q716 1320 634 1257T493 1071T412 850ZM349 412Q349 288 426 204T600 119Q668 119 744 170T873 327T926 536Q926 670 853 750T675 831Q555 831 452 714T349 412Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1139" d="M297 0Q321 148 399 356Q492 607 643 854T979 1280H248L283 1446H1219L1185 1280Q947 1071 769 741Q562 360 486 0H297Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1139" d="M462 806Q380 851 339 921T298 1073Q298 1206 394 1319Q522 1472 741 1472Q934 1472 1045 1369T1156 1115Q1156 1008 1096 922T908 785Q996 730 1034 668Q1083 587 1083 479Q1083 282 944 128T572
-26Q387 -26 270 88T153 373Q153 534 236 649T462 806ZM476 1065Q476 971 536 914T703 856Q827 856 904 931T982 1117Q982 1210 922 1268T755 1327Q675 1327 608 1290T509 1190T476 1065ZM335 358Q335 297 364 241T454 152T591 119Q738 119 829 257Q901 365 901
490Q901 592 835 657T660 722Q524 722 430 621T335 358Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1139" d="M138 336L308 353Q325 230 378 178T504 126Q608 126 697 216Q828 348 890 595Q799 527 729 498T584 469Q450 469 344 559Q204 676 204 895Q204 1143 366 1320Q505 1472 707 1472Q889 1472 1009 1338T1129
957Q1129 718 1049 485Q954 211 792 81Q660 -25 495 -25Q343 -25 247 69T138 336ZM379 916Q379 778 452 696T627 614Q702 614 776 665T903 817T956 1026Q956 1110 921 1182T826 1290T703 1327Q643 1327 585 1295T478 1201T404 1059T379 916Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="569" d="M296 857L339 1062H543L501 857H296ZM117 0L160 205H365L321 0H117Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="569" d="M290 857L333 1062H537L494 857H290ZM111 0L154 205H360L323 26Q289 -135 218 -210T49 -296L66 -217Q185 -184 223 0H111Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1196" d="M112 641V809L1083 1219V1040L313 724L1083 405V226L112 641Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1196" d="M1082 862H114V1030H1082V862ZM1082 417H114V585H1082V417Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1196" d="M1083 641L112 226V405L881 724L112 1040V1219L1083 809V641Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1139" d="M429 367Q439 458 470 528T566 673Q604 715 745 829T927 1014T969 1145Q969 1225 903 1285T731 1346Q617 1346 542 1275T441 1035L260 1065Q303 1279 426 1385T726 1491Q847 1491 946 1442T1097
1308T1148 1132Q1148 1021 1074 920Q1019 844 827 691Q696 585 656 525T600 367H429ZM340 0L383 205H588L545 0H340Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="2079" d="M1161 163Q1096 88 1016 43T854 -3Q765 -3 681 49T545 209T492 446Q492 605 573 764T776 1004T1011 1084Q1098 1084 1177 1039T1313 900L1347 1055H1526L1382 384Q1352 244 1352 229Q1352 202 1372 183T1422
163Q1475 163 1561 224Q1675 304 1741 438T1808 716Q1808 883 1723 1028T1468 1260T1093 1347Q859 1347 666 1238T366 924T259 485Q259 240 365 63T673 -198T1120 -283Q1382 -283 1559 -195T1824 19H2005Q1954 -86 1830 -195T1535 -367T1123 -431Q901 -431 714
-374T394 -203T195 61Q111 250 111 469Q111 713 211 934Q333 1205 557 1349T1102 1493Q1350 1493 1547 1392T1859 1089Q1956 916 1956 713Q1956 423 1752 198Q1570 -4 1354 -4Q1285 -4 1243 17T1180 77Q1167 102 1161 163ZM677 434Q677 297 742 221T891 145Q947
145 1009 178T1127 278T1220 445T1256 649Q1256 785 1189 860T1024 935Q960 935 904 903T794 798T709 623T677 434Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1366" d="M-41 0L790 1466H1021L1263 0H1073L1002 422H409L174 0H-41ZM493 573H978L921 941Q888 1160 880 1306Q830 1180 734 1007L493 573Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1366" d="M89 0L396 1466H850Q974 1466 1034 1456Q1132 1439 1199 1397T1304 1281T1341 1118Q1341 997 1275 905T1071 765Q1190 726 1249 648T1308 464Q1308 343 1239 232T1055 61T799 0H89ZM461 840H758Q971 840
1064 908T1158 1106Q1158 1168 1129 1213T1052 1278T869 1299H557L461 840ZM320 166H654Q787 166 833 175Q926 191 984 229T1075 331T1108 463Q1108 566 1044 619T798 673H426L320 166Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1479" d="M1235 516L1429 489Q1337 235 1161 105T766 -25Q499 -25 343 138T186 605Q186 1001 424 1260Q636 1491 951 1491Q1184 1491 1328 1366T1496 1030L1313 1013Q1284 1172 1194 1250T960 1329Q691 1329 525
1090Q381 884 381 601Q381 375 492 256T781 137Q933 137 1056 236T1235 516Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M91 0L397 1466H839Q998 1466 1082 1443Q1202 1412 1287 1333T1415 1134T1458 867Q1458 690 1405 545T1265 289T1084 116T860 23Q762 0 619 0H91ZM322 166H554Q711 166 833 195Q909 213 963 248Q1034
293 1092 367Q1168 465 1213 590T1259 876Q1259 1054 1197 1149T1039 1276Q968 1299 818 1299H559L322 166Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M92 0L399 1466H1457L1422 1299H560L464 843H1304L1269 676H429L323 166H1246L1211 0H92Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M93 0L399 1466H1352L1317 1299H560L463 832H1234L1199 665H428L289 0H93Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1593" d="M839 578L874 744H1516L1391 147Q1270 71 1115 23T810 -25Q490 -25 332 168Q199 331 199 587Q199 851 315 1067T609 1387T1004 1491Q1160 1491 1284 1435T1474 1284T1569 1037L1377 1016Q1346 1167 1249
1247T998 1328Q839 1328 701 1242T481 981T398 584Q398 363 507 250T808 137Q999 137 1219 263L1285 578H839Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M86 0L393 1466H588L461 857H1221L1348 1466H1544L1238 0H1042L1186 691H427L282 0H86Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="569" d="M117 0L424 1466H619L313 0H117Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1024" d="M83 427L265 440Q249 355 249 315Q249 234 299 186T440 137Q505 137 554 166T635 258Q659 305 684 427L902 1466H1097L874 395Q827 169 717 72T436 -25Q254 -25 161 59T68 295Q68 362 83 427Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1366" d="M91 0L397 1466H593L446 760L1242 1466H1518L837 869L1336 0H1117L694 743L387 476L287 0H91Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1139" d="M82 0L388 1466H584L313 166H1074L1039 0H82Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1706" d="M90 0L396 1466H637L785 516Q814 329 823 157Q884 305 1027 558L1541 1466H1786L1480 0H1287L1440 713Q1493 960 1592 1267Q1529 1124 1436 959L890 0H701L554 940Q534 1069 525 1241Q500 1048 476 935L281
0H90Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M100 0L407 1466H597L844 916Q957 664 1023 492Q1061 392 1111 222Q1138 407 1179 604L1359 1466H1550L1244 0H1050L686 847Q589 1071 535 1242Q520 1099 477 891L291 0H100Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1593" d="M187 614Q187 1006 413 1248T963 1491Q1237 1491 1409 1313T1582 834Q1582 620 1495 437Q1430 300 1331 201T1119 47Q969 -25 801 -25Q625 -25 481 59T262 293T187 614ZM380 604Q380 475 433 367T593
198T816 137Q929 137 1031 190T1213 339T1340 574T1387 849Q1387 1068 1265 1198T962 1328Q732 1328 556 1132T380 604Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1366" d="M88 0L395 1466H1007Q1166 1466 1245 1430T1377 1305T1429 1106Q1429 1015 1392 921T1299 766T1184 674T1060 628Q919 595 775 595H408L284 0H88ZM443 761H766Q954 761 1042 801T1183 925T1236 1101Q1236
1173 1208 1218T1129 1285T933 1307H557L443 761Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1593" d="M1238 118Q1312 30 1438 -52L1351 -168Q1218 -81 1112 43Q963 -27 828 -27Q720 -27 591 14T375 138T239 351T189 640Q189 831 262 1006Q323 1150 420 1254T634 1416Q787 1491 965 1491Q1239 1491 1411
1313T1584 834Q1584 613 1492 427T1238 118ZM1118 244Q1239 338 1314 502T1389 845Q1389 1067 1267 1197T968 1328Q820 1328 683 1242T464 988T382 624Q382 377 536 242Q656 137 793 137Q902 137 989 171Q898 254 802 304L873 426Q938 398 990 360T1118 244Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1479" d="M96 0L403 1466H1018Q1200 1466 1294 1436T1441 1321T1495 1109Q1495 930 1378 812T1000 659Q1080 600 1121 543Q1213 414 1269 276L1381 0H1162L1057 273Q1000 421 927 529Q877 604 825 627T656 651H428L292
0H96ZM461 810H732Q920 810 977 815Q1088 826 1159 865T1269 970T1308 1112Q1308 1176 1279 1223T1203 1288T1043 1305H565L461 810Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1366" d="M144 474L336 492L334 441Q334 356 373 286T502 177T716 138Q892 138 984 215T1077 391Q1077 460 1028 517Q978 573 755 669Q582 744 519 784Q420 849 373 925T326 1100Q326 1213 388 1304T569 1443T839
1491Q1018 1491 1141 1431T1319 1271T1375 1080Q1375 1071 1374 1050L1185 1035Q1185 1097 1174 1132Q1154 1193 1112 1235T997 1302T832 1328Q672 1328 583 1256Q515 1201 515 1110Q515 1056 543 1014T644 930Q696 901 891 815Q1049 745 1109 705Q1189 652 1232
577T1275 405Q1275 286 1203 186T1002 30T709 -25Q460 -25 303 83T144 474Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M465 0L736 1299H255L290 1466H1444L1409 1299H932L661 0H465Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M406 1466H602L414 565Q391 453 391 399Q391 281 484 209T718 137Q830 137 926 188T1079 340T1180 659L1349 1466H1545L1366 606Q1320 386 1245 258T1037 52T728 -26Q562 -26 441 29T259 181T198 401Q198
478 239 666L406 1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1366" d="M536 0L254 1466H443L613 592Q660 354 674 208Q766 396 825 506L1348 1466H1550L746 0H536Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1933" d="M346 0L256 1466H455L489 741Q492 689 499 459Q501 395 501 369Q501 352 500 270Q622 520 676 622L1122 1466H1324L1373 609Q1381 462 1384 255Q1402 306 1448 407Q1521 570 1556 640L1974 1466H2174L1428
0H1218L1169 888Q1162 1002 1158 1168Q1097 1029 1056 952L548 0H346Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1366" d="M-65 0L635 741L220 1466H436L625 1134Q700 1003 711 981Q737 932 768 864Q842 964 997 1127L1319 1466H1575L866 709L1268 0H1055L817 429Q782 492 736 591Q682 518 604 436L195 0H-65Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1366" d="M572 0L690 567L239 1466H449L665 1038Q736 898 803 738Q877 874 1005 1035L1349 1466H1583L883 552L768 0H572Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M50 0L69 147L803 1024L955 1208Q1001 1264 1044 1311Q951 1300 914 1300L866 1301L808 1300L751 1299H258L293 1466H1304L1287 1313L500 378Q355 205 316 161Q360 167 373 167H1172L1137 0H50Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="569" d="M13 -401L398 1466H801L772 1327H553L221 -262H442L413 -401H13Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M420 -24L174 1491H314L560 -24H420Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="569" d="M280 -401H-120L-91 -262H130L462 1327H242L271 1466H674L280 -401Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="961" d="M239 690H54L407 1491H552L907 690H726L479 1287L239 690Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1139" d="M-31 -407V-277H1162V-407H-31Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M493 1191L298 1466H518L634 1191H493Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1139" d="M784 132Q690 51 603 14T417 -24Q270 -24 180 62T90 284Q90 373 130 441T238 551T402 611Q463 623 633 630T878 666Q899 740 899 789Q899 852 853 888Q790 938 669 938Q555 938 483 888T377 744L194 760Q250
918 371 1002T678 1086Q875 1086 990 992Q1078 922 1078 810Q1078 725 1053 613L994 349Q966 223 966 144Q966 94 988 0H805Q790 52 784 132ZM851 538Q813 523 770 515T624 498Q466 484 401 463T303 394T270 290Q270 214 322 165T472 116Q562 116 645 163T776 296T851
538Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1139" d="M68 0L374 1466H555L446 942Q532 1021 602 1053T748 1086Q897 1086 996 975T1096 652Q1096 511 1056 394T957 198T835 71T706 0T579 -24Q474 -24 394 31T269 201L227 0H68ZM336 436L335 402Q335 266 400
195T562 124Q657 124 736 190T867 398T918 658Q918 792 854 866T694 940Q596 940 514 865T377 632Q336 515 336 436Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="1024" d="M801 387L982 368Q914 169 789 73T503 -24Q330 -24 223 88T115 401Q115 575 184 743T381 998T675 1086Q846 1086 946 990T1046 734L868 722Q867 823 810 880T658 937Q549 937 469 868T344 659T298 388Q298
252 358 184T506 116Q594 116 674 183T801 387Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1139" d="M784 154Q629 -24 460 -24Q309 -24 209 87T108 411Q108 605 187 765T386 1006T626 1086Q824 1086 925 895L1045 1466H1225L919 0H752L784 154ZM288 445Q288 334 310 270T385 164T512 121Q635 121 735
249Q869 419 869 669Q869 795 803 866T637 937Q572 937 519 908T413 810T324 633T288 445Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="1139" d="M848 361L1024 343Q986 212 850 94T524 -24Q406 -24 308 30T158 189T106 426Q106 600 186 763T395 1006T672 1086Q862 1086 975 968T1089 646Q1089 568 1075 486H293Q289 455 289 430Q289 281 357 203T525
124Q618 124 708 185T848 361ZM322 624H918Q919 652 919 664Q919 800 851 872T676 945Q560 945 465 865T322 624Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="569" d="M93 0L286 922H124L153 1062H315L346 1213Q370 1326 395 1376T478 1458T635 1491Q704 1491 835 1462L802 1304Q710 1328 648 1328Q595 1328 568 1302T520 1176L496 1062H698L669 922H467L274 0H93Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1139" d="M58 -96L241 -113Q239 -175 256 -206T310 -254Q359 -276 437 -276Q601 -276 673 -191Q720 -134 760 57L778 143Q637 0 478 0Q317 0 209 118T100 454Q100 633 185 783T389 1009T632 1086Q841 1086 954
888L990 1062H1156L942 37Q907 -132 850 -226T692 -373T457 -425Q329 -425 237 -392T99 -296T53 -150Q53 -125 58 -96ZM284 470Q284 361 305 306Q335 229 390 189T514 148Q603 148 691 210T833 404T888 654Q888 785 816 862T636 940Q570 940 508 905T393 797T312
623T284 470Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1139" d="M68 0L374 1466H555L438 903Q539 1001 626 1043T805 1086Q937 1086 1010 1017T1083 833Q1083 777 1051 627L920 0H739L874 643Q903 783 903 819Q903 871 867 904T763 937Q665 937 576 886T437 745T344
456L249 0H68Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="455" d="M325 1261L368 1466H548L505 1261H325ZM61 0L283 1062H464L242 0H61Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="455" d="M325 1261L368 1466H547L504 1261H325ZM-248 -399L-216 -245Q-154 -262 -106 -262Q-48 -262 -14 -224T58 -10L281 1062H462L232 -43Q189 -250 133 -325Q58 -425 -76 -425Q-147 -425 -248 -399Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1024" d="M70 0L377 1466H557L367 557L895 1062H1134L681 666L955 0H757L545 545L325 355L251 0H70Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="455" d="M54 0L360 1466H541L235 0H54Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1706" d="M67 0L289 1062H470L433 887Q534 1000 613 1043T786 1086Q885 1086 951 1034T1039 887Q1120 987 1209 1036T1398 1086Q1531 1086 1597 1023T1664 846Q1664 797 1641 684L1498 0H1317L1463 702Q1482 788
1482 825Q1482 877 1449 907T1356 937Q1275 937 1191 888T1061 760T979 515L871 0H690L840 717Q856 790 856 821Q856 873 824 905T739 937Q662 937 578 888T440 752T353 502L248 0H67Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1139" d="M68 0L290 1062H454L415 877Q522 986 615 1036T805 1086Q934 1086 1007 1016T1081 829Q1081 770 1055 643L920 0H739L880 673Q901 771 901 818Q901 871 865 904T759 937Q620 937 512 837T352 494L249 0H68Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1139" d="M100 403Q100 714 283 918Q434 1086 679 1086Q871 1086 988 966T1106 642Q1106 459 1032 302T822 60T534 -24Q410 -24 309 29T154 179T100 403ZM281 421Q281 271 353 194T536 116Q594 116 651 139T757
211T840 320T896 453Q927 552 927 643Q927 787 855 866T672 946Q587 946 517 906T391 787T308 606T281 421Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1139" d="M-21 -407L286 1062H453L422 914Q515 1011 588 1048T744 1086Q896 1086 996 976T1096 659Q1096 493 1041 357T906 137T744 15T576 -24Q385 -24 280 170L160 -407H-21ZM337 434Q337 315 354 269Q379 204
436 164T568 124Q724 124 820 299T916 658Q916 793 852 866T691 940Q622 940 563 904T454 795T370 617T337 434Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1139" d="M754 120Q599 -24 457 -24Q309 -24 207 88T105 408Q105 606 182 766T380 1006T629 1086Q726 1086 805 1032T934 867L975 1062H1131L825 -407H644L754 120ZM284 432Q284 275 349 200T511 124Q593 124 676
192T813 396T867 659Q867 789 800 863T636 937Q541 937 470 875Q377 795 324 644Q284 528 284 432Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="682" d="M68 0L290 1062H450L405 845Q487 968 565 1027T726 1086Q780 1086 859 1047L785 879Q738 913 682 913Q587 913 487 807T330 426L240 0H68Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="1024" d="M85 363L266 374Q266 296 290 241T378 151T529 116Q649 116 709 164T769 277Q769 324 733 366Q696 408 553 469T369 556Q302 597 268 652T234 780Q234 906 334 996T614 1086Q814 1086 918 994T1027 750L850
738Q846 834 782 890T601 946Q507 946 455 903T403 810Q403 760 448 722Q478 696 603 642Q811 552 865 500Q951 417 951 298Q951 219 903 143T755 22T520 -24Q336 -24 207 67Q78 158 85 363Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="569" d="M491 147L461 -1Q396 -18 335 -18Q227 -18 163 35Q115 75 115 144Q115 179 141 305L270 922H127L156 1062H299L354 1323L561 1448L480 1062H658L628 922H451L328 335Q305 223 305 201Q305 169 323 152T384
135Q444 135 491 147Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1139" d="M793 192Q602 -24 402 -24Q279 -24 204 46T128 219Q128 286 162 449L290 1062H471L329 383Q311 298 311 251Q311 191 347 158T455 124Q531 124 603 161T728 261T814 410Q836 465 865 603L961 1062H1142L920
0H753L793 192Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1024" d="M336 0L162 1062H338L429 477Q444 381 466 164Q518 277 599 423L954 1062H1145L537 0H336Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1479" d="M270 0L159 1062H333L381 585L400 317Q402 287 406 196Q436 298 457 352T524 508L777 1062H974L1009 531Q1017 410 1019 208Q1069 342 1182 580L1410 1062H1591L1072 0H884L844 623Q840 681 838 849Q797
742 741 618L460 0H270Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1024" d="M-3 0L459 539L194 1062H394L484 873Q534 767 574 670L880 1062H1101L655 525L923 0H723L617 216Q583 285 540 387L224 0H-3Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1024" d="M0 -410L11 -240Q67 -256 120 -256Q175 -256 209 -231Q253 -198 305 -107L363 -3L186 1062H364L444 525Q468 366 485 207L960 1062H1149L472 -141Q374 -317 298 -374T123 -431Q60 -431 0 -410Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="1024" d="M40 0L69 140L640 783Q701 851 776 924Q647 911 591 911H196L228 1062H1049L1025 948L449 301Q400 246 303 150Q454 159 510 159H928L895 0H40Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="684" d="M142 612Q219 614 276 653T369 772Q397 833 433 999T490 1226Q517 1309 554 1360T635 1440T740 1483Q775 1491 856 1491H912L878 1334H847Q762 1334 725 1314T667 1249T614 1055Q572 857 536 770T446
628T291 530Q363 497 397 441T432 291Q432 213 387 6Q355 -140 355 -178Q355 -216 370 -238Q381 -255 408 -264T529 -274L495 -431H440Q346 -431 308 -418Q250 -398 217 -351T184 -225Q184 -157 230 61Q265 226 265 284Q265 364 225 405T107 449L142 612Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="532" d="M188 -431V1491H345V-431H188Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="684" d="M633 612L598 449Q522 447 465 408T375 299T307 62T252 -162Q224 -247 186 -299T105 -379T-1 -423Q-35 -431 -116 -431H-172L-138 -274H-107Q-22 -274 15 -253T76 -182Q93 -145 125 6Q166 195
195 268Q234 370 295 432T449 530Q371 571 340 623T308 771Q308 848 353 1055Q385 1200 385 1239Q385 1290 358 1312T242 1334H211L245 1491H300Q394 1491 432 1478Q491 1458 523 1411T556 1285Q556 1219 523 1063Q475 832 475 776Q475 696 515 655T633 612Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1196" d="M87 557V762Q193 882 365 882Q425 882 491 865T679 795Q748 766 782 757T852 748Q917 748 986 787T1110 885V673Q1046 613 981 586T833 559Q773 559 719 573T546 640T348 693Q284 693 228 666T87 557Z" />
<hkern g1="space" g2="A" k="76" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Alphatonos" k="76" />
<hkern g1="space" g2="Upsilontonos" k="37" />
<hkern g1="space" g2="Alpha" k="76" />
<hkern g1="space" g2="Delta" k="76" />
<hkern g1="space" g2="Lambda" k="37" />
<hkern g1="space" g2="Upsilon" k="37" />
<hkern g1="space" g2="Upsilondieresis" k="37" />
<hkern g1="one" g2="one" k="152" />
<hkern g1="A" g2="space" k="76" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="113" />
<hkern g1="A" g2="W" k="37" />
<hkern g1="A" g2="Y" k="152" />
<hkern g1="A" g2="v" k="37" />
<hkern g1="A" g2="w" k="37" />
<hkern g1="A" g2="y" k="18" />
<hkern g1="A" g2="quoteright" k="76" />
<hkern g1="F" g2="space" k="37" />
<hkern g1="F" g2="comma" k="264" />
<hkern g1="F" g2="period" k="264" />
<hkern g1="F" g2="A" k="152" />
<hkern g1="L" g2="space" k="37" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="113" />
<hkern g1="L" g2="W" k="76" />
<hkern g1="L" g2="Y" k="188" />
<hkern g1="L" g2="y" k="37" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="P" g2="space" k="76" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="T" k="37" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="76" />
<hkern g1="T" g2="comma" k="188" />
<hkern g1="T" g2="hyphen" k="188" />
<hkern g1="T" g2="period" k="188" />
<hkern g1="T" g2="colon" k="152" />
<hkern g1="T" g2="semicolon" k="152" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="188" />
<hkern g1="T" g2="c" k="188" />
<hkern g1="T" g2="e" k="188" />
<hkern g1="T" g2="i" k="18" />
<hkern g1="T" g2="o" k="188" />
<hkern g1="T" g2="r" k="152" />
<hkern g1="T" g2="s" k="188" />
<hkern g1="T" g2="u" k="152" />
<hkern g1="T" g2="w" k="152" />
<hkern g1="T" g2="y" k="152" />
<hkern g1="V" g2="comma" k="152" />
<hkern g1="V" g2="hyphen" k="76" />
<hkern g1="V" g2="period" k="152" />
<hkern g1="V" g2="colon" k="37" />
<hkern g1="V" g2="semicolon" k="37" />
<hkern g1="V" g2="A" k="113" />
<hkern g1="V" g2="a" k="76" />
<hkern g1="V" g2="e" k="76" />
<hkern g1="V" g2="i" k="37" />
<hkern g1="V" g2="o" k="76" />
<hkern g1="V" g2="r" k="37" />
<hkern g1="V" g2="u" k="37" />
<hkern g1="V" g2="y" k="37" />
<hkern g1="W" g2="comma" k="76" />
<hkern g1="W" g2="hyphen" k="37" />
<hkern g1="W" g2="period" k="76" />
<hkern g1="W" g2="A" k="37" />
<hkern g1="W" g2="a" k="37" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="18" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="188" />
<hkern g1="Y" g2="hyphen" k="152" />
<hkern g1="Y" g2="period" k="188" />
<hkern g1="Y" g2="colon" k="76" />
<hkern g1="Y" g2="semicolon" k="76" />
<hkern g1="Y" g2="A" k="113" />
<hkern g1="Y" g2="a" k="152" />
<hkern g1="Y" g2="e" k="113" />
<hkern g1="Y" g2="i" k="37" />
<hkern g1="Y" g2="o" k="113" />
<hkern g1="Y" g2="p" k="113" />
<hkern g1="Y" g2="q" k="113" />
<hkern g1="Y" g2="u" k="76" />
<hkern g1="Y" g2="v" k="76" />
<hkern g1="f" g2="quoteright" k="-76" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="hyphen" k="37" />
<hkern g1="r" g2="period" k="76" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="113" />
<hkern g1="w" g2="period" k="113" />
<hkern g1="y" g2="comma" k="152" />
<hkern g1="y" g2="period" k="152" />
<hkern g1="quoteleft" g2="quoteleft" k="76" />
<hkern g1="quoteright" g2="space" k="113" />
<hkern g1="quoteright" g2="s" k="37" />
<hkern g1="quoteright" g2="quoteright" k="76" />
<hkern g1="quotedblbase" g2="afii10051" k="250" />
<hkern g1="quotedblbase" g2="afii10060" k="227" />
<hkern g1="quotedblbase" g2="afii10036" k="274" />
<hkern g1="quotedblbase" g2="afii10041" k="297" />
<hkern g1="quotedblbase" g2="afii10044" k="227" />
<hkern g1="Gamma" g2="comma" k="262" />
<hkern g1="Gamma" g2="period" k="262" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-209" />
<hkern g1="Gamma" g2="Alpha" k="195" />
<hkern g1="Gamma" g2="Delta" k="195" />
<hkern g1="Gamma" g2="Lambda" k="195" />
<hkern g1="Gamma" g2="iota" k="96" />
<hkern g1="Gamma" g2="iotadieresis" k="-94" />
<hkern g1="Theta" g2="Alpha" k="23" />
<hkern g1="Theta" g2="Delta" k="23" />
<hkern g1="Theta" g2="Lambda" k="23" />
<hkern g1="Theta" g2="Upsilon" k="111" />
<hkern g1="Theta" g2="Upsilondieresis" k="111" />
<hkern g1="Phi" g2="Alpha" k="80" />
<hkern g1="Phi" g2="Upsilon" k="111" />
<hkern g1="Phi" g2="Upsilondieresis" k="111" />
<hkern g1="delta" g2="tau" k="45" />
<hkern g1="delta" g2="gamma" k="37" />
<hkern g1="delta" g2="chi" k="59" />
<hkern g1="delta" g2="pi" k="45" />
<hkern g1="epsilon" g2="sigma1" k="55" />
<hkern g1="tau" g2="alpha" k="29" />
<hkern g1="tau" g2="delta" k="29" />
<hkern g1="tau" g2="sigma" k="29" />
<hkern g1="tau" g2="phi" k="29" />
<hkern g1="tau" g2="alphatonos" k="29" />
<hkern g1="tau" g2="zeta" k="29" />
<hkern g1="tau" g2="omicron" k="29" />
<hkern g1="tau" g2="sigma1" k="29" />
<hkern g1="tau" g2="omega" k="29" />
<hkern g1="tau" g2="omegatonos" k="29" />
<hkern g1="phi" g2="tau" k="45" />
<hkern g1="phi" g2="gamma" k="37" />
<hkern g1="phi" g2="chi" k="59" />
<hkern g1="phi" g2="pi" k="45" />
<hkern g1="Alphatonos" g2="space" k="76" />
<hkern g1="Alphatonos" g2="Theta" k="106" />
<hkern g1="Alphatonos" g2="Phi" k="119" />
<hkern g1="Alphatonos" g2="Omicron" k="106" />
<hkern g1="Alphatonos" g2="Tau" k="199" />
<hkern g1="Alphatonos" g2="Upsilon" k="264" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="264" />
<hkern g1="Alphatonos" g2="gamma" k="37" />
<hkern g1="Alphatonos" g2="nu" k="37" />
<hkern g1="Alphatonos" g2="chi" k="37" />
<hkern g1="Omicrontonos" g2="Upsilon" k="111" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="111" />
<hkern g1="Upsilontonos" g2="alpha" k="113" />
<hkern g1="Upsilontonos" g2="delta" k="113" />
<hkern g1="Upsilontonos" g2="sigma" k="113" />
<hkern g1="Upsilontonos" g2="phi" k="113" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-213" />
<hkern g1="Upsilontonos" g2="Alpha" k="152" />
<hkern g1="Upsilontonos" g2="Delta" k="152" />
<hkern g1="Upsilontonos" g2="Lambda" k="152" />
<hkern g1="Upsilontonos" g2="alphatonos" k="113" />
<hkern g1="Upsilontonos" g2="etatonos" k="37" />
<hkern g1="Upsilontonos" g2="iotatonos" k="37" />
<hkern g1="Upsilontonos" g2="eta" k="37" />
<hkern g1="Upsilontonos" g2="iota" k="37" />
<hkern g1="Upsilontonos" g2="kappa" k="37" />
<hkern g1="Upsilontonos" g2="mu" k="37" />
<hkern g1="Upsilontonos" g2="omicron" k="113" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="-106" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="113" />
<hkern g1="Omegatonos" g2="Upsilon" k="111" />
<hkern g1="Omegatonos" g2="Upsilondieresis" k="111" />
<hkern g1="Alpha" g2="space" k="76" />
<hkern g1="Alpha" g2="quoteright" k="76" />
<hkern g1="Alpha" g2="Theta" k="106" />
<hkern g1="Alpha" g2="Phi" k="119" />
<hkern g1="Alpha" g2="Omicron" k="106" />
<hkern g1="Alpha" g2="Tau" k="199" />
<hkern g1="Alpha" g2="Upsilon" k="264" />
<hkern g1="Alpha" g2="Upsilondieresis" k="264" />
<hkern g1="Alpha" g2="gamma" k="37" />
<hkern g1="Alpha" g2="nu" k="37" />
<hkern g1="Alpha" g2="chi" k="37" />
<hkern g1="Delta" g2="space" k="76" />
<hkern g1="Delta" g2="Theta" k="106" />
<hkern g1="Delta" g2="Omicron" k="106" />
<hkern g1="Delta" g2="Tau" k="199" />
<hkern g1="Delta" g2="Upsilon" k="264" />
<hkern g1="Delta" g2="Upsilondieresis" k="264" />
<hkern g1="Kappa" g2="Theta" k="98" />
<hkern g1="Kappa" g2="Phi" k="125" />
<hkern g1="Kappa" g2="alpha" k="25" />
<hkern g1="Kappa" g2="delta" k="25" />
<hkern g1="Kappa" g2="sigma" k="25" />
<hkern g1="Kappa" g2="phi" k="25" />
<hkern g1="Kappa" g2="Omicron" k="98" />
<hkern g1="Kappa" g2="alphatonos" k="25" />
<hkern g1="Kappa" g2="zeta" k="25" />
<hkern g1="Kappa" g2="theta" k="25" />
<hkern g1="Kappa" g2="xi" k="25" />
<hkern g1="Kappa" g2="omicron" k="25" />
<hkern g1="Kappa" g2="omega" k="25" />
<hkern g1="Kappa" g2="omicrontonos" k="25" />
<hkern g1="Kappa" g2="omegatonos" k="25" />
<hkern g1="Lambda" g2="space" k="37" />
<hkern g1="Lambda" g2="Theta" k="106" />
<hkern g1="Lambda" g2="Omicron" k="106" />
<hkern g1="Lambda" g2="Tau" k="199" />
<hkern g1="Lambda" g2="Upsilon" k="264" />
<hkern g1="Lambda" g2="Upsilondieresis" k="264" />
<hkern g1="Omicron" g2="Alphatonos" k="23" />
<hkern g1="Omicron" g2="Alpha" k="23" />
<hkern g1="Omicron" g2="Delta" k="23" />
<hkern g1="Omicron" g2="Lambda" k="23" />
<hkern g1="Omicron" g2="Upsilon" k="111" />
<hkern g1="Omicron" g2="Upsilondieresis" k="111" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="152" />
<hkern g1="Rho" g2="Delta" k="152" />
<hkern g1="Rho" g2="Lambda" k="152" />
<hkern g1="Sigma" g2="tau" k="66" />
<hkern g1="Tau" g2="comma" k="186" />
<hkern g1="Tau" g2="hyphen" k="186" />
<hkern g1="Tau" g2="period" k="186" />
<hkern g1="Tau" g2="colon" k="152" />
<hkern g1="Tau" g2="semicolon" k="152" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="186" />
<hkern g1="Tau" g2="delta" k="68" />
<hkern g1="Tau" g2="epsilon" k="186" />
<hkern g1="Tau" g2="sigma" k="186" />
<hkern g1="Tau" g2="phi" k="186" />
<hkern g1="Tau" g2="iotadieresistonos" k="-213" />
<hkern g1="Tau" g2="Alpha" k="152" />
<hkern g1="Tau" g2="Delta" k="152" />
<hkern g1="Tau" g2="Lambda" k="152" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="186" />
<hkern g1="Tau" g2="epsilontonos" k="186" />
<hkern g1="Tau" g2="upsilondieresistonos" k="152" />
<hkern g1="Tau" g2="gamma" k="88" />
<hkern g1="Tau" g2="eta" k="152" />
<hkern g1="Tau" g2="iota" k="16" />
<hkern g1="Tau" g2="mu" k="152" />
<hkern g1="Tau" g2="nu" k="88" />
<hkern g1="Tau" g2="omicron" k="186" />
<hkern g1="Tau" g2="upsilon" k="152" />
<hkern g1="Tau" g2="chi" k="88" />
<hkern g1="Tau" g2="psi" k="170" />
<hkern g1="Tau" g2="iotadieresis" k="-94" />
<hkern g1="Tau" g2="upsilondieresis" k="152" />
<hkern g1="Tau" g2="omicrontonos" k="186" />
<hkern g1="Tau" g2="upsilontonos" k="152" />
<hkern g1="Upsilon" g2="comma" k="186" />
<hkern g1="Upsilon" g2="hyphen" k="152" />
<hkern g1="Upsilon" g2="period" k="186" />
<hkern g1="Upsilon" g2="colon" k="76" />
<hkern g1="Upsilon" g2="semicolon" k="76" />
<hkern g1="Upsilon" g2="alpha" k="113" />
<hkern g1="Upsilon" g2="delta" k="113" />
<hkern g1="Upsilon" g2="sigma" k="113" />
<hkern g1="Upsilon" g2="phi" k="113" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-213" />
<hkern g1="Upsilon" g2="Alpha" k="152" />
<hkern g1="Upsilon" g2="Delta" k="152" />
<hkern g1="Upsilon" g2="Lambda" k="152" />
<hkern g1="Upsilon" g2="alphatonos" k="113" />
<hkern g1="Upsilon" g2="etatonos" k="37" />
<hkern g1="Upsilon" g2="iotatonos" k="37" />
<hkern g1="Upsilon" g2="gamma" k="37" />
<hkern g1="Upsilon" g2="eta" k="37" />
<hkern g1="Upsilon" g2="iota" k="37" />
<hkern g1="Upsilon" g2="kappa" k="37" />
<hkern g1="Upsilon" g2="mu" k="37" />
<hkern g1="Upsilon" g2="omicron" k="113" />
<hkern g1="Upsilon" g2="iotadieresis" k="-106" />
<hkern g1="Upsilon" g2="omicrontonos" k="113" />
<hkern g1="Chi" g2="omega" k="37" />
<hkern g1="Chi" g2="omegatonos" k="37" />
<hkern g1="Psi" g2="alpha" k="43" />
<hkern g1="Psi" g2="delta" k="43" />
<hkern g1="Psi" g2="sigma" k="43" />
<hkern g1="Psi" g2="phi" k="43" />
<hkern g1="Psi" g2="alphatonos" k="43" />
<hkern g1="Psi" g2="omicron" k="43" />
<hkern g1="Psi" g2="omega" k="43" />
<hkern g1="Psi" g2="omicrontonos" k="43" />
<hkern g1="Psi" g2="omegatonos" k="43" />
<hkern g1="Omega" g2="Upsilon" k="111" />
<hkern g1="Omega" g2="Upsilondieresis" k="111" />
<hkern g1="Upsilondieresis" g2="alpha" k="113" />
<hkern g1="Upsilondieresis" g2="delta" k="113" />
<hkern g1="Upsilondieresis" g2="sigma" k="113" />
<hkern g1="Upsilondieresis" g2="phi" k="113" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-213" />
<hkern g1="Upsilondieresis" g2="Alpha" k="152" />
<hkern g1="Upsilondieresis" g2="Delta" k="152" />
<hkern g1="Upsilondieresis" g2="Lambda" k="152" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="113" />
<hkern g1="Upsilondieresis" g2="etatonos" k="37" />
<hkern g1="Upsilondieresis" g2="eta" k="37" />
<hkern g1="Upsilondieresis" g2="iota" k="37" />
<hkern g1="Upsilondieresis" g2="kappa" k="37" />
<hkern g1="Upsilondieresis" g2="mu" k="37" />
<hkern g1="Upsilondieresis" g2="omicron" k="113" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="-106" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="113" />
<hkern g1="epsilontonos" g2="sigma1" k="55" />
<hkern g1="zeta" g2="alpha" k="102" />
<hkern g1="zeta" g2="delta" k="59" />
<hkern g1="zeta" g2="epsilon" k="125" />
<hkern g1="zeta" g2="sigma" k="102" />
<hkern g1="zeta" g2="tau" k="117" />
<hkern g1="zeta" g2="phi" k="102" />
<hkern g1="zeta" g2="alphatonos" k="102" />
<hkern g1="zeta" g2="epsilontonos" k="125" />
<hkern g1="zeta" g2="etatonos" k="115" />
<hkern g1="zeta" g2="gamma" k="59" />
<hkern g1="zeta" g2="eta" k="115" />
<hkern g1="zeta" g2="theta" k="59" />
<hkern g1="zeta" g2="iota" k="115" />
<hkern g1="zeta" g2="nu" k="59" />
<hkern g1="zeta" g2="omicron" k="193" />
<hkern g1="zeta" g2="upsilon" k="125" />
<hkern g1="zeta" g2="omega" k="102" />
<hkern g1="zeta" g2="iotadieresis" k="-113" />
<hkern g1="zeta" g2="omicrontonos" k="102" />
<hkern g1="zeta" g2="upsilontonos" k="125" />
<hkern g1="zeta" g2="omegatonos" k="102" />
<hkern g1="zeta" g2="pi" k="117" />
<hkern g1="kappa" g2="alpha" k="25" />
<hkern g1="kappa" g2="delta" k="25" />
<hkern g1="kappa" g2="sigma" k="25" />
<hkern g1="kappa" g2="phi" k="25" />
<hkern g1="kappa" g2="alphatonos" k="25" />
<hkern g1="kappa" g2="zeta" k="59" />
<hkern g1="kappa" g2="xi" k="59" />
<hkern g1="kappa" g2="omicron" k="25" />
<hkern g1="kappa" g2="sigma1" k="59" />
<hkern g1="kappa" g2="omega" k="25" />
<hkern g1="kappa" g2="omicrontonos" k="25" />
<hkern g1="kappa" g2="omegatonos" k="25" />
<hkern g1="lambda" g2="alpha" k="29" />
<hkern g1="lambda" g2="delta" k="29" />
<hkern g1="lambda" g2="sigma" k="29" />
<hkern g1="lambda" g2="phi" k="39" />
<hkern g1="lambda" g2="alphatonos" k="29" />
<hkern g1="lambda" g2="upsilondieresistonos" k="66" />
<hkern g1="lambda" g2="zeta" k="29" />
<hkern g1="lambda" g2="xi" k="29" />
<hkern g1="lambda" g2="omicron" k="29" />
<hkern g1="lambda" g2="sigma1" k="29" />
<hkern g1="lambda" g2="upsilon" k="66" />
<hkern g1="lambda" g2="omega" k="29" />
<hkern g1="lambda" g2="upsilondieresis" k="66" />
<hkern g1="lambda" g2="omicrontonos" k="29" />
<hkern g1="lambda" g2="upsilontonos" k="66" />
<hkern g1="lambda" g2="omegatonos" k="29" />
<hkern g1="xi" g2="alpha" k="29" />
<hkern g1="xi" g2="delta" k="29" />
<hkern g1="xi" g2="sigma" k="29" />
<hkern g1="xi" g2="phi" k="29" />
<hkern g1="xi" g2="alphatonos" k="29" />
<hkern g1="xi" g2="zeta" k="29" />
<hkern g1="xi" g2="xi" k="29" />
<hkern g1="xi" g2="omicron" k="29" />
<hkern g1="xi" g2="sigma1" k="29" />
<hkern g1="xi" g2="omicrontonos" k="29" />
<hkern g1="omicron" g2="tau" k="29" />
<hkern g1="omicron" g2="gamma" k="37" />
<hkern g1="omicron" g2="chi" k="59" />
<hkern g1="omicron" g2="pi" k="29" />
<hkern g1="rho" g2="tau" k="45" />
<hkern g1="rho" g2="pi" k="45" />
<hkern g1="chi" g2="alpha" k="35" />
<hkern g1="chi" g2="delta" k="35" />
<hkern g1="chi" g2="sigma" k="35" />
<hkern g1="chi" g2="phi" k="35" />
<hkern g1="chi" g2="alphatonos" k="35" />
<hkern g1="chi" g2="zeta" k="35" />
<hkern g1="chi" g2="omicron" k="35" />
<hkern g1="chi" g2="sigma1" k="35" />
<hkern g1="chi" g2="omega" k="35" />
<hkern g1="chi" g2="omicrontonos" k="35" />
<hkern g1="chi" g2="omegatonos" k="35" />
<hkern g1="omega" g2="tau" k="45" />
<hkern g1="omega" g2="gamma" k="37" />
<hkern g1="omega" g2="chi" k="59" />
<hkern g1="omega" g2="pi" k="45" />
<hkern g1="omicrontonos" g2="tau" k="45" />
<hkern g1="omicrontonos" g2="gamma" k="37" />
<hkern g1="omicrontonos" g2="chi" k="59" />
<hkern g1="omicrontonos" g2="pi" k="45" />
<hkern g1="omegatonos" g2="tau" k="45" />
<hkern g1="omegatonos" g2="gamma" k="37" />
<hkern g1="omegatonos" g2="chi" k="59" />
<hkern g1="omegatonos" g2="pi" k="45" />
<hkern g1="afii10052" g2="comma" k="205" />
<hkern g1="afii10052" g2="period" k="205" />
<hkern g1="afii10052" g2="guillemotleft" k="115" />
<hkern g1="afii10052" g2="guillemotright" k="115" />
<hkern g1="afii10058" g2="quoteright" k="227" />
<hkern g1="afii10059" g2="quoteright" k="182" />
<hkern g1="afii10017" g2="quoteright" k="160" />
<hkern g1="afii10017" g2="afii10021" k="-23" />
<hkern g1="afii10017" g2="afii10025" k="90" />
<hkern g1="afii10017" g2="afii10032" k="115" />
<hkern g1="afii10017" g2="afii10033" k="47" />
<hkern g1="afii10017" g2="afii10035" k="115" />
<hkern g1="afii10017" g2="afii10036" k="205" />
<hkern g1="afii10017" g2="afii10037" k="182" />
<hkern g1="afii10017" g2="afii10038" k="92" />
<hkern g1="afii10017" g2="afii10041" k="182" />
<hkern g1="afii10017" g2="afii10047" k="92" />
<hkern g1="afii10017" g2="afii10066" k="23" />
<hkern g1="afii10017" g2="afii10070" k="23" />
<hkern g1="afii10017" g2="afii10080" k="23" />
<hkern g1="afii10017" g2="afii10083" k="23" />
<hkern g1="afii10017" g2="afii10085" k="23" />
<hkern g1="afii10017" g2="afii10086" k="23" />
<hkern g1="afii10018" g2="afii10017" k="68" />
<hkern g1="afii10018" g2="afii10021" k="45" />
<hkern g1="afii10018" g2="afii10024" k="45" />
<hkern g1="afii10018" g2="afii10025" k="45" />
<hkern g1="afii10018" g2="afii10029" k="68" />
<hkern g1="afii10018" g2="afii10032" k="45" />
<hkern g1="afii10018" g2="afii10035" k="45" />
<hkern g1="afii10018" g2="afii10036" k="137" />
<hkern g1="afii10018" g2="afii10037" k="115" />
<hkern g1="afii10018" g2="afii10038" k="47" />
<hkern g1="afii10018" g2="afii10039" k="68" />
<hkern g1="afii10018" g2="afii10041" k="115" />
<hkern g1="afii10018" g2="afii10044" k="137" />
<hkern g1="afii10018" g2="afii10047" k="23" />
<hkern g1="afii10018" g2="afii10049" k="68" />
<hkern g1="afii10018" g2="afii10069" k="-23" />
<hkern g1="afii10018" g2="afii10085" k="45" />
<hkern g1="afii10018" g2="afii10097" k="-23" />
<hkern g1="afii10019" g2="afii10017" k="68" />
<hkern g1="afii10019" g2="afii10021" k="45" />
<hkern g1="afii10019" g2="afii10024" k="68" />
<hkern g1="afii10019" g2="afii10025" k="45" />
<hkern g1="afii10019" g2="afii10029" k="45" />
<hkern g1="afii10019" g2="afii10032" k="45" />
<hkern g1="afii10019" g2="afii10035" k="45" />
<hkern g1="afii10019" g2="afii10036" k="137" />
<hkern g1="afii10019" g2="afii10037" k="115" />
<hkern g1="afii10019" g2="afii10038" k="45" />
<hkern g1="afii10019" g2="afii10039" k="68" />
<hkern g1="afii10019" g2="afii10041" k="70" />
<hkern g1="afii10019" g2="afii10044" k="205" />
<hkern g1="afii10019" g2="afii10049" k="45" />
<hkern g1="afii10019" g2="afii10085" k="23" />
<hkern g1="afii10019" g2="afii10087" k="68" />
<hkern g1="afii10019" g2="afii10089" k="68" />
<hkern g1="afii10020" g2="comma" k="205" />
<hkern g1="afii10020" g2="period" k="205" />
<hkern g1="afii10020" g2="colon" k="45" />
<hkern g1="afii10020" g2="semicolon" k="23" />
<hkern g1="afii10020" g2="guillemotleft" k="115" />
<hkern g1="afii10020" g2="guillemotright" k="115" />
<hkern g1="afii10020" g2="afii10017" k="160" />
<hkern g1="afii10020" g2="afii10021" k="90" />
<hkern g1="afii10020" g2="afii10025" k="23" />
<hkern g1="afii10020" g2="afii10029" k="68" />
<hkern g1="afii10020" g2="afii10032" k="68" />
<hkern g1="afii10020" g2="afii10035" k="68" />
<hkern g1="afii10020" g2="afii10049" k="45" />
<hkern g1="afii10020" g2="afii10065" k="68" />
<hkern g1="afii10020" g2="afii10067" k="92" />
<hkern g1="afii10020" g2="afii10069" k="92" />
<hkern g1="afii10020" g2="afii10070" k="90" />
<hkern g1="afii10020" g2="afii10074" k="90" />
<hkern g1="afii10020" g2="afii10077" k="90" />
<hkern g1="afii10020" g2="afii10078" k="90" />
<hkern g1="afii10020" g2="afii10079" k="90" />
<hkern g1="afii10020" g2="afii10080" k="115" />
<hkern g1="afii10020" g2="afii10082" k="90" />
<hkern g1="afii10020" g2="afii10085" k="90" />
<hkern g1="afii10020" g2="afii10093" k="90" />
<hkern g1="afii10020" g2="afii10094" k="92" />
<hkern g1="afii10020" g2="afii10096" k="92" />
<hkern g1="afii10020" g2="afii10097" k="92" />
<hkern g1="afii10021" g2="afii10041" k="23" />
<hkern g1="afii10021" g2="afii10047" k="-23" />
<hkern g1="afii10021" g2="afii10073" k="-45" />
<hkern g1="afii10021" g2="afii10085" k="-23" />
<hkern g1="afii10022" g2="afii10025" k="23" />
<hkern g1="afii10024" g2="afii10025" k="23" />
<hkern g1="afii10024" g2="afii10032" k="45" />
<hkern g1="afii10024" g2="afii10035" k="45" />
<hkern g1="afii10024" g2="afii10041" k="45" />
<hkern g1="afii10024" g2="afii10044" k="-23" />
<hkern g1="afii10024" g2="afii10085" k="23" />
<hkern g1="afii10025" g2="afii10021" k="68" />
<hkern g1="afii10025" g2="afii10024" k="68" />
<hkern g1="afii10025" g2="afii10029" k="68" />
<hkern g1="afii10025" g2="afii10032" k="45" />
<hkern g1="afii10025" g2="afii10035" k="45" />
<hkern g1="afii10025" g2="afii10036" k="92" />
<hkern g1="afii10025" g2="afii10037" k="92" />
<hkern g1="afii10025" g2="afii10038" k="45" />
<hkern g1="afii10025" g2="afii10041" k="70" />
<hkern g1="afii10025" g2="afii10049" k="45" />
<hkern g1="afii10025" g2="afii10077" k="23" />
<hkern g1="afii10028" g2="afii10032" k="23" />
<hkern g1="afii10028" g2="afii10035" k="23" />
<hkern g1="afii10028" g2="afii10038" k="47" />
<hkern g1="afii10028" g2="afii10047" k="23" />
<hkern g1="afii10028" g2="afii10085" k="23" />
<hkern g1="afii10028" g2="afii10095" k="23" />
<hkern g1="afii10029" g2="afii10038" k="-23" />
<hkern g1="afii10029" g2="afii10066" k="-23" />
<hkern g1="afii10030" g2="afii10041" k="45" />
<hkern g1="afii10030" g2="afii10065" k="-23" />
<hkern g1="afii10030" g2="afii10085" k="-23" />
<hkern g1="afii10030" g2="afii10089" k="45" />
<hkern g1="afii10030" g2="afii10095" k="-23" />
<hkern g1="afii10032" g2="afii10017" k="45" />
<hkern g1="afii10032" g2="afii10021" k="70" />
<hkern g1="afii10032" g2="afii10024" k="68" />
<hkern g1="afii10032" g2="afii10029" k="68" />
<hkern g1="afii10032" g2="afii10037" k="137" />
<hkern g1="afii10032" g2="afii10039" k="68" />
<hkern g1="afii10032" g2="afii10041" k="68" />
<hkern g1="afii10032" g2="afii10049" k="45" />
<hkern g1="afii10032" g2="afii10077" k="23" />
<hkern g1="afii10032" g2="afii10087" k="45" />
<hkern g1="afii10034" g2="comma" k="319" />
<hkern g1="afii10034" g2="period" k="319" />
<hkern g1="afii10034" g2="colon" k="23" />
<hkern g1="afii10034" g2="semicolon" k="23" />
<hkern g1="afii10034" g2="guillemotright" k="68" />
<hkern g1="afii10034" g2="afii10017" k="160" />
<hkern g1="afii10034" g2="afii10021" k="160" />
<hkern g1="afii10034" g2="afii10024" k="90" />
<hkern g1="afii10034" g2="afii10025" k="45" />
<hkern g1="afii10034" g2="afii10029" k="137" />
<hkern g1="afii10034" g2="afii10030" k="23" />
<hkern g1="afii10034" g2="afii10036" k="115" />
<hkern g1="afii10034" g2="afii10037" k="92" />
<hkern g1="afii10034" g2="afii10038" k="23" />
<hkern g1="afii10034" g2="afii10039" k="92" />
<hkern g1="afii10034" g2="afii10049" k="23" />
<hkern g1="afii10034" g2="afii10069" k="23" />
<hkern g1="afii10034" g2="afii10070" k="23" />
<hkern g1="afii10034" g2="afii10080" k="23" />
<hkern g1="afii10034" g2="afii10097" k="23" />
<hkern g1="afii10035" g2="afii10017" k="68" />
<hkern g1="afii10035" g2="afii10021" k="68" />
<hkern g1="afii10035" g2="afii10025" k="23" />
<hkern g1="afii10035" g2="afii10029" k="68" />
<hkern g1="afii10035" g2="afii10030" k="23" />
<hkern g1="afii10035" g2="afii10032" k="23" />
<hkern g1="afii10035" g2="afii10036" k="68" />
<hkern g1="afii10035" g2="afii10037" k="115" />
<hkern g1="afii10035" g2="afii10039" k="45" />
<hkern g1="afii10035" g2="afii10041" k="90" />
<hkern g1="afii10035" g2="afii10044" k="137" />
<hkern g1="afii10035" g2="afii10065" k="-23" />
<hkern g1="afii10035" g2="afii10085" k="23" />
<hkern g1="afii10035" g2="afii10089" k="45" />
<hkern g1="afii10036" g2="comma" k="182" />
<hkern g1="afii10036" g2="period" k="182" />
<hkern g1="afii10036" g2="colon" k="23" />
<hkern g1="afii10036" g2="semicolon" k="23" />
<hkern g1="afii10036" g2="afii10017" k="68" />
<hkern g1="afii10036" g2="afii10021" k="45" />
<hkern g1="afii10036" g2="afii10024" k="-23" />
<hkern g1="afii10036" g2="afii10025" k="23" />
<hkern g1="afii10036" g2="afii10029" k="68" />
<hkern g1="afii10036" g2="afii10030" k="-23" />
<hkern g1="afii10036" g2="afii10032" k="45" />
<hkern g1="afii10036" g2="afii10038" k="68" />
<hkern g1="afii10036" g2="afii10047" k="23" />
<hkern g1="afii10036" g2="afii10049" k="-23" />
<hkern g1="afii10036" g2="afii10065" k="45" />
<hkern g1="afii10036" g2="afii10067" k="68" />
<hkern g1="afii10036" g2="afii10070" k="68" />
<hkern g1="afii10036" g2="afii10074" k="68" />
<hkern g1="afii10036" g2="afii10076" k="68" />
<hkern g1="afii10036" g2="afii10077" k="68" />
<hkern g1="afii10036" g2="afii10078" k="68" />
<hkern g1="afii10036" g2="afii10080" k="68" />
<hkern g1="afii10036" g2="afii10081" k="68" />
<hkern g1="afii10036" g2="afii10082" k="68" />
<hkern g1="afii10036" g2="afii10083" k="68" />
<hkern g1="afii10036" g2="afii10085" k="68" />
<hkern g1="afii10036" g2="afii10087" k="68" />
<hkern g1="afii10036" g2="afii10091" k="68" />
<hkern g1="afii10036" g2="afii10093" k="68" />
<hkern g1="afii10036" g2="afii10094" k="68" />
<hkern g1="afii10036" g2="afii10096" k="68" />
<hkern g1="afii10036" g2="afii10097" k="68" />
<hkern g1="afii10037" g2="comma" k="160" />
<hkern g1="afii10037" g2="period" k="160" />
<hkern g1="afii10037" g2="colon" k="45" />
<hkern g1="afii10037" g2="semicolon" k="45" />
<hkern g1="afii10037" g2="afii10017" k="68" />
<hkern g1="afii10037" g2="afii10021" k="68" />
<hkern g1="afii10037" g2="afii10025" k="-23" />
<hkern g1="afii10037" g2="afii10029" k="45" />
<hkern g1="afii10037" g2="afii10038" k="23" />
<hkern g1="afii10037" g2="afii10047" k="-23" />
<hkern g1="afii10037" g2="afii10049" k="-23" />
<hkern g1="afii10037" g2="afii10067" k="45" />
<hkern g1="afii10037" g2="afii10068" k="45" />
<hkern g1="afii10037" g2="afii10069" k="23" />
<hkern g1="afii10037" g2="afii10070" k="45" />
<hkern g1="afii10037" g2="afii10072" k="23" />
<hkern g1="afii10037" g2="afii10073" k="23" />
<hkern g1="afii10037" g2="afii10074" k="23" />
<hkern g1="afii10037" g2="afii10076" k="23" />
<hkern g1="afii10037" g2="afii10077" k="70" />
<hkern g1="afii10037" g2="afii10078" k="23" />
<hkern g1="afii10037" g2="afii10079" k="23" />
<hkern g1="afii10037" g2="afii10080" k="45" />
<hkern g1="afii10037" g2="afii10081" k="23" />
<hkern g1="afii10037" g2="afii10082" k="23" />
<hkern g1="afii10037" g2="afii10083" k="45" />
<hkern g1="afii10037" g2="afii10087" k="23" />
<hkern g1="afii10037" g2="afii10088" k="23" />
<hkern g1="afii10037" g2="afii10090" k="23" />
<hkern g1="afii10037" g2="afii10091" k="23" />
<hkern g1="afii10037" g2="afii10096" k="23" />
<hkern g1="afii10037" g2="afii10097" k="23" />
<hkern g1="afii10038" g2="afii10017" k="115" />
<hkern g1="afii10038" g2="afii10021" k="137" />
<hkern g1="afii10038" g2="afii10029" k="115" />
<hkern g1="afii10038" g2="afii10030" k="23" />
<hkern g1="afii10038" g2="afii10036" k="160" />
<hkern g1="afii10038" g2="afii10037" k="182" />
<hkern g1="afii10038" g2="afii10038" k="-23" />
<hkern g1="afii10038" g2="afii10041" k="70" />
<hkern g1="afii10038" g2="afii10049" k="45" />
<hkern g1="afii10038" g2="afii10077" k="45" />
<hkern g1="afii10039" g2="afii10025" k="23" />
<hkern g1="afii10039" g2="afii10032" k="70" />
<hkern g1="afii10039" g2="afii10035" k="70" />
<hkern g1="afii10039" g2="afii10038" k="68" />
<hkern g1="afii10039" g2="afii10080" k="45" />
<hkern g1="afii10039" g2="afii10085" k="45" />
<hkern g1="afii10040" g2="afii10065" k="-68" />
<hkern g1="afii10040" g2="afii10070" k="-45" />
<hkern g1="afii10040" g2="afii10080" k="-45" />
<hkern g1="afii10043" g2="afii10065" k="-45" />
<hkern g1="afii10043" g2="afii10070" k="-23" />
<hkern g1="afii10043" g2="afii10085" k="-23" />
<hkern g1="afii10044" g2="quoteright" k="227" />
<hkern g1="afii10044" g2="afii10049" k="68" />
<hkern g1="afii10046" g2="quoteright" k="250" />
<hkern g1="afii10046" g2="afii10017" k="90" />
<hkern g1="afii10046" g2="afii10021" k="45" />
<hkern g1="afii10046" g2="afii10024" k="115" />
<hkern g1="afii10046" g2="afii10025" k="68" />
<hkern g1="afii10046" g2="afii10029" k="45" />
<hkern g1="afii10046" g2="afii10030" k="45" />
<hkern g1="afii10046" g2="afii10032" k="92" />
<hkern g1="afii10046" g2="afii10035" k="92" />
<hkern g1="afii10046" g2="afii10036" k="227" />
<hkern g1="afii10046" g2="afii10039" k="115" />
<hkern g1="afii10046" g2="afii10041" k="205" />
<hkern g1="afii10046" g2="afii10047" k="68" />
<hkern g1="afii10046" g2="afii10049" k="92" />
<hkern g1="afii10047" g2="afii10021" k="70" />
<hkern g1="afii10047" g2="afii10024" k="47" />
<hkern g1="afii10047" g2="afii10029" k="92" />
<hkern g1="afii10047" g2="afii10032" k="-23" />
<hkern g1="afii10047" g2="afii10038" k="-45" />
<hkern g1="afii10047" g2="afii10039" k="70" />
<hkern g1="afii10047" g2="afii10049" k="45" />
<hkern g1="afii10047" g2="afii10069" k="-45" />
<hkern g1="afii10047" g2="afii10072" k="-23" />
<hkern g1="afii10047" g2="afii10078" k="-23" />
<hkern g1="afii10047" g2="afii10097" k="-23" />
<hkern g1="afii10048" g2="afii10017" k="90" />
<hkern g1="afii10048" g2="afii10021" k="115" />
<hkern g1="afii10048" g2="afii10024" k="68" />
<hkern g1="afii10048" g2="afii10029" k="115" />
<hkern g1="afii10048" g2="afii10032" k="23" />
<hkern g1="afii10048" g2="afii10035" k="23" />
<hkern g1="afii10048" g2="afii10036" k="137" />
<hkern g1="afii10048" g2="afii10039" k="68" />
<hkern g1="afii10048" g2="afii10041" k="92" />
<hkern g1="afii10065" g2="afii10073" k="45" />
<hkern g1="afii10065" g2="afii10077" k="23" />
<hkern g1="afii10065" g2="afii10081" k="23" />
<hkern g1="afii10065" g2="afii10085" k="68" />
<hkern g1="afii10065" g2="afii10089" k="137" />
<hkern g1="afii10065" g2="afii10095" k="23" />
<hkern g1="afii10066" g2="afii10069" k="-23" />
<hkern g1="afii10066" g2="afii10072" k="23" />
<hkern g1="afii10066" g2="afii10077" k="45" />
<hkern g1="afii10066" g2="afii10085" k="45" />
<hkern g1="afii10066" g2="afii10087" k="68" />
<hkern g1="afii10066" g2="afii10089" k="68" />
<hkern g1="afii10066" g2="afii10092" k="68" />
<hkern g1="afii10066" g2="afii10097" k="23" />
<hkern g1="afii10067" g2="afii10065" k="45" />
<hkern g1="afii10067" g2="afii10066" k="23" />
<hkern g1="afii10067" g2="afii10069" k="45" />
<hkern g1="afii10067" g2="afii10070" k="45" />
<hkern g1="afii10067" g2="afii10072" k="45" />
<hkern g1="afii10067" g2="afii10073" k="45" />
<hkern g1="afii10067" g2="afii10077" k="68" />
<hkern g1="afii10067" g2="afii10078" k="45" />
<hkern g1="afii10067" g2="afii10080" k="45" />
<hkern g1="afii10067" g2="afii10083" k="45" />
<hkern g1="afii10067" g2="afii10084" k="23" />
<hkern g1="afii10067" g2="afii10085" k="68" />
<hkern g1="afii10067" g2="afii10086" k="45" />
<hkern g1="afii10067" g2="afii10089" k="115" />
<hkern g1="afii10067" g2="afii10092" k="92" />
<hkern g1="afii10067" g2="afii10097" k="45" />
<hkern g1="afii10068" g2="afii10065" k="23" />
<hkern g1="afii10068" g2="afii10069" k="23" />
<hkern g1="afii10068" g2="afii10070" k="23" />
<hkern g1="afii10068" g2="afii10073" k="23" />
<hkern g1="afii10068" g2="afii10077" k="23" />
<hkern g1="afii10068" g2="afii10078" k="23" />
<hkern g1="afii10068" g2="afii10080" k="23" />
<hkern g1="afii10068" g2="afii10083" k="23" />
<hkern g1="afii10068" g2="afii10097" k="45" />
<hkern g1="afii10069" g2="afii10085" k="23" />
<hkern g1="afii10070" g2="afii10065" k="23" />
<hkern g1="afii10070" g2="afii10069" k="23" />
<hkern g1="afii10070" g2="afii10072" k="23" />
<hkern g1="afii10070" g2="afii10073" k="23" />
<hkern g1="afii10070" g2="afii10077" k="68" />
<hkern g1="afii10070" g2="afii10078" k="23" />
<hkern g1="afii10070" g2="afii10083" k="23" />
<hkern g1="afii10070" g2="afii10084" k="23" />
<hkern g1="afii10070" g2="afii10085" k="68" />
<hkern g1="afii10070" g2="afii10086" k="23" />
<hkern g1="afii10070" g2="afii10087" k="90" />
<hkern g1="afii10070" g2="afii10089" k="115" />
<hkern g1="afii10072" g2="afii10084" k="-23" />
<hkern g1="afii10072" g2="afii10085" k="-23" />
<hkern g1="afii10072" g2="afii10089" k="45" />
<hkern g1="afii10072" g2="afii10092" k="-23" />
<hkern g1="afii10073" g2="afii10065" k="23" />
<hkern g1="afii10073" g2="afii10066" k="23" />
<hkern g1="afii10073" g2="afii10069" k="23" />
<hkern g1="afii10073" g2="afii10070" k="23" />
<hkern g1="afii10073" g2="afii10072" k="23" />
<hkern g1="afii10073" g2="afii10077" k="45" />
<hkern g1="afii10073" g2="afii10078" k="23" />
<hkern g1="afii10073" g2="afii10080" k="23" />
<hkern g1="afii10073" g2="afii10083" k="45" />
<hkern g1="afii10073" g2="afii10085" k="68" />
<hkern g1="afii10073" g2="afii10086" k="23" />
<hkern g1="afii10073" g2="afii10089" k="115" />
<hkern g1="afii10073" g2="afii10092" k="68" />
<hkern g1="afii10076" g2="afii10066" k="-23" />
<hkern g1="afii10076" g2="afii10083" k="23" />
<hkern g1="afii10076" g2="afii10084" k="-23" />
<hkern g1="afii10076" g2="afii10089" k="45" />
<hkern g1="afii10077" g2="afii10085" k="23" />
<hkern g1="afii10077" g2="afii10089" k="68" />
<hkern g1="afii10078" g2="afii10073" k="23" />
<hkern g1="afii10078" g2="afii10083" k="23" />
<hkern g1="afii10078" g2="afii10085" k="23" />
<hkern g1="afii10078" g2="afii10086" k="23" />
<hkern g1="afii10078" g2="afii10095" k="23" />
<hkern g1="afii10080" g2="afii10072" k="45" />
<hkern g1="afii10080" g2="afii10073" k="23" />
<hkern g1="afii10080" g2="afii10077" k="45" />
<hkern g1="afii10080" g2="afii10085" k="68" />
<hkern g1="afii10080" g2="afii10087" k="45" />
<hkern g1="afii10080" g2="afii10089" k="92" />
<hkern g1="afii10080" g2="afii10095" k="23" />
<hkern g1="afii10080" g2="afii10097" k="45" />
<hkern g1="afii10082" g2="afii10072" k="23" />
<hkern g1="afii10082" g2="afii10073" k="23" />
<hkern g1="afii10082" g2="afii10077" k="45" />
<hkern g1="afii10082" g2="afii10078" k="23" />
<hkern g1="afii10082" g2="afii10085" k="68" />
<hkern g1="afii10082" g2="afii10087" k="68" />
<hkern g1="afii10082" g2="afii10089" k="92" />
<hkern g1="afii10082" g2="afii10095" k="23" />
<hkern g1="afii10082" g2="afii10097" k="23" />
<hkern g1="afii10083" g2="afii10072" k="23" />
<hkern g1="afii10083" g2="afii10085" k="23" />
<hkern g1="afii10083" g2="afii10087" k="45" />
<hkern g1="afii10083" g2="afii10089" k="68" />
<hkern g1="afii10083" g2="afii10092" k="45" />
<hkern g1="afii10084" g2="comma" k="23" />
<hkern g1="afii10084" g2="period" k="23" />
<hkern g1="afii10084" g2="afii10065" k="23" />
<hkern g1="afii10084" g2="afii10069" k="23" />
<hkern g1="afii10084" g2="afii10072" k="23" />
<hkern g1="afii10084" g2="afii10073" k="23" />
<hkern g1="afii10084" g2="afii10077" k="45" />
<hkern g1="afii10084" g2="afii10078" k="23" />
<hkern g1="afii10084" g2="afii10080" k="23" />
<hkern g1="afii10084" g2="afii10082" k="23" />
<hkern g1="afii10084" g2="afii10083" k="23" />
<hkern g1="afii10084" g2="afii10085" k="45" />
<hkern g1="afii10084" g2="afii10095" k="23" />
<hkern g1="afii10084" g2="afii10097" k="23" />
<hkern g1="afii10085" g2="comma" k="137" />
<hkern g1="afii10085" g2="period" k="137" />
<hkern g1="afii10085" g2="afii10066" k="-45" />
<hkern g1="afii10085" g2="afii10072" k="-23" />
<hkern g1="afii10085" g2="afii10077" k="23" />
<hkern g1="afii10085" g2="afii10095" k="-23" />
<hkern g1="afii10086" g2="afii10066" k="-23" />
<hkern g1="afii10086" g2="afii10070" k="-23" />
<hkern g1="afii10086" g2="afii10077" k="45" />
<hkern g1="afii10086" g2="afii10080" k="-23" />
<hkern g1="afii10086" g2="afii10085" k="45" />
<hkern g1="afii10086" g2="afii10089" k="92" />
<hkern g1="afii10087" g2="afii10065" k="23" />
<hkern g1="afii10087" g2="afii10070" k="23" />
<hkern g1="afii10087" g2="afii10073" k="23" />
<hkern g1="afii10087" g2="afii10080" k="23" />
<hkern g1="afii10087" g2="afii10083" k="23" />
<hkern g1="afii10087" g2="afii10086" k="45" />
<hkern g1="afii10087" g2="afii10089" k="92" />
<hkern g1="afii10087" g2="afii10095" k="23" />
<hkern g1="afii10088" g2="afii10065" k="-23" />
<hkern g1="afii10088" g2="afii10085" k="-23" />
<hkern g1="afii10091" g2="afii10065" k="-23" />
<hkern g1="afii10091" g2="afii10085" k="-45" />
<hkern g1="afii10094" g2="afii10089" k="182" />
<hkern g1="afii10095" g2="afii10072" k="23" />
<hkern g1="afii10095" g2="afii10077" k="45" />
<hkern g1="afii10095" g2="afii10087" k="47" />
<hkern g1="afii10095" g2="afii10097" k="23" />
<hkern g1="afii10096" g2="afii10072" k="23" />
<hkern g1="afii10096" g2="afii10077" k="45" />
<hkern g1="afii10096" g2="afii10087" k="68" />
<hkern g1="afii10096" g2="afii10089" k="92" />
<hkern g1="afii10110" g2="comma" k="115" />
<hkern g1="afii10110" g2="period" k="115" />
<hkern g1="afii10050" g2="comma" k="115" />
<hkern g1="afii10050" g2="period" k="115" />
<hkern g1="afii10050" g2="guillemotleft" k="45" />
<hkern g1="afii10050" g2="guillemotright" k="45" />
<hkern g1="pi" g2="alpha" k="29" />
<hkern g1="pi" g2="delta" k="29" />
<hkern g1="pi" g2="sigma" k="29" />
<hkern g1="pi" g2="phi" k="29" />
<hkern g1="pi" g2="alphatonos" k="29" />
<hkern g1="pi" g2="zeta" k="29" />
<hkern g1="pi" g2="omicron" k="29" />
<hkern g1="pi" g2="sigma1" k="29" />
<hkern g1="pi" g2="omega" k="29" />
<hkern g1="pi" g2="omegatonos" k="29" />
</font>

<font horiz-adv-x="803" ><font-face
    font-family="ArialNarrow-BoldItalic"
    units-per-em="2048"
    panose-1="2 11 6 6 2 2 2 10 2 4"
    ascent="1916"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1593" d="M284 0V1280H1308V0H284ZM316 32H1276V1248H316V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="467" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="559" d="M342 373H213L286 1121L345 1466H593L529 1095L342 373ZM151 277H383L335 0H103L151 277Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="797" d="M249 945L253 1218L296 1466H547L504 1218L419 945H249ZM619 945L623 1218L667 1466H917L874 1218L789 945H619Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="934" d="M126 365H15V585H163L212 880H15V1101H249L313 1491H497L433 1101H613L677 1491H867L801 1101H915V880H765L715 585H915V365H679L613 -25H430L494 365H312L247 -25H62L126 365ZM396 880L348 585H530L578
880H396Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="934" d="M352 -10Q238 24 162 137T74 426L281 439Q297 267 391 215L466 657Q344 723 280 830T215 1067Q215 1182 264 1281T400 1436T566 1492L609 1491L624 1577H741L724 1474Q826 1442 891 1353T968 1115L766
1102Q752 1213 686 1257L618 859Q758 791 824 685T891 435Q891 232 770 103T466 -27L436 -203H319L352 -10ZM511 918L573 1281Q507 1282 459 1230T411 1098Q411 986 511 918ZM573 596L504 195Q593 203 645 262T698 411Q698 468 674 508T573 596Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1493" d="M152 1011Q152 1207 238 1349T472 1491Q574 1491 637 1413T700 1189Q700 1051 652 936T535 771T379 721Q280 721 216 797T152 1011ZM325 988Q325 936 343 913T393 890Q450 890 487 986Q531 1103
531 1228Q531 1273 512 1297T463 1321Q434 1321 409 1296T354 1170T325 988ZM397 -63H208L1210 1491H1399L397 -63ZM903 229Q903 426 989 568T1224 710Q1325 710 1388 632T1451 407Q1451 270 1403 155T1286 -10T1130 -60Q1031 -60 967 16T903 229ZM1076 207Q1076
155 1094 132T1144 109Q1201 109 1237 205Q1282 322 1282 447Q1282 492 1263 516T1214 540Q1186 540 1160 515T1105 388T1076 207Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1212" d="M1015 638L1185 514Q1131 382 1053 290Q1098 231 1172 154L1024 -34Q952 15 880 108Q817 47 728 11T539 -25Q361 -25 250 91T139 391Q139 486 171 573T262 729T448 881Q395 1023 395 1127Q395
1290 491 1390T731 1491Q853 1491 932 1411T1011 1212Q1011 1109 942 1001T732 804Q780 706 852 576Q891 508 915 475Q956 524 1015 638ZM647 1000Q811 1102 811 1210Q811 1253 788 1278T726 1304Q679 1304 646 1264T612 1154Q612 1091 647 1000ZM534 679Q371 580
371 418Q371 322 421 265T548 208Q647 208 749 291Q623 478 534 679Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="399" d="M254 945L258 1218L301 1466H552L509 1218L424 945H254Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="559" d="M402 -431H242Q110 -55 110 314Q110 526 167 737T337 1159Q402 1283 552 1491H730Q511 1176 422 888Q321 560 321 190Q321 -99 402 -431Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="559" d="M197 1491H357Q489 1107 489 747Q489 534 431 323T262 -99Q196 -222 47 -431H-132Q88 -114 177 174Q278 502 278 877Q278 1151 197 1491Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="653" d="M342 783L214 894L369 1092L161 1151L209 1329L401 1214L379 1478H528L505 1214L709 1323L754 1146L546 1092L690 894L568 783L456 1014L342 783Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="981" d="M384 211V592H69V855H384V1236H594V855H910V592H594V211H384Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="467" d="M119 277H356L317 48Q283 -153 208 -234T17 -318L40 -185Q98 -169 131 -128T180 0H71L119 277Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="559" d="M113 667H569L522 390H65L113 667Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="467" d="M122 277H354L306 0H74L122 277Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="467" d="M-73 -25L522 1491H687L92 -25H-73Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="934" d="M108 477Q108 761 198 1020T413 1389Q507 1472 625 1472Q770 1472 864 1344T959 967Q959 683 870 424T656 56Q563 -25 443 -25Q300 -25 204 102T108 477ZM339 419Q339 301 370 253T451 205Q513 205
564 274Q631 367 680 629T730 1035Q730 1145 698 1193T617 1242Q558 1242 510 1174Q434 1067 381 781Q339 557 339 419Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="934" d="M199 842L243 1098Q548 1260 714 1475H857L604 0H367L542 1016Q470 959 374 911T199 842Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="934" d="M444 1009L213 1051Q243 1261 346 1366T599 1472Q761 1472 860 1365T959 1078Q959 938 886 805Q832 707 666 518Q515 348 460 262H877L832 0H102Q120 163 206 311Q264 411 477 658Q632 838 675 908Q731
1002 731 1080Q731 1158 695 1202T605 1247Q482 1247 444 1009Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="934" d="M86 383L311 416Q325 299 362 254T460 209Q537 209 591 273T645 443Q645 538 601 588T487 639Q470 639 450 635L491 874L515 872Q607 872 657 928T707 1089Q707 1162 673 1202T587 1242Q476 1242 432
1041L217 1093Q261 1267 344 1356Q452 1472 604 1472Q754 1472 847 1369T941 1090Q941 972 885 881T735 749Q806 703 845 628T884 458Q884 285 777 143Q650 -25 457 -25Q309 -25 209 78T86 383Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="934" d="M519 299H46L87 539L738 1466H940L783 543H928L886 299H741L689 0H467L519 299ZM561 543L639 1000L322 543H561Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="934" d="M107 420L336 445L335 415Q335 312 373 262T468 211Q552 211 621 308T690 578Q690 682 651 733T551 784Q504 784 461 758T377 679L183 697L366 1446H971L926 1184H527L472 958Q506 977 540 986T609
996Q743 996 833 885T924 580Q924 412 856 266T681 48T460 -25Q310 -25 209 94T107 420Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="934" d="M966 1108L746 1086Q739 1174 712 1208T638 1243Q567 1243 514 1162T425 917Q501 978 586 978Q723 978 814 864T906 546Q906 315 788 145T487 -26Q388 -26 309 32T183 209T136 532Q136 946 285 1209T656
1472Q787 1472 868 1383T966 1108ZM363 431Q363 314 400 260T494 205Q563 205 612 284Q678 389 678 564Q678 679 641 733T551 788Q509 788 466 752T393 628T363 431Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="934" d="M174 1181L219 1446H1012L977 1242Q915 1181 846 1076Q747 925 677 769Q580 551 525 371Q449 120 430 0H206Q226 146 299 378T468 807T688 1181H174Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="934" d="M361 807Q298 858 266 924T234 1072Q234 1181 285 1276T421 1422T611 1472Q764 1472 858 1375T952 1114Q952 1003 902 921T749 785Q823 730 859 652T896 472Q896 290 794 149Q668 -26 464 -26Q310
-26 211 85T111 380Q111 531 179 646T361 807ZM450 1053Q450 982 485 941T574 899Q635 899 684 956T733 1094Q733 1167 698 1210T608 1253Q545 1253 498 1197T450 1053ZM345 375Q345 290 383 245T479 199Q565 199 616 292T668 510Q668 587 629 633T533 679Q460
679 403 597T345 375Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="934" d="M107 338L327 360Q334 273 361 239T436 204Q507 204 560 285T649 529Q572 469 488 469Q351 469 260 582T168 900Q168 1128 285 1300T590 1472Q688 1472 766 1415T890 1238T937 915Q937 499 788 237T417
-25Q285 -25 201 69T107 338ZM711 1016Q711 1132 674 1186T580 1241Q511 1241 461 1162Q396 1057 396 881Q396 767 432 713T522 658Q565 658 608 695T681 819T711 1016Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="559" d="M300 1062H532L485 784H252L300 1062ZM166 277H398L350 0H118L166 277Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="559" d="M304 1062H537L489 784H257L304 1062ZM170 277H407L368 48Q334 -153 259 -234T68 -318L91 -185Q149 -169 182 -128T231 0H122L170 277Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="981" d="M902 167L78 604V846L902 1281V996L328 728L902 450V167Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="981" d="M69 816V1074H910V816H69ZM69 372V631H910V372H69Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="981" d="M77 166V449L653 725L77 998V1279L902 844V604L77 166Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1026" d="M573 366H361Q379 502 431 599T639 862Q765 996 791 1042T818 1136Q818 1201 776 1240T655 1280Q564 1280 506 1221T421 1024L206 1070Q249 1272 370 1381T659 1491Q827 1491 932 1388T1037 1123Q1037
1026 990 939T761 667Q642 546 614 498T573 366ZM337 277H570L522 0H290L337 277Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1638" d="M1457 19H1631Q1544 -196 1360 -313T909 -431Q637 -431 449 -324T155 -11T50 486Q50 783 165 1020T466 1374T890 1492Q1093 1492 1250 1398T1498 1126T1589 721Q1589 460 1452 247Q1293 0 1046 0Q980
0 945 27T897 114Q801 0 674 0Q542 0 450 112T358 417Q358 607 429 772T596 1010T803 1084Q876 1084 930 1050T1019 948L1039 1059H1255L1132 342Q1120 273 1120 252Q1120 229 1129 217T1152 204Q1190 204 1252 260Q1335 334 1388 463T1441 730Q1441 898 1369 1034T1177
1239T887 1308Q685 1308 535 1213T292 920T199 469Q199 252 286 86T524 -163T893 -247Q1089 -247 1230 -181T1457 19ZM571 430Q571 301 614 242T721 183Q777 183 824 225Q885 279 929 409T974 671Q974 784 930 844T823 904Q722 904 659 790Q571 630 571 430Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1212" d="M856 324H379L235 0H-19L661 1466H935L1130 0H896L856 324ZM825 568L756 1158L491 568H825Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1212" d="M67 0L318 1466H730Q895 1466 965 1445Q1074 1413 1133 1326T1192 1111Q1192 982 1135 895T964 763Q1053 733 1106 655T1160 473Q1160 331 1096 216T928 51T634 0H67ZM464 874H653Q777 874 831 894T916
963T947 1075Q947 1126 924 1161T866 1209T715 1221H524L464 874ZM355 236H593Q733 236 785 256T872 329T907 450Q907 529 861 574T716 619H420L355 236Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1212" d="M940 528L1189 483Q1114 228 968 101T628 -26Q412 -26 286 132T159 606Q159 877 251 1083T485 1390T794 1491Q981 1491 1105 1368T1252 1016L1015 988Q994 1121 937 1176T789 1231Q696 1231 610 1164T464
940T403 593Q403 416 473 322T643 227Q738 227 819 301T940 528Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1212" d="M73 0L324 1466H648Q817 1466 877 1452Q978 1427 1053 1353T1173 1156T1217 859Q1217 677 1172 523T1046 253T877 85T695 13Q633 0 497 0H73ZM361 236H486Q623 236 678 255Q750 279 813 353T922 560T968
867Q968 1011 931 1093T830 1204Q785 1224 673 1224H530L361 236Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1120" d="M69 0L320 1466H1211L1169 1221H526L469 888H1091L1049 643H427L358 245H1049L1008 0H69Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1026" d="M65 0L316 1466H1158L1116 1221H522L461 869H1043L1001 624H419L312 0H65Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1307" d="M739 783H1276L1168 154Q1068 74 929 25T653 -25Q415 -25 294 117Q149 287 149 588Q149 850 248 1069T493 1390T819 1491Q1017 1491 1147 1377T1320 1029L1090 997Q1029 1247 819 1247Q705 1247 609 1178T451
952T388 588Q388 401 458 314T660 227Q734 227 804 249Q899 278 966 320L1004 538H697L739 783Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1212" d="M897 655H432L319 0H72L323 1466H571L473 900H939L1036 1466H1283L1032 0H785L897 655Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="467" d="M59 0L310 1466H557L306 0H59Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="934" d="M765 1466H1008L856 578Q793 207 690 91T395 -25Q229 -25 139 67T49 335Q49 370 53 414L282 444Q277 401 277 373Q277 298 311 263T411 227Q504 227 543 294Q573 344 614 588L765 1466Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1212" d="M66 0L317 1466H564L458 843L1014 1466H1346L805 891L1201 0H922L625 698L392 449L315 0H66Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1026" d="M76 0L327 1466H575L365 245H977L935 0H76Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1399" d="M760 0H525L482 1225L291 0H68L319 1466H672L709 439L1119 1466H1475L1224 0H998L1235 1216L760 0Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1212" d="M1030 0H799L474 985L306 0H75L326 1466H557L882 485L1050 1466H1281L1030 0Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1307" d="M147 575Q147 765 211 966Q292 1224 451 1357T819 1491Q1036 1491 1176 1326T1317 876Q1317 618 1217 400T967 78T639 -26Q425 -26 298 124Q147 301 147 575ZM392 581Q392 419 471 323T665 226Q757 226
847 298T1003 534T1070 869Q1070 1047 988 1149Q916 1239 799 1239Q705 1239 613 1166T457 932T392 581Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1120" d="M316 0H69L320 1466H809Q945 1466 1018 1427T1135 1305T1180 1100Q1180 954 1127 832T994 650T805 570Q746 559 571 559H412L316 0ZM454 802H530Q713 802 779 827T889 918T932 1073Q932 1168 870 1204Q834
1225 704 1225H526L454 802Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1307" d="M885 29Q828 2 767 -12T639 -26Q426 -26 298 125Q148 302 148 579Q148 764 211 965Q293 1223 452 1357T820 1491Q1037 1491 1177 1326T1318 876Q1318 658 1243 462T1048 146Q1124 54 1214 -8L1097 -195Q982
-127 885 29ZM906 355Q976 441 1023 586T1071 868Q1071 1047 994 1143T800 1239Q706 1239 615 1168T459 935T393 597Q393 421 472 324T669 227Q724 227 749 235Q758 238 758 248Q758 258 722 297Q675 347 624 370L714 538Q825 469 906 355Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1212" d="M321 0H74L325 1466H860Q1008 1466 1081 1427T1199 1301T1245 1081Q1245 886 1150 769T875 623Q925 568 973 467Q1053 297 1149 0H883Q867 62 775 337Q727 478 687 536Q658 577 628 592T527 607H425L321
0ZM463 827H594Q780 827 845 850T954 937T998 1076Q998 1159 943 1197Q911 1221 803 1221H531L463 827Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1120" d="M106 475L341 490Q346 372 368 326T441 254T580 227Q694 227 751 277T809 408Q809 465 776 506Q743 546 605 619Q430 712 373 763T284 890T252 1061Q252 1257 367 1374T681 1491Q882 1491 1002 1375T1135
1048L898 1035Q880 1252 680 1252Q581 1252 535 1211T488 1097Q488 1031 532 990Q575 948 706 878Q879 787 936 737T1023 613T1054 446Q1054 238 923 107T577 -25Q415 -25 301 44T145 228T106 475Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1026" d="M592 0H345L555 1221H202L244 1466H1191L1149 1221H802L592 0Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1212" d="M320 1466H567L431 670L398 478Q394 450 394 428Q394 335 448 281T597 227Q680 227 738 264T830 377T900 664L1037 1466H1284L1147 664Q1105 419 1058 304Q990 138 874 57T585 -25Q384 -25 269 95T153
424Q153 491 188 694L320 1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1120" d="M671 0H406L191 1466H438L591 357L1088 1466H1333L671 0Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1585" d="M1212 0H962L935 1072L497 0H242L197 1466H439L449 440L862 1466H1131L1158 451L1554 1466H1793L1212 0Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1120" d="M270 0H-50L481 742L182 1466H441L557 1191Q620 1043 648 961Q748 1110 817 1205L1006 1466H1316L767 694L1063 0H784L694 221Q622 398 600 472Q569 414 435 228L270 0Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1120" d="M674 0H426L525 571L193 1466H456L605 1052Q658 904 676 837Q708 904 748 976L861 1169L1031 1466H1318L767 543L674 0Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1026" d="M42 0L82 231L773 1221H213L255 1466H1122L1086 1236L386 240L515 243H554L732 245H1016L974 0H42Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="559" d="M454 -190L417 -404H16L336 1466H737L699 1243H520L274 -190H454Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="467" d="M317 -25L131 1491H295L482 -25H317Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="559" d="M190 1252L226 1466H629L309 -404H-94L-56 -180H126L371 1252H190Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="981" d="M95 692L403 1491H586L887 692H653L491 1181L330 692H95Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="934" d="M-12 -154H947V-256H-12V-154Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="559" d="M225 1499H452L557 1200H397L225 1499Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="934" d="M400 761L170 785Q211 932 312 1009T568 1086Q726 1086 811 1008T896 799Q896 753 890 701T841 417Q806 226 806 150Q806 81 825 0H597Q583 58 580 120Q528 50 461 13T326 -24Q220 -24 148 60T76 284Q76
445 158 532Q239 619 430 637Q598 654 655 678Q670 739 670 775Q670 823 638 852T549 882Q427 882 400 761ZM624 495Q602 488 567 482Q402 458 350 418T297 309Q297 256 327 223T405 190Q454 190 499 217T571 294T617 457L624 495Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1026" d="M60 0L311 1466H547L463 976Q532 1039 587 1062T705 1086Q842 1086 926 975T1010 646Q1010 447 945 288T780 52T579 -24Q392 -24 304 175L274 0H60ZM377 433Q377 324 427 258T544 192Q597 192 649 236T741
396T781 639Q781 756 733 819T617 882Q515 882 446 750T377 433Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="934" d="M658 400L886 355Q829 165 718 71T463 -24Q301 -24 201 94T101 429Q101 624 168 776T351 1007T598 1086Q746 1086 841 992T948 731L724 702Q708 875 584 875Q527 875 472 828T376 660T334 396Q334 301
372 251T465 200Q522 200 574 248T658 400Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1026" d="M872 0H649L669 115Q603 38 541 7T404 -24Q270 -24 185 87T100 421Q100 684 221 885T531 1086Q706 1086 794 917L888 1466H1123L872 0ZM329 432Q329 316 376 253T492 190Q548 190 601 233T693 387T733
614Q733 734 682 804T565 875Q514 875 461 830T369 671T329 432Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="934" d="M915 442H324V415Q324 308 374 244T494 180Q610 180 677 328L888 285Q826 130 723 53T492 -24Q322 -24 210 108T97 468Q97 713 225 899T583 1086Q738 1086 834 969T931 629Q931 524 915 442ZM716 617L717
645Q717 766 673 824T557 882Q485 882 427 815T348 617H716Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="559" d="M674 1062L638 852H472L325 0H90L236 852H105L141 1062H272L291 1171Q316 1319 345 1374T430 1460T561 1491Q670 1491 790 1443L745 1238Q660 1273 607 1273Q573 1273 552 1248Q536 1229 520 1137L507 1062H674Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1026" d="M54 -56L303 -100Q303 -164 334 -195T430 -226Q493 -226 532 -202T594 -128T639 70L646 120Q525 -4 395 -4Q268 -4 185 104T102 428Q102 633 163 785T321 1012T520 1086Q605 1086 677 1032T792 874L824
1062H1045L894 177Q849 -82 815 -180Q768 -314 677 -372T426 -431Q239 -431 156 -362Q52 -276 52 -100L54 -56ZM332 457Q332 336 383 264Q422 209 488 209Q542 209 595 254T688 402T727 627Q727 745 677 813T561 882Q511 882 463 840T373 682T332 457Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1026" d="M305 0H70L321 1466H557L467 944Q551 1024 620 1055T763 1086Q866 1086 929 1014T992 816Q992 753 969 621L862 0H627L736 633Q753 736 753 765Q753 820 725 851T652 882Q593 882 540 833Q467 766 431
668Q411 615 378 421L305 0Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="467" d="M319 1466H555L510 1206H275L319 1466ZM250 1062H485L303 0H68L250 1062Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="467" d="M321 1466H557L512 1206H276L321 1466ZM251 1062H488L333 163Q267 -221 221 -303Q150 -431 -10 -431Q-103 -431 -183 -399L-146 -162Q-90 -179 -51 -179Q0 -179 28 -130T101 182L251 1062Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="934" d="M64 0L315 1466H551L420 703L726 1062H1032L682 676L869 0H633L513 491L354 319L299 0H64Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="467" d="M66 0L317 1466H553L301 0H66Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1493" d="M242 1062H464L441 933Q571 1086 713 1086Q903 1086 933 899Q980 981 1065 1033T1237 1086Q1339 1086 1399 1021T1459 838Q1459 783 1436 649L1325 0H1089L1200 649Q1221 771 1221 787Q1221 833 1198
857T1135 882Q1050 882 982 776Q928 693 892 483L810 0H574L684 642Q703 753 703 785Q703 830 679 856T616 882Q565 882 511 834T424 692Q405 637 379 488L295 0H60L242 1062Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1026" d="M252 1062H475L452 924Q539 1015 611 1050T761 1086Q866 1086 929 1013T992 813Q992 758 966 602L863 0H627L731 602Q754 737 754 764Q754 821 727 851T655 882Q607 882 557 844Q485 790 450 716T380
436L305 0H70L252 1062Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1026" d="M102 441Q102 702 220 885Q351 1086 599 1086Q785 1086 895 960T1006 609Q1006 345 869 161T509 -24Q328 -24 215 101T102 441ZM773 646Q773 751 724 811T598 871Q534 871 478 827T380 674T338 448Q338
329 389 263T517 197Q613 197 680 299Q773 439 773 646Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1026" d="M242 1062H465L446 953Q521 1028 583 1057T713 1086Q849 1086 933 972T1017 629Q1017 337 869 139Q747 -24 582 -24Q410 -24 321 146L226 -405H-9L242 1062ZM384 453Q384 328 434 260T550 192Q603 192
654 235T746 396T788 637Q788 756 741 819T623 882Q568 882 517 839T425 684T384 453Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1026" d="M833 1062H1049L799 -405H563L648 90Q584 26 528 1T406 -24Q271 -24 192 78Q100 197 100 417Q100 614 166 776T328 1012T532 1086Q719 1086 804 895L833 1062ZM327 422Q327 313 375 251T490 189Q546 189
598 231T690 385T730 621Q730 742 680 808T565 875Q515 875 462 829T368 667T327 422Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="653" d="M236 1062H456L421 856Q543 1086 687 1086Q737 1086 796 1056L706 821Q674 835 639 835Q584 835 536 798Q463 741 424 649T347 333L289 0H54L236 1062Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="934" d="M37 297L265 341Q295 251 341 216T463 180Q536 180 581 215T626 297Q626 329 607 351Q587 372 511 402Q300 487 249 536Q168 615 168 742Q168 892 274 989T564 1086Q876 1086 926 809L709 763Q671 889
527 889Q459 889 424 861T389 790Q389 754 416 729Q436 710 554 668Q723 608 781 551Q866 468 866 349Q866 188 757 82T468 -24Q114 -24 37 297Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="559" d="M126 849L162 1062H277L306 1232L575 1430L512 1062H656L620 849H476L399 404Q379 284 379 265Q379 230 397 213T459 196Q473 196 536 203L499 -10Q438 -24 376 -24Q256 -24 197 32T137 196Q137 246 167
422L240 849H126Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1026" d="M247 1062H483L375 433Q356 320 356 292Q356 244 384 212T454 180Q502 180 549 214Q615 261 654 336T718 556L804 1062H1039L858 0H638L662 144Q517 -24 349 -24Q243 -24 181 49T118 252Q118 306 146
470L247 1062Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="934" d="M503 0H301L126 1062H357L419 599Q443 419 449 349L501 467L568 614L784 1062H1038L503 0Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1307" d="M978 0H757L714 676L448 0H230L121 1062H330L391 350L662 1062H876L906 350L1176 1062H1412L978 0Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="934" d="M468 298L251 0H-37L366 544L144 1062H394L521 759L742 1062H1028L624 511L844 0H594L468 298Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="934" d="M141 1062H375L434 533Q456 330 459 247Q505 411 585 591L794 1062H1043L505 -104Q429 -268 388 -323T296 -405T179 -431Q105 -431 11 -399L32 -185Q74 -200 114 -200Q222 -200 293 0L141 1062Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="840" d="M28 0L62 194L539 838H150L188 1062H871L842 891L361 232H780L740 0H28Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="653" d="M92 410L134 650Q206 654 247 684T320 785T381 1026Q411 1203 441 1279T514 1399T622 1467T801 1491H844L801 1252Q709 1252 680 1239T634 1196Q622 1175 596 1046Q549 815 530 763Q500 680 462
629T352 530Q448 454 448 304Q448 228 422 74Q398 -76 398 -115Q398 -153 429 -175Q454 -191 546 -191L504 -431H461Q343 -431 290 -408T206 -334T175 -206Q175 -121 205 35Q232 176 232 252Q232 322 197 369Q170 405 92 410Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="471" d="M145 -431V1491H328V-431H145Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="653" d="M565 410Q493 406 452 376T380 275T319 35Q289 -142 259 -219T185 -339T78 -406T-101 -431H-144L-101 -191Q-18 -191 11 -179T60 -141T91 -46Q144 247 193 356T346 530Q293 578 272 630T251 764Q251
801 257 850Q277 1011 294 1107Q301 1148 301 1178Q301 1218 275 1235T152 1252L194 1491H238Q356 1491 408 1469T491 1392T523 1261Q523 1195 493 1026Q466 871 466 818Q466 733 503 688Q531 655 607 650L565 410Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="981" d="M55 519V778Q159 916 297 916Q349 916 392 904T536 842Q662 780 702 780Q749 780 810 815T926 924V654Q880 596 799 551Q747 522 681 522Q640 522 601 533T477 591Q351 658 279 658Q164 658 55 519Z" />
<hkern g1="space" g2="A" k="76" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Aogonek" k="76" />
<hkern g1="one" g2="one" k="113" />
<hkern g1="A" g2="space" k="76" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="113" />
<hkern g1="A" g2="Y" k="188" />
<hkern g1="A" g2="v" k="76" />
<hkern g1="A" g2="w" k="37" />
<hkern g1="A" g2="y" k="76" />
<hkern g1="A" g2="quoteright" k="113" />
<hkern g1="A" g2="Tcedilla" k="152" />
<hkern g1="A" g2="Tcaron" k="152" />
<hkern g1="F" g2="comma" k="227" />
<hkern g1="F" g2="period" k="227" />
<hkern g1="F" g2="A" k="113" />
<hkern g1="F" g2="Aogonek" k="113" />
<hkern g1="L" g2="space" k="37" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="152" />
<hkern g1="L" g2="W" k="113" />
<hkern g1="L" g2="Y" k="188" />
<hkern g1="L" g2="y" k="76" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="L" g2="Tcedilla" k="152" />
<hkern g1="L" g2="Tcaron" k="152" />
<hkern g1="P" g2="space" k="37" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="P" g2="Aogonek" k="152" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="76" />
<hkern g1="T" g2="comma" k="227" />
<hkern g1="T" g2="hyphen" k="113" />
<hkern g1="T" g2="period" k="227" />
<hkern g1="T" g2="colon" k="227" />
<hkern g1="T" g2="semicolon" k="227" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="152" />
<hkern g1="T" g2="c" k="152" />
<hkern g1="T" g2="e" k="152" />
<hkern g1="T" g2="i" k="37" />
<hkern g1="T" g2="o" k="152" />
<hkern g1="T" g2="r" k="113" />
<hkern g1="T" g2="s" k="152" />
<hkern g1="T" g2="u" k="152" />
<hkern g1="T" g2="w" k="152" />
<hkern g1="T" g2="y" k="152" />
<hkern g1="T" g2="Aogonek" k="152" />
<hkern g1="T" g2="aogonek" k="152" />
<hkern g1="T" g2="eogonek" k="152" />
<hkern g1="T" g2="Odblacute" k="37" />
<hkern g1="V" g2="comma" k="188" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="188" />
<hkern g1="V" g2="colon" k="113" />
<hkern g1="V" g2="semicolon" k="113" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="113" />
<hkern g1="V" g2="e" k="113" />
<hkern g1="V" g2="i" k="37" />
<hkern g1="V" g2="o" k="152" />
<hkern g1="V" g2="r" k="113" />
<hkern g1="V" g2="u" k="76" />
<hkern g1="V" g2="y" k="76" />
<hkern g1="V" g2="Aogonek" k="152" />
<hkern g1="V" g2="aogonek" k="113" />
<hkern g1="V" g2="eogonek" k="113" />
<hkern g1="W" g2="comma" k="113" />
<hkern g1="W" g2="hyphen" k="41" />
<hkern g1="W" g2="period" k="113" />
<hkern g1="W" g2="colon" k="37" />
<hkern g1="W" g2="semicolon" k="37" />
<hkern g1="W" g2="A" k="113" />
<hkern g1="W" g2="a" k="76" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="18" />
<hkern g1="W" g2="o" k="37" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="37" />
<hkern g1="W" g2="Aogonek" k="113" />
<hkern g1="W" g2="aogonek" k="76" />
<hkern g1="W" g2="eogonek" k="37" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="227" />
<hkern g1="Y" g2="hyphen" k="113" />
<hkern g1="Y" g2="period" k="227" />
<hkern g1="Y" g2="colon" k="152" />
<hkern g1="Y" g2="semicolon" k="152" />
<hkern g1="Y" g2="A" k="188" />
<hkern g1="Y" g2="a" k="113" />
<hkern g1="Y" g2="e" k="113" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="152" />
<hkern g1="Y" g2="p" k="113" />
<hkern g1="Y" g2="q" k="152" />
<hkern g1="Y" g2="u" k="113" />
<hkern g1="Y" g2="v" k="113" />
<hkern g1="Y" g2="Aogonek" k="188" />
<hkern g1="Y" g2="aogonek" k="113" />
<hkern g1="Y" g2="eogonek" k="113" />
<hkern g1="f" g2="quoteright" k="-37" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="76" />
<hkern g1="w" g2="period" k="76" />
<hkern g1="y" g2="comma" k="152" />
<hkern g1="y" g2="period" k="152" />
<hkern g1="quoteleft" g2="quoteleft" k="76" />
<hkern g1="quoteright" g2="space" k="113" />
<hkern g1="quoteright" g2="s" k="76" />
<hkern g1="quoteright" g2="quoteright" k="76" />
<hkern g1="Aogonek" g2="space" k="76" />
<hkern g1="Aogonek" g2="T" k="152" />
<hkern g1="Aogonek" g2="V" k="152" />
<hkern g1="Aogonek" g2="W" k="113" />
<hkern g1="Aogonek" g2="Y" k="188" />
<hkern g1="Aogonek" g2="v" k="76" />
<hkern g1="Aogonek" g2="w" k="37" />
<hkern g1="Aogonek" g2="quoteright" k="113" />
<hkern g1="Aogonek" g2="Tcedilla" k="152" />
<hkern g1="Aogonek" g2="Tcaron" k="152" />
<hkern g1="Lacute" g2="space" k="37" />
<hkern g1="Lacute" g2="T" k="152" />
<hkern g1="Lacute" g2="V" k="152" />
<hkern g1="Lacute" g2="W" k="113" />
<hkern g1="Lacute" g2="Y" k="188" />
<hkern g1="Lacute" g2="y" k="76" />
<hkern g1="Lacute" g2="quoteright" k="113" />
<hkern g1="Lacute" g2="Tcedilla" k="152" />
<hkern g1="Lacute" g2="Tcaron" k="152" />
<hkern g1="Racute" g2="V" k="37" />
<hkern g1="Racute" g2="W" k="37" />
<hkern g1="Racute" g2="Y" k="76" />
<hkern g1="racute" g2="comma" k="113" />
<hkern g1="racute" g2="period" k="113" />
<hkern g1="racute" g2="quoteright" k="-76" />
<hkern g1="Rcaron" g2="V" k="37" />
<hkern g1="Rcaron" g2="W" k="37" />
<hkern g1="Rcaron" g2="Y" k="76" />
<hkern g1="rcaron" g2="comma" k="113" />
<hkern g1="rcaron" g2="period" k="113" />
<hkern g1="rcaron" g2="quoteright" k="-76" />
<hkern g1="Tcedilla" g2="comma" k="227" />
<hkern g1="Tcedilla" g2="hyphen" k="113" />
<hkern g1="Tcedilla" g2="period" k="227" />
<hkern g1="Tcedilla" g2="colon" k="227" />
<hkern g1="Tcedilla" g2="semicolon" k="227" />
<hkern g1="Tcedilla" g2="A" k="152" />
<hkern g1="Tcedilla" g2="O" k="37" />
<hkern g1="Tcedilla" g2="a" k="152" />
<hkern g1="Tcedilla" g2="c" k="152" />
<hkern g1="Tcedilla" g2="e" k="152" />
<hkern g1="Tcedilla" g2="i" k="37" />
<hkern g1="Tcedilla" g2="o" k="152" />
<hkern g1="Tcedilla" g2="r" k="113" />
<hkern g1="Tcedilla" g2="s" k="152" />
<hkern g1="Tcedilla" g2="u" k="152" />
<hkern g1="Tcedilla" g2="w" k="152" />
<hkern g1="Tcedilla" g2="y" k="152" />
<hkern g1="Tcedilla" g2="Aogonek" k="152" />
<hkern g1="Tcedilla" g2="aogonek" k="152" />
<hkern g1="Tcedilla" g2="eogonek" k="152" />
<hkern g1="Tcedilla" g2="Odblacute" k="37" />
<hkern g1="Tcaron" g2="comma" k="227" />
<hkern g1="Tcaron" g2="hyphen" k="113" />
<hkern g1="Tcaron" g2="period" k="227" />
<hkern g1="Tcaron" g2="colon" k="227" />
<hkern g1="Tcaron" g2="semicolon" k="227" />
<hkern g1="Tcaron" g2="A" k="152" />
<hkern g1="Tcaron" g2="O" k="37" />
<hkern g1="Tcaron" g2="a" k="152" />
<hkern g1="Tcaron" g2="c" k="152" />
<hkern g1="Tcaron" g2="e" k="152" />
<hkern g1="Tcaron" g2="i" k="37" />
<hkern g1="Tcaron" g2="o" k="152" />
<hkern g1="Tcaron" g2="r" k="113" />
<hkern g1="Tcaron" g2="s" k="152" />
<hkern g1="Tcaron" g2="u" k="152" />
<hkern g1="Tcaron" g2="w" k="152" />
<hkern g1="Tcaron" g2="y" k="152" />
<hkern g1="Tcaron" g2="Aogonek" k="152" />
<hkern g1="Tcaron" g2="aogonek" k="152" />
<hkern g1="Tcaron" g2="eogonek" k="152" />
<hkern g1="Tcaron" g2="Odblacute" k="37" />
</font>

<font horiz-adv-x="803" ><font-face
    font-family="ArialNarrow-Bold"
    units-per-em="2048"
    panose-1="2 11 6 6 2 2 2 3 2 4"
    ascent="1916"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="467" d="M44 0V1280H433V0H44ZM91 53H387V1237H91V53Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="467" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="559" d="M210 378L150 1122V1466H399V1122L340 378H210ZM160 0V281H390V0H160Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="797" d="M135 945L92 1218V1466H343V1218L305 945H135ZM506 945L462 1218V1466H713V1218L675 945H506Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="934" d="M126 365H15V585H163L212 880H15V1101H249L313 1491H497L433 1101H613L677 1491H867L801 1101H915V880H765L715 585H915V365H679L613 -25H430L494 365H312L247 -25H62L126 365ZM396 880L348 585H530L578
880H396Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="934" d="M402 217V636Q91 744 91 1081Q91 1253 178 1361T402 1485V1584H520V1485Q647 1466 726 1379T826 1137L619 1104Q600 1223 520 1264V873Q711 810 779 718Q860 608 860 439Q860 251 768 130T520 -18V-205H402V-23Q107
20 58 411L272 439Q285 360 321 302T402 217ZM402 1267Q356 1248 326 1201T296 1097Q296 977 402 921V1267ZM520 203Q580 216 619 270T659 402Q659 544 520 593V203Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1493" d="M73 1104Q73 1305 145 1398T336 1491Q459 1491 531 1398T603 1104Q603 903 531 810T340 717Q218 717 146 809T73 1104ZM253 1106Q253 966 276 922T336 878Q374 878 397 922T420 1106Q420 1246 397
1290T337 1334Q299 1334 276 1290T253 1106ZM512 -56H341L982 1491H1147L512 -56ZM884 329Q884 530 956 623T1149 716Q1270 716 1342 623T1414 329Q1414 128 1342 35T1151 -59Q1029 -59 957 34T884 329ZM1064 330Q1064 190 1086 146T1147 102Q1185 102 1208 146T1231
330Q1231 470 1208 514T1148 558Q1109 558 1087 514T1064 330Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1212" d="M1186 179L1046 -38Q944 22 849 130Q774 47 692 11T500 -26Q283 -26 179 106T74 402Q74 685 348 851Q225 1027 225 1173Q225 1314 317 1402T561 1491Q708 1491 800 1399T893 1158Q893 1063
847 984T674 807L841 538Q869 600 892 705L1100 647Q1052 433 996 345Q1034 302 1095 249T1186 179ZM559 976L621 1034Q690 1099 690 1162Q690 1220 655 1256T567 1293Q515 1293 483 1261T450 1183Q450 1130 502 1056L559 976ZM468 671Q391 623 351 555T310 411Q310
317 360 262T490 206Q593 206 703 318L468 671Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="399" d="M118 945L75 1218V1466H326V1218L288 945H118Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="559" d="M502 -431H344Q220 -206 154 45T87 533Q87 788 154 1030T347 1491H504Q389 1179 349 969T308 525Q308 283 365 13Q405 -177 502 -431Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="559" d="M57 -431Q154 -179 193 8Q251 280 251 525Q251 759 211 969T55 1491H212Q341 1265 406 1025T472 546Q472 306 407 53T215 -431H57Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="653" d="M201 792L77 909Q116 963 153 1008L232 1102Q212 1106 114 1135Q46 1156 23 1166L71 1342Q175 1290 263 1225Q243 1386 244 1491H389Q389 1420 367 1223L438 1262Q513 1303 574 1332L618 1151Q526
1126 407 1102L552 900L427 799L315 1022Q269 919 201 792Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="981" d="M384 211V592H69V855H384V1236H594V855H910V592H594V211H384Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="467" d="M115 281H345V80Q345 -91 305 -174Q256 -277 141 -327L96 -211Q164 -183 194 -136T226 0H115V281Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="559" d="M53 391V672H506V391H53Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="467" d="M121 0V281H352V0H121Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="467" d="M-2 -25L296 1491H469L168 -25H-2Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="934" d="M461 1472Q636 1472 744 1306T852 723Q852 308 744 142T462 -25Q287 -25 179 140T71 726Q71 1139 179 1305T461 1472ZM461 1239Q393 1239 353 1149T312 723Q312 387 352 298T461 208Q530 208 570 298T610
723Q610 1059 570 1149T461 1239Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="934" d="M661 0H431V1059Q302 914 133 846V1101Q229 1140 332 1240T475 1472H661V0Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="934" d="M850 261V0H42Q55 148 121 281T380 632Q532 805 567 866Q619 955 619 1045Q619 1141 576 1190T463 1239Q310 1239 298 1010L69 1038Q90 1262 193 1367T469 1472Q658 1472 754 1349T850 1067Q850 977
826 893T750 723T580 504Q469 379 440 339T392 261H850Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="934" d="M63 389L286 422Q295 318 343 263T456 208Q527 208 576 273T625 453Q625 560 578 621T464 682Q420 682 359 661L384 890Q473 888 525 938Q576 988 576 1079Q576 1155 539 1198T444 1241Q386 1241 344
1192T293 1045L80 1089Q113 1290 209 1381T451 1472Q615 1472 711 1355T808 1096Q808 1000 765 923T634 788Q735 761 798 669T862 439Q862 238 743 107T458 -25Q300 -25 191 86T63 389Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="934" d="M523 0V295H31V541L552 1472H746V542H895V295H746V0H523ZM523 542V1043L247 542H523Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="934" d="M75 377L305 406Q314 310 364 255T474 200Q545 200 596 270T647 487Q647 625 597 691T468 757Q369 757 290 650L103 683L221 1446H830V1183H396L359 934Q437 981 517 981Q659 981 758 869Q883 726 883
492Q883 299 777 137T472 -25Q312 -25 205 79T75 377Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="934" d="M852 1107L629 1077Q613 1241 498 1241Q423 1241 374 1159T311 828Q354 890 407 921T524 952Q665 952 770 821T875 471Q875 239 764 107T489 -25Q309 -25 191 146T72 715Q72 1118 195 1295T511 1472Q644
1472 735 1382T852 1107ZM331 494Q331 355 382 282T500 208Q564 208 606 269T649 469Q649 613 603 679T489 745Q423 745 377 682T331 494Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="934" d="M71 1185V1446H859V1242Q762 1125 663 910T509 448T454 0H232Q240 312 336 623T595 1185H71Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="934" d="M270 791Q185 835 142 911T99 1094Q99 1267 197 1369T461 1472Q637 1472 729 1363T821 1096Q821 989 777 911T655 791Q758 741 809 651T860 428Q860 292 810 188T670 29T470 -26Q296 -26 183 94T69
419Q69 551 121 646T270 791ZM317 1074Q317 988 357 942T460 896Q523 896 564 942T605 1074Q605 1157 565 1203T463 1249Q399 1249 358 1203T317 1074ZM296 446Q296 328 346 264T466 200Q536 200 583 261T631 444Q631 549 583 610T463 671Q393 671 345 610T296
446Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="934" d="M76 339L299 369Q315 206 429 206Q506 206 555 287T618 618Q575 557 521 526T401 495Q264 495 159 626T53 974Q53 1206 164 1339T438 1472Q620 1472 738 1301T856 732Q856 328 733 151T414 -26Q278
-26 190 63T76 339ZM598 953Q598 1091 546 1165T428 1239Q364 1239 322 1178T279 975Q279 833 325 767T440 701Q505 701 551 764T598 953Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="559" d="M164 781V1062H395V781H164ZM164 0V281H395V0H164Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="559" d="M158 781V1062H388V781H158ZM158 281H388V80Q388 -91 348 -174Q299 -277 184 -327L139 -211Q207 -183 237 -135T269 0H158V281Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="981" d="M902 167L78 604V846L902 1281V996L328 728L902 450V167Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="981" d="M69 816V1074H910V816H69ZM69 372V631H910V372H69Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="981" d="M77 166V449L653 725L77 998V1279L902 844V604L77 166Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1026" d="M616 378H407L406 442Q406 571 440 651T572 827Q681 935 703 975T725 1068Q725 1155 669 1211T526 1267Q341 1267 298 1020L87 1052Q96 1240 216 1360T519 1481Q704 1481 827 1360T950 1058Q950
966 907 884T722 658Q649 584 632 539T616 378ZM407 0V281H638V0H407Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1638" d="M1457 19H1631Q1544 -196 1360 -313T909 -431Q637 -431 449 -324T155 -11T50 486Q50 783 165 1020T466 1374T890 1492Q1093 1492 1250 1398T1498 1126T1589 721Q1589 460 1452 247Q1293 0 1046 0Q980
0 945 27T897 114Q801 0 674 0Q542 0 450 112T358 417Q358 607 429 772T596 1010T803 1084Q876 1084 930 1050T1019 948L1039 1059H1255L1132 342Q1120 273 1120 252Q1120 229 1129 217T1152 204Q1190 204 1252 260Q1335 334 1388 463T1441 730Q1441 898 1369 1034T1177
1239T887 1308Q685 1308 535 1213T292 920T199 469Q199 252 286 86T524 -163T893 -247Q1089 -247 1230 -181T1457 19ZM571 430Q571 301 614 242T721 183Q777 183 824 225Q885 279 929 409T974 671Q974 784 930 844T823 904Q722 904 659 790Q571 630 571 430Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1212" d="M1206 0H942L837 333H357L258 0H0L468 1466H725L1206 0ZM759 580L594 1124L431 580H759Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1212" d="M122 1466H603Q800 1466 880 1430T1015 1303T1070 1097Q1070 991 1023 906T901 779Q1008 741 1068 649T1129 425Q1129 265 1052 155T870 18Q797 0 531 0H122V1466ZM364 1222V883H524Q668 883 702 888Q764
898 799 940T834 1056Q834 1121 806 1161T737 1212T504 1222H364ZM364 639V247H589Q737 247 779 262T849 323T878 439Q878 511 848 557T767 621T560 639H364Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1212" d="M892 539L1127 448Q1072 202 944 89T629 -25Q394 -25 248 156Q80 365 80 720Q80 1095 249 1307Q396 1491 644 1491Q846 1491 982 1353Q1079 1255 1124 1062L884 992Q861 1111 793 1174T631 1238Q498 1238
414 1122T330 739Q330 462 412 345T625 228Q721 228 791 302T892 539Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1212" d="M121 1466H564Q732 1466 817 1429T975 1302T1088 1071T1129 718Q1129 528 1086 388T977 165T818 42T577 0H121V1466ZM363 1218V247H545Q662 247 714 269T800 335T856 476T878 729Q878 892 856 986T786
1134T670 1205Q619 1218 473 1218H363Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1120" d="M123 0V1466H1015V1218H365V893H969V646H365V247H1037V0H123Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1026" d="M124 0V1466H948V1218H366V871H869V623H366V0H124Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1307" d="M682 539V786H1205V202Q1126 109 981 42T690 -25Q512 -25 376 62T161 324T81 735Q81 977 161 1149T370 1406T678 1491Q893 1491 1022 1382T1189 1060L949 1005Q922 1118 850 1178T678 1238Q523 1238 427
1118T331 750Q331 485 435 347Q524 228 676 228Q747 228 823 261T960 353V539H682Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1212" d="M123 0V1466H365V889H841V1466H1084V0H841V641H365V0H123Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="467" d="M115 0V1466H357V0H115Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="934" d="M556 1466H799V538Q799 313 754 203T620 34T399 -25Q226 -25 128 94T29 453L258 485Q262 356 291 302Q330 228 408 228Q484 228 520 281T556 519V1466Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1212" d="M125 0V1466H367V815L858 1466H1185L732 895L1209 0H895L564 688L367 443V0H125Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1026" d="M129 0V1454H371V247H975V0H129Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1399" d="M119 0V1466H482L700 466L916 1466H1280V0H1055V1154L816 0H582L345 1154V0H119Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1212" d="M125 0V1466H361L853 487V1466H1079V0H835L351 956V0H125Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1307" d="M74 724Q74 986 151 1155T354 1408T657 1491Q915 1491 1077 1294T1240 733Q1240 365 1068 158Q917 -25 658 -25Q397 -25 246 156Q74 363 74 724ZM324 734Q324 481 420 355T658 228Q801 228 895 353T989
739Q989 994 898 1116T658 1238Q510 1238 417 1115T324 734Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1120" d="M122 0V1466H512Q730 1466 797 1445Q904 1411 973 1300T1043 1014Q1043 855 983 748T833 597T523 553H364V0H122ZM364 1218V802H498Q633 802 681 821T761 889T792 1011Q792 1084 760 1134T681 1201T482
1218H364Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1307" d="M1090 186Q1179 109 1284 62L1195 -147Q1141 -127 1089 -93Q1077 -86 926 38Q807 -25 654 -25Q394 -25 234 169T73 733Q73 1103 234 1297T658 1491Q917 1491 1077 1297T1238 733Q1238 554 1203 425T1090
186ZM895 353Q988 483 988 732Q988 990 895 1114T656 1238Q510 1238 417 1114T323 733Q323 472 416 347T649 221Q701 221 748 242Q672 302 598 334L666 503Q786 453 895 353Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1212" d="M123 0V1466H634Q830 1466 914 1427T1052 1290T1106 1056Q1106 884 1024 779T789 647Q867 591 918 525T1057 286L1203 0H914L738 319Q643 492 609 535T537 595T415 612H365V0H123ZM365 846H545Q710 846
755 860T828 919T856 1036Q856 1106 828 1148T752 1207Q718 1218 555 1218H365V846Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1120" d="M61 477L298 505Q338 224 560 224Q670 224 733 281T796 424Q796 474 774 509T707 566T489 642Q334 689 262 744T148 888T105 1081Q105 1201 159 1297T310 1442T547 1491Q759 1491 878 1376T1004 1047L761
1034Q745 1152 692 1199T541 1246Q443 1246 390 1205T337 1103Q337 1043 385 1002Q433 961 606 912Q789 859 870 801T995 650T1038 425Q1038 234 921 104T553 -26Q111 -26 61 477Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1026" d="M393 0V1218H36V1466H991V1218H635V0H393Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1212" d="M120 1466H362V672Q362 487 371 431Q387 334 447 281T607 228Q691 228 744 265T816 369T836 655V1466H1079V696Q1079 401 1048 270T906 57T614 -25Q426 -25 321 42T168 232T120 684V1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1120" d="M429 0L0 1466H263L567 381L861 1466H1119L689 0H429Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1585" d="M292 0L5 1466H254L434 459L654 1466H943L1154 442L1339 1466H1583L1291 0H1033L793 1096L555 0H292Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1120" d="M1 0L412 765L39 1466H323L564 995L800 1466H1081L708 754L1119 0H826L559 507L292 0H1Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1120" d="M438 0V617L-2 1466H282L565 886L843 1466H1122L680 615V0H438Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1026" d="M18 0V267L650 1218H89V1466H969V1236L311 247H995V0H18Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="559" d="M119 -413V1466H527V1245H338V-192H527V-413H119Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="467" d="M-2 1491H168L469 -25H296L-2 1491Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="559" d="M439 1466V-413H31V-192H220V1247H31V1466H439Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="981" d="M95 692L403 1491H586L887 692H653L491 1181L330 692H95Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="934" d="M-12 -154H947V-256H-12V-154Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="559" d="M407 1192H261L35 1491H293L407 1192Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="934" d="M293 738L84 784Q122 945 209 1015T461 1086Q607 1086 684 1045T794 934T827 677L825 349Q825 211 836 144T877 0H649L619 116Q560 46 493 11T349 -24Q222 -24 141 61T60 289Q60 379 93 446T186 553T378
624Q538 661 601 693Q601 781 589 808T543 853T448 871Q386 871 351 843T293 738ZM601 510Q557 492 464 468Q357 440 324 406Q291 372 291 318Q291 257 327 216T419 174Q468 174 516 207T582 287T601 454V510Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1026" d="M110 0V1466H341V938Q394 1012 457 1049T594 1086Q748 1086 854 947T961 537Q961 267 852 122T596 -24Q521 -24 448 22T324 156V0H110ZM339 554Q339 417 365 345T439 236T540 198Q616 198 670 277T724
529Q724 710 670 790T531 871Q451 871 395 793T339 554Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="934" d="M880 748L653 698Q628 865 496 865Q411 865 359 793T307 550Q307 361 359 283T498 205Q563 205 605 249T665 407L892 360Q822 -24 489 -24Q276 -24 173 138T70 528Q70 801 186 943T492 1086Q645 1086 741
1005T880 748Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1026" d="M920 0H705V156Q652 66 580 21T432 -24Q286 -24 178 121T69 537Q69 809 175 947T436 1086Q509 1086 572 1049T689 938V1466H920V0ZM305 554Q305 410 329 340T399 234T502 198Q578 198 634 280T690 527Q690
710 636 790T497 871Q417 871 361 792T305 554Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="934" d="M626 338L855 291Q809 131 712 54T476 -24Q283 -24 178 105Q54 255 54 525Q54 791 179 951Q285 1086 453 1086Q640 1086 746 948Q868 790 868 482L867 450H290Q292 324 346 255T478 186Q589 186 626 338ZM639
622Q636 746 586 808T467 871Q394 871 344 806Q293 740 294 622H639Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="559" d="M20 1062H148V1142Q148 1287 175 1352T264 1454T416 1491Q514 1491 608 1455L578 1259Q522 1275 471 1275Q422 1275 400 1247T378 1137V1062H550V841H378V0H148V841H20V1062Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1026" d="M99 -70L363 -109Q369 -167 399 -191T496 -216Q572 -216 619 -191Q652 -173 670 -131T688 17V172Q636 86 571 43T427 0Q282 0 183 131Q69 281 69 537Q69 809 176 947T437 1086Q518 1086 584 1043T703
913V1062H919V109Q919 -120 877 -223T748 -378T505 -431Q362 -431 276 -393T145 -280T99 -105V-70ZM305 553Q305 383 359 305T491 227Q574 227 633 306T692 546Q692 712 636 791T496 871Q414 871 360 793T305 553Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1026" d="M351 1466V927Q406 1007 472 1046T617 1086Q721 1086 791 1031T891 875Q913 801 913 623V0H683V561Q683 756 658 805Q623 871 539 871Q450 871 401 800T351 532V0H120V1466H351Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="467" d="M121 1206V1466H352V1206H121ZM121 0V1062H352V0H121Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="467" d="M116 1206V1466H347V1206H116ZM347 1062V33Q347 -184 323 -264T237 -387T84 -431Q15 -431 -76 -401L-36 -161Q-3 -170 21 -170Q81 -170 104 -122Q116 -96 116 49V1062H347Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="934" d="M113 0V1466H344V688L613 1062H897L599 674L918 0H670L450 477L344 340V0H113Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="467" d="M121 0V1466H352V0H121Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1493" d="M103 1062H315V917Q372 1002 440 1044T587 1086Q671 1086 732 1044T833 917Q891 1002 957 1044T1099 1086Q1188 1086 1252 1044T1350 922T1384 679V0H1153V607Q1153 766 1125 818T1031 871Q954 871 907
798T860 510V0H629V582Q629 755 610 805Q585 871 509 871Q458 871 415 837T353 738T334 516V0H103V1062Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1026" d="M913 0H682V542Q682 705 669 759T621 842T540 871Q482 871 435 834T369 730T350 481V0H119V1062H333V906Q390 996 461 1041T620 1086Q721 1086 790 1034T886 899T913 660V0Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1026" d="M67 546Q67 702 129 830T291 1022T516 1086Q726 1086 846 922T966 537Q966 373 904 241T740 43T517 -24Q323 -24 195 124T67 546ZM303 531Q303 370 366 288T518 205Q605 205 667 288T729 533Q729 691
666 774T515 857Q428 857 366 774T303 531Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1026" d="M114 1062H329V906Q373 990 445 1038T600 1086Q749 1086 856 944T964 541Q964 267 856 122T599 -24Q530 -24 471 9T345 131V-404H114V1062ZM342 549Q342 369 400 284T542 199Q621 199 675 277T729 534Q729
703 674 783T538 864Q454 864 398 786T342 549Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1026" d="M690 -404V130Q643 56 575 16T432 -24Q286 -24 181 122T75 543Q75 803 182 944T445 1086Q528 1086 593 1041T708 905V1062H920V-404H690ZM698 544Q698 709 643 787T506 866Q423 866 367 786T311 527Q311
352 365 275T498 198Q577 198 637 284T698 544Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="653" d="M342 0H111V1062H325V911Q380 1017 423 1051T524 1086Q603 1086 675 1033L603 788Q546 834 495 834Q447 834 411 799T358 670T342 328V0Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="934" d="M40 303L271 346Q301 179 457 179Q540 179 581 211T622 294Q622 329 604 349Q585 369 529 384Q245 459 168 527Q72 612 72 760Q72 908 166 997T439 1086Q610 1086 699 1020T824 805L607 756Q578 884 443
884Q358 884 322 860T286 796Q286 761 319 738Q352 714 524 666Q717 612 786 535Q854 458 854 330Q854 176 749 76T457 -24Q288 -24 181 59T40 303Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="559" d="M519 1062V838H362V410Q362 271 369 249Q383 209 426 209Q458 209 518 236L538 18Q458 -24 357 -24Q269 -24 216 18T145 139Q131 197 131 375V838H25V1062H131V1273L362 1437V1062H519Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1026" d="M693 0V159Q645 73 567 25T404 -24Q318 -24 250 21T149 149T115 390V1062H346V574Q346 365 356 309T403 221T490 190Q548 190 597 230T661 334T677 614V1062H907V0H693Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="934" d="M360 0L9 1062H251L415 520L462 339L511 520L677 1062H913L567 0H360Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1307" d="M284 0L8 1062H232L395 366L545 1062H767L912 366L1079 1062H1306L1026 0H805L655 683L507 0H284Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="934" d="M10 0L324 547L23 1062H305L459 770L621 1062H891L596 559L919 0H636L459 329L279 0H10Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="934" d="M11 1062H257L464 308L668 1062H906L599 40L540 -159Q501 -271 463 -323T365 -403T218 -431Q151 -431 87 -414L67 -194Q121 -207 164 -207Q230 -207 272 -163T342 -3L11 1062Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="840" d="M28 0V219L355 676Q435 788 473 835Q433 832 367 831L60 829V1062H780V863L447 395L330 240Q426 247 449 247H806V0H28Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="653" d="M49 410V650Q119 654 154 683T209 779T229 1006Q229 1204 244 1278T293 1396T389 1465T566 1491H610V1252Q523 1252 496 1241T456 1204T442 1107Q442 986 433 829Q427 722 387 642Q358 584 288
530Q350 487 387 415T432 234Q442 86 442 -45Q442 -114 456 -140T498 -179T610 -191V-431H566Q450 -431 394 -409T300 -341T245 -224T228 20Q228 209 211 276T157 375T49 410Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="471" d="M145 -431V1491H328V-431H145Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="653" d="M598 410Q528 406 493 377T438 281T418 55Q418 -143 403 -217T354 -335T258 -405T81 -431H37V-191Q121 -191 148 -179T190 -141T205 -47Q205 67 214 227Q221 340 259 413T359 530Q289 584 260
642Q221 720 214 830Q204 974 204 1107Q204 1178 191 1203T151 1240T37 1252V1491H81Q197 1491 253 1469T347 1402T401 1285T418 1041Q418 851 435 784T489 685T598 650V410Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="981" d="M55 519V778Q159 916 297 916Q349 916 392 904T536 842Q662 780 702 780Q749 780 810 815T926 924V654Q880 596 799 551Q747 522 681 522Q640 522 601 533T477 591Q351 658 279 658Q164 658 55 519Z" />
<hkern g1="space" g2="A" k="61" />
<hkern g1="space" g2="Y" k="29" />
<hkern g1="space" g2="Aogonek" k="61" />
<hkern g1="one" g2="one" k="92" />
<hkern g1="A" g2="space" k="61" />
<hkern g1="A" g2="T" k="123" />
<hkern g1="A" g2="V" k="123" />
<hkern g1="A" g2="W" k="92" />
<hkern g1="A" g2="Y" k="154" />
<hkern g1="A" g2="v" k="61" />
<hkern g1="A" g2="w" k="29" />
<hkern g1="A" g2="y" k="61" />
<hkern g1="A" g2="quoteright" k="92" />
<hkern g1="A" g2="Tcedilla" k="123" />
<hkern g1="A" g2="Tcaron" k="123" />
<hkern g1="F" g2="comma" k="186" />
<hkern g1="F" g2="period" k="186" />
<hkern g1="F" g2="A" k="92" />
<hkern g1="F" g2="Aogonek" k="92" />
<hkern g1="L" g2="space" k="29" />
<hkern g1="L" g2="T" k="123" />
<hkern g1="L" g2="V" k="123" />
<hkern g1="L" g2="W" k="92" />
<hkern g1="L" g2="Y" k="154" />
<hkern g1="L" g2="y" k="61" />
<hkern g1="L" g2="quoteright" k="92" />
<hkern g1="L" g2="Tcedilla" k="123" />
<hkern g1="L" g2="Tcaron" k="123" />
<hkern g1="P" g2="space" k="29" />
<hkern g1="P" g2="comma" k="215" />
<hkern g1="P" g2="period" k="215" />
<hkern g1="P" g2="A" k="123" />
<hkern g1="P" g2="Aogonek" k="123" />
<hkern g1="R" g2="V" k="29" />
<hkern g1="R" g2="W" k="29" />
<hkern g1="R" g2="Y" k="61" />
<hkern g1="T" g2="comma" k="186" />
<hkern g1="T" g2="hyphen" k="92" />
<hkern g1="T" g2="period" k="186" />
<hkern g1="T" g2="colon" k="186" />
<hkern g1="T" g2="semicolon" k="186" />
<hkern g1="T" g2="A" k="123" />
<hkern g1="T" g2="O" k="29" />
<hkern g1="T" g2="a" k="123" />
<hkern g1="T" g2="c" k="123" />
<hkern g1="T" g2="e" k="123" />
<hkern g1="T" g2="i" k="29" />
<hkern g1="T" g2="o" k="123" />
<hkern g1="T" g2="r" k="92" />
<hkern g1="T" g2="s" k="123" />
<hkern g1="T" g2="u" k="123" />
<hkern g1="T" g2="w" k="123" />
<hkern g1="T" g2="y" k="123" />
<hkern g1="T" g2="Aogonek" k="123" />
<hkern g1="T" g2="aogonek" k="123" />
<hkern g1="T" g2="eogonek" k="123" />
<hkern g1="T" g2="Odblacute" k="29" />
<hkern g1="V" g2="comma" k="154" />
<hkern g1="V" g2="hyphen" k="92" />
<hkern g1="V" g2="period" k="154" />
<hkern g1="V" g2="colon" k="92" />
<hkern g1="V" g2="semicolon" k="92" />
<hkern g1="V" g2="A" k="123" />
<hkern g1="V" g2="a" k="92" />
<hkern g1="V" g2="e" k="92" />
<hkern g1="V" g2="i" k="29" />
<hkern g1="V" g2="o" k="123" />
<hkern g1="V" g2="r" k="92" />
<hkern g1="V" g2="u" k="61" />
<hkern g1="V" g2="y" k="61" />
<hkern g1="V" g2="Aogonek" k="123" />
<hkern g1="V" g2="aogonek" k="92" />
<hkern g1="V" g2="eogonek" k="92" />
<hkern g1="W" g2="comma" k="92" />
<hkern g1="W" g2="hyphen" k="33" />
<hkern g1="W" g2="period" k="92" />
<hkern g1="W" g2="colon" k="29" />
<hkern g1="W" g2="semicolon" k="29" />
<hkern g1="W" g2="A" k="92" />
<hkern g1="W" g2="a" k="61" />
<hkern g1="W" g2="e" k="29" />
<hkern g1="W" g2="i" k="14" />
<hkern g1="W" g2="o" k="29" />
<hkern g1="W" g2="r" k="29" />
<hkern g1="W" g2="u" k="29" />
<hkern g1="W" g2="y" k="29" />
<hkern g1="W" g2="Aogonek" k="92" />
<hkern g1="W" g2="aogonek" k="61" />
<hkern g1="W" g2="eogonek" k="29" />
<hkern g1="Y" g2="space" k="29" />
<hkern g1="Y" g2="comma" k="186" />
<hkern g1="Y" g2="hyphen" k="92" />
<hkern g1="Y" g2="period" k="186" />
<hkern g1="Y" g2="colon" k="123" />
<hkern g1="Y" g2="semicolon" k="123" />
<hkern g1="Y" g2="A" k="154" />
<hkern g1="Y" g2="a" k="92" />
<hkern g1="Y" g2="e" k="92" />
<hkern g1="Y" g2="i" k="61" />
<hkern g1="Y" g2="o" k="123" />
<hkern g1="Y" g2="p" k="92" />
<hkern g1="Y" g2="q" k="123" />
<hkern g1="Y" g2="u" k="92" />
<hkern g1="Y" g2="v" k="92" />
<hkern g1="Y" g2="Aogonek" k="154" />
<hkern g1="Y" g2="aogonek" k="92" />
<hkern g1="Y" g2="eogonek" k="92" />
<hkern g1="f" g2="quoteright" k="-29" />
<hkern g1="r" g2="comma" k="92" />
<hkern g1="r" g2="period" k="92" />
<hkern g1="r" g2="quoteright" k="-61" />
<hkern g1="v" g2="comma" k="123" />
<hkern g1="v" g2="period" k="123" />
<hkern g1="w" g2="comma" k="61" />
<hkern g1="w" g2="period" k="61" />
<hkern g1="y" g2="comma" k="123" />
<hkern g1="y" g2="period" k="123" />
<hkern g1="quoteleft" g2="quoteleft" k="61" />
<hkern g1="quoteright" g2="space" k="92" />
<hkern g1="quoteright" g2="s" k="61" />
<hkern g1="quoteright" g2="quoteright" k="61" />
<hkern g1="Aogonek" g2="space" k="61" />
<hkern g1="Aogonek" g2="T" k="123" />
<hkern g1="Aogonek" g2="V" k="123" />
<hkern g1="Aogonek" g2="W" k="92" />
<hkern g1="Aogonek" g2="Y" k="154" />
<hkern g1="Aogonek" g2="v" k="61" />
<hkern g1="Aogonek" g2="w" k="29" />
<hkern g1="Aogonek" g2="quoteright" k="92" />
<hkern g1="Aogonek" g2="Tcedilla" k="123" />
<hkern g1="Aogonek" g2="Tcaron" k="123" />
<hkern g1="Lacute" g2="space" k="29" />
<hkern g1="Lacute" g2="T" k="123" />
<hkern g1="Lacute" g2="V" k="123" />
<hkern g1="Lacute" g2="W" k="92" />
<hkern g1="Lacute" g2="Y" k="154" />
<hkern g1="Lacute" g2="y" k="61" />
<hkern g1="Lacute" g2="quoteright" k="92" />
<hkern g1="Lacute" g2="Tcedilla" k="123" />
<hkern g1="Lacute" g2="Tcaron" k="123" />
<hkern g1="Racute" g2="V" k="29" />
<hkern g1="Racute" g2="W" k="29" />
<hkern g1="Racute" g2="Y" k="61" />
<hkern g1="racute" g2="comma" k="92" />
<hkern g1="racute" g2="period" k="92" />
<hkern g1="racute" g2="quoteright" k="-61" />
<hkern g1="Rcaron" g2="V" k="29" />
<hkern g1="Rcaron" g2="W" k="29" />
<hkern g1="Rcaron" g2="Y" k="61" />
<hkern g1="rcaron" g2="comma" k="92" />
<hkern g1="rcaron" g2="period" k="92" />
<hkern g1="rcaron" g2="quoteright" k="-61" />
<hkern g1="Tcedilla" g2="comma" k="186" />
<hkern g1="Tcedilla" g2="hyphen" k="92" />
<hkern g1="Tcedilla" g2="period" k="186" />
<hkern g1="Tcedilla" g2="colon" k="186" />
<hkern g1="Tcedilla" g2="semicolon" k="186" />
<hkern g1="Tcedilla" g2="A" k="123" />
<hkern g1="Tcedilla" g2="O" k="29" />
<hkern g1="Tcedilla" g2="a" k="123" />
<hkern g1="Tcedilla" g2="c" k="123" />
<hkern g1="Tcedilla" g2="e" k="123" />
<hkern g1="Tcedilla" g2="i" k="29" />
<hkern g1="Tcedilla" g2="o" k="123" />
<hkern g1="Tcedilla" g2="r" k="92" />
<hkern g1="Tcedilla" g2="s" k="123" />
<hkern g1="Tcedilla" g2="u" k="123" />
<hkern g1="Tcedilla" g2="w" k="123" />
<hkern g1="Tcedilla" g2="y" k="123" />
<hkern g1="Tcedilla" g2="Aogonek" k="123" />
<hkern g1="Tcedilla" g2="aogonek" k="123" />
<hkern g1="Tcedilla" g2="eogonek" k="123" />
<hkern g1="Tcedilla" g2="Odblacute" k="29" />
<hkern g1="Tcaron" g2="comma" k="186" />
<hkern g1="Tcaron" g2="hyphen" k="92" />
<hkern g1="Tcaron" g2="period" k="186" />
<hkern g1="Tcaron" g2="colon" k="186" />
<hkern g1="Tcaron" g2="semicolon" k="186" />
<hkern g1="Tcaron" g2="A" k="123" />
<hkern g1="Tcaron" g2="O" k="29" />
<hkern g1="Tcaron" g2="a" k="123" />
<hkern g1="Tcaron" g2="c" k="123" />
<hkern g1="Tcaron" g2="e" k="123" />
<hkern g1="Tcaron" g2="i" k="29" />
<hkern g1="Tcaron" g2="o" k="123" />
<hkern g1="Tcaron" g2="r" k="92" />
<hkern g1="Tcaron" g2="s" k="123" />
<hkern g1="Tcaron" g2="u" k="123" />
<hkern g1="Tcaron" g2="w" k="123" />
<hkern g1="Tcaron" g2="y" k="123" />
<hkern g1="Tcaron" g2="Aogonek" k="123" />
<hkern g1="Tcaron" g2="aogonek" k="123" />
<hkern g1="Tcaron" g2="eogonek" k="123" />
<hkern g1="Tcaron" g2="Odblacute" k="29" />
</font>

<font horiz-adv-x="741" ><font-face
    font-family="ArialNarrow-Italic"
    units-per-em="2048"
    panose-1="2 11 5 6 2 2 2 10 2 4"
    ascent="1916"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="467" d="M44 0V1280H434V0H44ZM91 53H387V1237H91V53Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="467" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="467" d="M188 370L279 1166L331 1466H511L455 1141L281 370H188ZM95 0L130 205H298L262 0H95Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="596" d="M219 947L227 1226L268 1466H437L395 1226L309 947H219ZM490 947L499 1226L541 1466H709L667 1226L579 947H490Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="934" d="M82 -25L153 401H15V550H178L239 913H15V1062H263L335 1491H458L386 1062H645L716 1491H840L768 1062H911V913H744L683 550H911V401H658L587 -25H463L534 401H276L205 -25H82ZM301 550H559L620
913H362L301 550Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="934" d="M372 -13Q256 16 175 132T86 424L235 435Q242 315 287 240T398 136L492 689Q389 744 339 797T258 927T228 1087Q228 1253 338 1370T597 1487L629 1486L642 1564H724L708 1473Q934 1406 961 1112L820
1103Q808 1198 775 1248T683 1324L597 821Q755 742 820 646T886 422Q886 247 779 111T475 -26L452 -25L423 -196H341L372 -13ZM522 861L604 1341Q505 1345 440 1278T374 1099Q374 1019 406 965T522 861ZM568 650L477 119L490 118Q588 118 663 201T738 402Q738 484
702 541T568 650Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1493" d="M235 -54L1228 1491H1362L373 -54H235ZM163 1015Q163 1101 199 1226T303 1415T464 1478Q576 1478 637 1409T698 1197Q698 1054 651 930T537 757T386 707Q279 707 221 779T163 1015ZM289 982Q289
897 315 863T386 828Q429 828 460 857Q504 897 536 1001T569 1219Q569 1287 541 1322T468 1357Q429 1357 397 1328Q353 1288 321 1187T289 982ZM896 254Q896 339 932 464T1036 653T1197 717Q1309 717 1370 648T1431 436Q1431 293 1384 169T1270 -4T1119 -54Q1012
-54 954 18T896 254ZM1022 220Q1022 136 1048 101T1118 66Q1161 66 1193 95Q1236 135 1269 239T1302 453Q1302 526 1274 561T1202 596Q1162 596 1130 567Q1086 526 1054 426T1022 220Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1120" d="M833 143Q727 38 654 3T496 -32Q339 -32 236 81T132 380Q132 550 211 663T448 862Q405 977 396 1018Q384 1075 384 1136Q384 1272 468 1381T686 1491Q796 1491 869 1412T943 1209Q943 1103
878 1007T644 807Q750 571 850 418Q911 508 965 627L1094 546Q1039 407 944 274Q1001 186 1083 74L971 -35Q887 53 833 143ZM589 942Q798 1071 798 1206Q798 1267 764 1306T684 1346Q628 1346 584 1291T539 1155Q539 1060 589 942ZM747 282Q595 523 509 721Q394
656 347 595Q283 510 283 402Q283 283 348 207T502 131Q625 131 747 282Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="322" d="M214 947L224 1221L267 1466H435L392 1221L306 947H214Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="559" d="M271 -431Q142 -85 142 273Q142 524 196 735T359 1151Q426 1277 578 1491H694Q590 1355 485 1126T334 684T287 251Q287 -77 382 -431H271Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="559" d="M332 1491Q462 1149 462 787Q462 538 408 327T244 -91Q174 -223 25 -431H-90Q13 -296 118 -67T270 376T316 806Q316 1138 222 1491H332Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="653" d="M190 1195L227 1337Q357 1282 417 1241Q400 1416 400 1490H519Q517 1387 500 1242Q582 1293 694 1339L732 1197Q628 1155 528 1141Q579 1086 670 952L572 867Q524 944 458 1081Q396 936 352 866L256
950Q346 1089 391 1140Q281 1165 190 1195Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="981" d="M420 237V639H93V807H420V1206H560V807H887V639H560V237H420Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="467" d="M92 0L127 205H296L266 26Q215 -271 41 -296L55 -217Q152 -184 184 0H92Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="559" d="M77 440L108 621H561L530 440H77Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="467" d="M97 0L132 205H300L265 0H97Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="467" d="M-86 -24L560 1491H689L43 -24H-86Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="934" d="M119 481Q119 758 208 1016T423 1387Q518 1472 627 1472Q762 1472 856 1350T950 988Q950 752 890 521Q814 228 676 83Q573 -25 440 -25Q308 -25 214 102T119 481ZM263 435Q263 271 315 195T448 119Q531
119 597 204Q707 344 758 608T809 1030Q809 1189 759 1258T627 1327Q539 1327 471 1243Q375 1123 319 853T263 435Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="934" d="M405 0L595 1107Q473 989 249 918L277 1082Q420 1152 563 1281Q672 1378 719 1472H806L554 0H405Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="934" d="M99 0Q131 188 215 314Q278 409 529 654Q682 802 739 894T797 1085Q797 1190 737 1258T594 1327Q510 1327 447 1256T357 1026L212 1052Q234 1254 338 1363T591 1472Q754 1472 849 1359T944 1079Q944
930 857 796Q803 712 551 468Q362 286 306 166H844L815 0H99Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="934" d="M92 384L237 406Q253 249 310 184T456 119Q561 119 643 212T726 433Q726 548 664 616T505 684Q493 684 458 680L483 831Q504 827 524 827Q644 827 716 899T788 1089Q788 1193 730 1260T597 1327Q517
1327 453 1258T370 1057L224 1093Q261 1279 365 1375T605 1472Q746 1472 841 1367T936 1094Q936 979 887 893T737 749Q807 698 842 625T877 456Q877 255 753 115T467 -25Q312 -25 208 82T92 384Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="934" d="M503 0L567 374H77L108 553L781 1466H903L743 534H912L885 374H715L651 0H503ZM595 534L699 1146L252 534H595Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="934" d="M118 419L269 437L267 390Q267 317 297 250T373 151T470 119Q533 119 602 172T720 336T769 566Q769 693 708 765T554 837Q424 837 323 685L194 696L374 1446H961L933 1280H476L386 907Q487 997 601
997Q734 997 825 889T916 582Q916 309 770 129Q645 -25 459 -25Q364 -25 289 23T165 171T117 388L118 419Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="934" d="M338 850Q401 913 462 944T584 976Q718 976 809 865T900 555Q900 299 762 122Q647 -25 489 -25Q344 -25 242 105T140 489Q140 715 210 969T412 1360Q521 1472 664 1472Q784 1472 863 1381T954 1111L816
1095Q793 1320 653 1320Q592 1320 539 1274Q459 1206 408 1080T338 850ZM286 412Q286 285 350 202T492 119Q582 119 661 229Q759 363 759 538Q759 672 698 751T554 831Q456 831 371 716T286 412Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="934" d="M244 0Q270 191 356 445T559 915T804 1280H204L233 1446H1001L972 1280Q783 1077 643 769Q465 375 399 0H244Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="934" d="M378 806Q311 851 278 917T244 1073Q244 1214 339 1343T608 1472Q758 1472 852 1373T947 1115Q947 1004 897 920T744 785Q820 727 854 655T888 485Q888 259 765 117T469 -26Q323 -26 224 84T125 372Q125
479 159 574T246 723T378 806ZM390 1065Q390 967 441 912T576 856Q673 856 739 929T805 1117Q805 1214 753 1270T619 1327Q557 1327 505 1295T422 1199T390 1065ZM274 358Q274 250 333 185T484 119Q598 119 668 237T738 488Q738 596 682 659T541 722Q432 722 353
623T274 358Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="934" d="M113 336L252 353Q279 126 413 126Q501 126 574 219Q680 353 729 595Q650 523 592 496T479 469Q354 469 261 582T168 896Q168 1117 282 1294T580 1472Q726 1472 826 1340T926 958Q926 665 839 416T639
71T405 -25Q285 -25 204 67T113 336ZM311 916Q311 775 372 695T514 614Q626 614 709 754Q784 881 784 1028Q784 1116 753 1187T674 1292T576 1327Q519 1327 459 1279T355 1128T311 916Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="467" d="M243 857L278 1062H446L411 857H243ZM96 0L131 205H299L264 0H96Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="467" d="M239 857L274 1062H441L406 857H239ZM92 0L127 205H296L266 26Q215 -271 41 -296L55 -217Q152 -184 184 0H92Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="981" d="M91 641V809L887 1219V1040L256 724L887 405V226L91 641Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="981" d="M887 862H93V1030H887V862ZM887 417H93V585H887V417Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="981" d="M887 641L91 226V405L722 724L91 1040V1219L887 809V641Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="934" d="M352 367Q361 457 385 524T450 651T603 821Q721 939 758 1009T795 1144Q795 1229 738 1287T601 1346Q508 1346 446 1276T362 1035L214 1065Q249 1282 352 1386T596 1491Q744 1491 843 1390T942
1131Q942 1016 877 913Q831 839 679 691Q574 587 541 527T493 367H352ZM280 0L315 205H483L447 0H280Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1704" d="M953 163Q894 80 819 33Q762 -3 701 -3Q630 -3 562 47T449 204T404 442Q404 612 474 771T642 1007T830 1084Q908 1084 970 1038T1078 900L1105 1055H1253L1134 384Q1110 244 1110 229Q1110 200 1127
182T1168 163Q1211 163 1292 233T1428 436T1483 719Q1483 897 1406 1041T1194 1266T896 1347Q710 1347 558 1246T309 943T213 486Q213 238 298 67T544 -194T924 -283Q1121 -283 1270 -201T1497 19H1645Q1596 -102 1484 -212T1235 -377T921 -431Q663 -431 482 -327T196
-20T92 472Q92 771 207 1017T498 1378T904 1493Q1103 1493 1260 1397T1511 1117T1605 708Q1605 415 1430 187Q1283 -4 1113 -4Q1029 -4 995 36T953 163ZM556 434Q556 295 610 220T735 145Q791 145 861 203T981 385T1031 645Q1031 788 975 861T839 935Q779 935 718
883T606 697T556 434Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1120" d="M-33 0L648 1466H838L1036 0H880L822 422H336L143 0H-33ZM405 573H802L756 941Q729 1159 722 1306Q682 1180 603 1007L405 573Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1120" d="M73 0L324 1466H697Q833 1466 899 1442Q995 1408 1047 1325T1100 1116Q1100 993 1044 903T878 765Q973 727 1023 650T1073 464Q1073 338 1013 226T859 57T655 0H73ZM378 840H622Q798 840 866 901Q949
979 949 1107Q949 1172 923 1217T857 1281T712 1299H456L378 840ZM262 166H536Q644 166 680 174Q745 188 794 221T876 319T908 462Q908 572 852 622T655 673H349L262 166Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1212" d="M1012 516L1171 489Q1095 231 949 103T628 -25Q415 -25 284 134T152 604Q152 967 317 1218Q496 1491 780 1491Q962 1491 1084 1370T1226 1030L1076 1013Q1029 1329 786 1329Q574 1329 443 1113T312 600Q312
370 405 254T640 137Q762 137 854 225Q967 333 1012 516Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1212" d="M74 0L325 1466H688Q810 1466 874 1447Q968 1420 1041 1346T1155 1149T1195 866Q1195 653 1130 480T968 193T742 35Q644 0 507 0H74ZM263 166H454Q588 166 681 194T849 305T977 537T1032 876Q1032 1043
985 1141T855 1274Q796 1299 670 1299H457L263 166Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1120" d="M76 0L327 1466H1195L1167 1299H459L381 843H1069L1041 676H353L265 166H1022L993 0H76Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1026" d="M76 0L327 1466H1108L1080 1299H459L379 832H1011L983 665H351L237 0H76Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1307" d="M688 578L716 744H1243L1141 147Q1037 67 910 21T664 -25Q409 -25 286 148T163 587Q163 854 260 1070T502 1389T823 1491Q1032 1491 1162 1346Q1254 1243 1287 1037L1129 1016Q1103 1172 1022 1250T817
1328Q691 1328 580 1245T397 989T326 584Q326 356 418 247T663 137Q819 137 1000 263L1054 578H688Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1212" d="M70 0L321 1466H482L378 857H1001L1105 1466H1266L1015 0H854L972 691H349L231 0H70Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="467" d="M96 0L347 1466H508L257 0H96Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="840" d="M68 427L217 440Q203 355 203 313Q203 230 246 184T360 137Q409 137 448 163T513 242T560 427L738 1466H899L716 395Q677 166 586 71T356 -25Q215 -25 135 55T55 295Q55 362 68 427Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1120" d="M75 0L326 1466H487L366 760L1019 1466H1245L687 869L1096 0H917L569 743L317 476L236 0H75Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="934" d="M67 0L318 1466H479L256 166H880L852 0H67Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1399" d="M74 0L325 1466H522L644 516Q668 327 675 157Q726 306 842 558L1264 1466H1465L1214 0H1056L1181 713Q1225 961 1306 1267Q1254 1124 1177 959L730 0H575L454 940Q438 1064 430 1241Q411 1054 391 935L230 0H74Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1212" d="M81 0L332 1466H489L691 916Q781 673 832 509Q868 396 910 222Q933 411 966 604L1114 1466H1270L1019 0H860L561 847Q482 1073 437 1242Q426 1099 390 891L237 0H81Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1307" d="M154 614Q154 1017 355 1268Q534 1491 791 1491Q1007 1491 1152 1317T1298 833Q1298 584 1203 382T963 77T658 -25Q519 -25 408 49T225 273T154 614ZM312 604Q312 391 418 264T669 137Q779 137 885 218T1065
472T1138 851Q1138 1073 1035 1200T784 1328Q614 1328 478 1161Q312 956 312 604Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1120" d="M73 0L324 1466H827Q957 1466 1020 1431T1128 1308T1173 1106Q1173 957 1102 825T915 644T636 595H336L234 0H73ZM364 761H629Q773 761 845 796T965 916T1014 1100Q1014 1177 989 1223T921 1288T766 1307H458L364
761Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1307" d="M1016 118Q1074 32 1180 -52L1109 -168Q997 -79 913 43Q801 -26 662 -26Q447 -26 302 149T156 638Q156 886 249 1089T485 1392T793 1491Q1010 1491 1155 1317T1300 833Q1300 608 1222 420T1016 118ZM917
244Q1012 332 1076 496T1140 842Q1140 1072 1037 1200T787 1328Q676 1328 566 1245T385 996T314 620Q314 392 420 265T678 138Q745 138 812 171Q736 255 659 304L717 426Q818 374 917 244Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1212" d="M79 0L330 1466H835Q999 1466 1071 1431T1179 1328Q1227 1236 1227 1109Q1227 918 1126 806T821 659Q888 599 925 534Q997 407 1041 276L1133 0H953L867 273Q818 430 757 536Q718 605 676 628T538 651H352L240
0H79ZM379 810H600Q784 810 850 823T965 876T1044 977T1073 1112Q1073 1179 1049 1224T987 1287T856 1305H463L379 810Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1120" d="M119 474L276 492L275 443Q275 345 315 269Q345 211 416 175T587 138Q724 138 804 210T884 391Q884 467 839 523Q793 578 620 669Q486 740 438 776Q351 841 310 919T268 1099Q268 1275 380 1383T689 1491Q824
1491 920 1440T1072 1291T1129 1081L1128 1050L972 1035L973 1068Q973 1139 938 1200T836 1294T684 1328Q561 1328 493 1268T424 1110Q424 1021 476 973Q528 925 732 815Q881 734 934 684T1017 563T1047 404Q1047 220 918 98T580 -25Q354 -25 237 95T119 474Z"
/>
<glyph unicode="T" glyph-name="T" horiz-adv-x="1026" d="M381 0L604 1299H209L238 1466H1184L1156 1299H764L542 0H381Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1212" d="M333 1466H494L339 565Q320 453 320 398Q320 285 395 211T588 137Q744 137 842 265Q917 363 968 659L1106 1466H1266L1119 606Q1077 357 1005 229T829 38T594 -26Q394 -26 278 89T162 400Q162 478 196
666L333 1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1120" d="M439 0L208 1466H363L502 592Q541 354 552 208Q629 399 677 506L1105 1466H1271L611 0H439Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1585" d="M284 0L210 1466H373L401 741Q411 503 411 366L410 270L554 622L920 1466H1086L1126 609Q1133 452 1135 255Q1150 305 1185 402Q1246 568 1276 640L1619 1466H1782L1171 0H999L958 888Q953 1004 949 1168Q897
1024 866 952L450 0H284Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1120" d="M-53 0L521 741L181 1466H358L513 1134Q593 963 630 864Q692 965 818 1127L1082 1466H1291L711 709L1040 0H865L670 429Q643 488 604 591Q560 519 496 436L160 0H-53Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1120" d="M470 0L567 567L197 1466H369L547 1038Q603 902 660 738Q720 874 825 1035L1107 1466H1299L725 552L631 0H470Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1026" d="M41 0L56 147L784 1210Q822 1266 856 1311Q780 1299 736 1299H211L240 1466H1069L1055 1313L410 378L259 161Q298 167 340 167H961L932 0H41Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="467" d="M11 -401L327 1466H657L634 1327H453L181 -262H362L339 -401H11Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="467" d="M344 -24L143 1491H258L459 -24H344Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="467" d="M230 -401H-98L-74 -262H107L379 1327H199L223 1466H553L230 -401Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="788" d="M196 690H45L335 1491H454L744 690H596L393 1287L196 690Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="934" d="M-12 -154H943V-256H-12V-154Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="559" d="M405 1191L245 1466H425L521 1191H405Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="934" d="M643 132Q561 46 489 11T343 -24Q227 -24 151 59T74 285Q74 387 118 463T241 579T469 627Q594 634 640 642T720 666Q738 742 738 790Q738 857 690 897T549 938Q364 938 309 744L159 760Q254 1086 558 1086Q708
1086 796 1008T884 810Q884 726 864 613L816 349Q793 223 793 145Q793 90 810 0H661Q648 50 643 132ZM698 538Q643 512 512 498Q378 484 328 462T250 395T222 291Q222 210 267 163T387 116Q458 116 524 160T631 287T698 538Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="934" d="M56 0L307 1466H456L366 942Q438 1023 495 1054T612 1086Q733 1086 816 978T899 653Q899 454 832 293T667 54T474 -24Q295 -24 221 201L186 0H56ZM276 436L275 398Q275 263 329 194T464 124Q528 124 590
176T702 370T753 648Q753 793 700 866T565 940Q493 940 425 869T310 635Q276 515 276 436Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="840" d="M656 387L805 368Q749 169 645 73T413 -24Q275 -24 185 85T94 401Q94 604 160 770T328 1011T554 1086Q688 1086 773 992T857 734L711 722Q711 826 663 881T543 937Q464 937 401 885T291 691T244 377Q244
249 294 183T415 116Q487 116 553 183T656 387Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="934" d="M642 154Q516 -24 376 -24Q256 -24 172 85T88 412Q88 607 155 769T320 1009T515 1086Q676 1086 758 895L856 1466H1004L753 0H616L642 154ZM236 445L235 402Q235 270 296 186Q343 121 420 121Q520 121
603 249Q712 420 712 669Q712 797 656 867T523 937Q448 937 382 870T276 669T236 445Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="934" d="M695 361L840 343Q804 188 673 73Q564 -24 430 -24Q335 -24 257 27T133 181T87 426Q87 613 157 775T330 1011T551 1086Q702 1086 797 971T893 646Q893 568 882 486H240Q237 454 237 429Q237 279 294 202T431
124Q507 124 580 185T695 361ZM264 624H753V661Q753 803 697 874T554 945Q460 945 382 865T264 624Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="467" d="M77 0L235 922H102L126 1062H259L285 1213Q312 1370 351 1420Q407 1491 523 1491Q578 1491 686 1462L659 1304Q583 1328 533 1328Q489 1328 467 1301T427 1176L407 1062H573L549 922H383L226 0H77Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="934" d="M48 -96L198 -113V-137Q198 -206 237 -241T359 -276Q488 -276 548 -197Q590 -139 624 57L639 143Q523 0 393 0Q264 0 174 116T83 454Q83 628 152 781T320 1010T519 1086Q690 1086 783 888L813 1062H948L773
37Q733 -195 652 -297Q550 -425 375 -425Q209 -425 127 -352T44 -150Q44 -126 48 -96ZM233 470Q233 351 258 284T328 183T423 148Q490 148 559 203T678 388T728 654Q728 788 668 864T522 940Q453 940 386 879T276 691T233 470Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="934" d="M56 0L307 1466H456L359 903Q446 1006 517 1046T661 1086Q764 1086 826 1019T888 835Q888 777 862 627L755 0H606L717 643Q741 782 741 819Q741 873 710 905T626 937Q549 937 478 890T363 754T283 456L204 0H56Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="373" d="M266 1261L301 1466H449L414 1261H266ZM50 0L232 1062H380L198 0H50Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="373" d="M266 1261L301 1466H448L412 1261H266ZM-204 -399L-178 -245Q-127 -262 -87 -262Q-39 -262 -11 -222T47 -10L230 1062H379L189 -43Q153 -253 106 -328Q45 -425 -63 -425Q-121 -425 -204 -399Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="840" d="M57 0L308 1466H457L301 557L733 1062H930L558 666L782 0H620L447 545L266 355L205 0H57Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="373" d="M44 0L295 1466H444L193 0H44Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1399" d="M54 0L236 1062H384L354 887Q440 1005 505 1045T643 1086Q723 1086 778 1035T851 887Q917 987 991 1036T1146 1086Q1249 1086 1306 1025T1364 848Q1364 797 1344 684L1227 0H1079L1199 702Q1214 788 1214
826Q1214 880 1186 908T1111 937Q1049 937 981 892T873 767T802 515L714 0H565L688 717Q701 790 701 822Q701 875 674 906T605 937Q506 937 418 837T289 502L202 0H54Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="934" d="M56 0L238 1062H372L341 877Q435 995 512 1040T661 1086Q762 1086 824 1018T887 825Q887 769 865 643L755 0H606L722 673Q739 772 739 819Q739 874 708 905T622 937Q510 937 421 838T289 494L204 0H56Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="934" d="M82 403Q82 690 211 888T557 1086Q709 1086 808 970T907 638Q907 441 840 286T665 54T439 -24Q284 -24 183 90T82 403ZM231 421Q231 270 291 193T441 116Q512 116 583 173T707 364T760 637Q760 789 700
867T552 946Q475 946 403 889T281 701T231 421Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="934" d="M-17 -407L235 1062H372L346 914Q425 1014 485 1050T611 1086Q732 1086 815 977T899 658Q899 460 832 297T653 45Q567 -24 473 -24Q316 -24 230 170L131 -407H-17ZM275 399Q275 265 329 195T466 124Q531
124 580 167Q650 229 701 371T752 659Q752 795 698 867T565 940Q503 940 439 885T325 689T275 399Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="934" d="M619 120Q492 -24 380 -24Q258 -24 173 86T87 410Q87 610 153 771T317 1009T517 1086Q595 1086 661 1032T767 867L800 1062H929L677 -407H529L619 120ZM234 432Q234 273 288 199T420 124Q480 124 535 173Q612
240 662 377T712 660Q712 791 656 864T524 937Q456 937 405 894Q337 836 286 699T234 432Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="559" d="M56 0L238 1062H369L332 845Q463 1086 595 1086Q640 1086 705 1047L644 879Q605 913 562 913Q480 913 399 806T271 426L197 0H56Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="840" d="M64 363L213 374Q212 244 270 180T428 116Q519 116 572 161T625 278Q625 329 592 370Q558 411 445 470Q315 538 274 574T209 663T186 781Q186 914 272 1000T498 1086Q653 1086 743 998T837 750L691 738Q688
838 634 892T487 946Q415 946 370 906T325 812Q325 766 352 733Q379 699 489 642Q658 553 704 500Q774 417 774 298Q774 166 681 71T421 -24Q254 -24 159 72T64 343V363Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="467" d="M403 147L377 -1Q324 -18 274 -18Q191 -18 143 26T94 144Q94 179 116 305L221 922H104L128 1062H245L290 1323L460 1448L394 1062H539L515 922H370L269 335Q250 222 250 202Q250 167 266 151T315 135Q364
135 403 147Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="934" d="M650 192Q493 -24 329 -24Q234 -24 170 44T105 219Q105 287 133 449L238 1062H386L270 383Q255 298 255 252Q255 189 286 157T373 124Q452 124 530 187T645 346T709 603L788 1062H936L754 0H617L650 192Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="840" d="M275 0L132 1062H276L351 477Q363 377 381 164Q424 278 491 423L781 1062H938L440 0H275Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1212" d="M221 0L130 1062H272L312 585Q326 412 332 196Q372 355 429 508L636 1062H798L827 531Q833 418 835 208Q876 343 968 580L1155 1062H1304L878 0H724L692 623Q688 688 687 849Q653 741 607 618L377 0H221Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="840" d="M-3 0L376 539L159 1062H323L396 873Q438 766 470 670L721 1062H903L537 525L756 0H592L506 216Q477 289 442 387L183 0H-3Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="840" d="M0 -410L9 -240Q55 -256 98 -256Q143 -256 170 -232Q208 -198 250 -107L297 -3L152 1062H298L364 525Q384 364 398 207L787 1062H942L387 -141Q304 -323 241 -377T101 -431Q49 -431 0 -410Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="840" d="M33 0L57 140L525 783Q575 851 637 924Q531 911 484 911H161L187 1062H860L841 948L368 301Q328 246 249 150Q372 159 418 159H761L734 0H33Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="561" d="M142 612Q198 613 243 647T318 747T380 999Q413 1181 430 1241Q458 1338 508 1402Q545 1450 596 1470T726 1491H772L744 1334H718Q651 1334 622 1316T574 1255T528 1055Q491 842 460 757T385 622T264
530Q380 465 380 302Q380 211 330 -67Q317 -140 317 -184Q317 -233 341 -253T435 -274H460L433 -431H387Q303 -431 264 -411T201 -344T177 -231Q177 -156 214 61Q243 225 243 283Q243 361 204 410Q174 447 113 449L142 612Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="436" d="M155 -431V1491H284V-431H155Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="561" d="M519 612L490 449Q434 447 388 413T314 313T252 61Q219 -119 201 -182Q173 -279 123 -343Q86 -390 35 -410T-94 -431H-140L-112 -274H-87Q-20 -274 10 -256T58 -195T103 6Q141 219 172 305T252
444T368 530Q305 571 279 623T252 759Q252 848 288 1055Q314 1201 314 1244Q314 1293 290 1313T197 1334H171L199 1491H245Q329 1491 368 1471T430 1405T454 1291Q454 1214 417 999Q389 837 389 778Q389 699 428 650Q457 614 519 612Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="981" d="M72 557V762Q159 882 300 882Q346 882 400 865T557 795Q648 748 699 748Q748 748 794 776Q859 817 911 885V673Q809 559 684 559Q636 559 592 572T459 634Q351 693 286 693Q236 693 189 666T72 557Z" />
<hkern g1="space" g2="A" k="113" />
<hkern g1="space" g2="T" k="37" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Aogonek" k="113" />
<hkern g1="space" g2="Tcedilla" k="37" />
<hkern g1="space" g2="Tcaron" k="37" />
<hkern g1="one" g2="one" k="152" />
<hkern g1="A" g2="space" k="113" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="76" />
<hkern g1="A" g2="Y" k="152" />
<hkern g1="A" g2="v" k="37" />
<hkern g1="A" g2="w" k="37" />
<hkern g1="A" g2="y" k="37" />
<hkern g1="A" g2="quoteright" k="152" />
<hkern g1="A" g2="Tcedilla" k="152" />
<hkern g1="A" g2="Tcaron" k="152" />
<hkern g1="F" g2="comma" k="227" />
<hkern g1="F" g2="period" k="227" />
<hkern g1="F" g2="A" k="113" />
<hkern g1="F" g2="Aogonek" k="113" />
<hkern g1="L" g2="space" k="76" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="152" />
<hkern g1="L" g2="W" k="152" />
<hkern g1="L" g2="Y" k="152" />
<hkern g1="L" g2="y" k="76" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="L" g2="Tcedilla" k="152" />
<hkern g1="L" g2="Tcaron" k="152" />
<hkern g1="P" g2="space" k="37" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="P" g2="Aogonek" k="152" />
<hkern g1="R" g2="T" k="37" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="37" />
<hkern g1="R" g2="Tcedilla" k="37" />
<hkern g1="R" g2="Tcaron" k="37" />
<hkern g1="T" g2="space" k="37" />
<hkern g1="T" g2="comma" k="227" />
<hkern g1="T" g2="hyphen" k="113" />
<hkern g1="T" g2="period" k="227" />
<hkern g1="T" g2="colon" k="227" />
<hkern g1="T" g2="semicolon" k="227" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="227" />
<hkern g1="T" g2="c" k="227" />
<hkern g1="T" g2="e" k="227" />
<hkern g1="T" g2="i" k="76" />
<hkern g1="T" g2="o" k="227" />
<hkern g1="T" g2="r" k="76" />
<hkern g1="T" g2="s" k="227" />
<hkern g1="T" g2="u" k="76" />
<hkern g1="T" g2="w" k="113" />
<hkern g1="T" g2="y" k="113" />
<hkern g1="T" g2="Aogonek" k="152" />
<hkern g1="T" g2="aogonek" k="227" />
<hkern g1="T" g2="eogonek" k="227" />
<hkern g1="T" g2="Odblacute" k="37" />
<hkern g1="V" g2="comma" k="188" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="188" />
<hkern g1="V" g2="colon" k="76" />
<hkern g1="V" g2="semicolon" k="76" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="152" />
<hkern g1="V" g2="e" k="113" />
<hkern g1="V" g2="i" k="37" />
<hkern g1="V" g2="o" k="113" />
<hkern g1="V" g2="r" k="76" />
<hkern g1="V" g2="u" k="76" />
<hkern g1="V" g2="y" k="76" />
<hkern g1="V" g2="Aogonek" k="152" />
<hkern g1="V" g2="aogonek" k="152" />
<hkern g1="V" g2="eogonek" k="113" />
<hkern g1="W" g2="comma" k="113" />
<hkern g1="W" g2="hyphen" k="37" />
<hkern g1="W" g2="period" k="113" />
<hkern g1="W" g2="colon" k="37" />
<hkern g1="W" g2="semicolon" k="37" />
<hkern g1="W" g2="A" k="76" />
<hkern g1="W" g2="a" k="76" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="0" />
<hkern g1="W" g2="o" k="37" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="18" />
<hkern g1="W" g2="Aogonek" k="76" />
<hkern g1="W" g2="aogonek" k="76" />
<hkern g1="W" g2="eogonek" k="37" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="264" />
<hkern g1="Y" g2="hyphen" k="188" />
<hkern g1="Y" g2="period" k="264" />
<hkern g1="Y" g2="colon" k="113" />
<hkern g1="Y" g2="semicolon" k="133" />
<hkern g1="Y" g2="A" k="152" />
<hkern g1="Y" g2="a" k="152" />
<hkern g1="Y" g2="e" k="188" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="188" />
<hkern g1="Y" g2="p" k="152" />
<hkern g1="Y" g2="q" k="188" />
<hkern g1="Y" g2="u" k="113" />
<hkern g1="Y" g2="v" k="113" />
<hkern g1="Y" g2="Aogonek" k="152" />
<hkern g1="Y" g2="aogonek" k="152" />
<hkern g1="Y" g2="eogonek" k="188" />
<hkern g1="f" g2="f" k="37" />
<hkern g1="f" g2="quoteright" k="-37" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="113" />
<hkern g1="w" g2="period" k="113" />
<hkern g1="y" g2="comma" k="152" />
<hkern g1="y" g2="period" k="152" />
<hkern g1="quoteleft" g2="quoteleft" k="37" />
<hkern g1="quoteright" g2="space" k="76" />
<hkern g1="quoteright" g2="s" k="37" />
<hkern g1="quoteright" g2="quoteright" k="37" />
<hkern g1="Aogonek" g2="space" k="113" />
<hkern g1="Aogonek" g2="T" k="152" />
<hkern g1="Aogonek" g2="V" k="152" />
<hkern g1="Aogonek" g2="W" k="76" />
<hkern g1="Aogonek" g2="Y" k="152" />
<hkern g1="Aogonek" g2="v" k="37" />
<hkern g1="Aogonek" g2="w" k="37" />
<hkern g1="Aogonek" g2="quoteright" k="152" />
<hkern g1="Aogonek" g2="Tcedilla" k="152" />
<hkern g1="Aogonek" g2="Tcaron" k="152" />
<hkern g1="Lacute" g2="space" k="76" />
<hkern g1="Lacute" g2="T" k="152" />
<hkern g1="Lacute" g2="V" k="152" />
<hkern g1="Lacute" g2="W" k="152" />
<hkern g1="Lacute" g2="Y" k="152" />
<hkern g1="Lacute" g2="y" k="76" />
<hkern g1="Lacute" g2="quoteright" k="113" />
<hkern g1="Lacute" g2="Tcedilla" k="152" />
<hkern g1="Lacute" g2="Tcaron" k="152" />
<hkern g1="Racute" g2="T" k="37" />
<hkern g1="Racute" g2="V" k="37" />
<hkern g1="Racute" g2="W" k="37" />
<hkern g1="Racute" g2="Y" k="37" />
<hkern g1="Racute" g2="Tcedilla" k="37" />
<hkern g1="Racute" g2="Tcaron" k="37" />
<hkern g1="racute" g2="comma" k="113" />
<hkern g1="racute" g2="period" k="113" />
<hkern g1="racute" g2="quoteright" k="-76" />
<hkern g1="Rcaron" g2="T" k="37" />
<hkern g1="Rcaron" g2="V" k="37" />
<hkern g1="Rcaron" g2="W" k="37" />
<hkern g1="Rcaron" g2="Y" k="37" />
<hkern g1="Rcaron" g2="Tcedilla" k="37" />
<hkern g1="Rcaron" g2="Tcaron" k="37" />
<hkern g1="rcaron" g2="comma" k="113" />
<hkern g1="rcaron" g2="period" k="113" />
<hkern g1="rcaron" g2="quoteright" k="-76" />
<hkern g1="Tcedilla" g2="space" k="37" />
<hkern g1="Tcedilla" g2="comma" k="227" />
<hkern g1="Tcedilla" g2="hyphen" k="113" />
<hkern g1="Tcedilla" g2="period" k="227" />
<hkern g1="Tcedilla" g2="colon" k="227" />
<hkern g1="Tcedilla" g2="semicolon" k="227" />
<hkern g1="Tcedilla" g2="A" k="152" />
<hkern g1="Tcedilla" g2="O" k="37" />
<hkern g1="Tcedilla" g2="a" k="227" />
<hkern g1="Tcedilla" g2="c" k="227" />
<hkern g1="Tcedilla" g2="e" k="227" />
<hkern g1="Tcedilla" g2="i" k="76" />
<hkern g1="Tcedilla" g2="o" k="227" />
<hkern g1="Tcedilla" g2="r" k="76" />
<hkern g1="Tcedilla" g2="s" k="227" />
<hkern g1="Tcedilla" g2="u" k="76" />
<hkern g1="Tcedilla" g2="w" k="113" />
<hkern g1="Tcedilla" g2="y" k="113" />
<hkern g1="Tcedilla" g2="Aogonek" k="152" />
<hkern g1="Tcedilla" g2="aogonek" k="227" />
<hkern g1="Tcedilla" g2="eogonek" k="227" />
<hkern g1="Tcedilla" g2="Odblacute" k="37" />
<hkern g1="Tcaron" g2="space" k="37" />
<hkern g1="Tcaron" g2="comma" k="227" />
<hkern g1="Tcaron" g2="hyphen" k="113" />
<hkern g1="Tcaron" g2="period" k="227" />
<hkern g1="Tcaron" g2="colon" k="227" />
<hkern g1="Tcaron" g2="semicolon" k="227" />
<hkern g1="Tcaron" g2="A" k="152" />
<hkern g1="Tcaron" g2="O" k="37" />
<hkern g1="Tcaron" g2="a" k="227" />
<hkern g1="Tcaron" g2="c" k="227" />
<hkern g1="Tcaron" g2="e" k="227" />
<hkern g1="Tcaron" g2="i" k="76" />
<hkern g1="Tcaron" g2="o" k="227" />
<hkern g1="Tcaron" g2="r" k="76" />
<hkern g1="Tcaron" g2="s" k="227" />
<hkern g1="Tcaron" g2="u" k="76" />
<hkern g1="Tcaron" g2="w" k="113" />
<hkern g1="Tcaron" g2="y" k="113" />
<hkern g1="Tcaron" g2="Aogonek" k="152" />
<hkern g1="Tcaron" g2="aogonek" k="227" />
<hkern g1="Tcaron" g2="eogonek" k="227" />
<hkern g1="Tcaron" g2="Odblacute" k="37" />
</font>

<font horiz-adv-x="741" ><font-face
    font-family="ArialNarrow"
    units-per-em="2048"
    panose-1="2 11 5 6 2 2 2 3 2 4"
    ascent="1916"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="467" d="M44 0V1280H433V0H44ZM91 53H387V1237H91V53Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="467" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="467" d="M193 364L148 1141V1466H331V1141L289 364H193ZM155 0V205H324V0H155Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="596" d="M117 947L76 1226V1466H244V1226L207 947H117ZM388 947L349 1226V1466H517V1226L477 947H388Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="934" d="M82 -25L153 401H15V550H178L239 913H15V1062H263L335 1491H458L386 1062H645L716 1491H840L768 1062H911V913H744L683 550H911V401H658L587 -25H463L534 401H276L205 -25H82ZM301 550H559L620
913H362L301 550Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="934" d="M415 -211V-31Q295 -12 226 36T111 179T57 407L206 441Q225 279 282 205T415 121V694Q317 716 221 786Q157 832 120 914T83 1107Q83 1220 125 1312T235 1453T415 1515V1601H503V1515Q596 1504 659
1462T766 1344T823 1154L671 1126Q646 1327 503 1363V844Q604 813 633 799Q699 768 747 717T824 590T853 417Q853 222 752 101T503 -29V-211H415ZM415 1365Q331 1349 281 1283T230 1114Q230 936 415 867V1365ZM503 121Q586 134 643 209T701 408Q701 507 659 566T503
669V121Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1493" d="M94 1114Q94 1297 167 1394T346 1491Q456 1491 532 1394T608 1104Q608 915 532 816T348 716Q242 716 168 814T94 1114ZM351 1367Q296 1367 260 1309T223 1103Q223 956 259 898T354 840Q407 840
443 898T480 1103Q480 1249 443 1308T351 1367ZM351 -54L1009 1491H1129L474 -54H351ZM872 344Q872 527 945 624T1123 721Q1234 721 1310 625T1386 335Q1386 145 1310 46T1126 -54Q1020 -54 946 45T872 344ZM1129 597Q1073 597 1037 539T1000 333Q1000 186 1037
128T1132 70Q1184 70 1220 129T1257 334Q1257 480 1221 538T1129 597Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1120" d="M799 173Q653 -25 455 -25Q276 -25 175 109T73 405Q73 676 359 842Q280 953 252 1024T224 1164Q224 1303 311 1397T522 1491Q640 1491 721 1403T802 1178Q802 969 575 821L791 486Q826 572
848 690L1001 650Q962 460 895 334Q976 202 1082 109L983 -34Q894 37 799 173ZM499 937Q591 1004 621 1055T651 1173Q651 1251 611 1297T515 1343Q458 1343 417 1298T375 1181Q375 1112 433 1030L499 937ZM706 315L436 724Q322 641 277 568T232 416Q232 316 294
225T456 134Q520 134 591 183T706 315Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="322" d="M109 947L71 1221V1466H239V1221L200 947H109Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="559" d="M392 -431Q282 -259 192 -7T101 532Q101 1018 392 1491H498Q386 1256 344 1127T277 842T252 530Q252 50 498 -431H392Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="559" d="M167 -431H61Q306 50 306 530Q306 687 282 842T215 1126T61 1491H167Q458 1018 458 532Q458 253 371 2T167 -431Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="653" d="M50 1197L88 1339Q218 1283 277 1242Q262 1426 261 1491H380Q378 1395 361 1243Q444 1294 554 1339L592 1197Q487 1155 388 1141Q438 1088 529 952L431 867Q385 943 318 1082Q257 941 211 867L115
952Q205 1090 251 1141Q144 1166 50 1197Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="981" d="M419 237V639H92V807H419V1206H559V807H886V639H559V237H419Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="467" d="M152 0V205H320V0Q320 -119 285 -186T183 -290L142 -213Q187 -189 210 -142T235 0H152Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="559" d="M53 440V621H506V440H53Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="467" d="M155 0V205H323V0H155Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="467" d="M0 -25L348 1491H467L118 -25H0Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="934" d="M67 723Q67 1092 166 1282T460 1472Q632 1472 731 1318Q851 1132 851 723Q851 356 752 166T458 -25Q286 -25 177 143T67 723ZM218 723Q218 366 286 245T462 123Q563 123 631 246T699 723Q699 1081 631
1202T453 1323Q353 1323 286 1200T218 723Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="934" d="M623 0H475V1147Q424 1087 338 1025T180 930V1104Q302 1174 395 1275T527 1472H623V0Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="934" d="M845 173V0H50Q47 105 113 235T357 542Q564 748 628 860T692 1070Q692 1182 627 1252T465 1323Q362 1323 296 1247T230 1029L78 1048Q94 1259 197 1365T470 1472Q654 1472 748 1348T843 1066Q843 926
769 798T488 455Q356 320 318 271T255 173H845Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="934" d="M68 387L216 411Q262 123 449 123Q550 123 624 208T698 430Q698 558 630 636T463 714Q421 714 359 694L376 852L399 850Q508 850 576 917T644 1096Q644 1199 587 1261T448 1324Q363 1324 305 1259T230
1060L83 1092Q111 1280 209 1376T446 1472Q592 1472 694 1364T796 1092Q796 992 753 915T631 794Q703 774 750 728T826 605T855 433Q855 231 736 103T451 -26Q297 -26 190 86T68 387Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="934" d="M540 0V351H19V516L568 1466H688V516H851V351H688V0H540ZM540 516V1177L164 516H540Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="934" d="M67 384L222 400Q240 260 303 192T451 123Q556 123 632 219T708 483Q708 640 635 726T450 813Q383 813 325 776T232 671L93 693L210 1446H807V1274H328L263 880Q370 972 490 972Q641 972 752 844T864
497Q864 282 753 129T453 -25Q297 -25 190 83T67 384Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="934" d="M833 1107L686 1093Q665 1206 624 1254Q565 1324 482 1324Q353 1324 275 1164Q208 1026 207 756Q258 852 335 901T498 951Q641 951 747 822T854 475Q854 328 801 209T663 32T478 -25Q296 -25 178 139T60
686Q60 1111 181 1291T491 1472Q628 1472 720 1379T833 1107ZM230 475Q230 316 305 220T479 123Q566 123 634 214T703 464Q703 620 635 706T469 792Q373 792 302 707T230 475Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="934" d="M77 1274V1447H855V1307Q681 1081 549 719T397 0H245Q248 184 303 429T456 896T665 1274H77Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="934" d="M294 795Q205 835 160 909T114 1095Q114 1262 212 1367T460 1472Q610 1472 709 1365T809 1089Q809 983 765 910T632 795Q741 752 799 656T858 418Q858 222 745 99T463 -25Q293 -25 180 98T66 423Q66
570 126 665T294 795ZM266 1100Q266 992 323 928T463 864Q544 864 601 927T658 1090Q658 1193 600 1258T461 1324Q381 1324 324 1260T266 1100ZM217 423Q217 288 289 206T463 123Q565 123 636 203T707 417Q707 552 634 634T459 717Q358 717 288 635T217 423Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="934" d="M89 339L231 355Q265 123 431 123Q505 123 565 173T668 353T710 654V690Q664 601 586 549T427 497Q280 497 174 625T67 977Q67 1207 177 1339T446 1472Q558 1472 655 1398T805 1180T858 765Q858 463
801 296T647 52T428 -25Q291 -25 199 68T89 339ZM694 986Q694 1143 624 1233T463 1323Q368 1323 294 1227T219 971Q219 827 290 742T460 656Q558 656 626 742T694 986Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="467" d="M155 857V1062H323V857H155ZM155 0V205H323V0H155Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="467" d="M152 857V1062H320V857H152ZM152 0V205H320V0Q320 -119 285 -186T183 -290L142 -213Q187 -189 210 -142T235 0H152Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="981" d="M90 641V809L886 1219V1040L255 724L886 405V226L90 641Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="981" d="M886 862H92V1030H886V862ZM886 417H92V585H886V417Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="981" d="M886 641L90 226V405L721 724L90 1040V1219L886 809V641Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="934" d="M385 361L383 415Q383 560 432 658Q466 726 575 843Q649 922 672 971T695 1079Q695 1189 625 1266T464 1343Q371 1343 307 1272T223 1046L71 1068Q93 1280 196 1385T463 1491Q627 1491 736 1379T846
1091Q846 995 810 915T666 717Q574 618 552 561T526 361H385ZM375 0V205H543V0H375Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1704" d="M950 163Q892 81 826 39T702 -3Q582 -3 500 106Q401 238 401 446Q401 614 472 773T640 1008T830 1084Q898 1084 963 1038T1075 900L1102 1055H1250L1131 384Q1107 245 1107 229Q1107 200 1124 182T1164
163Q1208 163 1289 233T1425 436T1480 719Q1480 897 1403 1041T1191 1266T896 1347Q707 1347 554 1245T306 942T210 481Q210 237 296 66T541 -194T920 -283Q1117 -283 1266 -201T1494 19H1642Q1593 -102 1481 -212T1232 -377T919 -431Q660 -431 479 -327T194 -21T89
467Q89 770 204 1016T494 1377T904 1493Q1100 1493 1256 1397T1507 1119T1602 715Q1602 415 1428 188Q1281 -4 1108 -4Q1026 -4 992 36T950 163ZM553 434Q553 296 607 221T730 145Q788 145 858 203T978 386T1028 647Q1028 787 972 861T837 935Q776 935 715 883T603
697T553 434Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1120" d="M-2 0L460 1466H631L1123 0H941L801 444H299L167 0H-2ZM345 602H752L627 1008Q569 1195 542 1312Q519 1171 477 1032L345 602Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1120" d="M124 0V1466H575Q712 1466 792 1424T923 1291T974 1092Q974 991 930 910T806 780Q911 742 971 651T1032 425Q1032 292 978 192T832 46T582 0H124ZM283 850H543Q645 850 688 864Q750 885 783 934T817 1069Q817
1148 787 1200T706 1273T524 1293H283V850ZM283 173H582Q681 173 728 191Q796 217 831 276T867 426Q867 509 833 566T742 650T561 677H283V173Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1212" d="M983 514L1143 465Q1090 218 958 97T635 -25Q468 -25 350 56T156 318T80 743Q80 985 155 1152T360 1405T648 1491Q822 1491 947 1383T1122 1064L966 1019Q886 1325 645 1325Q525 1325 437 1264T297 1072T244
743Q244 442 350 292T632 141Q762 141 856 233T983 514Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1212" d="M126 0V1466H541Q695 1466 775 1439Q880 1404 957 1311T1077 1077T1120 741Q1120 492 1047 319T860 73T560 0H126ZM285 173H541Q696 173 776 223T899 386Q956 535 956 743Q956 966 896 1093T740 1264Q676
1293 537 1293H285V173Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1120" d="M133 0V1466H1002V1293H292V844H957V672H292V173H1030V0H133Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1026" d="M141 0V1466H952V1293H300V839H864V666H300V0H141Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1307" d="M696 575V747L1205 748V204Q1088 90 963 33T706 -25Q530 -25 392 63T174 320T93 726Q93 966 174 1144T386 1406T696 1491Q828 1491 927 1442T1090 1303T1186 1056L1043 1008Q1014 1132 970 1193T854 1290T692
1325Q561 1325 467 1262T315 1064T257 737Q257 443 380 297T700 150Q794 150 892 195T1049 302V575H696Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1212" d="M129 0V1466H288V864H913V1466H1072V0H913V691H288V0H129Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="467" d="M160 0V1466H319V0H160Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="840" d="M45 416L188 440Q194 272 240 210T367 148Q424 148 467 179T526 259Q547 324 547 456V1466H706V467Q706 197 618 86T368 -25Q211 -25 134 75Q45 189 45 416Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1120" d="M124 0V1466H283V739L880 1466H1096L591 872L1118 0H908L480 742L283 508V0H124Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="934" d="M120 0V1466H279V173H871V0H120Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1399" d="M125 0V1466H364L649 428L706 211Q727 292 770 446L1058 1466H1272V0H1119V1227L769 0H626L278 1248V0H125Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1212" d="M125 0V1466H288L920 315V1466H1072V0H909L278 1152V0H125Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1307" d="M85 714Q85 1089 250 1290T661 1492Q820 1492 951 1402T1158 1141T1235 732Q1235 406 1087 201Q924 -25 660 -25Q394 -25 232 207Q85 417 85 714ZM249 711Q249 440 368 291T659 141Q834 141 952 292T1071
736Q1071 925 1010 1074Q963 1188 869 1256T662 1325Q482 1325 366 1175T249 711Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1120" d="M130 0V1466H583Q743 1466 819 1438Q923 1400 985 1297T1047 1044Q1047 846 946 721T597 596H289V0H130ZM289 769H600Q747 769 815 835T883 1036Q883 1123 850 1185T769 1270T597 1293H289V769Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1307" d="M1045 157Q1156 64 1249 21L1202 -114Q1070 -56 944 66Q811 -25 650 -25Q386 -25 223 206Q76 414 76 732Q76 970 155 1144T362 1405T652 1492Q811 1492 941 1403T1149 1142T1226 736Q1226 553 1179 405T1045
157ZM694 405Q831 359 921 265Q1061 423 1061 736Q1061 925 1008 1057T860 1257T653 1325Q475 1325 358 1176T240 732Q240 442 359 292T653 141Q737 141 813 180Q739 239 655 264L694 405Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1212" d="M129 0V1466H662Q829 1466 908 1425T1039 1289T1090 1067Q1090 901 1004 798T752 667Q819 627 854 586Q925 502 979 399L1189 0H989L829 305Q736 484 689 546T597 629T472 651H288V0H129ZM288 819H630Q742
819 800 846T892 931T926 1066Q926 1177 861 1240T668 1304H288V819Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1120" d="M76 471L226 487Q238 366 280 299T402 190T580 149Q722 149 800 218T879 399Q879 464 851 512T765 592T516 679Q346 729 274 780T162 909T122 1087Q122 1265 237 1378T547 1491Q681 1491 781 1438T937
1286T997 1053L844 1039Q832 1182 759 1251T552 1320Q417 1320 346 1260T275 1103Q275 1014 327 965Q379 916 561 866Q739 817 811 781Q921 725 977 634T1033 415Q1033 289 974 186T814 28T569 -26Q346 -26 214 108T76 471Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1026" d="M438 0V1293H42V1466H995V1293H597V0H438Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1212" d="M915 1466H1075V619Q1075 406 1034 270T883 54T604 -25Q366 -25 248 117T129 619V1466H288V620Q288 421 319 332T420 197T592 150Q762 150 838 246T915 620V1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1120" d="M474 0L8 1466H180L493 401Q529 277 556 161Q584 282 620 401L945 1466H1107L637 0H474Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1585" d="M342 0L23 1466H186L369 505Q398 357 420 205L474 476L703 1466H895L1067 724Q1130 453 1161 205Q1184 348 1220 524L1409 1466H1569L1239 0H1086L832 1117L794 1289Q777 1193 759 1117L504 0H342Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1120" d="M8 0L473 764L63 1466H252L471 1090Q538 974 567 910Q606 988 662 1077L905 1466H1077L655 775L1110 0H914L611 523Q586 567 559 621Q518 541 501 511L199 0H8Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1120" d="M468 0V621L5 1466H199L435 1024Q505 893 558 776Q611 891 689 1035L922 1466H1107L627 621V0H468Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1026" d="M36 0V180L652 1119Q716 1217 777 1293H105V1466H966V1293L292 276L219 173H986V0H36Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="467" d="M117 -407V1466H443V1317H264V-258H443V-407H117Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="467" d="M348 -25L0 1491H119L467 -25H348Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="467" d="M362 -407H36V-258H214V1317H36V1466H362V-407Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="788" d="M196 690H45L335 1491H454L744 690H596L393 1287L196 690Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="934" d="M-12 -154H943V-256H-12V-154Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="559" d="M381 1194H262L73 1474H271L381 1194Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="934" d="M676 131Q602 54 522 15T356 -24Q220 -24 139 58T58 279Q58 371 96 442T200 553T400 612Q580 638 664 674L665 720Q665 829 626 873Q571 937 457 937Q354 937 303 895T228 735L83 759Q114 930 208 1008T479
1086Q616 1086 694 1035T792 907T813 685V445Q813 193 822 128T860 0H706Q683 55 676 131ZM664 533Q583 493 423 465Q330 449 293 429T236 371T215 284Q215 208 262 163T392 117Q471 117 535 158T632 267T664 467V533Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="934" d="M244 0H107V1466H254V943Q301 1015 360 1050T493 1086Q595 1086 678 1025T812 840T862 539Q862 269 749 123T485 -24Q409 -24 349 15T244 133V0ZM242 539Q242 374 272 292T357 167T479 124Q570 124 640
226T711 533Q711 742 643 840T476 938Q385 938 314 836T242 539Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="840" d="M679 389L824 366Q799 176 699 76T457 -24Q286 -24 176 116T65 532Q65 809 176 947T463 1086Q598 1086 690 1002T809 750L666 723Q645 831 593 884T468 938Q359 938 288 842T216 535Q216 318 284 221T460
124Q544 124 603 188T679 389Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="934" d="M673 0V134Q633 57 570 17T434 -24Q280 -24 168 121T55 531Q55 712 105 838T238 1025T424 1086Q497 1086 559 1048T663 940V1466H811V0H673ZM206 530Q206 324 277 224T444 124Q538 124 607 220T676 510Q676
733 607 835T433 938Q340 938 273 840T206 530Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="934" d="M704 342L856 319Q818 149 719 63T472 -24Q287 -24 173 116T58 522Q58 797 173 941T466 1086Q635 1086 748 944T861 533L860 485H210Q219 306 293 215T473 124Q639 124 704 342ZM219 633H705Q695 771 646
839Q575 938 465 938Q366 938 296 856T219 633Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="467" d="M150 0V922H19V1062H150V1175Q150 1300 176 1362T255 1458T390 1491Q453 1491 528 1473L506 1316Q460 1326 419 1326Q353 1326 325 1292T296 1160V1062H466V922H296V0H150Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="934" d="M80 -88L224 -114Q234 -199 284 -240T423 -282Q520 -282 577 -236T656 -97Q669 -41 669 139Q621 70 561 35T428 0Q272 0 169 132Q51 284 51 539Q51 710 103 838T239 1026T429 1086Q506 1086 569 1048T682
934V1062H818V144Q818 -101 778 -205T647 -370T428 -431Q259 -431 168 -340T80 -88ZM203 550Q203 341 272 245T441 149Q541 149 611 243T681 542Q681 742 609 839T434 937Q342 937 273 840T203 550Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="934" d="M108 0V1466H255V940Q307 1013 372 1049T517 1086Q656 1086 736 998T817 673V0H670V673Q670 811 621 871T486 931Q390 931 323 854T255 581V0H108Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="373" d="M108 1259V1466H255V1259H108ZM108 0V1062H255V0H108Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="373" d="M107 1257V1466H254V1257H107ZM-80 -412L-52 -259Q-8 -273 17 -273Q64 -273 85 -236T107 -54V1062H254V-58Q254 -275 199 -353T36 -431Q-24 -431 -80 -412Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="840" d="M112 0V1466H259V630L609 1062H800L467 668L833 0H652L363 543L259 421V0H112Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="373" d="M104 0V1466H251V0H104Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1399" d="M110 0V1062H242V913Q286 996 355 1041T506 1086Q598 1086 661 1039T752 900Q804 993 871 1039T1021 1086Q1146 1086 1218 1001T1290 729V0H1143V669Q1143 783 1127 830T1073 904T990 930Q895 930 835
855T775 617V0H627V690Q627 822 587 876T475 930Q374 930 316 849T257 551V0H110Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="934" d="M108 0V1062H241V911Q289 999 358 1042T518 1086Q588 1086 647 1059T743 987T798 871T816 653V0H668V646Q668 763 648 817T586 900T487 930Q381 930 318 851T255 580V0H108Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="934" d="M53 531Q53 806 168 946T461 1086Q635 1086 752 946T869 542Q869 256 754 116T461 -24Q286 -24 170 116T53 531ZM204 531Q204 325 279 225T465 124Q569 124 643 225T718 531Q718 736 643 836T457 937Q352
937 278 836T204 531Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="934" d="M108 -407V1062H243V924Q293 1010 354 1048T494 1086Q597 1086 680 1025T813 840T864 540Q864 269 751 123T484 -24Q416 -24 357 11T255 110V-407H108ZM241 525Q241 319 310 222T477 124Q571 124 642 225T713
537Q713 745 644 845T476 945Q387 945 314 838T241 525Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="934" d="M663 -407V113Q628 52 566 14T440 -24Q284 -24 170 124T56 541Q56 775 152 930T424 1086Q505 1086 568 1045T677 920V1062H810V-407H663ZM207 534Q207 327 279 226T451 124Q540 124 609 221T678 512Q678
731 606 837T433 944Q342 944 275 845T207 534Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="559" d="M108 0V1062H241V901Q292 1013 334 1049T430 1086Q504 1086 581 1028L531 861Q476 900 424 900Q377 900 338 867T283 775Q255 672 255 556V0H108Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="840" d="M52 317L198 345Q211 233 269 179T423 124Q519 124 571 171T624 292Q624 355 579 390Q548 414 429 450Q257 503 199 540T109 639T77 780Q77 916 164 1001T405 1086Q502 1086 575 1051T688 957T742 788L598
764Q578 938 409 938Q313 938 266 900T219 801Q219 742 264 708Q291 688 424 644Q607 585 661 551T745 457T775 315Q775 163 679 69T415 -25Q102 -25 52 317Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="467" d="M437 161L457 2Q396 -14 347 -14Q270 -14 223 16T159 100T141 311V922H33V1062H141V1325L288 1433V1062H437V922H288V301Q288 215 301 190Q320 154 372 154Q397 154 437 161Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="934" d="M679 0V156Q628 66 559 21T403 -24Q300 -24 227 31T130 172T105 404V1062H252V473Q252 309 268 254T329 165T431 131Q537 131 605 218Q663 293 663 493V1062H811V0H679Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="840" d="M352 0L21 1062H177L364 426Q396 318 420 212Q439 296 474 414L668 1062H820L490 0H352Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1212" d="M268 0L2 1062H155L293 449L344 221L390 440L528 1062H680L810 446L854 243L904 448L1053 1062H1197L924 0H771L632 636L599 817L423 0H268Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="840" d="M12 0L330 552L36 1062H220L354 813Q391 744 415 694Q452 762 481 811L628 1062H804L503 562L827 0H646L467 330L420 419L191 0H12Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="840" d="M104 -409L88 -240Q137 -256 172 -256Q219 -256 249 -237T300 -178Q307 -164 358 -2L27 1062H186L368 447Q402 332 431 201Q456 325 491 443L677 1062H825L494 -18Q429 -228 392 -298T307 -400T199 -431Q157
-431 104 -409Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="840" d="M33 0V146L588 922Q493 916 421 916H66V1062H778V943L306 269L215 146Q314 155 401 155H804V0H33Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="561" d="M46 612Q102 613 142 647T198 747T216 999Q217 1181 223 1241Q234 1338 273 1402Q301 1449 348 1470T475 1491H521V1334H495Q411 1334 383 1298T354 1129Q354 853 342 779Q326 679 290 626T183
530Q270 485 312 392T354 80Q354 -141 361 -178Q371 -231 398 -252T495 -274H521V-431H475Q389 -431 346 -410T276 -347Q239 -291 228 -216T216 61Q215 247 198 313T142 413T46 449V612Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="436" d="M156 -431V1491H285V-431H156Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="561" d="M512 612V449Q455 447 416 413T360 313T342 61Q341 -120 335 -179Q324 -276 285 -341Q257 -389 210 -410T83 -431H37V-274H63Q146 -274 174 -237T203 -68Q203 209 216 285Q233 384 272 441T375
530Q281 585 242 675T203 980Q203 1201 197 1239Q187 1292 160 1313T63 1334H37V1491H83Q169 1491 212 1470T282 1407Q319 1351 330 1276T342 999Q343 814 360 747T416 647T512 612Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="981" d="M72 557V762Q159 882 300 882Q346 882 400 865T557 795Q648 748 699 748Q748 748 794 776Q859 817 911 885V673Q809 559 684 559Q636 559 592 572T459 634Q351 693 286 693Q236 693 189 666T72 557Z" />
<hkern g1="space" g2="A" k="92" />
<hkern g1="space" g2="T" k="29" />
<hkern g1="space" g2="Y" k="29" />
<hkern g1="space" g2="Aogonek" k="92" />
<hkern g1="space" g2="Tcedilla" k="29" />
<hkern g1="space" g2="Tcaron" k="29" />
<hkern g1="one" g2="one" k="123" />
<hkern g1="A" g2="space" k="92" />
<hkern g1="A" g2="T" k="123" />
<hkern g1="A" g2="V" k="123" />
<hkern g1="A" g2="W" k="61" />
<hkern g1="A" g2="Y" k="123" />
<hkern g1="A" g2="v" k="29" />
<hkern g1="A" g2="w" k="29" />
<hkern g1="A" g2="y" k="29" />
<hkern g1="A" g2="quoteright" k="123" />
<hkern g1="A" g2="Tcedilla" k="123" />
<hkern g1="A" g2="Tcaron" k="123" />
<hkern g1="F" g2="comma" k="186" />
<hkern g1="F" g2="period" k="186" />
<hkern g1="F" g2="A" k="92" />
<hkern g1="F" g2="Aogonek" k="92" />
<hkern g1="L" g2="space" k="61" />
<hkern g1="L" g2="T" k="123" />
<hkern g1="L" g2="V" k="123" />
<hkern g1="L" g2="W" k="123" />
<hkern g1="L" g2="Y" k="123" />
<hkern g1="L" g2="y" k="61" />
<hkern g1="L" g2="quoteright" k="92" />
<hkern g1="L" g2="Tcedilla" k="123" />
<hkern g1="L" g2="Tcaron" k="123" />
<hkern g1="P" g2="space" k="29" />
<hkern g1="P" g2="comma" k="215" />
<hkern g1="P" g2="period" k="215" />
<hkern g1="P" g2="A" k="123" />
<hkern g1="P" g2="Aogonek" k="123" />
<hkern g1="R" g2="T" k="29" />
<hkern g1="R" g2="V" k="29" />
<hkern g1="R" g2="W" k="29" />
<hkern g1="R" g2="Y" k="29" />
<hkern g1="R" g2="Tcedilla" k="29" />
<hkern g1="R" g2="Tcaron" k="29" />
<hkern g1="T" g2="space" k="29" />
<hkern g1="T" g2="comma" k="186" />
<hkern g1="T" g2="hyphen" k="92" />
<hkern g1="T" g2="period" k="186" />
<hkern g1="T" g2="colon" k="186" />
<hkern g1="T" g2="semicolon" k="186" />
<hkern g1="T" g2="A" k="123" />
<hkern g1="T" g2="O" k="29" />
<hkern g1="T" g2="a" k="186" />
<hkern g1="T" g2="c" k="186" />
<hkern g1="T" g2="e" k="186" />
<hkern g1="T" g2="i" k="37" />
<hkern g1="T" g2="o" k="186" />
<hkern g1="T" g2="r" k="61" />
<hkern g1="T" g2="s" k="143" />
<hkern g1="T" g2="u" k="61" />
<hkern g1="T" g2="w" k="92" />
<hkern g1="T" g2="y" k="92" />
<hkern g1="T" g2="Aogonek" k="123" />
<hkern g1="T" g2="aogonek" k="186" />
<hkern g1="T" g2="eogonek" k="186" />
<hkern g1="T" g2="Odblacute" k="29" />
<hkern g1="V" g2="comma" k="154" />
<hkern g1="V" g2="hyphen" k="92" />
<hkern g1="V" g2="period" k="154" />
<hkern g1="V" g2="colon" k="61" />
<hkern g1="V" g2="semicolon" k="61" />
<hkern g1="V" g2="A" k="123" />
<hkern g1="V" g2="a" k="123" />
<hkern g1="V" g2="e" k="92" />
<hkern g1="V" g2="i" k="29" />
<hkern g1="V" g2="o" k="92" />
<hkern g1="V" g2="r" k="61" />
<hkern g1="V" g2="u" k="61" />
<hkern g1="V" g2="y" k="61" />
<hkern g1="V" g2="Aogonek" k="123" />
<hkern g1="V" g2="aogonek" k="123" />
<hkern g1="V" g2="eogonek" k="92" />
<hkern g1="W" g2="comma" k="92" />
<hkern g1="W" g2="hyphen" k="29" />
<hkern g1="W" g2="period" k="92" />
<hkern g1="W" g2="colon" k="29" />
<hkern g1="W" g2="semicolon" k="29" />
<hkern g1="W" g2="A" k="61" />
<hkern g1="W" g2="a" k="61" />
<hkern g1="W" g2="e" k="29" />
<hkern g1="W" g2="i" k="0" />
<hkern g1="W" g2="o" k="29" />
<hkern g1="W" g2="r" k="29" />
<hkern g1="W" g2="u" k="29" />
<hkern g1="W" g2="y" k="14" />
<hkern g1="W" g2="Aogonek" k="61" />
<hkern g1="W" g2="aogonek" k="61" />
<hkern g1="W" g2="eogonek" k="29" />
<hkern g1="Y" g2="space" k="29" />
<hkern g1="Y" g2="comma" k="215" />
<hkern g1="Y" g2="hyphen" k="154" />
<hkern g1="Y" g2="period" k="215" />
<hkern g1="Y" g2="colon" k="92" />
<hkern g1="Y" g2="semicolon" k="109" />
<hkern g1="Y" g2="A" k="123" />
<hkern g1="Y" g2="a" k="123" />
<hkern g1="Y" g2="e" k="154" />
<hkern g1="Y" g2="i" k="61" />
<hkern g1="Y" g2="o" k="154" />
<hkern g1="Y" g2="p" k="123" />
<hkern g1="Y" g2="q" k="154" />
<hkern g1="Y" g2="u" k="92" />
<hkern g1="Y" g2="v" k="92" />
<hkern g1="Y" g2="Aogonek" k="123" />
<hkern g1="Y" g2="aogonek" k="123" />
<hkern g1="Y" g2="eogonek" k="154" />
<hkern g1="f" g2="f" k="29" />
<hkern g1="f" g2="quoteright" k="-29" />
<hkern g1="r" g2="comma" k="92" />
<hkern g1="r" g2="period" k="92" />
<hkern g1="r" g2="quoteright" k="-61" />
<hkern g1="v" g2="comma" k="123" />
<hkern g1="v" g2="period" k="123" />
<hkern g1="w" g2="comma" k="92" />
<hkern g1="w" g2="period" k="92" />
<hkern g1="y" g2="comma" k="123" />
<hkern g1="y" g2="period" k="123" />
<hkern g1="quoteleft" g2="quoteleft" k="29" />
<hkern g1="quoteright" g2="space" k="61" />
<hkern g1="quoteright" g2="s" k="29" />
<hkern g1="quoteright" g2="quoteright" k="29" />
<hkern g1="Aogonek" g2="space" k="92" />
<hkern g1="Aogonek" g2="T" k="123" />
<hkern g1="Aogonek" g2="V" k="123" />
<hkern g1="Aogonek" g2="W" k="61" />
<hkern g1="Aogonek" g2="Y" k="123" />
<hkern g1="Aogonek" g2="v" k="29" />
<hkern g1="Aogonek" g2="w" k="29" />
<hkern g1="Aogonek" g2="quoteright" k="123" />
<hkern g1="Aogonek" g2="Tcedilla" k="123" />
<hkern g1="Aogonek" g2="Tcaron" k="123" />
<hkern g1="Lacute" g2="space" k="61" />
<hkern g1="Lacute" g2="T" k="123" />
<hkern g1="Lacute" g2="V" k="123" />
<hkern g1="Lacute" g2="W" k="123" />
<hkern g1="Lacute" g2="Y" k="123" />
<hkern g1="Lacute" g2="y" k="61" />
<hkern g1="Lacute" g2="quoteright" k="92" />
<hkern g1="Lacute" g2="Tcedilla" k="123" />
<hkern g1="Lacute" g2="Tcaron" k="123" />
<hkern g1="Racute" g2="T" k="29" />
<hkern g1="Racute" g2="V" k="29" />
<hkern g1="Racute" g2="W" k="29" />
<hkern g1="Racute" g2="Y" k="29" />
<hkern g1="Racute" g2="Tcedilla" k="29" />
<hkern g1="Racute" g2="Tcaron" k="29" />
<hkern g1="racute" g2="comma" k="92" />
<hkern g1="racute" g2="period" k="92" />
<hkern g1="racute" g2="quoteright" k="-61" />
<hkern g1="Rcaron" g2="T" k="29" />
<hkern g1="Rcaron" g2="V" k="29" />
<hkern g1="Rcaron" g2="W" k="29" />
<hkern g1="Rcaron" g2="Y" k="29" />
<hkern g1="Rcaron" g2="Tcedilla" k="29" />
<hkern g1="Rcaron" g2="Tcaron" k="29" />
<hkern g1="rcaron" g2="comma" k="92" />
<hkern g1="rcaron" g2="period" k="92" />
<hkern g1="rcaron" g2="quoteright" k="-61" />
<hkern g1="Tcedilla" g2="space" k="29" />
<hkern g1="Tcedilla" g2="comma" k="186" />
<hkern g1="Tcedilla" g2="hyphen" k="92" />
<hkern g1="Tcedilla" g2="period" k="186" />
<hkern g1="Tcedilla" g2="colon" k="186" />
<hkern g1="Tcedilla" g2="semicolon" k="186" />
<hkern g1="Tcedilla" g2="A" k="123" />
<hkern g1="Tcedilla" g2="O" k="29" />
<hkern g1="Tcedilla" g2="a" k="186" />
<hkern g1="Tcedilla" g2="c" k="186" />
<hkern g1="Tcedilla" g2="e" k="186" />
<hkern g1="Tcedilla" g2="i" k="37" />
<hkern g1="Tcedilla" g2="o" k="186" />
<hkern g1="Tcedilla" g2="r" k="61" />
<hkern g1="Tcedilla" g2="s" k="143" />
<hkern g1="Tcedilla" g2="u" k="61" />
<hkern g1="Tcedilla" g2="w" k="92" />
<hkern g1="Tcedilla" g2="y" k="92" />
<hkern g1="Tcedilla" g2="Aogonek" k="123" />
<hkern g1="Tcedilla" g2="aogonek" k="186" />
<hkern g1="Tcedilla" g2="eogonek" k="186" />
<hkern g1="Tcedilla" g2="Odblacute" k="29" />
<hkern g1="Tcaron" g2="space" k="29" />
<hkern g1="Tcaron" g2="comma" k="186" />
<hkern g1="Tcaron" g2="hyphen" k="92" />
<hkern g1="Tcaron" g2="period" k="186" />
<hkern g1="Tcaron" g2="colon" k="186" />
<hkern g1="Tcaron" g2="semicolon" k="186" />
<hkern g1="Tcaron" g2="A" k="123" />
<hkern g1="Tcaron" g2="O" k="29" />
<hkern g1="Tcaron" g2="a" k="186" />
<hkern g1="Tcaron" g2="c" k="186" />
<hkern g1="Tcaron" g2="e" k="186" />
<hkern g1="Tcaron" g2="i" k="37" />
<hkern g1="Tcaron" g2="o" k="186" />
<hkern g1="Tcaron" g2="r" k="61" />
<hkern g1="Tcaron" g2="s" k="143" />
<hkern g1="Tcaron" g2="u" k="61" />
<hkern g1="Tcaron" g2="w" k="92" />
<hkern g1="Tcaron" g2="y" k="92" />
<hkern g1="Tcaron" g2="Aogonek" k="123" />
<hkern g1="Tcaron" g2="aogonek" k="186" />
<hkern g1="Tcaron" g2="eogonek" k="186" />
<hkern g1="Tcaron" g2="Odblacute" k="29" />
</font>

<font horiz-adv-x="904" ><font-face
    font-family="Arial"
    units-per-em="2048"
    panose-1="2 11 6 4 2 2 2 2 2 4"
    ascent="1854"
    descent="-434"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1536" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="569" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="569" d="M231 364L176 1141V1466H399V1141L347 364H231ZM184 0V205H391V0H184Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="727" d="M144 947L94 1226V1466H299V1226L254 947H144ZM475 947L426 1226V1466H631V1226L583 947H475Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1139" d="M103 -25L190 401H21V550H220L294 913H21V1062H324L411 1491H561L474 1062H789L876 1491H1027L940 1062H1113V913H910L835 550H1113V401H805L718 -25H568L654 401H340L253 -25H103ZM370 550H684L759
913H444L370 550Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1139" d="M510 -211V-31Q375 -14 291 29T145 170T73 407L254 441Q275 296 328 228Q404 132 510 121V694Q399 715 283 780Q197 828 151 913T104 1106Q104 1298 240 1417Q331 1497 510 1515V1601H616V1515Q773
1500 865 1423Q983 1325 1007 1154L821 1126Q805 1232 755 1288T616 1363V844Q752 810 796 791Q880 754 933 701T1014 575T1043 417Q1043 230 924 105T616 -29V-211H510ZM510 1365Q405 1349 345 1281T284 1120Q284 1028 335 966T510 867V1365ZM616 121Q721 134
789 212T858 405Q858 503 810 562T616 669V121Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1821" d="M119 1114Q119 1271 198 1381T427 1491Q565 1491 655 1393T746 1103Q746 917 655 817T429 716Q296 716 208 815T119 1114ZM432 1367Q365 1367 321 1309T276 1096Q276 955 321 898T432 840Q500 840
544 898T589 1110Q589 1252 544 1309T432 1367ZM433 -54L1235 1491H1381L582 -54H433ZM1067 344Q1067 502 1146 611T1376 721Q1514 721 1604 623T1695 333Q1695 147 1604 47T1377 -54Q1244 -54 1156 45T1067 344ZM1381 597Q1313 597 1269 539T1224 326Q1224 186
1269 128T1380 70Q1449 70 1493 128T1538 340Q1538 482 1493 539T1381 597Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1366" d="M973 173Q884 74 779 25T552 -25Q327 -25 195 127Q88 251 88 404Q88 540 175 649T437 842Q338 956 305 1027T272 1164Q272 1296 375 1393T636 1491Q786 1491 881 1399T977 1178Q977 969 700
821L963 486Q1008 574 1033 690L1220 650Q1172 458 1090 334Q1191 200 1319 109L1198 -34Q1089 36 973 173ZM607 937Q724 1006 758 1058T793 1173Q793 1248 746 1295T627 1343Q554 1343 506 1296T457 1181Q457 1147 474 1110T527 1030L607 937ZM860 315L530 724Q384
637 333 563T282 415Q282 326 353 230T554 134Q635 134 721 184T860 315Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="391" d="M136 947L90 1221V1466H295V1221L247 947H136Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M479 -431Q330 -243 227 9T124 531Q124 769 201 987Q291 1240 479 1491H608Q487 1283 448 1194Q387 1056 352 906Q309 719 309 530Q309 49 608 -431H479Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M253 -431H124Q423 49 423 530Q423 718 380 903Q346 1053 285 1191Q246 1281 124 1491H253Q441 1240 531 987Q608 769 608 531Q608 261 505 9T253 -431Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="797" d="M64 1197L110 1339Q269 1283 341 1242Q322 1423 321 1491H466Q463 1392 443 1243Q546 1295 679 1339L725 1197Q598 1155 476 1141Q537 1088 648 952L528 867Q470 946 391 1082Q317 941 261 867L143
952Q259 1095 309 1141Q180 1166 64 1197Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1196" d="M513 237V639H114V807H513V1206H683V807H1082V639H683V237H513Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="569" d="M182 0V205H387V0Q387 -113 347 -182T220 -290L170 -213Q227 -188 254 -140T284 0H182Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M65 440V621H618V440H65Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="569" d="M186 0V205H391V0H186Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M0 -25L425 1491H569L145 -25H0Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1139" d="M85 723Q85 983 138 1141T297 1386T563 1472Q681 1472 770 1425T917 1288T1008 1070T1041 723Q1041 465 988 307T830 62T563 -25Q351 -25 230 127Q85 310 85 723ZM270 723Q270 362 354 243T563 123Q687
123 771 243T856 723Q856 1085 772 1204T561 1323Q437 1323 363 1218Q270 1084 270 723Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1139" d="M763 0H583V1147Q518 1085 413 1023T223 930V1104Q374 1175 487 1276T647 1472H763V0Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1139" d="M1031 173V0H62Q60 65 83 125Q120 224 201 320T437 542Q676 738 760 852T844 1069Q844 1176 768 1249T568 1323Q438 1323 360 1245T281 1029L96 1048Q115 1255 239 1363T572 1472Q783 1472 906 1355T1029
1065Q1029 977 993 892T874 713T596 455Q434 319 388 271T312 173H1031Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1139" d="M86 387L266 411Q297 258 371 191T553 123Q680 123 767 211T855 429Q855 553 774 633T568 714Q517 714 441 694L461 852Q479 850 490 850Q605 850 697 910T789 1095Q789 1194 722 1259T549 1324Q444
1324 374 1258T284 1060L104 1092Q137 1273 254 1372T545 1472Q665 1472 766 1421T920 1280T974 1091Q974 996 923 918T772 794Q902 764 974 670T1046 433Q1046 241 906 108T552 -26Q359 -26 232 89T86 387Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1139" d="M662 0V351H26V516L695 1466H842V516H1040V351H842V0H662ZM662 516V1177L203 516H662Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1139" d="M85 384L274 400Q295 262 371 193T556 123Q686 123 776 221T866 481Q866 635 780 724T553 813Q466 813 396 774T286 671L117 693L259 1446H988V1274H403L324 880Q456 972 601 972Q793 972 925 839T1057
497Q1057 298 941 153Q800 -25 556 -25Q356 -25 230 87T85 384Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1139" d="M1019 1107L840 1093Q816 1199 772 1247Q699 1324 592 1324Q506 1324 441 1276Q356 1214 307 1095T256 756Q321 855 415 903T612 951Q792 951 918 819T1045 476Q1045 338 986 220T822 38T586 -25Q361
-25 219 140T77 686Q77 1111 234 1304Q371 1472 603 1472Q776 1472 886 1375T1019 1107ZM284 475Q284 382 323 297T434 168T583 123Q697 123 779 215T861 465Q861 617 780 704T576 792Q454 792 369 705T284 475Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1139" d="M97 1274V1447H1046V1307Q906 1158 769 911T556 403Q502 219 487 0H302Q305 173 370 418T556 890T815 1274H97Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1139" d="M362 795Q250 836 196 912T142 1094Q142 1254 257 1363T563 1472Q755 1472 872 1361T989 1089Q989 987 936 912T773 795Q908 751 978 653T1049 419Q1049 231 916 103T566 -25Q349 -25 216 103T83
424Q83 567 155 663T362 795ZM326 1100Q326 996 393 930T567 864Q671 864 737 929T804 1090Q804 1189 736 1256T565 1324Q462 1324 394 1258T326 1100ZM268 423Q268 346 304 274T413 163T568 123Q697 123 781 206T865 417Q865 547 779 632T562 717Q435 717 352
633T268 423Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1139" d="M112 339L285 355Q307 233 369 178T528 123Q611 123 673 161T776 262T843 434T870 654Q870 666 869 690Q815 604 722 551T519 497Q337 497 211 629T85 977Q85 1200 216 1336T546 1472Q689 1472 807
1395T987 1176T1049 763Q1049 482 988 316T807 62T524 -25Q352 -25 243 70T112 339ZM849 986Q849 1141 767 1232T568 1323Q448 1323 359 1225T270 971Q270 831 354 744T563 656Q688 656 768 743T849 986Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="569" d="M185 857V1062H390V857H185ZM185 0V205H390V0H185Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="569" d="M182 857V1062H387V857H182ZM182 0V205H387V0Q387 -113 347 -182T220 -290L170 -213Q227 -188 254 -140T284 0H182Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1196" d="M112 641V809L1083 1219V1040L313 724L1083 405V226L112 641Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1196" d="M1082 862H114V1030H1082V862ZM1082 417H114V585H1082V417Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1196" d="M1083 641L112 226V405L881 724L112 1040V1219L1083 809V641Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1139" d="M472 361Q471 397 471 415Q471 521 501 598Q523 656 572 715Q608 758 701 840T823 972T851 1079Q851 1184 769 1263T568 1343Q453 1343 376 1271T275 1046L90 1068Q115 1273 238 1382T565 1491Q780
1491 908 1374T1036 1091Q1036 995 991 914T815 717Q727 639 700 602T660 517T645 361H472ZM461 0V205H666V0H461Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="2079" d="M1161 163Q1096 88 1016 43T854 -3Q765 -3 681 49T545 209T492 446Q492 605 573 764T776 1004T1011 1084Q1098 1084 1177 1039T1313 900L1347 1055H1526L1382 384Q1352 244 1352 229Q1352 202 1372 183T1422
163Q1475 163 1561 224Q1675 304 1741 438T1808 716Q1808 883 1723 1028T1468 1260T1093 1347Q859 1347 666 1238T366 924T259 485Q259 240 365 63T673 -198T1120 -283Q1382 -283 1559 -195T1824 19H2005Q1954 -86 1830 -195T1535 -367T1123 -431Q901 -431 714
-374T394 -203T195 61Q111 250 111 469Q111 713 211 934Q333 1205 557 1349T1102 1493Q1350 1493 1547 1392T1859 1089Q1956 916 1956 713Q1956 423 1752 198Q1570 -4 1354 -4Q1285 -4 1243 17T1180 77Q1167 102 1161 163ZM677 434Q677 297 742 221T891 145Q947
145 1009 178T1127 278T1220 445T1256 649Q1256 785 1189 860T1024 935Q960 935 904 903T794 798T709 623T677 434Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1366" d="M-3 0L560 1466H769L1369 0H1148L977 444H364L203 0H-3ZM420 602H917L764 1008Q694 1193 660 1312Q632 1171 581 1032L420 602Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1366" d="M150 0V1466H700Q868 1466 969 1422T1128 1285T1186 1091Q1186 997 1135 914T981 780Q1114 741 1185 647T1257 425Q1257 322 1214 234T1106 97T946 25T709 0H150ZM344 850H661Q790 850 846 867Q920 889
957 940T995 1068Q995 1141 960 1196T860 1272T637 1293H344V850ZM344 173H709Q803 173 841 180Q908 192 953 220T1027 301T1056 425Q1056 507 1014 567T898 652T683 677H344V173Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1479" d="M1204 514L1398 465Q1337 226 1179 101T791 -25Q554 -25 406 71T180 351T102 744Q102 973 189 1143T438 1402T794 1491Q1014 1491 1164 1379T1373 1064L1182 1019Q1131 1179 1034 1252T790 1325Q621 1325
508 1244T348 1027T302 745Q302 558 356 419T526 210T775 141Q938 141 1051 235T1204 514Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M158 0V1466H663Q834 1466 924 1445Q1050 1416 1139 1340Q1255 1242 1312 1090T1370 741Q1370 574 1331 445T1231 232T1098 99T923 25T687 0H158ZM352 173H665Q810 173 892 200T1024 276Q1093 345 1131
461T1170 744Q1170 974 1095 1097T911 1263Q833 1293 660 1293H352V173Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M162 0V1466H1222V1293H356V844H1167V672H356V173H1256V0H162Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M168 0V1466H1157V1293H362V839H1050V666H362V0H168Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1593" d="M844 575V747L1465 748V204Q1322 90 1170 33T858 -25Q642 -25 466 67T199 335T109 726Q109 940 198 1125T456 1401T843 1491Q1002 1491 1130 1440T1332 1296T1443 1056L1268 1008Q1235 1120 1186 1184T1046
1286T844 1325Q711 1325 614 1285T458 1178T365 1033Q309 897 309 738Q309 542 376 410T573 214T847 150Q973 150 1093 198T1275 302V575H844Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M164 0V1466H358V864H1120V1466H1314V0H1120V691H358V0H164Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="569" d="M191 0V1466H385V0H191Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1024" d="M59 416L234 440Q241 272 297 210T452 148Q525 148 578 181T651 272T671 456V1466H865V467Q865 283 821 182T680 28T453 -25Q260 -25 158 86T59 416Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1366" d="M150 0V1466H344V739L1072 1466H1335L720 872L1362 0H1106L584 742L344 508V0H150Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1139" d="M150 0V1466H344V173H1066V0H150Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1706" d="M152 0V1466H444L791 428Q839 283 861 211Q886 291 939 446L1290 1466H1551V0H1364V1227L938 0H763L339 1248V0H152Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M156 0V1466H355L1125 315V1466H1311V0H1112L342 1152V0H156Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1593" d="M99 714Q99 1079 295 1285T801 1492Q1004 1492 1167 1395T1415 1125T1501 731Q1501 508 1411 332T1156 66T800 -25Q593 -25 430 75T183 348T99 714ZM299 711Q299 446 441 294T799 141Q1018 141 1159 295T1301
732Q1301 911 1241 1044T1064 1251T802 1325Q596 1325 448 1184T299 711Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1366" d="M158 0V1466H711Q857 1466 934 1452Q1042 1434 1115 1384T1232 1242T1277 1042Q1277 855 1158 726T728 596H352V0H158ZM352 769H731Q919 769 998 839T1077 1036Q1077 1128 1031 1193T908 1280Q859 1293
727 1293H352V769Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1593" d="M1269 157Q1404 64 1518 21L1461 -114Q1303 -57 1146 66Q983 -25 786 -25Q587 -25 425 71T176 341T88 733Q88 950 176 1128T426 1399T790 1492Q993 1492 1156 1396T1404 1126T1490 734Q1490 553 1435
409T1269 157ZM842 405Q1010 358 1119 265Q1290 421 1290 734Q1290 912 1230 1045T1053 1251T791 1325Q574 1325 431 1177T288 733Q288 447 429 294T791 141Q895 141 987 180Q896 239 795 264L842 405Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1479" d="M161 0V1466H811Q1007 1466 1109 1427T1272 1287T1333 1066Q1333 910 1232 803T920 667Q997 630 1037 594Q1122 516 1198 399L1453 0H1209L1015 305Q930 437 875 507T777 605T688 644Q655 651 580 651H355V0H161ZM355
819H772Q905 819 980 846T1094 934T1133 1066Q1133 1170 1058 1237T819 1304H355V819Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1366" d="M92 471L275 487Q288 377 335 307T483 193T708 149Q819 149 904 182T1030 272T1072 398Q1072 467 1032 518T900 605Q841 628 639 676T356 768Q251 823 200 904T148 1087Q148 1198 211 1294T395 1441T664
1491Q827 1491 951 1439T1143 1284T1215 1053L1029 1039Q1014 1178 928 1249T672 1320Q496 1320 416 1256T335 1100Q335 1021 392 970Q448 919 684 866T1009 772Q1137 713 1198 623T1259 414Q1259 297 1192 194T1000 33T717 -25Q518 -25 384 33T173 207T92 471Z"
/>
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M531 0V1293H48V1466H1210V1293H725V0H531Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M1120 1466H1314V619Q1314 398 1264 268T1084 57T741 -25Q535 -25 404 46T217 251T161 619V1466H355V620Q355 429 390 339T512 199T724 150Q938 150 1029 247T1120 620V1466Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1366" d="M577 0L9 1466H219L600 401Q646 273 677 161Q711 281 756 401L1152 1466H1350L776 0H577Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1933" d="M414 0L25 1466H224L447 505Q483 354 509 205Q565 440 575 476L854 1466H1088L1298 724Q1377 448 1412 205Q1440 344 1485 524L1715 1466H1910L1508 0H1321L1012 1117Q973 1257 966 1289Q943 1188 923
1117L612 0H414Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1366" d="M9 0L576 764L76 1466H307L573 1090Q656 973 691 910Q740 990 807 1077L1102 1466H1313L798 775L1353 0H1113L744 523Q713 568 680 621Q631 541 610 511L242 0H9Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1366" d="M571 0V621L6 1466H242L531 1024Q611 900 680 776Q746 891 840 1035L1124 1466H1350L765 621V0H571Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M41 0V180L792 1119Q872 1219 944 1293H126V1466H1176V1293L353 276L264 173H1200V0H41Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="569" d="M139 -407V1466H536V1317H319V-258H536V-407H139Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M425 -25L0 1491H145L569 -25H425Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="569" d="M436 -407H39V-258H256V1317H39V1466H436V-407Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="961" d="M239 690H54L407 1491H552L907 690H726L479 1287L239 690Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1139" d="M-31 -407V-277H1162V-407H-31Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M465 1194H320L89 1474H330L465 1194Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1139" d="M828 131Q728 46 636 11T437 -24Q262 -24 168 61T74 280Q74 358 109 422T202 526T332 585Q385 599 492 612Q710 638 813 674Q814 711 814 721Q814 831 763 876Q694 937 558 937Q431 937 371 893T281 735L105
759Q129 872 184 941T343 1048T584 1086Q720 1086 805 1054T930 974T986 851Q995 805 995 685V445Q995 194 1006 128T1052 0H864Q836 56 828 131ZM813 533Q715 493 519 465Q408 449 362 429T291 371T266 285Q266 213 320 165T480 117Q584 117 665 162T784 287Q813
348 813 467V533Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1139" d="M301 0H134V1466H314V943Q428 1086 605 1086Q703 1086 790 1047T934 936T1023 763T1055 547Q1055 274 920 125T596 -24Q408 -24 301 133V0ZM299 539Q299 348 351 263Q436 124 581 124Q699 124 785 226T871
532Q871 740 789 839T589 938Q471 938 385 836T299 539Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="1024" d="M828 389L1005 366Q976 183 857 80T563 -24Q345 -24 213 118T80 527Q80 699 137 828T310 1021T564 1086Q737 1086 847 999T988 750L813 723Q788 830 725 884T571 938Q435 938 350 841T265 532Q265 318
347 221T561 124Q667 124 738 189T828 389Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1139" d="M824 0V134Q723 -24 527 -24Q400 -24 294 46T129 241T70 530Q70 689 123 818T282 1017T519 1086Q615 1086 690 1046T812 940V1466H991V0H824ZM255 530Q255 326 341 225T544 124Q662 124 744 220T827 515Q827
733 743 835T536 937Q416 937 336 839T255 530Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="1139" d="M862 342L1048 319Q1004 156 885 66T581 -24Q348 -24 212 119T75 522Q75 790 213 938T571 1086Q784 1086 919 941T1054 533Q1054 517 1053 485H261Q271 310 360 217T582 124Q681 124 751 176T862 342ZM271
633H864Q852 767 796 834Q710 938 573 938Q449 938 365 855T271 633Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="569" d="M178 0V922H19V1062H178V1175Q178 1282 197 1334Q223 1404 288 1447T472 1491Q548 1491 640 1473L613 1316Q557 1326 507 1326Q425 1326 391 1291T357 1160V1062H564V922H357V0H178Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1139" d="M102 -88L277 -114Q288 -195 338 -232Q405 -282 521 -282Q646 -282 714 -232T806 -92Q820 -37 819 139Q701 0 525 0Q306 0 186 158T66 537Q66 689 121 817T280 1016T526 1086Q714 1086 836 934V1062H1002V144Q1002
-104 952 -207T792 -371T522 -431Q332 -431 215 -346T102 -88ZM251 550Q251 341 334 245T542 149Q666 149 750 244T834 544Q834 739 748 838T539 937Q419 937 335 840T251 550Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1139" d="M135 0V1466H315V940Q441 1086 633 1086Q751 1086 838 1040T962 911T1000 673V0H820V673Q820 808 762 869T596 931Q516 931 446 890T345 777T315 581V0H135Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="455" d="M136 1259V1466H316V1259H136ZM136 0V1062H316V0H136Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="455" d="M134 1257V1466H314V1257H134ZM-94 -412L-60 -259Q-6 -273 25 -273Q80 -273 107 -237T134 -54V1062H314V-58Q314 -254 263 -331Q198 -431 47 -431Q-26 -431 -94 -412Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1024" d="M136 0V1466H316V630L742 1062H975L569 668L1016 0H794L443 543L316 421V0H136Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="455" d="M131 0V1466H311V0H131Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1706" d="M135 0V1062H296V913Q346 991 429 1038T618 1086Q736 1086 811 1037T918 900Q1044 1086 1246 1086Q1404 1086 1489 999T1574 729V0H1395V669Q1395 777 1378 824T1314 901T1206 930Q1094 930 1020 856T946
617V0H766V690Q766 810 722 870T578 930Q502 930 438 890T344 773T315 551V0H135Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1139" d="M135 0V1062H297V911Q414 1086 635 1086Q731 1086 811 1052T932 961T988 828Q998 778 998 653V0H818V646Q818 756 797 810T723 897T597 930Q482 930 399 857T315 580V0H135Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1139" d="M68 531Q68 826 232 968Q369 1086 566 1086Q785 1086 924 943T1063 546Q1063 341 1002 224T823 41T566 -24Q343 -24 206 119T68 531ZM253 531Q253 327 342 226T566 124Q700 124 789 226T878 537Q878 734
789 835T566 937Q431 937 342 836T253 531Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1139" d="M135 -407V1062H299V924Q357 1005 430 1045T607 1086Q743 1086 847 1016T1004 819T1057 539Q1057 376 999 246T829 46T594 -24Q504 -24 433 14T315 110V-407H135ZM298 525Q298 320 381 222T582 124Q702
124 787 225T873 540Q873 743 790 844T590 945Q475 945 387 838T298 525Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1139" d="M812 -407V113Q770 54 695 15T534 -24Q345 -24 209 127T72 541Q72 701 127 828T288 1020T520 1086Q717 1086 830 920V1062H992V-407H812ZM257 534Q257 329 343 227T549 124Q664 124 747 221T830 518Q830
730 743 837T537 944Q420 944 339 845T257 534Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="682" d="M133 0V1062H295V901Q357 1014 409 1050T525 1086Q616 1086 710 1028L648 861Q582 900 516 900Q457 900 410 865T343 766Q313 670 313 556V0H133Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="1024" d="M63 317L241 345Q256 238 324 181T516 124Q640 124 700 174T760 293Q760 354 707 389Q670 413 523 450Q325 500 249 536T133 637T93 780Q93 851 125 911T214 1012Q256 1043 328 1064T484 1086Q609 1086
703 1050T843 953T905 788L729 764Q717 846 660 892T497 938Q373 938 320 897T267 801Q267 766 289 738Q311 709 358 690Q385 680 517 644Q708 593 783 561T902 466T945 312Q945 222 893 143T741 20T517 -24Q310 -24 202 62T63 317Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="569" d="M528 161L554 2Q478 -14 418 -14Q320 -14 266 17T190 98T168 311V922H36V1062H168V1325L347 1433V1062H528V922H347V301Q347 224 356 202T387 167T449 154Q479 154 528 161Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1139" d="M831 0V156Q707 -24 494 -24Q400 -24 319 12T198 102T142 236Q131 289 131 404V1062H311V473Q311 332 322 283Q339 212 394 172T530 131Q611 131 682 172T782 285T812 493V1062H992V0H831Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1024" d="M430 0L26 1062H216L444 426Q481 323 512 212Q536 296 579 414L815 1062H1000L598 0H430Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1479" d="M331 0L6 1062H192L361 449L424 221Q428 238 479 440L648 1062H833L992 446L1045 243L1106 448L1288 1062H1463L1131 0H944L775 636L734 817L519 0H331Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1024" d="M15 0L403 552L44 1062H269L432 813Q478 742 506 694Q550 760 587 811L766 1062H981L614 562L1009 0H788L570 330L512 419L233 0H15Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1024" d="M127 -409L107 -240Q166 -256 210 -256Q270 -256 306 -236T365 -180Q382 -153 420 -46Q425 -31 436 -2L33 1062H227L448 447Q491 330 525 201Q556 325 599 443L826 1062H1006L602 -18Q537 -193 501 -259Q453
-348 391 -389T243 -431Q191 -431 127 -409Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="1024" d="M40 0V146L716 922Q601 916 513 916H80V1062H948V943L373 269L262 146Q383 155 489 155H980V0H40Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="684" d="M57 612Q134 614 182 653T247 762T264 998T270 1218Q279 1302 303 1353T364 1434T456 1481Q494 1491 580 1491H636V1334H605Q501 1334 467 1297T433 1129Q433 867 422 798Q404 691 361 633T224
530Q334 484 383 390T433 80Q433 -115 437 -152Q445 -220 477 -247T605 -274H636V-431H580Q482 -431 438 -415Q374 -392 332 -341T278 -210T264 49T247 298T183 407T57 449V612Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="532" d="M188 -431V1491H345V-431H188Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="684" d="M626 612V449Q549 447 501 407T436 299T419 63T413 -157Q404 -242 380 -292T319 -373T227 -420Q189 -431 103 -431H47V-274H78Q182 -274 216 -237T250 -68Q250 182 259 249Q275 360 323 426T459
530Q344 585 297 675T250 981Q250 1176 245 1214Q238 1281 206 1307T78 1334H47V1491H103Q201 1491 245 1475Q309 1453 351 1401T405 1270T419 1011T436 763T500 654T626 612Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1196" d="M87 557V762Q193 882 365 882Q425 882 491 865T679 795Q748 766 782 757T852 748Q917 748 986 787T1110 885V673Q1046 613 981 586T833 559Q773 559 719 573T546 640T348 693Q284 693 228 666T87 557Z" />
<hkern g1="space" g2="A" k="113" />
<hkern g1="space" g2="T" k="37" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Alphatonos" k="113" />
<hkern g1="space" g2="Alpha" k="113" />
<hkern g1="space" g2="Delta" k="113" />
<hkern g1="space" g2="Lambda" k="113" />
<hkern g1="space" g2="Tau" k="37" />
<hkern g1="space" g2="Upsilon" k="37" />
<hkern g1="space" g2="Upsilondieresis" k="37" />
<hkern g1="one" g2="one" k="152" />
<hkern g1="A" g2="space" k="113" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="76" />
<hkern g1="A" g2="Y" k="152" />
<hkern g1="A" g2="v" k="37" />
<hkern g1="A" g2="w" k="37" />
<hkern g1="A" g2="y" k="37" />
<hkern g1="A" g2="quoteright" k="152" />
<hkern g1="F" g2="comma" k="227" />
<hkern g1="F" g2="period" k="227" />
<hkern g1="F" g2="A" k="113" />
<hkern g1="L" g2="space" k="76" />
<hkern g1="L" g2="T" k="152" />
<hkern g1="L" g2="V" k="152" />
<hkern g1="L" g2="W" k="152" />
<hkern g1="L" g2="Y" k="152" />
<hkern g1="L" g2="y" k="76" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="P" g2="space" k="37" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="T" k="37" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="37" />
<hkern g1="T" g2="space" k="37" />
<hkern g1="T" g2="comma" k="227" />
<hkern g1="T" g2="hyphen" k="113" />
<hkern g1="T" g2="period" k="227" />
<hkern g1="T" g2="colon" k="227" />
<hkern g1="T" g2="semicolon" k="227" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="227" />
<hkern g1="T" g2="c" k="227" />
<hkern g1="T" g2="e" k="227" />
<hkern g1="T" g2="i" k="76" />
<hkern g1="T" g2="o" k="227" />
<hkern g1="T" g2="r" k="76" />
<hkern g1="T" g2="s" k="227" />
<hkern g1="T" g2="u" k="76" />
<hkern g1="T" g2="w" k="113" />
<hkern g1="T" g2="y" k="113" />
<hkern g1="V" g2="comma" k="188" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="188" />
<hkern g1="V" g2="colon" k="76" />
<hkern g1="V" g2="semicolon" k="76" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="152" />
<hkern g1="V" g2="e" k="113" />
<hkern g1="V" g2="i" k="37" />
<hkern g1="V" g2="o" k="113" />
<hkern g1="V" g2="r" k="76" />
<hkern g1="V" g2="u" k="76" />
<hkern g1="V" g2="y" k="76" />
<hkern g1="W" g2="comma" k="113" />
<hkern g1="W" g2="hyphen" k="37" />
<hkern g1="W" g2="period" k="113" />
<hkern g1="W" g2="colon" k="37" />
<hkern g1="W" g2="semicolon" k="37" />
<hkern g1="W" g2="A" k="76" />
<hkern g1="W" g2="a" k="76" />
<hkern g1="W" g2="e" k="37" />
<hkern g1="W" g2="i" k="0" />
<hkern g1="W" g2="o" k="37" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="18" />
<hkern g1="Y" g2="space" k="37" />
<hkern g1="Y" g2="comma" k="264" />
<hkern g1="Y" g2="hyphen" k="188" />
<hkern g1="Y" g2="period" k="264" />
<hkern g1="Y" g2="colon" k="113" />
<hkern g1="Y" g2="semicolon" k="133" />
<hkern g1="Y" g2="A" k="152" />
<hkern g1="Y" g2="a" k="152" />
<hkern g1="Y" g2="e" k="188" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="188" />
<hkern g1="Y" g2="p" k="152" />
<hkern g1="Y" g2="q" k="188" />
<hkern g1="Y" g2="u" k="113" />
<hkern g1="Y" g2="v" k="113" />
<hkern g1="f" g2="f" k="37" />
<hkern g1="f" g2="quoteright" k="-37" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="113" />
<hkern g1="w" g2="period" k="113" />
<hkern g1="y" g2="comma" k="152" />
<hkern g1="y" g2="period" k="152" />
<hkern g1="quoteleft" g2="quoteleft" k="37" />
<hkern g1="quoteright" g2="space" k="76" />
<hkern g1="quoteright" g2="s" k="37" />
<hkern g1="quoteright" g2="quoteright" k="37" />
<hkern g1="quotedblbase" g2="afii10051" k="160" />
<hkern g1="quotedblbase" g2="afii10060" k="160" />
<hkern g1="quotedblbase" g2="afii10036" k="160" />
<hkern g1="quotedblbase" g2="afii10041" k="68" />
<hkern g1="quotedblbase" g2="afii10044" k="68" />
<hkern g1="Gamma" g2="comma" k="225" />
<hkern g1="Gamma" g2="period" k="225" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-164" />
<hkern g1="Gamma" g2="Alpha" k="188" />
<hkern g1="Gamma" g2="Delta" k="188" />
<hkern g1="Gamma" g2="Lambda" k="188" />
<hkern g1="Gamma" g2="iota" k="88" />
<hkern g1="Gamma" g2="iotadieresis" k="-88" />
<hkern g1="Theta" g2="Alpha" k="37" />
<hkern g1="Theta" g2="Delta" k="37" />
<hkern g1="Theta" g2="Lambda" k="37" />
<hkern g1="Theta" g2="Upsilon" k="66" />
<hkern g1="Theta" g2="Upsilondieresis" k="66" />
<hkern g1="Phi" g2="Alpha" k="59" />
<hkern g1="Phi" g2="Upsilon" k="66" />
<hkern g1="Phi" g2="Upsilondieresis" k="66" />
<hkern g1="delta" g2="tau" k="29" />
<hkern g1="delta" g2="lambda" k="39" />
<hkern g1="delta" g2="chi" k="55" />
<hkern g1="delta" g2="pi" k="29" />
<hkern g1="tau" g2="alpha" k="29" />
<hkern g1="tau" g2="delta" k="29" />
<hkern g1="tau" g2="sigma" k="29" />
<hkern g1="tau" g2="phi" k="29" />
<hkern g1="tau" g2="alphatonos" k="29" />
<hkern g1="tau" g2="zeta" k="29" />
<hkern g1="tau" g2="omicron" k="29" />
<hkern g1="tau" g2="sigma1" k="29" />
<hkern g1="tau" g2="omega" k="29" />
<hkern g1="tau" g2="omegatonos" k="29" />
<hkern g1="phi" g2="tau" k="29" />
<hkern g1="phi" g2="lambda" k="39" />
<hkern g1="phi" g2="chi" k="55" />
<hkern g1="phi" g2="pi" k="29" />
<hkern g1="Alphatonos" g2="Theta" k="43" />
<hkern g1="Alphatonos" g2="Phi" k="59" />
<hkern g1="Alphatonos" g2="Omicron" k="43" />
<hkern g1="Alphatonos" g2="Tau" k="152" />
<hkern g1="Alphatonos" g2="Upsilon" k="152" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="152" />
<hkern g1="Alphatonos" g2="gamma" k="37" />
<hkern g1="Alphatonos" g2="nu" k="37" />
<hkern g1="Alphatonos" g2="chi" k="37" />
<hkern g1="Omicrontonos" g2="Upsilon" k="66" />
<hkern g1="Upsilontonos" g2="Theta" k="115" />
<hkern g1="Upsilontonos" g2="Phi" k="115" />
<hkern g1="Upsilontonos" g2="alpha" k="186" />
<hkern g1="Upsilontonos" g2="sigma" k="186" />
<hkern g1="Upsilontonos" g2="phi" k="186" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-170" />
<hkern g1="Upsilontonos" g2="Alpha" k="152" />
<hkern g1="Upsilontonos" g2="Delta" k="152" />
<hkern g1="Upsilontonos" g2="Lambda" k="152" />
<hkern g1="Upsilontonos" g2="Omicron" k="115" />
<hkern g1="Upsilontonos" g2="Omega" k="98" />
<hkern g1="Upsilontonos" g2="etatonos" k="152" />
<hkern g1="Upsilontonos" g2="iotatonos" k="76" />
<hkern g1="Upsilontonos" g2="eta" k="152" />
<hkern g1="Upsilontonos" g2="iota" k="76" />
<hkern g1="Upsilontonos" g2="kappa" k="152" />
<hkern g1="Upsilontonos" g2="mu" k="152" />
<hkern g1="Upsilontonos" g2="omicron" k="186" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="-98" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="186" />
<hkern g1="Omegatonos" g2="Upsilon" k="47" />
<hkern g1="Omegatonos" g2="Upsilondieresis" k="47" />
<hkern g1="Alpha" g2="space" k="113" />
<hkern g1="Alpha" g2="quoteright" k="152" />
<hkern g1="Alpha" g2="Theta" k="43" />
<hkern g1="Alpha" g2="Phi" k="59" />
<hkern g1="Alpha" g2="Omicron" k="43" />
<hkern g1="Alpha" g2="Tau" k="152" />
<hkern g1="Alpha" g2="Upsilon" k="152" />
<hkern g1="Alpha" g2="Upsilondieresis" k="152" />
<hkern g1="Alpha" g2="gamma" k="37" />
<hkern g1="Alpha" g2="nu" k="37" />
<hkern g1="Alpha" g2="chi" k="37" />
<hkern g1="Delta" g2="space" k="113" />
<hkern g1="Delta" g2="Theta" k="43" />
<hkern g1="Delta" g2="Omicron" k="43" />
<hkern g1="Delta" g2="Tau" k="119" />
<hkern g1="Delta" g2="Upsilon" k="152" />
<hkern g1="Delta" g2="Upsilondieresis" k="152" />
<hkern g1="Kappa" g2="Theta" k="63" />
<hkern g1="Kappa" g2="Phi" k="113" />
<hkern g1="Kappa" g2="alpha" k="25" />
<hkern g1="Kappa" g2="delta" k="25" />
<hkern g1="Kappa" g2="sigma" k="25" />
<hkern g1="Kappa" g2="phi" k="25" />
<hkern g1="Kappa" g2="Omicron" k="63" />
<hkern g1="Kappa" g2="alphatonos" k="25" />
<hkern g1="Kappa" g2="zeta" k="25" />
<hkern g1="Kappa" g2="theta" k="25" />
<hkern g1="Kappa" g2="xi" k="25" />
<hkern g1="Kappa" g2="omicron" k="25" />
<hkern g1="Kappa" g2="omega" k="25" />
<hkern g1="Kappa" g2="omicrontonos" k="25" />
<hkern g1="Kappa" g2="omegatonos" k="25" />
<hkern g1="Lambda" g2="space" k="113" />
<hkern g1="Lambda" g2="Theta" k="43" />
<hkern g1="Lambda" g2="Omicron" k="43" />
<hkern g1="Lambda" g2="Tau" k="152" />
<hkern g1="Lambda" g2="Upsilon" k="152" />
<hkern g1="Lambda" g2="Upsilondieresis" k="152" />
<hkern g1="Omicron" g2="Alpha" k="37" />
<hkern g1="Omicron" g2="Delta" k="43" />
<hkern g1="Omicron" g2="Lambda" k="37" />
<hkern g1="Omicron" g2="Upsilon" k="66" />
<hkern g1="Omicron" g2="Upsilondieresis" k="66" />
<hkern g1="Rho" g2="space" k="37" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="152" />
<hkern g1="Rho" g2="Delta" k="152" />
<hkern g1="Rho" g2="Lambda" k="152" />
<hkern g1="Sigma" g2="tau" k="98" />
<hkern g1="Sigma" g2="pi" k="98" />
<hkern g1="Tau" g2="space" k="37" />
<hkern g1="Tau" g2="comma" k="225" />
<hkern g1="Tau" g2="period" k="225" />
<hkern g1="Tau" g2="colon" k="225" />
<hkern g1="Tau" g2="semicolon" k="225" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="225" />
<hkern g1="Tau" g2="epsilon" k="225" />
<hkern g1="Tau" g2="sigma" k="225" />
<hkern g1="Tau" g2="phi" k="225" />
<hkern g1="Tau" g2="iotadieresistonos" k="-188" />
<hkern g1="Tau" g2="Alpha" k="152" />
<hkern g1="Tau" g2="Delta" k="152" />
<hkern g1="Tau" g2="Lambda" k="152" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="225" />
<hkern g1="Tau" g2="epsilontonos" k="225" />
<hkern g1="Tau" g2="upsilondieresistonos" k="178" />
<hkern g1="Tau" g2="gamma" k="178" />
<hkern g1="Tau" g2="eta" k="150" />
<hkern g1="Tau" g2="iota" k="76" />
<hkern g1="Tau" g2="mu" k="150" />
<hkern g1="Tau" g2="nu" k="113" />
<hkern g1="Tau" g2="omicron" k="225" />
<hkern g1="Tau" g2="upsilon" k="176" />
<hkern g1="Tau" g2="chi" k="113" />
<hkern g1="Tau" g2="psi" k="150" />
<hkern g1="Tau" g2="iotadieresis" k="-188" />
<hkern g1="Tau" g2="upsilondieresis" k="178" />
<hkern g1="Tau" g2="omicrontonos" k="225" />
<hkern g1="Tau" g2="upsilontonos" k="178" />
<hkern g1="Upsilon" g2="space" k="37" />
<hkern g1="Upsilon" g2="comma" k="262" />
<hkern g1="Upsilon" g2="hyphen" k="186" />
<hkern g1="Upsilon" g2="period" k="262" />
<hkern g1="Upsilon" g2="colon" k="113" />
<hkern g1="Upsilon" g2="semicolon" k="113" />
<hkern g1="Upsilon" g2="Theta" k="115" />
<hkern g1="Upsilon" g2="Phi" k="115" />
<hkern g1="Upsilon" g2="alpha" k="186" />
<hkern g1="Upsilon" g2="sigma" k="186" />
<hkern g1="Upsilon" g2="phi" k="186" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-188" />
<hkern g1="Upsilon" g2="Alpha" k="152" />
<hkern g1="Upsilon" g2="Delta" k="152" />
<hkern g1="Upsilon" g2="Lambda" k="152" />
<hkern g1="Upsilon" g2="Omicron" k="115" />
<hkern g1="Upsilon" g2="Omega" k="98" />
<hkern g1="Upsilon" g2="etatonos" k="152" />
<hkern g1="Upsilon" g2="iotatonos" k="76" />
<hkern g1="Upsilon" g2="gamma" k="98" />
<hkern g1="Upsilon" g2="eta" k="152" />
<hkern g1="Upsilon" g2="iota" k="76" />
<hkern g1="Upsilon" g2="kappa" k="152" />
<hkern g1="Upsilon" g2="mu" k="152" />
<hkern g1="Upsilon" g2="omicron" k="186" />
<hkern g1="Upsilon" g2="iotadieresis" k="-121" />
<hkern g1="Upsilon" g2="omicrontonos" k="186" />
<hkern g1="Psi" g2="alpha" k="78" />
<hkern g1="Psi" g2="delta" k="78" />
<hkern g1="Psi" g2="sigma" k="78" />
<hkern g1="Psi" g2="phi" k="78" />
<hkern g1="Psi" g2="alphatonos" k="78" />
<hkern g1="Psi" g2="theta" k="39" />
<hkern g1="Psi" g2="omicron" k="78" />
<hkern g1="Psi" g2="omega" k="78" />
<hkern g1="Psi" g2="omicrontonos" k="78" />
<hkern g1="Psi" g2="omegatonos" k="78" />
<hkern g1="Omega" g2="Upsilon" k="47" />
<hkern g1="Omega" g2="Upsilondieresis" k="47" />
<hkern g1="Upsilondieresis" g2="space" k="37" />
<hkern g1="Upsilondieresis" g2="Theta" k="115" />
<hkern g1="Upsilondieresis" g2="Phi" k="115" />
<hkern g1="Upsilondieresis" g2="alpha" k="186" />
<hkern g1="Upsilondieresis" g2="sigma" k="186" />
<hkern g1="Upsilondieresis" g2="phi" k="186" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-170" />
<hkern g1="Upsilondieresis" g2="Alpha" k="152" />
<hkern g1="Upsilondieresis" g2="Delta" k="152" />
<hkern g1="Upsilondieresis" g2="Lambda" k="152" />
<hkern g1="Upsilondieresis" g2="Omicron" k="115" />
<hkern g1="Upsilondieresis" g2="Omega" k="98" />
<hkern g1="Upsilondieresis" g2="etatonos" k="152" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="76" />
<hkern g1="Upsilondieresis" g2="eta" k="152" />
<hkern g1="Upsilondieresis" g2="iota" k="76" />
<hkern g1="Upsilondieresis" g2="kappa" k="152" />
<hkern g1="Upsilondieresis" g2="mu" k="152" />
<hkern g1="Upsilondieresis" g2="omicron" k="186" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="-98" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="186" />
<hkern g1="zeta" g2="alpha" k="137" />
<hkern g1="zeta" g2="delta" k="76" />
<hkern g1="zeta" g2="sigma" k="137" />
<hkern g1="zeta" g2="tau" k="86" />
<hkern g1="zeta" g2="phi" k="137" />
<hkern g1="zeta" g2="alphatonos" k="137" />
<hkern g1="zeta" g2="etatonos" k="37" />
<hkern g1="zeta" g2="gamma" k="86" />
<hkern g1="zeta" g2="eta" k="37" />
<hkern g1="zeta" g2="theta" k="98" />
<hkern g1="zeta" g2="iota" k="37" />
<hkern g1="zeta" g2="kappa" k="37" />
<hkern g1="zeta" g2="nu" k="86" />
<hkern g1="zeta" g2="omicron" k="137" />
<hkern g1="zeta" g2="omega" k="137" />
<hkern g1="zeta" g2="omicrontonos" k="137" />
<hkern g1="zeta" g2="omegatonos" k="137" />
<hkern g1="zeta" g2="pi" k="86" />
<hkern g1="theta" g2="lambda" k="39" />
<hkern g1="kappa" g2="alpha" k="25" />
<hkern g1="kappa" g2="delta" k="25" />
<hkern g1="kappa" g2="sigma" k="25" />
<hkern g1="kappa" g2="phi" k="25" />
<hkern g1="kappa" g2="alphatonos" k="25" />
<hkern g1="kappa" g2="zeta" k="25" />
<hkern g1="kappa" g2="theta" k="25" />
<hkern g1="kappa" g2="xi" k="25" />
<hkern g1="kappa" g2="omicron" k="25" />
<hkern g1="kappa" g2="sigma1" k="25" />
<hkern g1="kappa" g2="omega" k="25" />
<hkern g1="kappa" g2="omicrontonos" k="25" />
<hkern g1="kappa" g2="omegatonos" k="25" />
<hkern g1="lambda" g2="alpha" k="31" />
<hkern g1="lambda" g2="delta" k="31" />
<hkern g1="lambda" g2="sigma" k="31" />
<hkern g1="lambda" g2="phi" k="37" />
<hkern g1="lambda" g2="alphatonos" k="31" />
<hkern g1="lambda" g2="xi" k="31" />
<hkern g1="lambda" g2="omicron" k="31" />
<hkern g1="lambda" g2="sigma1" k="47" />
<hkern g1="lambda" g2="upsilon" k="49" />
<hkern g1="lambda" g2="omega" k="31" />
<hkern g1="lambda" g2="omicrontonos" k="31" />
<hkern g1="lambda" g2="upsilontonos" k="49" />
<hkern g1="lambda" g2="omegatonos" k="31" />
<hkern g1="xi" g2="alpha" k="55" />
<hkern g1="xi" g2="delta" k="55" />
<hkern g1="xi" g2="sigma" k="55" />
<hkern g1="xi" g2="phi" k="55" />
<hkern g1="xi" g2="alphatonos" k="55" />
<hkern g1="xi" g2="zeta" k="55" />
<hkern g1="xi" g2="xi" k="55" />
<hkern g1="xi" g2="omicron" k="55" />
<hkern g1="xi" g2="sigma1" k="55" />
<hkern g1="xi" g2="omicrontonos" k="55" />
<hkern g1="omicron" g2="tau" k="29" />
<hkern g1="omicron" g2="lambda" k="39" />
<hkern g1="omicron" g2="chi" k="55" />
<hkern g1="omicron" g2="pi" k="29" />
<hkern g1="rho" g2="tau" k="29" />
<hkern g1="rho" g2="lambda" k="39" />
<hkern g1="rho" g2="pi" k="29" />
<hkern g1="chi" g2="alpha" k="55" />
<hkern g1="chi" g2="delta" k="55" />
<hkern g1="chi" g2="sigma" k="55" />
<hkern g1="chi" g2="phi" k="55" />
<hkern g1="chi" g2="alphatonos" k="55" />
<hkern g1="chi" g2="zeta" k="55" />
<hkern g1="chi" g2="omicron" k="55" />
<hkern g1="chi" g2="sigma1" k="55" />
<hkern g1="chi" g2="omega" k="55" />
<hkern g1="chi" g2="omicrontonos" k="55" />
<hkern g1="chi" g2="omegatonos" k="55" />
<hkern g1="omega" g2="tau" k="29" />
<hkern g1="omega" g2="lambda" k="39" />
<hkern g1="omega" g2="chi" k="55" />
<hkern g1="omega" g2="pi" k="29" />
<hkern g1="omicrontonos" g2="tau" k="29" />
<hkern g1="omicrontonos" g2="lambda" k="39" />
<hkern g1="omicrontonos" g2="chi" k="55" />
<hkern g1="omicrontonos" g2="pi" k="29" />
<hkern g1="omegatonos" g2="tau" k="29" />
<hkern g1="omegatonos" g2="lambda" k="39" />
<hkern g1="omegatonos" g2="chi" k="55" />
<hkern g1="omegatonos" g2="pi" k="29" />
<hkern g1="afii10052" g2="comma" k="250" />
<hkern g1="afii10052" g2="period" k="250" />
<hkern g1="afii10052" g2="guillemotleft" k="137" />
<hkern g1="afii10052" g2="guillemotright" k="137" />
<hkern g1="afii10052" g2="emdash" k="45" />
<hkern g1="afii10058" g2="quoteright" k="160" />
<hkern g1="afii10059" g2="quoteright" k="137" />
<hkern g1="afii10017" g2="quoteright" k="115" />
<hkern g1="afii10017" g2="afii10021" k="-68" />
<hkern g1="afii10017" g2="afii10025" k="23" />
<hkern g1="afii10017" g2="afii10029" k="-45" />
<hkern g1="afii10017" g2="afii10032" k="45" />
<hkern g1="afii10017" g2="afii10033" k="23" />
<hkern g1="afii10017" g2="afii10035" k="45" />
<hkern g1="afii10017" g2="afii10036" k="160" />
<hkern g1="afii10017" g2="afii10037" k="90" />
<hkern g1="afii10017" g2="afii10038" k="68" />
<hkern g1="afii10017" g2="afii10041" k="160" />
<hkern g1="afii10017" g2="afii10047" k="45" />
<hkern g1="afii10017" g2="afii10065" k="-23" />
<hkern g1="afii10017" g2="afii10084" k="45" />
<hkern g1="afii10017" g2="afii10085" k="23" />
<hkern g1="afii10017" g2="afii10086" k="-23" />
<hkern g1="afii10017" g2="afii10095" k="-45" />
<hkern g1="afii10018" g2="afii10017" k="45" />
<hkern g1="afii10018" g2="afii10025" k="23" />
<hkern g1="afii10018" g2="afii10032" k="23" />
<hkern g1="afii10018" g2="afii10035" k="23" />
<hkern g1="afii10018" g2="afii10036" k="92" />
<hkern g1="afii10018" g2="afii10037" k="47" />
<hkern g1="afii10018" g2="afii10038" k="23" />
<hkern g1="afii10018" g2="afii10039" k="45" />
<hkern g1="afii10018" g2="afii10041" k="92" />
<hkern g1="afii10018" g2="afii10044" k="68" />
<hkern g1="afii10018" g2="afii10047" k="23" />
<hkern g1="afii10018" g2="afii10049" k="23" />
<hkern g1="afii10018" g2="afii10077" k="23" />
<hkern g1="afii10018" g2="afii10085" k="45" />
<hkern g1="afii10019" g2="afii10017" k="68" />
<hkern g1="afii10019" g2="afii10021" k="45" />
<hkern g1="afii10019" g2="afii10024" k="45" />
<hkern g1="afii10019" g2="afii10025" k="68" />
<hkern g1="afii10019" g2="afii10029" k="23" />
<hkern g1="afii10019" g2="afii10032" k="68" />
<hkern g1="afii10019" g2="afii10035" k="68" />
<hkern g1="afii10019" g2="afii10036" k="137" />
<hkern g1="afii10019" g2="afii10037" k="68" />
<hkern g1="afii10019" g2="afii10038" k="68" />
<hkern g1="afii10019" g2="afii10039" k="90" />
<hkern g1="afii10019" g2="afii10041" k="92" />
<hkern g1="afii10019" g2="afii10044" k="115" />
<hkern g1="afii10019" g2="afii10049" k="68" />
<hkern g1="afii10019" g2="afii10069" k="23" />
<hkern g1="afii10019" g2="afii10078" k="23" />
<hkern g1="afii10019" g2="afii10084" k="68" />
<hkern g1="afii10019" g2="afii10085" k="23" />
<hkern g1="afii10019" g2="afii10087" k="23" />
<hkern g1="afii10019" g2="afii10089" k="68" />
<hkern g1="afii10019" g2="afii10097" k="23" />
<hkern g1="afii10020" g2="comma" k="250" />
<hkern g1="afii10020" g2="period" k="250" />
<hkern g1="afii10020" g2="guillemotleft" k="137" />
<hkern g1="afii10020" g2="guillemotright" k="137" />
<hkern g1="afii10020" g2="emdash" k="45" />
<hkern g1="afii10020" g2="afii10017" k="137" />
<hkern g1="afii10020" g2="afii10021" k="137" />
<hkern g1="afii10020" g2="afii10025" k="45" />
<hkern g1="afii10020" g2="afii10029" k="115" />
<hkern g1="afii10020" g2="afii10030" k="47" />
<hkern g1="afii10020" g2="afii10032" k="115" />
<hkern g1="afii10020" g2="afii10035" k="92" />
<hkern g1="afii10020" g2="afii10049" k="68" />
<hkern g1="afii10020" g2="afii10065" k="115" />
<hkern g1="afii10020" g2="afii10067" k="115" />
<hkern g1="afii10020" g2="afii10069" k="137" />
<hkern g1="afii10020" g2="afii10070" k="137" />
<hkern g1="afii10020" g2="afii10074" k="115" />
<hkern g1="afii10020" g2="afii10077" k="115" />
<hkern g1="afii10020" g2="afii10078" k="115" />
<hkern g1="afii10020" g2="afii10079" k="115" />
<hkern g1="afii10020" g2="afii10080" k="137" />
<hkern g1="afii10020" g2="afii10082" k="115" />
<hkern g1="afii10020" g2="afii10085" k="137" />
<hkern g1="afii10020" g2="afii10093" k="115" />
<hkern g1="afii10020" g2="afii10094" k="115" />
<hkern g1="afii10020" g2="afii10096" k="115" />
<hkern g1="afii10020" g2="afii10097" k="137" />
<hkern g1="afii10021" g2="afii10037" k="-23" />
<hkern g1="afii10021" g2="afii10038" k="45" />
<hkern g1="afii10021" g2="afii10041" k="70" />
<hkern g1="afii10021" g2="afii10073" k="-68" />
<hkern g1="afii10021" g2="afii10080" k="-23" />
<hkern g1="afii10021" g2="afii10085" k="-45" />
<hkern g1="afii10022" g2="afii10025" k="45" />
<hkern g1="afii10022" g2="afii10083" k="23" />
<hkern g1="afii10024" g2="afii10025" k="23" />
<hkern g1="afii10024" g2="afii10032" k="45" />
<hkern g1="afii10024" g2="afii10035" k="23" />
<hkern g1="afii10024" g2="afii10036" k="-23" />
<hkern g1="afii10024" g2="afii10037" k="-45" />
<hkern g1="afii10024" g2="afii10044" k="-45" />
<hkern g1="afii10024" g2="afii10065" k="-23" />
<hkern g1="afii10024" g2="afii10070" k="25" />
<hkern g1="afii10024" g2="afii10080" k="23" />
<hkern g1="afii10024" g2="afii10085" k="23" />
<hkern g1="afii10025" g2="afii10029" k="23" />
<hkern g1="afii10025" g2="afii10032" k="23" />
<hkern g1="afii10025" g2="afii10035" k="23" />
<hkern g1="afii10025" g2="afii10036" k="45" />
<hkern g1="afii10025" g2="afii10037" k="23" />
<hkern g1="afii10025" g2="afii10038" k="23" />
<hkern g1="afii10025" g2="afii10041" k="45" />
<hkern g1="afii10025" g2="afii10049" k="23" />
<hkern g1="afii10028" g2="afii10025" k="23" />
<hkern g1="afii10028" g2="afii10032" k="23" />
<hkern g1="afii10028" g2="afii10035" k="23" />
<hkern g1="afii10028" g2="afii10037" k="-23" />
<hkern g1="afii10028" g2="afii10038" k="70" />
<hkern g1="afii10029" g2="afii10038" k="23" />
<hkern g1="afii10029" g2="afii10066" k="-23" />
<hkern g1="afii10029" g2="afii10085" k="-23" />
<hkern g1="afii10030" g2="afii10038" k="23" />
<hkern g1="afii10030" g2="afii10041" k="23" />
<hkern g1="afii10030" g2="afii10065" k="-23" />
<hkern g1="afii10030" g2="afii10070" k="-23" />
<hkern g1="afii10030" g2="afii10080" k="-23" />
<hkern g1="afii10030" g2="afii10083" k="-23" />
<hkern g1="afii10030" g2="afii10085" k="-23" />
<hkern g1="afii10030" g2="afii10089" k="23" />
<hkern g1="afii10030" g2="afii10095" k="-23" />
<hkern g1="afii10032" g2="afii10017" k="45" />
<hkern g1="afii10032" g2="afii10021" k="45" />
<hkern g1="afii10032" g2="afii10024" k="45" />
<hkern g1="afii10032" g2="afii10029" k="23" />
<hkern g1="afii10032" g2="afii10037" k="45" />
<hkern g1="afii10032" g2="afii10039" k="92" />
<hkern g1="afii10032" g2="afii10041" k="45" />
<hkern g1="afii10032" g2="afii10049" k="45" />
<hkern g1="afii10032" g2="afii10069" k="45" />
<hkern g1="afii10032" g2="afii10077" k="23" />
<hkern g1="afii10032" g2="afii10087" k="23" />
<hkern g1="afii10034" g2="comma" k="387" />
<hkern g1="afii10034" g2="period" k="387" />
<hkern g1="afii10034" g2="colon" k="45" />
<hkern g1="afii10034" g2="semicolon" k="45" />
<hkern g1="afii10034" g2="guillemotright" k="115" />
<hkern g1="afii10034" g2="afii10017" k="137" />
<hkern g1="afii10034" g2="afii10021" k="137" />
<hkern g1="afii10034" g2="afii10024" k="23" />
<hkern g1="afii10034" g2="afii10025" k="45" />
<hkern g1="afii10034" g2="afii10029" k="115" />
<hkern g1="afii10034" g2="afii10030" k="23" />
<hkern g1="afii10034" g2="afii10032" k="45" />
<hkern g1="afii10034" g2="afii10035" k="23" />
<hkern g1="afii10034" g2="afii10036" k="92" />
<hkern g1="afii10034" g2="afii10037" k="45" />
<hkern g1="afii10034" g2="afii10038" k="23" />
<hkern g1="afii10034" g2="afii10039" k="92" />
<hkern g1="afii10034" g2="afii10049" k="45" />
<hkern g1="afii10034" g2="afii10065" k="68" />
<hkern g1="afii10034" g2="afii10069" k="160" />
<hkern g1="afii10034" g2="afii10070" k="90" />
<hkern g1="afii10034" g2="afii10080" k="90" />
<hkern g1="afii10034" g2="afii10095" k="45" />
<hkern g1="afii10034" g2="afii10097" k="68" />
<hkern g1="afii10035" g2="afii10017" k="45" />
<hkern g1="afii10035" g2="afii10021" k="45" />
<hkern g1="afii10035" g2="afii10025" k="23" />
<hkern g1="afii10035" g2="afii10029" k="68" />
<hkern g1="afii10035" g2="afii10030" k="23" />
<hkern g1="afii10035" g2="afii10032" k="45" />
<hkern g1="afii10035" g2="afii10036" k="68" />
<hkern g1="afii10035" g2="afii10037" k="68" />
<hkern g1="afii10035" g2="afii10039" k="115" />
<hkern g1="afii10035" g2="afii10041" k="68" />
<hkern g1="afii10035" g2="afii10044" k="70" />
<hkern g1="afii10035" g2="afii10047" k="23" />
<hkern g1="afii10035" g2="afii10065" k="-23" />
<hkern g1="afii10035" g2="afii10072" k="-45" />
<hkern g1="afii10035" g2="afii10089" k="23" />
<hkern g1="afii10036" g2="comma" k="227" />
<hkern g1="afii10036" g2="period" k="227" />
<hkern g1="afii10036" g2="guillemotleft" k="90" />
<hkern g1="afii10036" g2="guillemotright" k="90" />
<hkern g1="afii10036" g2="emdash" k="45" />
<hkern g1="afii10036" g2="afii10017" k="68" />
<hkern g1="afii10036" g2="afii10021" k="68" />
<hkern g1="afii10036" g2="afii10024" k="-23" />
<hkern g1="afii10036" g2="afii10025" k="23" />
<hkern g1="afii10036" g2="afii10029" k="45" />
<hkern g1="afii10036" g2="afii10032" k="92" />
<hkern g1="afii10036" g2="afii10038" k="68" />
<hkern g1="afii10036" g2="afii10049" k="45" />
<hkern g1="afii10036" g2="afii10065" k="92" />
<hkern g1="afii10036" g2="afii10067" k="90" />
<hkern g1="afii10036" g2="afii10070" k="115" />
<hkern g1="afii10036" g2="afii10074" k="90" />
<hkern g1="afii10036" g2="afii10076" k="90" />
<hkern g1="afii10036" g2="afii10077" k="92" />
<hkern g1="afii10036" g2="afii10078" k="90" />
<hkern g1="afii10036" g2="afii10080" k="160" />
<hkern g1="afii10036" g2="afii10081" k="90" />
<hkern g1="afii10036" g2="afii10082" k="115" />
<hkern g1="afii10036" g2="afii10083" k="115" />
<hkern g1="afii10036" g2="afii10085" k="115" />
<hkern g1="afii10036" g2="afii10087" k="90" />
<hkern g1="afii10036" g2="afii10091" k="90" />
<hkern g1="afii10036" g2="afii10093" k="90" />
<hkern g1="afii10036" g2="afii10094" k="90" />
<hkern g1="afii10036" g2="afii10096" k="90" />
<hkern g1="afii10036" g2="afii10097" k="115" />
<hkern g1="afii10037" g2="comma" k="272" />
<hkern g1="afii10037" g2="period" k="272" />
<hkern g1="afii10037" g2="colon" k="45" />
<hkern g1="afii10037" g2="semicolon" k="45" />
<hkern g1="afii10037" g2="guillemotleft" k="90" />
<hkern g1="afii10037" g2="guillemotright" k="92" />
<hkern g1="afii10037" g2="emdash" k="23" />
<hkern g1="afii10037" g2="afii10017" k="137" />
<hkern g1="afii10037" g2="afii10021" k="92" />
<hkern g1="afii10037" g2="afii10025" k="45" />
<hkern g1="afii10037" g2="afii10029" k="68" />
<hkern g1="afii10037" g2="afii10032" k="68" />
<hkern g1="afii10037" g2="afii10038" k="68" />
<hkern g1="afii10037" g2="afii10047" k="45" />
<hkern g1="afii10037" g2="afii10049" k="45" />
<hkern g1="afii10037" g2="afii10066" k="45" />
<hkern g1="afii10037" g2="afii10067" k="115" />
<hkern g1="afii10037" g2="afii10068" k="92" />
<hkern g1="afii10037" g2="afii10069" k="160" />
<hkern g1="afii10037" g2="afii10070" k="137" />
<hkern g1="afii10037" g2="afii10072" k="68" />
<hkern g1="afii10037" g2="afii10073" k="115" />
<hkern g1="afii10037" g2="afii10074" k="92" />
<hkern g1="afii10037" g2="afii10075" k="68" />
<hkern g1="afii10037" g2="afii10076" k="92" />
<hkern g1="afii10037" g2="afii10077" k="137" />
<hkern g1="afii10037" g2="afii10078" k="92" />
<hkern g1="afii10037" g2="afii10079" k="92" />
<hkern g1="afii10037" g2="afii10080" k="137" />
<hkern g1="afii10037" g2="afii10081" k="92" />
<hkern g1="afii10037" g2="afii10082" k="92" />
<hkern g1="afii10037" g2="afii10083" k="137" />
<hkern g1="afii10037" g2="afii10087" k="92" />
<hkern g1="afii10037" g2="afii10088" k="92" />
<hkern g1="afii10037" g2="afii10090" k="92" />
<hkern g1="afii10037" g2="afii10091" k="92" />
<hkern g1="afii10037" g2="afii10096" k="92" />
<hkern g1="afii10037" g2="afii10097" k="137" />
<hkern g1="afii10038" g2="afii10017" k="45" />
<hkern g1="afii10038" g2="afii10021" k="68" />
<hkern g1="afii10038" g2="afii10029" k="68" />
<hkern g1="afii10038" g2="afii10036" k="115" />
<hkern g1="afii10038" g2="afii10037" k="92" />
<hkern g1="afii10038" g2="afii10041" k="45" />
<hkern g1="afii10038" g2="afii10049" k="70" />
<hkern g1="afii10038" g2="afii10077" k="68" />
<hkern g1="afii10039" g2="afii10025" k="45" />
<hkern g1="afii10039" g2="afii10032" k="68" />
<hkern g1="afii10039" g2="afii10035" k="68" />
<hkern g1="afii10039" g2="afii10038" k="68" />
<hkern g1="afii10039" g2="afii10047" k="70" />
<hkern g1="afii10039" g2="afii10080" k="23" />
<hkern g1="afii10039" g2="afii10085" k="45" />
<hkern g1="afii10040" g2="afii10032" k="45" />
<hkern g1="afii10040" g2="afii10065" k="-45" />
<hkern g1="afii10043" g2="afii10065" k="-23" />
<hkern g1="afii10043" g2="afii10085" k="-45" />
<hkern g1="afii10044" g2="quoteright" k="137" />
<hkern g1="afii10044" g2="afii10049" k="68" />
<hkern g1="afii10046" g2="quoteright" k="160" />
<hkern g1="afii10046" g2="afii10017" k="45" />
<hkern g1="afii10046" g2="afii10021" k="45" />
<hkern g1="afii10046" g2="afii10024" k="68" />
<hkern g1="afii10046" g2="afii10025" k="23" />
<hkern g1="afii10046" g2="afii10029" k="70" />
<hkern g1="afii10046" g2="afii10030" k="45" />
<hkern g1="afii10046" g2="afii10032" k="45" />
<hkern g1="afii10046" g2="afii10035" k="45" />
<hkern g1="afii10046" g2="afii10036" k="205" />
<hkern g1="afii10046" g2="afii10039" k="92" />
<hkern g1="afii10046" g2="afii10041" k="160" />
<hkern g1="afii10046" g2="afii10047" k="23" />
<hkern g1="afii10046" g2="afii10049" k="92" />
<hkern g1="afii10047" g2="afii10021" k="68" />
<hkern g1="afii10047" g2="afii10024" k="25" />
<hkern g1="afii10047" g2="afii10025" k="23" />
<hkern g1="afii10047" g2="afii10029" k="68" />
<hkern g1="afii10047" g2="afii10039" k="70" />
<hkern g1="afii10047" g2="afii10049" k="45" />
<hkern g1="afii10047" g2="afii10069" k="68" />
<hkern g1="afii10047" g2="afii10072" k="-23" />
<hkern g1="afii10047" g2="afii10077" k="68" />
<hkern g1="afii10047" g2="afii10078" k="23" />
<hkern g1="afii10047" g2="afii10097" k="23" />
<hkern g1="afii10048" g2="afii10017" k="68" />
<hkern g1="afii10048" g2="afii10021" k="90" />
<hkern g1="afii10048" g2="afii10024" k="45" />
<hkern g1="afii10048" g2="afii10029" k="92" />
<hkern g1="afii10048" g2="afii10032" k="23" />
<hkern g1="afii10048" g2="afii10035" k="23" />
<hkern g1="afii10048" g2="afii10036" k="115" />
<hkern g1="afii10048" g2="afii10039" k="92" />
<hkern g1="afii10048" g2="afii10041" k="68" />
<hkern g1="afii10048" g2="afii10069" k="92" />
<hkern g1="afii10048" g2="afii10077" k="92" />
<hkern g1="afii10048" g2="afii10078" k="23" />
<hkern g1="afii10065" g2="afii10073" k="23" />
<hkern g1="afii10065" g2="afii10084" k="45" />
<hkern g1="afii10065" g2="afii10085" k="23" />
<hkern g1="afii10065" g2="afii10089" k="45" />
<hkern g1="afii10066" g2="afii10065" k="47" />
<hkern g1="afii10066" g2="afii10069" k="92" />
<hkern g1="afii10066" g2="afii10070" k="23" />
<hkern g1="afii10066" g2="afii10072" k="23" />
<hkern g1="afii10066" g2="afii10073" k="45" />
<hkern g1="afii10066" g2="afii10077" k="92" />
<hkern g1="afii10066" g2="afii10078" k="45" />
<hkern g1="afii10066" g2="afii10083" k="23" />
<hkern g1="afii10066" g2="afii10085" k="45" />
<hkern g1="afii10066" g2="afii10086" k="23" />
<hkern g1="afii10066" g2="afii10087" k="68" />
<hkern g1="afii10066" g2="afii10089" k="68" />
<hkern g1="afii10066" g2="afii10092" k="68" />
<hkern g1="afii10066" g2="afii10095" k="23" />
<hkern g1="afii10066" g2="afii10097" k="45" />
<hkern g1="afii10067" g2="afii10065" k="23" />
<hkern g1="afii10067" g2="afii10066" k="23" />
<hkern g1="afii10067" g2="afii10069" k="23" />
<hkern g1="afii10067" g2="afii10070" k="23" />
<hkern g1="afii10067" g2="afii10072" k="23" />
<hkern g1="afii10067" g2="afii10073" k="23" />
<hkern g1="afii10067" g2="afii10077" k="47" />
<hkern g1="afii10067" g2="afii10078" k="23" />
<hkern g1="afii10067" g2="afii10080" k="23" />
<hkern g1="afii10067" g2="afii10083" k="23" />
<hkern g1="afii10067" g2="afii10084" k="45" />
<hkern g1="afii10067" g2="afii10085" k="45" />
<hkern g1="afii10067" g2="afii10086" k="23" />
<hkern g1="afii10067" g2="afii10089" k="92" />
<hkern g1="afii10067" g2="afii10092" k="68" />
<hkern g1="afii10067" g2="afii10097" k="23" />
<hkern g1="afii10068" g2="comma" k="250" />
<hkern g1="afii10068" g2="period" k="250" />
<hkern g1="afii10068" g2="afii10065" k="45" />
<hkern g1="afii10068" g2="afii10069" k="92" />
<hkern g1="afii10068" g2="afii10070" k="45" />
<hkern g1="afii10068" g2="afii10073" k="23" />
<hkern g1="afii10068" g2="afii10077" k="45" />
<hkern g1="afii10068" g2="afii10080" k="45" />
<hkern g1="afii10068" g2="afii10083" k="45" />
<hkern g1="afii10068" g2="afii10097" k="23" />
<hkern g1="afii10069" g2="afii10092" k="45" />
<hkern g1="afii10069" g2="afii10095" k="-23" />
<hkern g1="afii10070" g2="afii10066" k="23" />
<hkern g1="afii10070" g2="afii10069" k="45" />
<hkern g1="afii10070" g2="afii10072" k="23" />
<hkern g1="afii10070" g2="afii10073" k="45" />
<hkern g1="afii10070" g2="afii10077" k="68" />
<hkern g1="afii10070" g2="afii10084" k="68" />
<hkern g1="afii10070" g2="afii10085" k="23" />
<hkern g1="afii10070" g2="afii10087" k="45" />
<hkern g1="afii10070" g2="afii10089" k="68" />
<hkern g1="afii10072" g2="afii10066" k="-23" />
<hkern g1="afii10072" g2="afii10085" k="-23" />
<hkern g1="afii10072" g2="afii10089" k="23" />
<hkern g1="afii10072" g2="afii10092" k="-45" />
<hkern g1="afii10073" g2="afii10066" k="23" />
<hkern g1="afii10073" g2="afii10069" k="45" />
<hkern g1="afii10073" g2="afii10070" k="23" />
<hkern g1="afii10073" g2="afii10073" k="23" />
<hkern g1="afii10073" g2="afii10077" k="23" />
<hkern g1="afii10073" g2="afii10080" k="23" />
<hkern g1="afii10073" g2="afii10083" k="23" />
<hkern g1="afii10073" g2="afii10085" k="23" />
<hkern g1="afii10073" g2="afii10086" k="23" />
<hkern g1="afii10073" g2="afii10089" k="68" />
<hkern g1="afii10073" g2="afii10092" k="45" />
<hkern g1="afii10076" g2="afii10065" k="-45" />
<hkern g1="afii10076" g2="afii10066" k="-45" />
<hkern g1="afii10076" g2="afii10070" k="-23" />
<hkern g1="afii10076" g2="afii10073" k="-23" />
<hkern g1="afii10076" g2="afii10077" k="-23" />
<hkern g1="afii10076" g2="afii10080" k="-23" />
<hkern g1="afii10076" g2="afii10083" k="-23" />
<hkern g1="afii10076" g2="afii10084" k="-23" />
<hkern g1="afii10076" g2="afii10085" k="-23" />
<hkern g1="afii10076" g2="afii10095" k="-23" />
<hkern g1="afii10077" g2="afii10080" k="-23" />
<hkern g1="afii10077" g2="afii10089" k="45" />
<hkern g1="afii10078" g2="afii10066" k="23" />
<hkern g1="afii10078" g2="afii10073" k="23" />
<hkern g1="afii10078" g2="afii10085" k="-23" />
<hkern g1="afii10080" g2="afii10069" k="45" />
<hkern g1="afii10080" g2="afii10072" k="23" />
<hkern g1="afii10080" g2="afii10073" k="23" />
<hkern g1="afii10080" g2="afii10077" k="45" />
<hkern g1="afii10080" g2="afii10084" k="45" />
<hkern g1="afii10080" g2="afii10085" k="23" />
<hkern g1="afii10080" g2="afii10087" k="23" />
<hkern g1="afii10080" g2="afii10089" k="45" />
<hkern g1="afii10082" g2="afii10069" k="47" />
<hkern g1="afii10082" g2="afii10073" k="23" />
<hkern g1="afii10082" g2="afii10077" k="70" />
<hkern g1="afii10082" g2="afii10084" k="45" />
<hkern g1="afii10082" g2="afii10085" k="23" />
<hkern g1="afii10082" g2="afii10087" k="23" />
<hkern g1="afii10082" g2="afii10089" k="45" />
<hkern g1="afii10082" g2="afii10097" k="23" />
<hkern g1="afii10083" g2="afii10072" k="-23" />
<hkern g1="afii10083" g2="afii10080" k="-23" />
<hkern g1="afii10083" g2="afii10089" k="23" />
<hkern g1="afii10083" g2="afii10095" k="-23" />
<hkern g1="afii10084" g2="comma" k="227" />
<hkern g1="afii10084" g2="period" k="227" />
<hkern g1="afii10084" g2="afii10065" k="23" />
<hkern g1="afii10084" g2="afii10069" k="68" />
<hkern g1="afii10084" g2="afii10070" k="23" />
<hkern g1="afii10084" g2="afii10072" k="-68" />
<hkern g1="afii10084" g2="afii10077" k="45" />
<hkern g1="afii10084" g2="afii10080" k="23" />
<hkern g1="afii10084" g2="afii10083" k="23" />
<hkern g1="afii10084" g2="afii10085" k="-23" />
<hkern g1="afii10085" g2="comma" k="205" />
<hkern g1="afii10085" g2="period" k="205" />
<hkern g1="afii10085" g2="guillemotright" k="-23" />
<hkern g1="afii10085" g2="afii10065" k="23" />
<hkern g1="afii10085" g2="afii10066" k="-23" />
<hkern g1="afii10085" g2="afii10069" k="68" />
<hkern g1="afii10085" g2="afii10070" k="23" />
<hkern g1="afii10085" g2="afii10072" k="-23" />
<hkern g1="afii10085" g2="afii10077" k="45" />
<hkern g1="afii10085" g2="afii10078" k="23" />
<hkern g1="afii10085" g2="afii10080" k="25" />
<hkern g1="afii10085" g2="afii10082" k="23" />
<hkern g1="afii10085" g2="afii10083" k="23" />
<hkern g1="afii10085" g2="afii10086" k="23" />
<hkern g1="afii10085" g2="afii10095" k="23" />
<hkern g1="afii10085" g2="afii10097" k="23" />
<hkern g1="afii10086" g2="afii10066" k="23" />
<hkern g1="afii10086" g2="afii10069" k="45" />
<hkern g1="afii10086" g2="afii10077" k="45" />
<hkern g1="afii10086" g2="afii10084" k="45" />
<hkern g1="afii10086" g2="afii10085" k="23" />
<hkern g1="afii10086" g2="afii10089" k="45" />
<hkern g1="afii10086" g2="afii10097" k="23" />
<hkern g1="afii10087" g2="afii10065" k="23" />
<hkern g1="afii10087" g2="afii10066" k="23" />
<hkern g1="afii10087" g2="afii10070" k="23" />
<hkern g1="afii10087" g2="afii10073" k="23" />
<hkern g1="afii10087" g2="afii10080" k="23" />
<hkern g1="afii10087" g2="afii10083" k="23" />
<hkern g1="afii10087" g2="afii10084" k="23" />
<hkern g1="afii10087" g2="afii10086" k="23" />
<hkern g1="afii10087" g2="afii10089" k="45" />
<hkern g1="afii10088" g2="afii10070" k="23" />
<hkern g1="afii10088" g2="afii10073" k="23" />
<hkern g1="afii10088" g2="afii10080" k="23" />
<hkern g1="afii10088" g2="afii10083" k="23" />
<hkern g1="afii10091" g2="afii10070" k="23" />
<hkern g1="afii10091" g2="afii10080" k="23" />
<hkern g1="afii10091" g2="afii10085" k="-23" />
<hkern g1="afii10094" g2="afii10084" k="160" />
<hkern g1="afii10094" g2="afii10089" k="137" />
<hkern g1="afii10095" g2="afii10069" k="45" />
<hkern g1="afii10095" g2="afii10070" k="-23" />
<hkern g1="afii10095" g2="afii10073" k="23" />
<hkern g1="afii10095" g2="afii10077" k="45" />
<hkern g1="afii10095" g2="afii10080" k="-23" />
<hkern g1="afii10095" g2="afii10084" k="45" />
<hkern g1="afii10095" g2="afii10087" k="23" />
<hkern g1="afii10095" g2="afii10097" k="23" />
<hkern g1="afii10096" g2="afii10069" k="45" />
<hkern g1="afii10096" g2="afii10072" k="23" />
<hkern g1="afii10096" g2="afii10077" k="45" />
<hkern g1="afii10096" g2="afii10078" k="23" />
<hkern g1="afii10096" g2="afii10084" k="45" />
<hkern g1="afii10096" g2="afii10087" k="23" />
<hkern g1="afii10096" g2="afii10089" k="45" />
<hkern g1="afii10110" g2="comma" k="205" />
<hkern g1="afii10110" g2="period" k="205" />
<hkern g1="afii10050" g2="comma" k="250" />
<hkern g1="afii10050" g2="period" k="250" />
<hkern g1="afii10050" g2="colon" k="45" />
<hkern g1="afii10050" g2="semicolon" k="45" />
<hkern g1="afii10050" g2="guillemotleft" k="160" />
<hkern g1="afii10050" g2="guillemotright" k="160" />
<hkern g1="afii10050" g2="emdash" k="45" />
<hkern g1="pi" g2="alpha" k="29" />
<hkern g1="pi" g2="sigma" k="29" />
<hkern g1="pi" g2="phi" k="29" />
<hkern g1="pi" g2="alphatonos" k="29" />
<hkern g1="pi" g2="zeta" k="29" />
<hkern g1="pi" g2="omicron" k="29" />
<hkern g1="pi" g2="sigma1" k="29" />
<hkern g1="pi" g2="omega" k="29" />
<hkern g1="pi" g2="omegatonos" k="29" />
</font>

<font horiz-adv-x="1229" ><font-face
    font-family="CourierNew-Bold"
    units-per-em="2048"
    panose-1="2 7 6 9 2 2 5 2 4 4"
    ascent="1705"
    descent="-615"
    alphabetic="0" />
<missing-glyph d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" />
<glyph unicode="!" glyph-name="exclam" d="M767 1093L710 475Q706 427 678 401T608 374Q566 374 538 400T506 475L448 1093Q444 1140 444 1155Q444 1233 491 1280T608 1328Q677 1328 724 1280T772 1159Q772 1144 767 1093ZM734 75Q734 31 701 1T610 -30Q552 -30
519 0T486 75Q486 118 518 148T610 179Q669 179 701 149T734 75Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" d="M264 1237H528L463 747Q458 709 442 694T399 679Q372 679 356 694T335 746L264 1237ZM691 1237H955L890 747Q885 709 869 694T826 679Q799 679 783 694T762 746L691 1237Z" />
<glyph unicode="#" glyph-name="numbersign" d="M917 923H965Q1039 923 1070 895T1102 820Q1102 775 1071 747T966 718H902L887 494H923Q997 494 1028 466T1060 391Q1060 346 1029 318T924 289H872L848 -63Q847 -71 833 -134Q823 -158 797 -175T742 -192Q701 -192
672 -162T642 -85Q642 -77 644 -47L668 289H515L491 -62Q487 -115 483 -125Q472 -155 446 -173T387 -192Q343 -192 314 -162T284 -85Q284 -74 286 -48L309 289H259Q185 289 154 317T122 392Q122 437 153 465T259 494H324L339 718H302Q228 718 197 746T165 821Q165
866 196 894T301 923H354L378 1275Q382 1327 387 1340Q398 1369 424 1387T483 1405Q525 1405 555 1375T585 1295Q585 1283 583 1260L560 923H712L736 1275Q740 1347 768 1376T841 1405Q884 1405 914 1375T944 1300Q944 1290 943 1283L940 1260L917 923ZM697 718H545L530
494H682L697 718Z" />
<glyph unicode="$" glyph-name="dollar" d="M717 1231Q788 1222 856 1191Q872 1200 886 1204T915 1209Q961 1209 989 1178T1018 1072V1006Q1018 932 990 901T916 869Q875 869 847 896T813 975Q741 1032 633 1032Q520 1032 468 992T415 902Q415 864 447 834Q479
804 581 783L717 754Q889 719 964 649Q1062 560 1062 414Q1062 286 973 187T717 55V-119Q717 -193 689 -224T614 -256Q569 -256 541 -225T512 -119V55Q432 72 352 108Q309 72 272 72Q223 72 195 103T166 208V337Q166 411 194 442T269 474Q306 474 331 454T367 393T398
330Q428 298 489 277T616 255Q730 255 806 314Q857 353 857 415Q857 466 823 499Q789 531 680 553L526 584Q363 616 287 701Q211 786 211 905Q211 1023 293 1115T512 1231V1287Q512 1360 540 1391T615 1423Q660 1423 688 1392T717 1287V1231Z" />
<glyph unicode="%" glyph-name="percent" d="M772 995Q772 875 688 791T483 706Q363 706 278 790T193 995Q193 1115 278 1200T483 1285Q603 1285 687 1201T772 995ZM646 995Q646 1063 598 1110T483 1158Q415 1158 368 1111T320 995Q320 928 368 880T483 832Q550
832 598 880T646 995ZM1014 690L258 445Q230 436 217 436Q194 436 176 455T158 503Q158 524 172 541Q182 554 219 566L975 811Q1003 820 1016 820Q1040 820 1057 801T1075 754Q1075 732 1061 715Q1051 702 1014 690ZM1032 259Q1032 139 947 55T742 -30Q622 -30
537 55T452 259Q452 379 537 464T742 549Q862 549 947 465T1032 259ZM905 259Q905 327 857 374T742 422Q675 422 627 375T579 259Q579 192 627 145T742 97Q809 97 857 144T905 259Z" />
<glyph unicode="&amp;" glyph-name="ampersand" d="M828 407L878 581H983Q1047 581 1071 566Q1119 535 1119 477Q1119 435 1094 407T1032 376Q1007 269 969 205Q1050 205 1073 190Q1122 160 1122 102Q1122 57 1091 29T985 0H863L839 32Q794 0 753 -12Q692 -30
605 -30Q424 -30 325 62T225 297Q225 394 274 482T426 631Q382 704 369 744T355 831Q355 955 449 1048T672 1142Q706 1142 742 1134T816 1107Q852 1123 870 1123Q912 1123 942 1093T972 1020Q972 985 956 963T889 913L803 867Q754 911 724 926Q701 937 671 937Q624
937 592 906T560 833Q560 798 619 712L828 407ZM544 459Q430 406 430 298Q430 241 469 208T605 175Q667 175 719 205L544 459Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" d="M481 1252H745L680 724Q675 682 659 667T615 651Q590 651 574 666T552 723L481 1252Z" />
<glyph unicode="(" glyph-name="parenleft" d="M541 498Q541 673 599 852Q642 984 732 1146Q797 1262 828 1288T897 1315Q941 1315 971 1285T1001 1213Q1001 1184 977 1144Q869 967 820 812T770 498Q770 338 819 183T977 -149Q1001 -188 1001 -218Q1001 -260 971
-290T897 -320Q860 -320 832 -296Q792 -261 726 -139Q631 38 596 153Q541 329 541 498Z" />
<glyph unicode=")" glyph-name="parenright" d="M702 498Q702 323 644 143Q601 11 511 -150Q446 -266 415 -293T346 -320Q302 -320 272 -290T242 -218Q242 -188 266 -149Q374 28 423 183T473 498Q473 657 424 812T266 1144Q242 1184 242 1213Q242 1255 272 1285T346
1315Q383 1315 411 1291Q451 1257 517 1134Q612 957 647 843Q702 666 702 498Z" />
<glyph unicode="*" glyph-name="asterisk" d="M447 776L270 833Q207 853 190 876Q166 905 166 941Q166 983 195 1013T262 1044Q286 1044 333 1028L510 971V1157Q510 1231 538 1262T613 1294Q659 1294 687 1263T715 1157V971L892 1028Q940 1044 962 1044Q1000 1044
1029 1014T1059 942Q1059 905 1039 880T956 833L779 776L888 625Q928 570 928 538Q928 495 898 465T826 435Q795 435 775 448T722 505L613 655L503 505Q472 461 451 448T400 434Q358 434 328 464T297 539Q297 570 337 625L447 776Z" />
<glyph unicode="+" glyph-name="plus" d="M717 480V137Q717 63 689 32T615 0Q569 0 541 31T512 137V480H219Q145 480 114 508T82 583Q82 629 113 657T219 685H512V1027Q512 1100 540 1132T615 1164Q661 1164 689 1133T718 1027L717 685H1010Q1084 685 1115 657T1147
583Q1147 537 1116 509T1010 480H717Z" />
<glyph unicode="," glyph-name="comma" d="M566 276H840L545 -280Q519 -329 480 -329Q454 -329 436 -312T417 -274Q417 -259 424 -233L566 276Z" />
<glyph unicode="-" glyph-name="hyphen" d="M1044 488H188V675H1044V488Z" />
<glyph unicode="." glyph-name="period" d="M771 103Q771 45 730 6T617 -33Q545 -33 504 6T463 103Q463 161 504 200T617 239Q689 239 730 200T771 103Z" />
<glyph unicode="/" glyph-name="slash" d="M1037 1270L380 -146Q355 -199 335 -215Q309 -236 272 -236Q230 -236 200 -206T169 -138Q169 -111 193 -59L852 1356Q877 1409 896 1425Q923 1446 959 1446Q1001 1446 1031 1417T1061 1349Q1061 1322 1037 1270Z" />
<glyph unicode="0" glyph-name="zero" d="M1062 761V536Q1062 336 947 153T616 -30Q492 -30 407 24T245 225T168 536V761Q168 960 283 1143T613 1327Q736 1327 821 1273T984 1073T1062 761ZM856 761Q856 928 763 1053Q710 1122 614 1122Q521 1122 462 1046Q373
931 373 761V536Q373 368 467 244Q519 175 616 175Q708 175 767 251Q856 366 856 536V761Z" />
<glyph unicode="1" glyph-name="one" d="M719 1327V205H926Q1000 205 1031 177T1063 102Q1063 57 1032 29T926 0H307Q233 0 202 28T170 103Q170 148 201 176T307 205H514V1060L331 1012Q287 1000 265 1000Q226 1000 198 1031T169 1107Q169 1148 190 1171T278 1213L719
1327Z" />
<glyph unicode="2" glyph-name="two" d="M423 205H872Q909 235 942 235Q989 235 1016 204T1044 98V0H110V217Q664 674 779 805Q837 872 837 932Q837 1007 772 1064T597 1122Q487 1122 414 1058Q376 1024 353 957Q339 915 315 897T254 879Q212 879 182 909T151
979Q151 1039 206 1129T368 1273T600 1327Q794 1327 918 1210T1042 925Q1042 840 1007 768T836 567Q730 466 423 205Z" />
<glyph unicode="3" glyph-name="three" d="M907 685Q998 623 1043 542T1088 359Q1088 250 1029 158T856 18T560 -30Q322 -30 202 44Q135 86 135 144Q135 188 164 218T236 249Q265 249 296 229Q340 199 379 189Q439 175 544 175Q723 175 803 221T883 353Q883 416
837 474T712 565Q667 583 560 590Q509 593 482 621T454 692Q454 736 484 766T560 796Q662 796 669 797Q709 801 749 823T813 883T838 963Q838 1028 781 1075T608 1123Q460 1123 382 1037Q359 1012 345 1005Q324 994 298 994Q256 994 226 1024T196 1098Q196 1167
288 1232Q422 1327 623 1327Q813 1327 928 1219T1043 959Q1043 880 1009 812T907 685Z" />
<glyph unicode="4" glyph-name="four" d="M915 1294V492Q980 492 1011 464T1042 390Q1042 345 1011 316T915 287V205Q980 205 1011 176T1042 102Q1042 57 1011 29T905 0H630Q556 0 525 28T493 103Q493 148 524 176T630 205H710V287H153V458L644 1294H915ZM710
492V996L413 492H710Z" />
<glyph unicode="5" glyph-name="five" d="M442 1089V845Q556 881 649 881Q838 881 963 752T1088 419Q1088 209 962 90T574 -30Q344 -30 210 57Q132 107 132 172Q132 213 162 243T235 274Q270 274 311 241T397 194Q461 175 561 175Q747 175 815 234T883 417Q883
538 818 607T649 676Q538 676 396 604Q364 587 340 587Q296 587 267 619T237 702V1294H864Q938 1294 969 1266T1001 1191Q1001 1146 970 1118T864 1089H442Z" />
<glyph unicode="6" glyph-name="six" d="M422 700Q496 762 563 790T706 819Q867 819 988 691T1109 370Q1109 191 997 81T691 -30Q530 -30 426 45T269 276T216 624Q216 854 321 1006T568 1243T868 1327Q993 1327 1062 1278Q1107 1245 1107 1194Q1107 1149 1077
1119T1005 1088Q981 1088 936 1112Q909 1126 884 1126Q786 1126 681 1071T499 900Q446 820 422 700ZM452 383Q484 263 538 219T694 175Q795 175 849 228T904 372Q904 476 842 545T701 614Q639 614 569 553T452 383Z" />
<glyph unicode="7" glyph-name="seven" d="M826 1089H357Q353 1029 326 1003T255 976Q209 976 181 1007T152 1112V1294H1042V1089L710 101Q689 39 664 19T602 -2Q559 -2 529 28T498 97Q498 119 514 167L826 1089Z" />
<glyph unicode="8" glyph-name="eight" d="M905 655Q984 594 1023 517T1063 346Q1063 243 1013 157T854 20T614 -30Q482 -30 376 20T220 157T169 346Q169 439 208 516T327 655Q258 719 223 791T188 943Q188 1100 308 1213T616 1327Q804 1327 924 1214T1044 943Q1044
862 1010 790T905 655ZM834 939Q834 1015 775 1068T614 1122Q512 1122 453 1069T393 939Q393 862 452 809T614 755Q715 755 774 808T834 939ZM858 336Q858 417 789 482T616 548Q513 548 444 483T374 334Q374 270 434 223T616 175Q739 175 798 222T858 336Z" />
<glyph unicode="9" glyph-name="nine" d="M903 538Q826 472 762 445T627 417Q462 417 339 549T215 877Q215 1030 300 1155Q416 1327 627 1327Q778 1327 891 1237T1057 976T1110 620Q1110 306 867 116Q679 -30 455 -30Q331 -30 263 20Q217 53 217 107Q217 151 246
180T319 210Q343 210 373 195Q412 175 455 175Q610 175 741 280T903 538ZM874 861Q841 1003 777 1062T629 1122Q542 1122 481 1056T420 879Q420 764 481 693T622 622Q761 622 874 861Z" />
<glyph unicode=":" glyph-name="colon" d="M769 771Q769 713 728 674T615 635Q543 635 502 674T461 771Q461 829 502 868T615 907Q687 907 728 868T769 771ZM771 100Q771 42 730 3T617 -36Q545 -36 504 3T463 100Q463 158 504 197T617 236Q689 236 730 197T771 100Z" />
<glyph unicode=";" glyph-name="semicolon" d="M864 766Q864 708 823 669T710 630Q639 630 598 669T557 767Q557 824 597 863T710 903Q782 903 823 864T864 766ZM547 299H808L519 -170Q491 -217 464 -217Q439 -217 422 -202T404 -170Q404 -157 411 -135L547 299Z" />
<glyph unicode="&lt;" glyph-name="less" d="M400 584L1064 216Q1114 188 1130 166T1147 110Q1147 67 1116 36T1044 4Q1017 4 963 34L-26 584L963 1134Q1017 1163 1043 1163Q1085 1163 1116 1132T1147 1058Q1147 1024 1131 1002T1064 952L400 584Z" />
<glyph unicode="=" glyph-name="equal" d="M1054 674H178Q104 674 73 702T41 777Q41 822 72 850T178 879H1054Q1128 879 1159 851T1191 776Q1191 731 1160 703T1054 674ZM1054 288H178Q104 288 73 316T41 390Q41 436 72 464T178 493H1054Q1128 493 1159 465T1191
390Q1191 344 1160 316T1054 288Z" />
<glyph unicode="&gt;" glyph-name="greater" d="M831 584L167 952Q117 980 101 1002T84 1058Q84 1101 115 1132T188 1163Q214 1163 268 1134L1257 584L268 34Q214 4 188 4Q146 4 115 35T84 110Q84 144 100 166T167 216L831 584Z" />
<glyph unicode="?" glyph-name="question" d="M719 473Q713 415 686 389T616 362Q571 362 543 393T514 499V614Q757 707 807 757T857 859Q857 932 799 985T633 1038Q520 1038 415 986V956Q415 883 387 852T312 820Q267 820 239 851T210 956V1121Q367 1195 454
1219T634 1243Q828 1243 945 1131T1062 850Q1062 730 992 646T719 473ZM762 77Q762 30 729 1T617 -29Q539 -29 506 0T472 77Q472 124 505 153T617 183Q695 183 728 154T762 77Z" />
<glyph unicode="@" glyph-name="at" d="M824 894V957Q824 1056 767 1116T619 1176Q547 1176 484 1129T388 1006Q331 873 331 740V436Q331 205 435 69Q503 -20 625 -20Q690 -20 744 -3T829 44T884 74Q917 74 939 52T961 -4Q961 -54 892 -102Q792 -170 619 -170Q487
-170 401 -110Q290 -32 235 120T180 422V751Q180 991 299 1159T616 1327Q705 1327 784 1290T919 1161T975 957V410Q1019 390 1019 343Q1019 308 995 287T914 265H824V271Q777 264 755 264Q635 264 546 353T456 562Q456 690 554 786T824 894ZM824 739Q718 729 662
678T606 560Q606 503 652 461T775 419Q790 419 824 422V739Z" />
<glyph unicode="A" glyph-name="A" d="M865 330H367L317 205H367Q441 205 472 177T504 102Q504 57 473 29T367 0H91Q17 0 -14 28T-46 103Q-46 149 -13 178T96 205L418 1007H284Q210 1007 179 1035T147 1110Q147 1156 178 1184T284 1213L727 1212L1135 205Q1207
205 1230 189Q1276 156 1276 102Q1276 57 1245 29T1140 0H864Q790 0 759 28T727 103Q727 148 758 176T864 205H914L865 330ZM780 535L615 941L449 535H780Z" />
<glyph unicode="B" glyph-name="B" d="M196 205V1007H164Q90 1007 59 1035T27 1110Q27 1156 58 1184T164 1213H678Q862 1213 974 1111T1086 867Q1086 800 1060 741T981 632Q1078 574 1126 497T1175 321Q1175 243 1140 176Q1114 125 1076 95Q1025 53 951 27T766
0H164Q90 0 59 28T27 103Q27 148 59 176T164 205H196ZM401 709H626Q747 709 827 770Q881 811 881 872Q881 926 830 966T668 1007H401V709ZM401 205H755Q880 205 931 242Q970 270 970 322Q970 384 893 444T672 504H401V205Z" />
<glyph unicode="C" glyph-name="C" d="M936 1160Q955 1186 977 1199T1026 1212Q1071 1212 1099 1181T1128 1076V902Q1128 828 1100 797T1026 765Q985 765 960 788Q935 811 923 874Q916 916 895 939Q854 984 781 1011T633 1038Q541 1038 464 998T328 868T269 654V521Q269
373 376 274T675 175Q789 175 868 206Q914 224 966 277Q998 309 1016 318T1057 328Q1098 328 1129 297T1160 224Q1160 182 1118 134Q1057 64 961 24Q832 -30 676 -30Q494 -30 348 45Q230 105 147 234T64 517V656Q64 816 138 954T345 1168T625 1243Q714 1243 791
1223T936 1160Z" />
<glyph unicode="D" glyph-name="D" d="M156 205V1007Q91 1008 60 1036T29 1110Q29 1156 60 1184T166 1213L595 1212Q695 1212 790 1175T944 1081Q988 1038 1035 963T1107 814T1131 633V535Q1131 405 1087 305T972 141T837 47Q737 0 578 0H166Q92 0 61 28T29 103Q29
148 60 177T156 205ZM361 205H579Q701 205 763 240Q844 286 885 357T926 541V638Q926 735 889 808Q831 922 759 964T577 1007H361V205Z" />
<glyph unicode="E" glyph-name="E" d="M404 506V205H927V316Q927 390 955 421T1030 453Q1075 453 1103 422T1132 316V0H167Q93 0 62 28T30 103Q30 148 62 176T167 205H199V1007H167Q93 1007 62 1035T30 1110Q30 1156 61 1184T167 1213L1087 1212V900Q1087 827
1059 796T985 764Q939 764 911 795T882 900V1007H404V711H584Q584 791 599 814Q630 863 687 863Q732 863 760 832T789 726V490Q789 423 773 400Q741 353 687 353Q630 353 599 402Q584 425 584 506H404Z" />
<glyph unicode="F" glyph-name="F" d="M474 505V205H684Q758 205 789 177T821 102Q821 57 790 29T684 0H237Q163 0 132 28T100 103Q100 148 132 176T237 205H269V1007H237Q163 1007 132 1035T100 1110Q100 1156 131 1184T237 1213L1202 1212V899Q1202 826 1174
795T1099 763Q1054 763 1026 794T997 899V1007H474V710H654Q654 790 669 813Q700 862 757 862Q802 862 830 831T859 725V489Q859 415 831 384T756 352Q700 352 669 401Q654 424 654 505H474Z" />
<glyph unicode="G" glyph-name="G" d="M1131 375V100Q992 25 895 -2T684 -30Q527 -30 393 17Q288 53 228 108T116 270T65 511V659Q65 864 190 1025Q358 1243 647 1243Q731 1243 806 1226T950 1175Q991 1212 1030 1212Q1075 1212 1103 1181T1131 1076V943Q1131
869 1103 838T1029 806Q993 806 967 828Q947 843 934 894T903 964Q876 993 808 1015T654 1038Q532 1038 442 988Q378 951 324 859T270 659V511Q270 346 365 261T669 175Q810 175 926 228V375H717Q643 375 612 403T580 478Q580 524 611 552T717 581L1081 580Q1155
580 1186 552T1218 478Q1218 442 1197 415T1131 375Z" />
<glyph unicode="H" glyph-name="H" d="M839 502H401V205H433Q507 205 538 177T570 102Q570 57 539 29T433 0H182Q108 0 77 28T45 103Q45 159 94 190Q118 206 196 205V1007Q142 1012 115 1040T87 1110Q87 1156 118 1184T224 1213L433 1212Q507 1212 538 1184T570
1110Q570 1064 539 1036T433 1007H401V707H839V1007H807Q733 1007 702 1035T670 1110Q670 1156 701 1184T807 1213L1016 1212Q1090 1212 1121 1184T1153 1110Q1153 1068 1126 1040T1044 1007V205Q1123 205 1146 190Q1195 159 1195 102Q1195 57 1164 29T1058 0H807Q733
0 702 28T670 103Q670 148 702 176T807 205H839V502Z" />
<glyph unicode="I" glyph-name="I" d="M717 1007V205H924Q998 205 1029 177T1061 102Q1061 57 1030 29T924 0H305Q231 0 200 28T168 103Q168 148 199 176T305 205H512V1007H305Q231 1007 200 1035T168 1110Q168 1156 199 1184T305 1213L924 1212Q998 1212 1029
1184T1061 1110Q1061 1064 1030 1036T924 1007H717Z" />
<glyph unicode="J" glyph-name="J" d="M1000 1007V387Q1000 270 961 201Q901 94 788 32T549 -30Q388 -30 110 106V443Q110 517 138 548T213 580Q258 580 286 549T315 443V242Q456 175 556 175Q609 175 666 199T752 258T790 325Q795 343 795 411V1007H546Q472 1007
441 1035T409 1110Q409 1156 440 1184T546 1213L1120 1212Q1194 1212 1225 1184T1257 1110Q1257 1064 1226 1036T1120 1007H1000Z" />
<glyph unicode="K" glyph-name="K" d="M401 432V205H475Q549 205 580 177T612 102Q612 57 581 29T475 0H164Q90 0 59 28T27 103Q27 148 59 176T164 205H196V1007H164Q90 1007 59 1035T27 1110Q27 1156 58 1184T164 1213L475 1212Q549 1212 580 1184T612 1110Q612
1064 581 1036T475 1007H401V703L765 1016Q733 1039 721 1059T709 1108Q709 1155 740 1184T846 1213L1055 1212Q1129 1212 1160 1184T1192 1110Q1192 1065 1161 1036T1062 1007L694 685Q797 626 887 505T1048 205H1103Q1176 205 1207 177T1239 102Q1239 57 1208
29T1103 0H917Q853 153 777 292Q715 405 660 456T527 539L401 432Z" />
<glyph unicode="L" glyph-name="L" d="M529 1007V205H971V399Q971 473 999 504T1074 536Q1119 536 1147 505T1176 399V0H205Q131 0 100 28T68 103Q68 148 99 176T205 205H324V1007H205Q131 1007 100 1035T68 1110Q68 1156 99 1184T205 1213L649 1212Q723 1212
754 1184T786 1110Q786 1064 755 1036T649 1007H529Z" />
<glyph unicode="M" glyph-name="M" d="M294 816V205H368Q442 205 473 177T505 102Q505 57 474 29T368 0H99Q25 0 -6 28T-38 103Q-38 148 -7 176T89 205V1007Q35 1012 8 1040T-20 1110Q-20 1156 11 1184T117 1213L342 1212L621 595L895 1213L1122 1212Q1196 1212
1227 1184T1259 1110Q1259 1068 1231 1040T1150 1007V205Q1215 205 1246 176T1277 102Q1277 57 1246 29T1140 0H870Q797 0 766 28T734 103Q734 148 765 176T870 205H945V816L710 288H532L294 816Z" />
<glyph unicode="N" glyph-name="N" d="M358 825V205H432Q506 205 537 177T569 102Q569 57 538 29T432 0H163Q89 0 58 28T26 103Q26 147 57 176T153 205V1007H121Q47 1007 16 1035T-16 1110Q-16 1156 15 1184T121 1213L358 1212L882 390V1007H808Q734 1007 703
1035T671 1110Q671 1156 702 1184T808 1213L1077 1212Q1151 1212 1182 1184T1214 1110Q1214 1065 1183 1036T1088 1007V0H885L358 825Z" />
<glyph unicode="O" glyph-name="O" d="M1190 606Q1190 333 1017 152T615 -30Q410 -30 245 121Q41 308 41 606Q41 904 245 1092Q410 1243 615 1243Q843 1243 1016 1062T1190 606ZM985 606Q985 793 872 915T615 1038Q472 1038 359 915T246 606Q246 420 359 298T615
175Q759 175 872 297T985 606Z" />
<glyph unicode="P" glyph-name="P" d="M496 416V205H703Q777 205 808 177T840 102Q840 57 809 29T703 0H259Q185 0 154 28T122 103Q122 148 154 176T259 205H291V1007H259Q185 1007 154 1035T122 1110Q122 1156 153 1184T259 1213L731 1212Q939 1212 1060 1099T1182
822Q1182 732 1141 652Q1110 592 1038 534T890 446T690 416H496ZM496 621H686Q820 621 898 681T977 827Q977 899 914 953T732 1007H496V621Z" />
<glyph unicode="Q" glyph-name="Q" d="M662 -28L656 -37Q762 -37 855 -80Q893 -98 918 -98Q954 -98 1006 -64T1088 -30Q1131 -30 1160 -59T1190 -133Q1190 -186 1135 -225Q1026 -303 916 -303Q860 -303 803 -281Q711 -245 657 -245Q570 -245 392 -290Q355 -299
334 -299Q295 -299 266 -269T236 -192Q236 -152 276 -113L407 14Q245 84 143 242T40 606Q40 904 245 1092Q409 1243 614 1243Q820 1243 984 1092Q1189 904 1189 606Q1189 350 1034 172T662 -28ZM984 606Q984 793 871 915T614 1038Q471 1038 358 915T245 606Q245
420 358 298T614 175Q758 175 871 297T984 606Z" />
<glyph unicode="R" glyph-name="R" d="M403 463V205H477Q551 205 582 177T614 102Q614 57 583 29T477 0H166Q92 0 61 28T29 103Q29 148 61 176T166 205H198V1007H166Q92 1007 61 1035T29 1110Q29 1156 60 1184T166 1213L630 1212Q847 1212 966 1105T1086 843Q1086
747 1030 669T861 529Q926 472 1000 383Q1046 326 1124 205Q1202 205 1227 189Q1272 158 1272 102Q1272 57 1241 29T1136 0H1019Q770 385 606 463H403ZM403 668H563Q652 668 722 695Q816 731 848 771T881 850Q881 908 819 957T638 1007H403V668Z" />
<glyph unicode="S" glyph-name="S" d="M315 52Q288 20 272 11T231 2Q184 2 156 33T127 138V276Q127 350 155 381T231 413Q267 413 291 394T329 331T356 270Q385 239 459 207T621 175Q758 175 846 239Q902 278 902 335Q902 373 875 406T787 462Q747 477 608 503Q440
534 354 578T218 702T168 875Q168 1022 291 1132T611 1243Q690 1243 757 1226T880 1172Q920 1211 960 1211Q1005 1211 1033 1180T1062 1075V921Q1062 847 1034 816T960 784Q922 784 894 807Q872 824 861 875T833 948Q804 986 746 1012T612 1038Q501 1038 437 987T372
879Q372 841 398 806T476 750Q510 736 667 705T909 637T1050 521T1106 333Q1106 181 999 90Q857 -30 637 -30Q552 -30 472 -10T315 52Z" />
<glyph unicode="T" glyph-name="T" d="M714 1007V205H852Q926 205 957 177T989 102Q989 57 958 29T852 0H372Q298 0 267 28T235 103Q235 148 266 176T372 205H509V1007H287V813Q287 739 259 708T184 676Q139 676 111 707T82 813V1213L1144 1212V813Q1144 739 1116
708T1041 676Q996 676 968 707T939 813V1007H714Z" />
<glyph unicode="U" glyph-name="U" d="M1083 1007V426Q1083 236 947 103T618 -30Q523 -30 440 3T290 102T186 237T149 426V1007Q84 1007 53 1036T22 1110Q22 1156 53 1184T159 1212L428 1213Q502 1213 533 1185T565 1110Q565 1064 534 1036T428 1007H354V408Q354
316 430 246T615 175Q687 175 750 209T853 308Q878 349 878 408V1007H804Q730 1007 699 1035T667 1110Q667 1156 698 1184T804 1213L1073 1212Q1147 1212 1178 1184T1210 1110Q1210 1065 1179 1036T1083 1007Z" />
<glyph unicode="V" glyph-name="V" d="M614 299L911 1007H864Q790 1007 759 1035T727 1110Q727 1156 758 1184T864 1213L1139 1212Q1213 1212 1244 1184T1276 1110Q1276 1055 1228 1023Q1205 1007 1134 1007L713 0H516L96 1007Q24 1007 1 1023Q-47 1054 -47 1110Q-47
1156 -16 1184T90 1213L367 1212Q440 1212 471 1184T503 1110Q503 1064 472 1036T367 1007H319L614 299Z" />
<glyph unicode="W" glyph-name="W" d="M615 582L425 0H195L73 1007Q26 1013 2 1039T-22 1107Q-22 1155 9 1184T115 1213L388 1212Q462 1212 493 1184T525 1110Q525 1064 494 1036T388 1007H281L349 434L510 911H723L883 434L951 1007H844Q770 1007 739 1035T707
1110Q707 1156 738 1184T844 1213L1116 1212Q1190 1212 1221 1184T1253 1110Q1253 1071 1228 1043T1156 1007L1038 0H812L615 582Z" />
<glyph unicode="X" glyph-name="X" d="M749 618L1091 205Q1152 204 1182 176T1213 102Q1213 57 1182 29T1076 0H845Q772 0 741 28T709 103Q709 146 738 174T825 205L619 459L411 205Q468 203 497 174T526 102Q526 57 495 29T389 0H159Q85 0 54 28T22 103Q22 147
53 176T144 205L484 620L160 1007Q100 1009 71 1037T41 1110Q41 1156 72 1184T178 1213L367 1212Q441 1212 472 1184T504 1110Q504 1076 484 1048Q471 1031 426 1007L617 778L804 1007Q759 1031 746 1048Q726 1076 726 1110Q726 1155 757 1184T863 1213L1051 1212Q1125
1212 1156 1184T1188 1110Q1188 1066 1158 1037T1069 1007L749 618Z" />
<glyph unicode="Y" glyph-name="Y" d="M718 509V205H856Q930 205 961 177T993 102Q993 57 962 29T856 0H375Q302 0 271 28T239 103Q239 148 270 176T375 205H513V509L174 1007Q106 1007 75 1036T43 1110Q43 1156 74 1184T180 1213L366 1212Q440 1212 471 1184T503
1110Q503 1041 422 1007L616 721L806 1007Q761 1024 742 1050T723 1110Q723 1156 754 1184T860 1213L1053 1212Q1127 1212 1158 1184T1190 1110Q1190 1064 1158 1036T1054 1007L718 509Z" />
<glyph unicode="Z" glyph-name="Z" d="M413 205H878V357Q878 431 906 462T981 494Q1027 494 1055 463T1084 357L1083 0H151V205L776 1007H398V860Q398 786 370 755T296 723Q250 723 222 754T193 860V1213L1041 1212V1012L413 205Z" />
<glyph unicode="[" glyph-name="bracketleft" d="M715 1089V-115H839Q913 -115 944 -143T976 -217Q976 -263 945 -291T839 -320H510V1294H838Q912 1294 943 1266T975 1191Q975 1146 944 1118T838 1089H715Z" />
<glyph unicode="\" glyph-name="backslash" d="M380 1356L1038 -54Q1043 -65 1055 -105Q1061 -128 1061 -140Q1061 -176 1033 -203T962 -230Q923 -230 900 -212T852 -142L195 1269Q170 1322 170 1348Q170 1386 200 1416T272 1446Q309 1446 332 1428T380 1356Z" />
<glyph unicode="]" glyph-name="bracketright" d="M514 -115V1089H390Q316 1089 285 1117T253 1191Q253 1237 284 1265T390 1294H719V-320H391Q317 -320 286 -292T254 -217Q254 -172 285 -144T391 -115H514Z" />
<glyph unicode="^" glyph-name="asciicircum" d="M612 1031L371 741Q338 701 318 689T271 677Q228 677 198 707T167 782Q167 817 212 872L612 1355L1015 872Q1044 837 1052 819T1061 781Q1061 738 1031 708T958 677Q930 677 910 689T857 740L612 1031Z" />
<glyph unicode="_" glyph-name="underscore" d="M1182 -615H56Q-18 -615 -49 -587T-81 -513Q-81 -467 -50 -439T56 -410H1182Q1255 -410 1286 -438T1318 -513Q1318 -558 1287 -586T1182 -615Z" />
<glyph unicode="`" glyph-name="grave" d="M544 1340L769 1157Q810 1125 810 1093Q810 1065 791 1046T743 1027Q720 1027 686 1054L460 1237Q420 1269 420 1301Q420 1329 439 1348T487 1367Q510 1367 544 1340Z" />
<glyph unicode="a" glyph-name="a" d="M799 0V48Q722 7 629 -13T460 -34Q295 -34 192 53T89 247Q89 376 220 486T584 597Q677 597 799 577V626Q799 672 760 701T609 730Q518 730 373 694Q319 681 289 681Q248 681 220 710T191 786Q191 812 201 831T229 861T304
889Q380 910 459 922T602 935Q793 935 898 853T1004 627V205H1039Q1113 205 1144 177T1176 102Q1176 57 1145 29T1039 0H799ZM799 367Q676 391 572 391Q447 391 357 330Q301 291 301 251Q301 222 328 204Q378 171 465 171Q539 171 632 200T799 279V367Z" />
<glyph unicode="b" glyph-name="b" d="M356 1297V837Q431 886 508 910T665 935Q878 935 1026 788T1174 433Q1174 234 1033 101T661 -33Q579 -33 503 -12T356 50V0H116Q42 0 11 28T-21 103Q-21 148 11 176T116 205H151V1092H116Q42 1092 11 1120T-21 1195Q-21 1240
10 1268T116 1297H356ZM969 427Q969 554 880 642T662 730Q534 730 445 642T356 430Q356 317 436 245T662 172Q808 172 888 244T969 427Z" />
<glyph unicode="c" glyph-name="c" d="M934 871Q971 906 1010 906Q1054 906 1082 875T1111 770V638Q1111 564 1083 533T1008 502Q966 502 937 526Q916 544 904 599T846 682Q765 730 639 730Q494 730 407 645T319 430Q319 310 403 241T682 171Q810 171 891 197Q939
213 982 251T1060 290Q1102 290 1132 259T1163 186Q1163 118 1070 57Q932 -34 666 -34Q427 -34 294 65Q114 198 114 429Q114 648 260 791T641 935Q726 935 799 919T934 871Z" />
<glyph unicode="d" glyph-name="d" d="M1085 1297V205H1120Q1193 205 1225 177T1257 102Q1257 57 1226 29T1120 0H880V50Q810 9 734 -12T575 -33Q344 -33 203 100T62 433Q62 641 210 788T571 935Q651 935 728 911T880 837V1092H845Q771 1092 740 1120T708 1194Q708
1240 739 1268T845 1297H1085ZM880 427Q880 554 791 642T573 730Q445 730 356 642T267 430Q267 317 347 245T573 172Q718 172 799 244T880 427Z" />
<glyph unicode="e" glyph-name="e" d="M1129 350H288Q320 270 401 221T622 172Q736 172 925 221Q1003 241 1033 241Q1074 241 1102 212T1130 139Q1130 99 1100 71Q1060 34 905 1T607 -33Q361 -33 214 106T66 448Q66 664 225 799T593 935Q718 935 822 891T978 796Q1050
722 1097 613Q1129 537 1129 437V350ZM902 555Q855 643 779 686T598 730Q494 730 418 687T294 555H902Z" />
<glyph unicode="f" glyph-name="f" d="M613 703V205H905Q979 205 1010 177T1042 102Q1042 57 1011 29T905 0H286Q212 0 181 28T149 103Q149 148 180 176T286 205H408V703H310Q236 703 205 731T173 806Q173 851 204 879T310 908H408V986Q408 1120 508 1208T800
1297Q885 1297 996 1282T1139 1238T1171 1166Q1171 1119 1143 1090T1074 1060Q1055 1060 1017 1067Q890 1092 792 1092Q690 1092 652 1062T613 986V908H929Q1003 908 1034 880T1066 805Q1066 760 1035 732T929 703H613Z" />
<glyph unicode="g" glyph-name="g" d="M840 847V908H1080Q1154 908 1185 880T1217 805Q1217 760 1186 732T1080 703H1045V-43Q1045 -151 1000 -231T860 -370T648 -428H416Q342 -428 311 -400T279 -326Q279 -280 310 -252T416 -223H642Q736 -223 788 -172T840 -43V57Q772
13 702 -9T557 -31Q348 -31 207 108T66 453Q66 659 207 798T557 938Q635 938 705 916T840 847ZM839 454Q839 567 756 650T555 733Q438 733 355 650T271 454Q271 340 354 258T555 175Q672 175 755 257T839 454Z" />
<glyph unicode="h" glyph-name="h" d="M403 1297V860Q467 898 532 916T665 935Q771 935 854 899T991 786T1046 590V205Q1124 205 1148 190Q1196 159 1196 102Q1196 57 1165 29T1060 0H826Q753 0 722 28T690 103Q690 159 738 190Q763 206 840 205V576Q840 655 804
687Q757 730 665 730Q597 730 545 704T403 589V205Q482 205 505 190Q554 159 554 102Q554 57 523 29T417 0H184Q110 0 79 28T47 103Q47 159 96 190Q120 206 198 205V1092H163Q89 1092 58 1120T26 1195Q26 1240 57 1268T163 1297H403Z" />
<glyph unicode="i" glyph-name="i" d="M688 1297V1080H444V1297H688ZM716 908V205H962Q1036 205 1067 177T1099 102Q1099 57 1068 29T962 0H265Q191 0 160 28T128 103Q128 148 159 176T265 205H511V703H346Q273 703 241 731T209 806Q209 851 240 879T346 908H716Z" />
<glyph unicode="j" glyph-name="j" d="M821 1297V1080H576V1297H821ZM737 703H319Q245 703 214 731T182 806Q182 851 213 879T319 908H942V-43Q942 -151 897 -231T757 -370T545 -428H313Q239 -428 208 -400T176 -326Q176 -280 207 -252T313 -223H539Q633 -223
685 -172T737 -43V703Z" />
<glyph unicode="k" glyph-name="k" d="M446 341V0H206Q132 0 101 28T69 103Q69 148 101 176T206 205H241V1092H206Q132 1092 101 1120T69 1195Q69 1240 100 1268T206 1297H446V606L606 735Q581 778 581 805Q581 851 612 879T717 908H951Q1025 908 1056 880T1088
805Q1088 760 1057 732T951 703H894L645 501L980 205H1040Q1114 205 1145 177T1177 102Q1177 57 1146 29T1040 0H804Q730 0 699 28T667 103Q667 142 701 180L484 372L446 341Z" />
<glyph unicode="l" glyph-name="l" d="M717 1297V205H963Q1037 205 1068 177T1100 102Q1100 57 1069 29T963 0H266Q192 0 161 28T129 103Q129 148 160 176T266 205H512V1092H347Q274 1092 242 1120T210 1195Q210 1240 241 1268T347 1297H717Z" />
<glyph unicode="m" glyph-name="m" d="M298 908V850Q348 899 388 917T482 936Q527 936 571 914T657 848Q710 892 764 913T876 935Q990 935 1061 874Q1155 794 1155 664V205Q1219 205 1250 176T1281 102Q1281 57 1250 29T1145 0H950V647Q950 694 933 712T881 730Q847
730 818 712Q781 687 728 618V205Q792 205 823 176T854 102Q854 57 823 29T718 0H523V647Q523 693 506 711T453 730Q417 730 382 708T298 618V205Q362 205 393 176T425 102Q425 57 394 29T288 0H103Q29 0 -2 28T-34 103Q-34 148 -3 176T93 205V703Q28 703 -3 732T-34
806Q-34 851 -3 879T103 908H298Z" />
<glyph unicode="n" glyph-name="n" d="M407 908V839Q463 887 530 911T677 935Q859 935 965 822Q1049 732 1049 586V205Q1114 205 1145 177T1176 102Q1176 57 1145 29T1039 0H854Q780 0 749 28T717 103Q717 148 748 176T844 205V592Q844 659 808 690Q761 730 667
730Q596 730 543 703T407 586V205Q486 205 509 190Q558 160 558 102Q558 57 527 29T421 0H188Q114 0 83 28T51 103Q51 159 99 190Q123 205 202 205V703Q137 703 106 732T75 806Q75 851 106 879T212 908H407Z" />
<glyph unicode="o" glyph-name="o" d="M1147 437Q1147 319 1082 209T887 33T616 -33Q476 -33 348 31T153 207T86 439Q86 562 154 680T349 867T616 935Q756 935 885 866T1081 679T1147 437ZM942 436Q942 535 871 618Q774 730 616 730Q477 730 384 641T291 435Q291
339 385 256T616 172Q754 172 848 255T942 436Z" />
<glyph unicode="p" glyph-name="p" d="M360 113V-223H483Q557 -223 588 -251T620 -326Q620 -371 589 -399T483 -428H120Q46 -428 15 -400T-17 -326Q-17 -280 15 -252T120 -223H155V703H120Q46 703 15 731T-17 806Q-17 851 14 879T120 908H360V838Q432 887 509
911T667 935Q877 935 1025 793T1173 466Q1173 263 998 131Q852 21 669 21Q590 21 513 44T360 113ZM968 465Q968 508 934 574T830 685T664 730Q511 730 421 615Q360 536 360 463Q360 381 447 304T664 226Q794 226 881 303T968 465Z" />
<glyph unicode="q" glyph-name="q" d="M1090 703V-223H1126Q1199 -223 1230 -251T1262 -326Q1262 -371 1231 -399T1126 -428H763Q689 -428 658 -400T626 -326Q626 -280 657 -252T763 -223H885V113Q810 67 733 44T576 21Q393 21 247 131Q72 263 72 466Q72 650 220
792T579 935Q660 935 736 911T885 838V908H1126Q1199 908 1230 880T1262 805Q1262 760 1231 732T1126 703H1090ZM885 465Q885 508 851 574T746 685T581 730Q427 730 338 615Q277 536 277 463Q277 380 364 303T581 226Q711 226 798 303T885 465Z" />
<glyph unicode="r" glyph-name="r" d="M572 908V780Q701 873 775 904T915 935Q1015 935 1109 861Q1173 811 1173 759Q1173 715 1143 685T1069 654Q1031 654 989 692T914 730Q871 730 786 676T572 514V205H864Q938 205 969 177T1001 102Q1001 57 970 29T864 0H245Q171
0 140 28T108 103Q108 148 139 176T245 205H367V703H293Q219 703 188 731T156 806Q156 851 187 879T293 908H572Z" />
<glyph unicode="s" glyph-name="s" d="M836 668Q786 699 731 714T616 730Q497 730 427 691Q396 674 396 654Q396 631 438 609Q470 593 581 578Q785 550 865 522Q970 485 1027 412T1084 258Q1084 148 987 74Q848 -33 626 -33Q537 -33 462 -18T323 28Q308 15 291
8T256 1Q208 1 180 32T151 138V207Q151 281 179 312T254 344Q291 344 316 324T355 253Q402 213 468 193T620 172Q761 172 839 216Q876 238 876 262Q876 302 823 328Q770 354 604 372Q357 398 274 472Q191 545 191 652Q191 762 284 835Q410 935 614 935Q685 935
750 922T876 880Q895 894 911 901T942 908Q984 908 1012 877T1040 771V721Q1040 654 1024 630Q992 584 937 584Q900 584 872 607T836 668Z" />
<glyph unicode="t" glyph-name="t" d="M564 703V292Q564 226 591 205Q633 172 741 172Q898 172 1031 239Q1082 265 1111 265Q1151 265 1180 235T1210 162Q1210 122 1178 93Q1129 46 985 7T741 -33Q550 -33 455 49T359 252V703H285Q211 703 180 731T148 806Q148
851 179 879T285 908H359V1093Q359 1167 387 1198T462 1230Q507 1230 535 1199T564 1093V908H943Q1017 908 1048 880T1080 805Q1080 760 1049 732T943 703H564Z" />
<glyph unicode="u" glyph-name="u" d="M1050 908V205Q1115 205 1146 176T1177 102Q1177 57 1146 29T1040 0H845V47Q757 7 677 -13T525 -33Q424 -33 350 9T233 127Q202 181 202 262V703H167Q93 703 62 731T30 806Q30 851 61 879T167 908H407V298Q407 233 438 203T535
172Q597 172 668 196T845 285V703H771Q697 703 666 731T634 806Q634 851 665 879T771 908H1050Z" />
<glyph unicode="v" glyph-name="v" d="M616 249L837 703Q755 703 732 717Q682 748 682 806Q682 851 713 879T819 908H1100Q1174 908 1205 880T1237 805Q1237 760 1206 732T1100 703H1066L723 0H509L166 703H137Q63 703 32 731T0 806Q0 851 31 879T137 908H412Q485
908 516 880T548 805Q548 748 500 718Q476 703 393 703L616 249Z" />
<glyph unicode="w" glyph-name="w" d="M616 378L474 0H281L109 703Q53 706 25 734T-4 806Q-4 851 27 879T133 908H324Q398 908 429 880T461 805Q461 759 425 727Q398 703 319 703L397 378L524 711H706L834 378L914 703Q838 703 814 718Q766 749 766 806Q766 851
797 879T903 908H1096Q1170 908 1201 880T1233 805Q1233 764 1206 736T1124 703L956 0H766L616 378Z" />
<glyph unicode="x" glyph-name="x" d="M768 472L1079 205Q1135 202 1163 174T1191 102Q1191 57 1160 29T1054 0H821Q747 0 716 28T684 104Q684 140 706 167T768 205L615 337L459 205Q506 193 526 168T547 104Q547 57 516 29T411 0H180Q106 0 75 28T43 103Q43 145
71 173T155 205L459 473L190 703Q137 707 110 735T82 806Q82 851 113 879T219 908H411Q485 908 516 880T548 807Q548 748 492 711L616 608L738 713Q683 752 683 803Q683 851 714 879T820 908H1010Q1084 908 1115 880T1147 805Q1147 764 1120 736T1038 703L768 472Z"
/>
<glyph unicode="y" glyph-name="y" d="M500 7L145 703Q95 709 69 737T43 805Q43 851 74 879T180 908H367Q441 908 472 880T504 805Q504 760 473 732T373 703L615 232L855 703Q789 703 758 731T726 806Q726 851 757 879T863 908H1056Q1129 908 1160 880T1192 805Q1192
764 1165 736T1085 703L615 -223Q692 -223 716 -238Q764 -269 764 -326Q764 -371 733 -399T627 -428H180Q106 -428 75 -400T43 -326Q43 -280 74 -252T180 -223H384L500 7Z" />
<glyph unicode="z" glyph-name="z" d="M504 205H864Q867 262 895 290T966 319Q1012 319 1040 288T1069 182V0H177V170L717 703H403V683Q403 610 375 579T300 547Q254 547 226 578T197 683L198 908H1046V740L504 205Z" />
<glyph unicode="{" glyph-name="braceleft" d="M656 497Q692 456 705 418T718 293V-33Q718 -74 733 -91T791 -112T860 -145T887 -216Q887 -260 857 -290T779 -320Q712 -320 650 -285T542 -169Q513 -117 513 -48V313Q513 356 499 372T439 393T369 426T344 497Q344
542 368 569T439 601T496 620Q513 640 513 682V1024Q513 1134 593 1214T778 1295Q826 1295 856 1265T887 1191Q887 1150 860 1121T790 1088T736 1070Q718 1049 718 1008V682Q718 613 705 576T656 497Z" />
<glyph unicode="|" glyph-name="bar" d="M718 1097V-123Q718 -228 713 -248Q705 -278 678 -299T616 -320Q581 -320 554 -299T518 -246Q513 -228 513 -123V1097Q513 1202 518 1222Q526 1252 553 1273T616 1294Q650 1294 677 1273T713 1221Q718 1201 718 1097Z" />
<glyph unicode="}" glyph-name="braceright" d="M568 497Q533 538 520 576T506 682V1008Q506 1049 491 1066T433 1088T364 1121T337 1191Q337 1235 367 1265T445 1295Q512 1295 574 1260T682 1144Q711 1092 711 1024V682Q711 639 725 623T785 601T855 569T880
497Q880 453 856 426T785 394T728 375Q711 355 711 313V-48Q711 -159 631 -239T446 -320Q398 -320 368 -290T337 -216Q337 -175 364 -146T434 -113T488 -95Q506 -74 506 -33V293Q506 379 518 417T568 497Z" />
<glyph unicode="~" glyph-name="asciitilde" d="M1001 729Q1045 729 1075 699T1105 627Q1105 584 1060 531Q992 452 946 419Q878 369 801 369Q743 369 686 398T544 508T434 590Q422 590 411 582Q389 568 340 513T270 447T230 435Q188 435 157 466T125 538Q125
599 229 697T433 795Q488 795 546 767T699 644Q748 595 771 582Q786 574 798 574Q812 574 823 582Q848 599 903 664Q938 706 957 717T1001 729Z" />
</font>

<font horiz-adv-x="1229" ><font-face
    font-family="CourierNew-BoldItalic"
    units-per-em="2048"
    panose-1="2 7 6 9 2 2 5 9 4 4"
    ascent="1705"
    descent="-615"
    alphabetic="0" />
<missing-glyph d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" />
<glyph unicode="!" glyph-name="exclam" d="M999 1093L811 475Q796 427 763 401T690 374Q649 374 627 396T605 460Q605 467 606 475L681 1093Q691 1179 714 1223T788 1297T890 1328Q947 1328 985 1292T1023 1207Q1023 1169 999 1093ZM604 -30Q551 -30 526 -7T500
55Q500 103 541 141T648 179Q701 179 726 156T752 97Q752 47 711 9T604 -30Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" d="M527 1237H791L621 747Q608 709 589 694T543 679Q519 679 506 692T492 726Q492 731 493 746L527 1237ZM954 1237H1218L1049 747Q1036 709 1017 694T970 679Q947 679 933 692T919 726Q919 731 921 746L954 1237Z" />
<glyph unicode="#" glyph-name="numbersign" d="M1113 923H1161Q1230 923 1254 902T1279 841Q1279 779 1220 739Q1189 718 1118 718H1055L992 494H1028Q1097 494 1121 473T1146 412Q1146 351 1087 310Q1056 289 985 289H934L835 -63Q832 -71 805 -134Q790 -158
760 -175T701 -192Q667 -192 644 -169T621 -116Q621 -94 634 -47L729 289H577L478 -62Q463 -115 457 -125Q440 -155 410 -173T345 -192Q310 -192 287 -169T263 -116Q263 -94 276 -48L371 289H321Q252 289 228 310T203 371Q203 431 260 472Q292 494 364 494H429L492
718H454Q386 718 362 739T337 799Q337 860 395 901Q426 923 498 923H550L649 1275Q664 1327 671 1339Q688 1368 718 1386T782 1405Q817 1405 840 1383T864 1330Q864 1305 851 1260L756 923H908L1007 1275Q1027 1347 1061 1376T1140 1405Q1176 1405 1199 1382T1223
1326Q1223 1303 1208 1260L1113 923ZM850 718H698L635 494H787L850 718Z" />
<glyph unicode="$" glyph-name="dollar" d="M978 1231Q1047 1222 1109 1191Q1144 1209 1171 1209Q1208 1209 1231 1187T1254 1134Q1254 1112 1246 1072L1231 1006Q1215 932 1180 901T1099 869Q1064 869 1041 891T1018 944Q1018 955 1020 975Q960 1032 852 1032Q729
1032 667 984T605 884Q605 851 628 830Q658 802 746 783L877 754Q1037 720 1098 655Q1158 589 1158 490Q1158 340 1044 216T728 55L691 -119Q675 -193 640 -224T558 -256Q524 -256 501 -234T477 -181Q477 -161 486 -119L523 55Q447 72 374 108Q324 72 286 72Q248
72 225 94T201 147Q201 167 210 208L237 337Q253 411 288 442T369 474Q406 474 427 454T450 393T467 331Q490 299 546 277T670 255Q798 255 886 324Q948 373 948 443Q948 481 924 502Q890 534 797 553L650 584Q514 612 455 678Q395 743 395 838Q395 973 500 1088T773
1231L785 1287Q800 1360 835 1391T917 1423Q952 1423 975 1401T999 1348Q999 1328 990 1287L978 1231Z" />
<glyph unicode="%" glyph-name="percent" d="M631 706Q530 706 465 770T399 935Q399 1070 508 1177T759 1285Q860 1285 925 1221T991 1059Q991 921 882 814T631 706ZM659 832Q738 832 799 892T861 1031Q861 1086 825 1122T731 1158Q651 1158 590 1098T528 962Q528
906 565 869T659 832ZM1162 690L353 445Q323 436 310 436Q291 436 278 450T264 490Q264 514 280 533T340 566L1148 811Q1178 820 1191 820Q1210 820 1223 806T1237 767Q1237 742 1221 723T1162 690ZM733 -30Q633 -30 568 35T502 199Q502 334 611 441T861 549Q962
549 1027 485T1093 323Q1093 185 984 78T733 -30ZM762 97Q841 97 902 157T964 296Q964 350 927 386T834 422Q754 422 693 362T631 226Q631 170 668 134T762 97Z" />
<glyph unicode="&amp;" glyph-name="ampersand" d="M913 407L1000 581H1105Q1173 581 1194 562Q1222 538 1222 501Q1222 453 1188 416T1111 376Q1063 270 1011 205Q1095 205 1116 188Q1145 164 1145 124Q1145 63 1086 22Q1055 0 984 0H861L845 32Q792 -1 746 -13Q685
-30 597 -30Q438 -30 359 41T279 223Q279 335 350 447T559 631Q524 720 524 773Q524 855 578 945T728 1088T913 1142Q947 1142 981 1134T1050 1107Q1089 1123 1107 1123Q1143 1123 1166 1100T1190 1041Q1190 1000 1162 966Q1143 943 1082 913L986 867Q948 910 920
925Q899 937 870 937Q815 937 774 898T733 817Q733 786 769 712L913 407ZM641 459Q563 426 526 373T489 268Q489 225 521 200T640 175Q703 175 761 205L641 459Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" d="M747 1252H1011L834 724Q820 682 800 667T754 651Q731 651 718 664T704 700Q704 705 705 723L747 1252Z" />
<glyph unicode="(" glyph-name="parenleft" d="M1177 1315Q1215 1315 1238 1292T1262 1236Q1262 1195 1221 1144Q1026 905 940 700T854 285Q854 85 946 -149Q958 -180 958 -193Q958 -243 919 -281T830 -320Q797 -320 778 -304Q749 -280 713 -184Q665 -60 641 62Q624
152 624 254Q624 463 692 652T891 1031T1097 1284Q1133 1315 1177 1315Z" />
<glyph unicode=")" glyph-name="parenright" d="M278 -320Q240 -320 217 -297T193 -241Q193 -199 234 -149Q428 86 514 294T601 712Q601 915 509 1144Q497 1174 497 1189Q497 1239 536 1277T625 1315Q658 1315 677 1299Q706 1275 742 1179Q789 1055 813 933Q831
843 831 741Q831 532 763 343T564 -36T358 -288Q322 -320 278 -320Z" />
<glyph unicode="*" glyph-name="asterisk" d="M612 776L447 833Q395 851 380 870T364 920Q364 967 402 1005T485 1044Q508 1044 552 1028L717 971L756 1157Q772 1231 807 1262T889 1294Q924 1294 947 1272T970 1218Q970 1200 961 1157L922 971L1111 1028Q1162
1044 1185 1044Q1216 1044 1239 1021T1262 962Q1262 922 1234 889T1133 833L944 776L1021 625Q1045 579 1045 554Q1045 511 1006 473T918 435Q887 435 870 448T830 505L752 655L610 505Q569 460 546 448T493 435Q456 435 433 458T410 517Q410 542 421 563T470 625L612
776Z" />
<glyph unicode="+" glyph-name="plus" d="M820 480L747 137Q731 63 696 32T614 0Q579 0 556 22T533 76Q533 95 542 137L615 480H321Q253 480 229 501T204 562Q204 623 262 663Q293 686 365 685H658L731 1027Q747 1101 782 1132T864 1164Q899 1164 922 1142T945
1088Q945 1068 936 1027L864 685H1156Q1225 685 1249 664T1274 604Q1274 544 1217 503Q1185 480 1113 480H820Z" />
<glyph unicode="," glyph-name="comma" d="M625 276H899L486 -280Q450 -329 410 -329Q387 -329 373 -316T358 -283Q358 -267 375 -233L625 276Z" />
<glyph unicode="-" glyph-name="hyphen" d="M1147 488H291L331 675H1187L1147 488Z" />
<glyph unicode="." glyph-name="period" d="M610 -33Q545 -33 514 -4T482 75Q482 140 534 189T667 239Q732 239 764 210T796 132Q796 67 744 17T610 -33Z" />
<glyph unicode="/" glyph-name="slash" d="M1306 1270L348 -146Q312 -200 285 -218T220 -236Q185 -236 162 -213T138 -153Q138 -121 180 -59L1140 1356Q1176 1410 1200 1425Q1231 1446 1266 1446Q1302 1446 1325 1423T1349 1364Q1349 1332 1306 1270Z" />
<glyph unicode="0" glyph-name="zero" d="M1224 761L1176 536Q1133 332 989 163Q824 -30 607 -30Q454 -30 361 77T268 409Q268 466 283 536L331 761Q375 967 530 1147T900 1327Q1053 1327 1146 1220T1239 887Q1239 829 1224 761ZM1019 761Q1031 816 1031 864Q1031
1000 981 1061T854 1122Q761 1122 685 1046Q572 932 536 761L488 536Q476 481 476 433Q476 297 526 236T653 175Q746 175 822 251Q935 365 971 536L1019 761Z" />
<glyph unicode="1" glyph-name="one" d="M1001 1327L762 205H969Q1038 205 1062 184T1086 124Q1086 62 1027 21Q996 0 926 0H306Q238 0 214 21T189 81Q189 143 247 183Q279 205 350 205H557L739 1060L546 1012Q500 1001 477 1001Q443 1001 422 1023T401 1083Q401
1130 429 1161T536 1213L1001 1327Z" />
<glyph unicode="2" glyph-name="two" d="M466 205H916Q959 235 992 235Q1029 235 1051 214T1074 159Q1074 138 1065 98L1044 0H110L156 217Q845 700 970 824Q1039 893 1039 965Q1039 1030 986 1076T836 1122Q746 1122 674 1080T557 957Q535 918 515 903Q482 879
440 879Q404 879 381 902T357 960Q357 1008 415 1088Q497 1203 623 1265T884 1327Q1052 1327 1150 1236T1248 1009Q1248 899 1198 811T1002 604T466 205Z" />
<glyph unicode="3" glyph-name="three" d="M1052 685Q1113 637 1143 575T1173 438Q1173 322 1101 208T893 32T553 -30Q332 -30 224 36Q163 73 163 122Q163 171 201 210T289 249Q318 249 350 224T421 189Q479 175 581 175Q725 175 803 201T921 279T962 390Q962
443 925 492T826 567Q785 584 685 590Q640 592 619 613T598 670Q598 719 637 757T728 796Q834 796 846 798Q894 805 941 833T1017 906T1045 991Q1045 1046 998 1084T846 1123Q698 1123 602 1037Q554 994 510 994Q474 994 451 1017T427 1075Q427 1148 525 1216Q686
1327 907 1327Q1073 1327 1163 1243T1254 1033Q1254 932 1204 845T1052 685Z" />
<glyph unicode="4" glyph-name="four" d="M1190 1294L1020 492Q1078 493 1102 471T1127 411Q1127 361 1087 324T976 287L959 205Q1018 205 1042 184T1066 124Q1066 63 1008 22Q976 0 905 0H629Q561 0 537 21T512 81Q512 142 570 183Q602 205 673 205H754L771 287H214L250
458L919 1294H1190ZM815 492L922 996L517 492H815Z" />
<glyph unicode="5" glyph-name="five" d="M674 1089L622 845Q744 881 843 881Q998 881 1094 786T1190 531Q1190 392 1117 253T910 42T565 -30Q357 -30 235 48Q167 91 167 149Q167 197 206 235T294 274Q329 274 363 241T438 194Q498 175 600 175Q749 175 823 210T939
323T981 491Q981 577 931 626T794 676Q683 676 525 604Q489 587 465 587Q430 587 407 610T383 670Q383 685 387 702L513 1294H1140Q1209 1294 1233 1273T1258 1213Q1258 1153 1201 1112Q1169 1089 1097 1089H674Z" />
<glyph unicode="6" glyph-name="six" d="M571 700Q661 764 734 791T885 819Q1017 819 1108 724T1200 480Q1200 263 1054 117T695 -30Q505 -30 414 66T322 372Q322 807 593 1067T1151 1327Q1264 1327 1325 1285Q1364 1258 1364 1214Q1364 1166 1325 1127T1236 1088Q1212
1088 1172 1112Q1148 1126 1123 1126Q1028 1126 911 1072T691 900Q620 820 571 700ZM534 383Q541 264 585 220T730 175Q847 175 918 246T990 429Q990 513 944 563T832 614Q770 614 688 554T534 383Z" />
<glyph unicode="7" glyph-name="seven" d="M1057 1089H589Q571 1028 539 1002T462 976Q426 976 403 998T380 1051Q380 1071 389 1112L427 1294H1317L1274 1089L732 101Q700 42 676 24Q642 -2 602 -2Q565 -2 541 21T517 80Q517 107 550 167L1057 1089Z" />
<glyph unicode="8" glyph-name="eight" d="M1044 655Q1095 608 1120 551T1145 425Q1145 314 1079 203T884 31T607 -30Q424 -30 329 53T234 266Q234 372 293 475T466 655Q424 704 403 758T381 871Q381 976 449 1087T642 1262T898 1327Q1062 1327 1157 1239T1252
1018Q1252 916 1200 826T1044 655ZM773 755Q889 755 963 822T1037 977Q1037 1037 990 1079T853 1122Q737 1122 663 1055T589 901Q589 840 636 798T773 755ZM654 175Q791 175 862 233T933 372Q933 445 879 496T730 548Q616 548 530 469T443 307Q443 252 484 221Q544
175 654 175Z" />
<glyph unicode="9" glyph-name="nine" d="M1018 538Q926 471 857 444T716 417Q575 417 483 515T390 773Q390 951 511 1112Q671 1327 911 1327Q1074 1327 1171 1218T1269 883Q1269 669 1211 511T1041 240T792 58Q617 -30 439 -30Q336 -30 277 12Q238 41 238 83Q238
134 276 172T364 210Q388 210 415 195Q450 175 489 175Q641 175 796 277T1018 538ZM1058 861Q1054 1004 1003 1063T868 1122Q766 1122 683 1032T600 812Q600 722 644 672T755 622Q825 622 901 682T1058 861Z" />
<glyph unicode=":" glyph-name="colon" d="M749 635Q685 635 654 664T622 743Q622 807 674 857T807 907Q872 907 903 878T935 801Q935 734 883 685T749 635ZM609 -36Q544 -36 513 -7T481 72Q481 136 533 186T667 236Q731 236 763 207T795 130Q795 63 743 14T609 -36Z" />
<glyph unicode=";" glyph-name="semicolon" d="M747 630Q683 630 651 660T619 739Q619 803 671 853T805 903Q870 903 901 874T933 796Q933 730 881 680T747 630ZM513 299H775L386 -170Q347 -217 320 -217Q298 -217 284 -205T270 -177Q270 -164 285 -135L513 299Z" />
<glyph unicode="&lt;" glyph-name="less" d="M524 584L1110 216Q1149 191 1160 175T1172 132Q1172 83 1133 44T1043 4Q1018 4 970 34L98 584L1204 1134Q1264 1163 1290 1163Q1327 1163 1350 1140T1374 1080Q1374 1040 1347 1006Q1328 983 1266 952L524 584Z" />
<glyph unicode="=" glyph-name="equal" d="M1198 674H321Q253 674 229 695T204 755Q204 816 261 856Q293 879 365 879H1241Q1310 879 1334 858T1359 798Q1359 737 1301 696Q1270 674 1198 674ZM1116 288H239Q171 288 147 309T122 369Q122 430 180 471Q212 493
283 493H1159Q1228 493 1252 472T1277 412Q1277 350 1218 309Q1187 288 1116 288Z" />
<glyph unicode="&gt;" glyph-name="greater" d="M955 584L369 952Q330 977 319 993T307 1037Q307 1085 346 1124T435 1163Q461 1163 509 1134L1381 584L275 34Q215 4 189 4Q152 4 129 28T105 90Q105 129 133 163Q151 186 212 216L955 584Z" />
<glyph unicode="?" glyph-name="question" d="M820 473Q801 414 768 388T693 362Q658 362 635 384T612 437Q612 458 620 499L645 614Q894 702 969 757T1044 890Q1044 955 998 996T856 1038Q799 1038 741 1025T625 986L619 956Q603 882 568 851T486 820Q451 820
428 842T405 896Q405 914 414 956L449 1121Q623 1196 715 1219T901 1243Q1069 1243 1160 1158T1252 936Q1252 794 1167 686T820 473ZM612 -29Q539 -29 513 -7T487 55Q487 116 542 156Q579 183 655 183Q729 183 755 161T781 100Q781 38 725 -2Q688 -29 612 -29Z"
/>
<glyph unicode="@" glyph-name="at" d="M1013 894L1027 957Q1033 985 1033 1014Q1033 1089 989 1132T869 1176Q796 1176 722 1129T597 1001Q515 870 487 740L423 436Q403 345 403 275Q403 119 469 39Q519 -20 620 -20Q759 -20 834 42Q874 74 899 74Q927 74 944
57T961 13Q961 -41 887 -90Q768 -170 580 -170Q424 -170 337 -70T249 251Q249 329 269 422L339 751Q387 979 529 1141Q691 1327 900 1327Q1032 1327 1109 1251T1187 1037Q1187 1001 1177 957L1061 410Q1092 395 1092 359Q1092 321 1062 293T970 265H879L881 271Q831
264 807 264Q707 264 637 333T567 501Q567 642 691 761T1013 894ZM980 739Q858 728 790 665T721 531Q721 486 758 453T862 419Q879 419 913 422L980 739Z" />
<glyph unicode="A" glyph-name="A" d="M935 330H437L360 205H410Q479 205 503 184T527 124Q527 62 468 21Q437 0 367 0H90Q22 0 -2 21T-27 81Q-27 133 14 170T139 205L632 1007H497Q429 1007 405 1028T380 1089Q380 1150 438 1191Q470 1213 541 1213H984L1178
205Q1248 207 1274 185T1300 124Q1300 62 1240 21Q1210 0 1139 0H863Q795 0 771 21T746 81Q746 142 804 183Q836 205 907 205H957L935 330ZM893 535L814 941L562 535H893Z" />
<glyph unicode="B" glyph-name="B" d="M239 205L409 1007H377Q309 1007 285 1028T260 1089Q260 1150 318 1191Q350 1213 421 1213H935Q1098 1213 1187 1132T1277 935Q1277 848 1237 773T1115 632Q1183 586 1216 526T1250 389Q1250 299 1207 223T1109 104T967 31T765
0H163Q95 0 71 21T46 81Q46 142 104 183Q136 205 207 205H239ZM551 709H776Q905 709 986 767T1068 893Q1068 941 1026 974T881 1007H615L551 709ZM444 205H798Q934 205 987 245T1040 343Q1040 402 976 453T778 504H508L444 205Z" />
<glyph unicode="C" glyph-name="C" d="M1183 1160Q1208 1186 1233 1199T1283 1212Q1319 1212 1342 1190T1365 1137Q1365 1117 1357 1076L1320 902Q1304 827 1269 796T1189 765Q1152 765 1131 786Q1109 806 1109 844V884Q1109 937 1056 978Q975 1038 854 1038Q762
1038 676 998T512 867T408 654L380 521Q371 481 371 442Q371 329 458 252T711 175Q824 175 909 205Q960 223 1025 277Q1064 309 1083 318T1126 328Q1162 328 1186 304T1210 245Q1210 173 1090 89Q918 -30 662 -30Q507 -30 389 30T217 187T162 413Q162 460 174 517L204
656Q258 910 457 1076T889 1243Q978 1243 1051 1223T1183 1160Z" />
<glyph unicode="D" glyph-name="D" d="M272 205L442 1007Q383 1007 359 1029T335 1089Q335 1150 393 1191Q425 1213 496 1213L925 1212Q1150 1212 1272 1046Q1353 936 1353 760Q1353 702 1338 633L1317 535Q1289 405 1224 304T1072 139T914 45Q808 0 651 0H238Q170
0 146 21T121 81Q121 132 162 169T272 205ZM477 205H695Q822 205 903 248T1037 363T1114 541L1134 638Q1144 685 1144 723Q1144 856 1071 931T864 1007H647L477 205Z" />
<glyph unicode="E" glyph-name="E" d="M511 506L447 205H970L994 316Q1009 390 1044 421T1126 453Q1161 453 1184 431T1208 377Q1208 357 1199 316L1132 0H166Q98 0 74 21T49 81Q49 142 107 183Q139 205 210 205H242L412 1007H380Q312 1007 288 1028T263 1089Q263
1150 321 1191Q353 1213 424 1213L1345 1212L1278 900Q1263 826 1228 795T1146 764Q1111 764 1088 786T1064 839Q1064 859 1073 900L1096 1007H618L555 711H735Q752 791 771 814Q813 863 871 863Q906 863 929 841T952 788Q952 767 943 726L893 490Q879 424 858
400Q816 353 760 353Q725 353 702 375T679 429Q679 450 691 506H511Z" />
<glyph unicode="F" glyph-name="F" d="M581 505L517 205H727Q796 205 820 184T844 124Q844 62 785 21Q754 0 684 0H236Q168 0 144 21T119 81Q119 142 177 183Q209 205 280 205H312L482 1007H450Q382 1007 358 1028T333 1089Q333 1150 391 1191Q423 1213 494 1213L1459
1212L1393 899Q1377 825 1342 794T1260 763Q1225 763 1202 785T1179 838Q1179 858 1188 899L1211 1007H688L624 710H804Q821 789 841 813Q882 862 940 862Q975 862 998 840T1022 787Q1022 766 1013 725L963 489Q947 415 912 384T830 352Q795 352 772 374T749 428Q749
448 761 505H581Z" />
<glyph unicode="G" glyph-name="G" d="M1211 375L1152 100Q995 24 892 -3T671 -30Q504 -30 384 23T212 162T160 390Q160 446 174 511L205 659Q248 864 407 1025Q622 1243 911 1243Q995 1243 1067 1226T1200 1175Q1249 1212 1287 1212Q1322 1212 1345 1190T1369
1137Q1369 1117 1360 1076L1332 943Q1316 869 1281 838T1199 806Q1164 806 1142 828Q1127 844 1124 895T1108 964Q1087 993 1024 1015T875 1038Q758 1038 659 991Q585 956 509 863T410 659L379 511Q368 460 368 410Q368 303 436 248Q526 175 706 175Q777 175 844
188T975 228L1006 375H797Q728 375 704 396T679 457Q679 517 737 558Q768 581 840 581L1205 580Q1273 580 1297 559T1322 499Q1322 460 1294 425T1211 375Z" />
<glyph unicode="H" glyph-name="H" d="M945 502H507L444 205H476Q545 205 569 184T593 124Q593 62 534 21Q503 0 433 0H181Q113 0 89 21T64 81Q64 145 126 186Q156 206 239 205L409 1007Q363 1011 342 1032T320 1089Q320 1150 379 1191Q410 1213 481 1213L690
1212Q759 1212 783 1191T808 1131Q808 1069 748 1028Q717 1007 647 1007H614L551 707H989L1053 1007H1020Q952 1007 928 1028T903 1089Q903 1150 961 1191Q993 1213 1064 1213L1273 1212Q1342 1212 1366 1191T1390 1131Q1390 1085 1355 1049T1258 1007L1087 205Q1169
205 1190 188Q1218 164 1218 124Q1218 62 1159 21Q1128 0 1058 0H806Q738 0 714 21T689 81Q689 142 747 183Q779 205 850 205H882L945 502Z" />
<glyph unicode="I" glyph-name="I" d="M932 1007L761 205H968Q1037 205 1061 184T1085 124Q1085 62 1026 21Q995 0 925 0H305Q237 0 213 21T188 81Q188 143 246 183Q278 205 349 205H556L726 1007H519Q451 1007 427 1028T402 1089Q402 1150 460 1191Q492 1213
563 1213L1182 1212Q1251 1212 1275 1191T1299 1131Q1299 1069 1240 1028Q1209 1007 1139 1007H932Z" />
<glyph unicode="J" glyph-name="J" d="M1215 1007L1083 387Q1058 271 1004 201Q921 92 794 31T544 -30Q382 -30 133 106L205 443Q220 517 255 548T337 580Q372 580 395 558T419 504Q419 485 410 443L367 242Q494 175 592 175Q647 175 710 200T809 260T860 326Q869
344 883 411L1010 1007H760Q692 1007 668 1028T643 1089Q643 1150 701 1191Q733 1213 804 1213L1378 1212Q1446 1212 1470 1191T1495 1131Q1495 1070 1437 1029Q1406 1007 1334 1007H1215Z" />
<glyph unicode="K" glyph-name="K" d="M493 432L445 205H520Q588 205 612 184T637 124Q637 62 577 21Q546 0 476 0H164Q96 0 72 21T47 81Q47 142 105 183Q137 205 208 205H240L410 1007H378Q310 1007 286 1028T261 1089Q261 1150 319 1191Q351 1213 422 1213L734
1212Q802 1212 826 1191T851 1131Q851 1069 791 1028Q761 1007 690 1007H616L551 703L982 1016Q943 1048 943 1084Q943 1149 1002 1191Q1033 1213 1104 1213L1313 1212Q1382 1212 1406 1191T1431 1131Q1431 1081 1391 1044T1277 1007L840 685Q931 626 996 504T1092
205H1147Q1215 205 1239 184T1264 124Q1264 62 1204 21Q1174 0 1103 0H917Q886 152 844 278T757 456T642 539L493 432Z" />
<glyph unicode="L" glyph-name="L" d="M743 1007L573 205H1014L1055 399Q1071 473 1106 504T1188 536Q1223 536 1246 514T1269 461Q1269 440 1261 399L1176 0H204Q136 0 112 21T87 81Q87 143 145 183Q177 205 248 205H367L538 1007H418Q350 1007 326 1028T301
1089Q301 1150 359 1191Q391 1213 462 1213L906 1212Q975 1212 999 1191T1024 1131Q1024 1069 964 1028Q933 1007 863 1007H743Z" />
<glyph unicode="M" glyph-name="M" d="M467 816L337 205H411Q480 205 504 184T528 124Q528 62 469 21Q438 0 368 0H98Q30 0 6 21T-19 81Q-19 131 21 168T132 205L302 1007Q256 1011 235 1032T213 1089Q213 1150 271 1191Q303 1213 374 1213L599 1212L747 595L1152
1212H1379Q1447 1212 1471 1191T1496 1131Q1496 1085 1461 1049T1363 1007L1193 205Q1252 205 1276 184T1300 124Q1300 62 1241 21Q1210 0 1139 0H870Q802 0 778 21T753 81Q753 142 811 183Q842 205 914 205H988L1118 816L771 288H593L467 816Z" />
<glyph unicode="N" glyph-name="N" d="M534 825L402 205H476Q545 205 569 184T593 124Q593 62 534 21Q503 0 433 0H163Q95 0 71 21T46 81Q46 131 86 168T197 205L367 1007H335Q267 1007 243 1028T218 1089Q218 1150 276 1191Q308 1213 379 1213L616 1212L966 390L1097
1007H1022Q954 1007 930 1028T905 1089Q905 1150 963 1191Q995 1213 1066 1213L1336 1212Q1404 1212 1428 1191T1453 1131Q1453 1081 1413 1044T1302 1007L1088 0H885L534 825Z" />
<glyph unicode="O" glyph-name="O" d="M610 -30Q417 -30 286 105T154 452Q154 648 257 837T553 1143Q718 1243 880 1243Q1071 1243 1203 1108T1336 766Q1336 605 1268 451T1095 194T863 31T610 -30ZM653 175Q758 175 874 249T1057 454T1125 716Q1125 859 1041
948T836 1038Q734 1038 619 966T434 763T364 500Q364 354 448 265T653 175Z" />
<glyph unicode="P" glyph-name="P" d="M488 416L443 205H650Q719 205 743 184T767 124Q767 62 708 21Q677 0 607 0H162Q94 0 70 21T45 81Q45 142 103 183Q135 205 206 205H238L408 1007H376Q308 1007 284 1028T259 1089Q259 1150 317 1191Q349 1213 420 1213L893
1212Q1076 1212 1172 1124T1269 900Q1269 797 1212 697Q1170 622 1111 574Q1002 487 905 452T682 416H488ZM532 621H721Q819 621 914 665Q985 699 1022 753T1060 859Q1060 920 1008 963T850 1007H614L532 621Z" />
<glyph unicode="Q" glyph-name="Q" d="M656 -28L648 -37Q688 -37 743 -48T835 -79T896 -98Q934 -98 993 -64T1082 -30Q1119 -30 1142 -52T1165 -110Q1165 -182 1073 -234Q951 -303 851 -303Q818 -303 795 -298T715 -269T606 -245Q569 -245 510 -255Q392 -275 331
-290Q292 -299 270 -299Q239 -299 216 -276T192 -219Q192 -162 252 -113L410 14Q293 71 223 186T153 452Q153 648 256 837T552 1143Q717 1243 879 1243Q1071 1243 1202 1108T1334 761Q1334 575 1242 395T984 102T656 -28ZM652 175Q757 175 873 249T1056 454T1124
716Q1124 859 1040 948T835 1038Q733 1038 618 966T433 763T363 500Q363 354 447 265T652 175Z" />
<glyph unicode="R" glyph-name="R" d="M502 463L447 205H522Q590 205 614 184T639 124Q639 62 579 21Q548 0 478 0H166Q98 0 74 21T49 81Q49 142 107 183Q139 205 210 205H242L412 1007H380Q312 1007 288 1028T263 1089Q263 1150 321 1191Q353 1213 424 1213L889
1212Q1081 1212 1177 1128T1273 912Q1273 793 1199 698T974 529Q1026 474 1080 386Q1114 330 1168 205Q1248 205 1272 185T1297 124Q1297 62 1238 21Q1207 0 1136 0H1019Q935 197 855 311T705 463H502ZM545 668H705Q783 668 843 686Q924 711 977 743Q1016 767 1040
801T1065 872Q1065 925 1013 966T853 1007H618L545 668Z" />
<glyph unicode="S" glyph-name="S" d="M325 52Q292 20 273 11T230 2Q193 2 170 24T147 78Q147 97 156 138L185 276Q201 350 236 381T318 413Q355 413 375 394T398 330T414 268Q438 237 504 206T657 175Q780 175 877 227T975 358Q975 390 953 418T876 466Q843 478
705 505T497 567T386 664T346 806Q346 994 512 1118T874 1243Q953 1243 1016 1226T1128 1172Q1177 1211 1216 1211Q1252 1211 1275 1189T1299 1136Q1299 1116 1290 1075L1257 921Q1241 847 1206 816T1126 784Q1083 784 1060 811Q1047 828 1047 877T1034 949Q1013
986 961 1012T832 1038Q708 1038 621 969Q556 917 556 856Q556 801 602 768Q635 743 753 718Q950 677 1011 652Q1097 617 1141 555T1185 413Q1185 303 1124 203T926 36T630 -30Q545 -30 469 -10T325 52Z" />
<glyph unicode="T" glyph-name="T" d="M928 1007L758 205H896Q964 205 988 184T1013 124Q1013 63 955 22Q923 0 852 0H371Q303 0 279 21T254 81Q254 143 312 183Q344 205 415 205H553L723 1007H501L460 813Q444 739 409 708T327 676Q292 676 269 698T246 751Q246
772 255 813L340 1212H1401L1316 813Q1301 739 1266 708T1184 676Q1149 676 1126 698T1103 751Q1103 772 1111 813L1153 1007H928Z" />
<glyph unicode="U" glyph-name="U" d="M1297 1007L1174 426Q1133 234 968 102T609 -30Q444 -30 336 73T228 328Q228 373 239 426L363 1007Q304 1007 280 1029T256 1088Q256 1151 315 1191Q345 1212 416 1212L686 1213Q754 1213 778 1192T803 1131Q803 1070 745
1029Q713 1007 642 1007H568L440 408Q436 386 436 364Q436 288 497 232T649 175Q726 175 796 210T920 310Q953 349 965 408L1092 1007H1018Q950 1007 926 1028T901 1089Q901 1150 959 1191Q990 1213 1062 1213L1331 1212Q1400 1212 1424 1191T1448 1132Q1448 1081
1409 1044T1297 1007Z" />
<glyph unicode="V" glyph-name="V" d="M678 299L1126 1007H1079Q1010 1007 986 1028T961 1089Q961 1150 1019 1191Q1051 1213 1122 1213L1397 1212Q1465 1212 1489 1191T1514 1131Q1514 1070 1456 1029Q1424 1007 1348 1007L713 0H517L310 1007Q236 1007 215 1026Q187
1050 187 1089Q187 1150 245 1191Q277 1213 348 1213L625 1212Q693 1212 717 1191T742 1131Q742 1069 682 1028Q652 1007 581 1007H533L678 299Z" />
<glyph unicode="W" glyph-name="W" d="M739 582L425 0H195L287 1007Q248 1012 229 1032T210 1082Q210 1148 269 1190Q300 1213 372 1213L646 1212Q715 1212 739 1191T763 1131Q763 1070 705 1029Q674 1007 602 1007H495L441 434L703 911H917L975 434L1165 1007H1058Q989
1007 965 1028T940 1089Q940 1150 999 1191Q1030 1213 1101 1213L1374 1212Q1442 1212 1466 1191T1491 1131Q1491 1088 1459 1052T1370 1007L1038 0H811L739 582Z" />
<glyph unicode="X" glyph-name="X" d="M881 618L1135 205Q1190 205 1213 183T1237 124Q1237 62 1178 21Q1147 0 1076 0H846Q778 0 754 21T729 81Q729 137 779 177Q810 202 869 205L717 459L455 205Q505 203 527 182T550 124Q550 62 491 21Q460 0 389 0H159Q91
0 67 21T42 81Q42 131 81 168T188 205L616 620L375 1007Q321 1008 298 1030T275 1089Q275 1150 333 1191Q365 1213 436 1213L626 1212Q694 1212 718 1191T743 1131Q743 1091 713 1054Q694 1032 640 1007L783 778L1019 1007Q983 1028 973 1043Q960 1061 960 1089Q960
1150 1018 1191Q1050 1213 1121 1213L1309 1212Q1378 1212 1402 1191T1427 1131Q1427 1082 1388 1045T1284 1007L881 618Z" />
<glyph unicode="Y" glyph-name="Y" d="M826 509L762 205H899Q968 205 992 184T1017 124Q1017 62 957 21Q926 0 856 0H375Q307 0 283 21T258 81Q258 143 316 183Q348 205 419 205H557L621 509L388 1007Q325 1007 301 1029T276 1089Q276 1150 335 1191Q366 1213
437 1213L624 1212Q693 1212 717 1191T741 1131Q741 1094 717 1062T636 1007L769 721L1020 1007Q957 1034 957 1089Q957 1150 1015 1191Q1046 1212 1118 1212H1310Q1379 1212 1403 1191T1427 1131Q1427 1071 1371 1030Q1338 1007 1268 1007L826 509Z" />
<glyph unicode="Z" glyph-name="Z" d="M457 205H922L954 357Q970 431 1005 462T1087 494Q1122 494 1145 472T1168 419Q1168 398 1160 357L1083 0H151L195 205L990 1007H613L581 860Q566 786 531 755T449 723Q414 723 391 745T367 799Q367 818 376 860L451 1212H1299L1256
1012L457 205Z" />
<glyph unicode="[" glyph-name="bracketleft" d="M948 1089L692 -115H816Q884 -115 908 -136T933 -196Q933 -257 875 -298Q843 -320 772 -320H443L786 1294H1114Q1182 1294 1206 1273T1231 1213Q1231 1152 1173 1111Q1142 1089 1070 1089H948Z" />
<glyph unicode="\" glyph-name="backslash" d="M668 1356L1026 -54Q1033 -81 1033 -124Q1033 -163 997 -196T913 -230Q876 -230 856 -213T822 -142L464 1269Q454 1309 454 1328Q454 1371 492 1408T579 1446Q614 1446 634 1429T668 1356Z" />
<glyph unicode="]" glyph-name="bracketright" d="M490 -115L745 1089H622Q553 1089 529 1110T504 1170Q504 1230 561 1271Q593 1294 665 1294H994L651 -320H323Q255 -320 231 -299T206 -238Q206 -177 264 -137Q296 -115 367 -115H490Z" />
<glyph unicode="^" glyph-name="asciicircum" d="M832 1031L529 741Q487 700 465 689T415 677Q378 677 355 700T331 759Q331 785 342 807T398 872L901 1355L1201 872Q1229 826 1229 802Q1229 754 1190 716T1102 677Q1074 677 1057 689T1014 740L832 1031Z" />
<glyph unicode="_" glyph-name="underscore" d="M1051 -615H-75Q-143 -615 -167 -594T-192 -534Q-192 -473 -134 -432Q-102 -410 -31 -410H1095Q1163 -410 1187 -431T1212 -491Q1212 -554 1152 -594Q1122 -615 1051 -615Z" />
<glyph unicode="`" glyph-name="grave" d="M677 1329L864 1147Q891 1121 891 1099Q891 1072 868 1050T816 1027Q795 1027 768 1053L582 1235Q555 1261 555 1284Q555 1311 578 1333T631 1356Q651 1356 677 1329Z" />
<glyph unicode="a" glyph-name="a" d="M798 0L808 48Q637 -33 446 -33Q304 -33 220 39T136 203Q136 278 194 361Q272 473 408 535T711 597Q803 597 921 577L931 626Q933 636 933 646Q933 683 904 703Q866 730 763 730Q669 730 520 694Q464 681 432 681Q399 681
377 703T355 761Q355 811 387 843T562 905T809 935Q977 935 1060 866T1144 696Q1144 664 1137 627L1047 205H1082Q1151 205 1175 184T1199 124Q1199 62 1140 21Q1109 0 1039 0H798ZM876 367Q759 391 654 391Q518 391 408 318Q345 277 345 240Q345 210 388 191T500
171Q571 171 671 199T857 279L876 367Z" />
<glyph unicode="b" glyph-name="b" d="M632 1297L535 837Q705 935 866 935Q1048 935 1163 823T1278 544Q1278 401 1202 265T974 48T654 -33Q490 -33 367 50L356 0H116Q48 0 24 21T-1 81Q-1 142 57 183Q89 205 160 205H195L383 1092H348Q280 1092 256 1113T231
1173Q231 1234 289 1275Q321 1297 392 1297H632ZM698 172Q866 172 966 265T1067 497Q1067 596 998 663T818 730Q670 730 556 619T442 372Q442 284 506 228T698 172Z" />
<glyph unicode="c" glyph-name="c" d="M1119 871Q1164 906 1202 906Q1237 906 1260 884T1284 830Q1284 811 1275 770L1247 638Q1231 564 1196 533T1115 502Q1072 502 1049 526Q1031 544 1031 599Q1031 654 994 681Q923 730 795 730Q598 730 483 583Q404 482 404
369Q404 279 473 225T719 171Q845 171 932 197Q984 213 1035 251T1122 290Q1158 290 1181 266T1205 206Q1205 134 1106 71Q942 -34 656 -34Q419 -34 307 66T194 322Q194 469 279 618T516 851T840 935Q924 935 994 919T1119 871Z" />
<glyph unicode="d" glyph-name="d" d="M1361 1297L1129 205H1164Q1232 205 1256 184T1281 124Q1281 62 1223 22Q1192 0 1120 0H880L891 50Q733 -33 569 -33Q367 -33 255 70T143 326Q143 469 224 612T471 853Q612 935 770 935Q929 935 1058 837L1112 1092H1077Q1009
1092 985 1113T960 1173Q960 1234 1018 1275Q1050 1297 1121 1297H1361ZM609 172Q777 172 877 265T978 496Q978 596 909 663T729 730Q581 730 467 619T353 371Q353 284 417 228T609 172Z" />
<glyph unicode="e" glyph-name="e" d="M1204 350H363Q377 271 447 222T657 172Q773 172 972 221Q1055 241 1086 241Q1119 241 1141 220T1163 163Q1163 112 1118 73T903 0T598 -33Q384 -33 268 74T151 349Q151 488 235 628T476 851T798 935Q992 935 1112 828T1233
529Q1233 488 1223 437L1204 350ZM1020 555Q993 639 926 684T754 730Q649 730 564 687T413 555H1020Z" />
<glyph unicode="f" glyph-name="f" d="M762 703L657 205H948Q1017 205 1041 184T1065 124Q1065 62 1006 21Q975 0 905 0H285Q217 0 193 21T168 81Q168 143 226 183Q258 205 329 205H452L557 703H459Q391 703 366 724T341 784Q341 844 398 885Q430 908 502 908H601L618
986Q646 1122 765 1209T1075 1297Q1149 1297 1257 1283T1393 1246T1421 1187Q1421 1137 1384 1099T1299 1060Q1281 1060 1243 1067Q1121 1092 1023 1092Q922 1092 877 1062T823 986L806 908H1122Q1190 908 1214 887T1239 827Q1239 766 1181 725Q1150 703 1078 703H762Z"
/>
<glyph unicode="g" glyph-name="g" d="M996 868L1033 908H1273Q1342 908 1366 887T1391 826Q1391 767 1334 726Q1302 703 1230 703H1195L1036 -43Q1013 -149 952 -229T782 -369T557 -428H325Q257 -428 233 -407T208 -347Q208 -285 267 -244Q298 -223 368 -223H594Q688
-223 751 -173T831 -43L852 57Q775 13 700 -9T550 -31Q370 -31 261 75T151 344Q151 489 230 629T455 853T758 938Q823 938 875 923T996 868ZM590 175Q728 175 835 278T942 512Q942 605 877 669T714 733Q576 733 469 629T362 398Q362 302 426 239T590 175Z" />
<glyph unicode="h" glyph-name="h" d="M679 1297L586 860Q730 935 866 935Q1020 935 1100 863T1181 673Q1181 634 1171 590L1090 205Q1171 205 1192 188Q1221 164 1221 124Q1221 62 1161 21Q1131 0 1060 0H827Q758 0 734 21T710 81Q710 145 771 186Q802 206 884
205L963 576Q970 607 970 632Q970 674 935 702T821 730Q753 730 695 704T529 589L447 205Q528 205 549 188Q578 164 578 124Q578 62 519 21Q488 0 417 0H184Q116 0 92 21T67 81Q67 145 129 186Q159 206 242 205L430 1092H395Q327 1092 303 1113T278 1173Q278 1234
336 1275Q368 1297 439 1297H679Z" />
<glyph unicode="i" glyph-name="i" d="M964 1297L918 1080H674L720 1297H964ZM910 908L760 205H1007Q1075 205 1099 184T1124 124Q1124 62 1064 21Q1034 0 963 0H265Q197 0 173 21T148 81Q148 143 206 183Q238 205 309 205H555L661 703H496Q428 703 404 724T379
784Q379 844 436 885Q467 908 540 908H910Z" />
<glyph unicode="j" glyph-name="j" d="M1096 1297L1050 1080H805L851 1297H1096ZM886 703H468Q399 703 375 724T350 784Q350 844 407 885Q439 908 511 908H1135L932 -43Q910 -149 848 -229T679 -369T453 -428H221Q153 -428 129 -407T104 -347Q104 -286 162 -245Q194
-223 265 -223H491Q584 -223 647 -173T727 -43L886 703Z" />
<glyph unicode="k" glyph-name="k" d="M519 341L446 0H206Q138 0 114 21T89 81Q89 142 147 183Q179 205 250 205H285L473 1092H438Q370 1092 346 1113T321 1173Q321 1234 379 1275Q411 1297 482 1297H722L575 606L763 735Q750 769 750 785Q750 844 807 885Q839
908 911 908H1145Q1213 908 1237 887T1262 827Q1262 766 1205 725Q1173 703 1101 703H1044L752 501L1024 205H1085Q1153 205 1177 184T1202 124Q1202 62 1142 21Q1111 0 1041 0H805Q736 0 712 21T687 81Q687 132 739 180L564 372L519 341Z" />
<glyph unicode="l" glyph-name="l" d="M993 1297L761 205H1008Q1076 205 1100 184T1125 124Q1125 62 1065 21Q1035 0 964 0H266Q198 0 174 21T149 81Q149 143 207 183Q239 205 310 205H556L745 1092H580Q512 1092 488 1113T463 1173Q463 1234 521 1275Q552 1297
623 1297H993Z" />
<glyph unicode="m" glyph-name="m" d="M475 908L468 847Q533 897 578 916T672 935Q770 935 837 848Q899 892 958 913T1076 935Q1181 935 1241 877T1302 724Q1302 696 1295 664L1198 205Q1257 205 1281 184T1305 124Q1305 62 1246 21Q1215 0 1144 0H949L1087 647Q1091
669 1091 686Q1091 706 1078 718T1036 730Q1002 730 971 712Q927 688 859 618L771 205Q830 205 854 184T878 124Q878 62 819 21Q788 0 717 0H522L660 647Q664 668 664 685Q664 705 650 717T609 730Q572 730 538 711Q493 686 429 618L341 205Q400 205 424 184T448
124Q448 62 389 21Q358 0 287 0H102Q34 0 10 21T-15 81Q-15 131 25 168T136 205L242 703Q182 703 158 725T134 784Q134 844 191 885Q223 908 295 908H475Z" />
<glyph unicode="n" glyph-name="n" d="M599 908L590 839Q659 891 721 913T864 935Q1021 935 1102 864T1183 677Q1183 635 1173 586L1092 205Q1151 205 1175 184T1199 124Q1199 62 1140 21Q1109 0 1038 0H853Q785 0 761 21T736 81Q736 131 776 168T887 205L969
592Q974 616 974 637Q974 676 944 699Q903 730 822 730Q752 730 693 703T531 586L450 205Q531 205 552 188Q581 164 581 124Q581 62 522 21Q491 0 420 0H187Q119 0 95 21T70 81Q70 145 132 186Q162 205 245 205L351 703Q292 703 268 725T243 784Q243 844 300 885Q332
908 404 908H599Z" />
<glyph unicode="o" glyph-name="o" d="M611 -33Q484 -33 380 18T223 158T170 350Q170 479 258 623T503 851T823 935Q940 935 1043 881T1198 737T1250 538Q1250 398 1168 265T928 49T611 -33ZM653 172Q810 172 925 272T1040 483Q1040 590 967 660T773 730Q601 730
478 602Q380 499 380 396Q380 309 455 241T653 172Z" />
<glyph unicode="p" glyph-name="p" d="M385 113L313 -223H436Q504 -223 528 -244T553 -304Q553 -367 494 -407Q463 -428 392 -428H29Q-39 -428 -63 -407T-88 -347Q-88 -286 -30 -245Q2 -223 73 -223H108L305 703H270Q201 703 177 724T152 784Q152 844 209 885Q241
908 313 908H553L539 838Q703 935 867 935Q1050 935 1166 823T1282 551Q1282 426 1203 301T971 99T675 21Q516 21 385 113ZM712 226Q858 226 964 316T1071 495Q1071 596 1002 663T821 730Q677 730 567 628T456 433Q456 354 526 290T712 226Z" />
<glyph unicode="q" glyph-name="q" d="M1239 703L1042 -223H1078Q1146 -223 1170 -244T1195 -304Q1195 -366 1137 -406Q1105 -428 1034 -428H671Q603 -428 579 -407T554 -347Q554 -285 613 -244Q644 -223 715 -223H837L909 113Q739 21 581 21Q394 21 278 128T161
382Q161 582 348 758T777 935Q939 935 1063 838L1078 908H1318Q1386 908 1410 887T1435 827Q1435 766 1378 725Q1346 703 1274 703H1239ZM628 226Q774 226 880 317T986 495Q986 596 918 663T736 730Q593 730 483 628T372 433Q372 353 442 290T628 226Z" />
<glyph unicode="r" glyph-name="r" d="M766 908L739 780Q889 874 969 904T1115 935Q1203 935 1270 881T1337 781Q1337 732 1298 693T1209 654Q1171 654 1137 692T1070 730Q1033 730 950 688T682 514L617 205H908Q977 205 1001 184T1025 124Q1025 62 966 21Q935
0 865 0H245Q177 0 153 21T128 81Q128 143 186 183Q218 205 289 205H412L517 703H443Q375 703 350 724T325 784Q325 844 382 885Q414 908 487 908H766Z" />
<glyph unicode="s" glyph-name="s" d="M977 668Q934 699 883 714T770 730Q672 730 603 704T534 650Q534 632 557 616Q588 594 703 578Q881 553 963 526T1095 439T1144 306Q1144 159 986 63T619 -33Q530 -33 457 -18T328 28Q291 1 257 1Q218 1 195 23T171 77Q171
97 180 138L195 207Q210 282 245 313T327 344Q364 344 384 324T408 253Q446 213 508 193T656 172Q807 172 894 221Q933 243 933 271Q933 310 885 333Q837 355 683 372Q462 396 393 454Q324 512 324 603Q324 682 375 753T528 873Q660 935 812 935Q883 935 946 922T1063
880Q1106 908 1134 908Q1166 908 1189 886T1212 833Q1212 812 1204 771L1193 721Q1177 647 1142 616T1060 584Q1023 584 1000 607T977 668Z" />
<glyph unicode="t" glyph-name="t" d="M690 703L602 292Q596 261 596 241Q596 214 620 198Q660 172 752 172Q910 172 1058 239Q1115 265 1144 265Q1178 265 1200 243T1222 184Q1222 137 1185 102Q1132 52 975 10T702 -33Q607 -33 521 -1Q458 22 420 72T382 187Q382
220 389 252L485 703H410Q342 703 318 724T293 784Q293 845 351 886Q382 908 454 908H528L568 1093Q583 1167 618 1198T700 1230Q735 1230 758 1208T782 1155Q782 1134 773 1093L733 908H1112Q1181 908 1205 887T1230 826Q1230 767 1173 726Q1141 703 1069 703H690Z"
/>
<glyph unicode="u" glyph-name="u" d="M1242 908L1093 205Q1152 205 1176 184T1200 124Q1200 63 1142 22Q1111 0 1039 0H844L854 47Q661 -33 512 -33Q394 -33 322 33T250 200Q250 228 257 262L350 703H315Q247 703 223 724T198 784Q198 845 256 886Q287 908 359
908H599L469 298Q463 267 463 248Q463 217 489 195T569 172Q632 172 708 196T905 285L994 703H919Q851 703 827 724T802 784Q802 845 860 886Q891 908 963 908H1242Z" />
<glyph unicode="v" glyph-name="v" d="M669 249L986 703Q902 703 881 720Q851 744 851 784Q851 845 909 886Q941 908 1012 908H1293Q1361 908 1385 887T1410 826Q1410 767 1354 726Q1322 703 1249 703H1215L723 0H509L315 703H286Q218 703 194 724T169 784Q169
845 227 886Q258 908 330 908H605Q673 908 697 887T722 826Q722 793 699 759T641 712Q616 703 542 703L669 249Z" />
<glyph unicode="w" glyph-name="w" d="M697 378L474 0H281L258 703Q209 705 187 727T165 784Q165 845 223 886Q254 908 326 908H517Q586 908 610 887T635 826Q635 766 577 725Q545 703 469 703L478 378L675 711H858L915 378L1063 703Q985 703 964 721Q935 745
935 784Q935 845 993 886Q1024 908 1096 908H1289Q1358 908 1382 887T1407 826Q1407 781 1371 745T1273 703L956 0H766L697 378Z" />
<glyph unicode="x" glyph-name="x" d="M869 472L1123 205Q1172 203 1194 182T1216 124Q1216 62 1156 21Q1126 0 1055 0H821Q753 0 729 21T704 81Q704 123 733 158T812 205L687 337L503 205Q541 195 557 176T573 129Q573 62 512 21Q482 0 411 0H180Q112 0 88 21T63
81Q63 128 99 164T199 205L560 473L340 703Q294 706 273 728T251 784Q251 844 308 885Q340 908 412 908H605Q673 908 697 887T722 827Q722 756 644 711L745 607L890 713Q852 745 852 782Q852 843 908 884Q940 908 1013 908H1204Q1272 908 1296 887T1321 827Q1321
781 1286 745T1188 703L869 472Z" />
<glyph unicode="y" glyph-name="y" d="M501 7L294 703Q251 708 231 729T211 784Q211 845 269 886Q300 908 372 908H559Q628 908 652 887T677 827Q677 777 637 740T522 703L663 232L1003 703Q943 703 919 725T895 784Q895 844 951 885Q983 908 1056 908H1248Q1316
908 1340 887T1365 827Q1365 781 1330 745T1234 703L567 -223Q647 -223 668 -241Q697 -265 697 -304Q697 -367 637 -407Q606 -428 536 -428H88Q20 -428 -4 -407T-29 -347Q-29 -286 29 -245Q61 -223 132 -223H336L501 7Z" />
<glyph unicode="z" glyph-name="z" d="M548 205H907Q923 263 957 291T1035 319Q1070 319 1093 297T1116 243Q1116 223 1108 182L1069 0H177L213 170L866 703H552Q534 619 515 596Q474 547 415 547Q380 547 357 569T334 622Q334 642 343 683L391 908H1239L1204
740L548 205Z" />
<glyph unicode="{" glyph-name="braceleft" d="M762 497Q795 446 795 401Q795 364 780 293L711 -33Q707 -51 707 -66Q707 -87 718 -98T765 -112T822 -137T844 -193Q844 -243 805 -281T710 -320Q653 -320 606 -294T528 -215T496 -108Q496 -78 503 -48L580 313Q584
333 584 349Q584 368 573 378T523 393T466 417T447 471Q447 522 479 558T572 602Q615 607 628 620Q649 640 658 682L731 1024Q754 1135 851 1215T1054 1295Q1096 1295 1119 1273T1143 1215Q1143 1167 1108 1130T1017 1088Q977 1084 963 1070Q941 1049 932 1008L863
682Q849 614 828 576T762 497Z" />
<glyph unicode="|" glyph-name="bar" d="M718 1097V-123Q718 -228 713 -248Q705 -278 678 -299T616 -320Q581 -320 554 -299T518 -246Q513 -228 513 -123V1097Q513 1202 518 1222Q526 1252 553 1273T616 1294Q650 1294 677 1273T713 1221Q718 1201 718 1097Z" />
<glyph unicode="}" glyph-name="braceright" d="M674 497Q641 549 641 596Q641 632 651 682L721 1008Q724 1027 724 1041Q724 1062 713 1073T666 1088T609 1113T588 1168Q588 1219 627 1257T722 1295Q779 1295 825 1269T903 1190T935 1083Q935 1053 929 1024L856
682Q852 661 852 645Q852 627 863 616T912 601T970 578T989 524Q989 473 957 437T864 393Q821 388 808 375Q787 355 778 313L701 -48Q677 -160 580 -240T377 -320Q336 -320 313 -297T289 -240Q289 -192 324 -155T415 -112Q454 -109 468 -95Q491 -74 499 -33L569
293Q587 379 607 416T674 497Z" />
<glyph unicode="~" glyph-name="asciitilde" d="M1157 729Q1194 729 1217 706T1241 648Q1241 599 1191 549Q1125 482 1060 435Q967 369 880 369Q825 369 774 396T650 511Q601 569 583 581Q570 590 560 590Q533 590 442 508Q389 459 367 447T321 435Q286 435 262
459T237 518Q237 553 261 587T353 677T480 764T601 795Q658 795 710 766T836 644Q874 596 893 583Q907 574 920 574Q935 574 949 583Q978 601 1044 664Q1088 706 1110 717T1157 729Z" />
</font>

<font horiz-adv-x="1229" ><font-face
    font-family="CourierNew-Italic"
    units-per-em="2048"
    panose-1="2 7 4 9 2 2 5 9 4 4"
    ascent="1705"
    descent="-615"
    alphabetic="0" />
<missing-glyph d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" />
<glyph unicode="!" glyph-name="exclam" d="M944 1170L762 492Q753 459 739 447T707 434Q693 434 684 443T675 468Q675 475 677 492L784 1170Q794 1233 821 1259T889 1285Q918 1285 936 1268T955 1226Q955 1210 944 1170ZM633 178H673Q710 178 733 155T757 96Q757
46 718 8T628 -30H589Q552 -30 529 -7T505 52Q505 102 544 140T633 178Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" d="M537 1255H803L621 730Q606 687 587 671T542 655Q521 655 508 668T495 711Q495 719 496 730L537 1255ZM966 1255H1232L1050 730Q1035 687 1016 671T971 655Q950 655 937 668T924 711Q924 719 925 730L966 1255Z" />
<glyph unicode="#" glyph-name="numbersign" d="M958 740L884 476H1044Q1073 476 1081 469Q1093 459 1093 443Q1093 422 1077 407T1027 392H860L728 -76Q720 -106 705 -118T674 -130L658 -126Q640 -114 640 -99Q640 -89 645 -70L776 392H587L454 -76Q446 -106
432 -118T401 -130L384 -126Q366 -114 366 -99Q366 -89 372 -70L502 392H327Q299 392 290 399Q279 410 279 426Q279 446 295 461T345 476H526L600 740H444Q416 740 406 749T395 774Q395 794 412 809T462 824H624L756 1292Q765 1321 779 1333T810 1346L827 1342Q845
1330 845 1313Q845 1304 839 1286L709 824H898L1030 1292Q1038 1321 1052 1333T1083 1346L1100 1342Q1118 1330 1118 1313Q1118 1304 1113 1286L982 824H1161Q1189 824 1197 817Q1209 807 1209 791Q1209 770 1193 755T1143 740H958ZM874 740H685L610 476H799L874
740Z" />
<glyph unicode="$" glyph-name="dollar" d="M825 1198L848 1304Q854 1335 868 1348T902 1361Q917 1361 926 1352T936 1330Q936 1321 932 1304L910 1198Q977 1192 1017 1176T1109 1121Q1116 1146 1130 1158T1163 1170Q1177 1170 1186 1161T1196 1139Q1196 1130
1192 1114L1166 989Q1159 959 1145 946T1111 933Q1098 933 1088 941T1078 958L1080 997Q1080 1031 1028 1068Q959 1118 853 1118Q725 1118 635 1038T544 868Q544 803 592 772Q640 740 778 713T963 666Q1026 639 1060 594T1095 481Q1095 347 985 240T679 113L626
-134Q620 -165 606 -178T572 -191Q558 -191 548 -182T538 -160Q538 -151 542 -134L595 113Q443 123 358 213Q347 162 336 151Q319 135 298 135Q284 135 275 144T265 166Q265 174 268 191L303 355Q310 386 324 399T358 412Q371 412 381 403T391 389L387 329Q387
319 413 289Q451 242 503 222Q571 195 655 195Q814 195 911 277T1009 461Q1009 506 984 539T903 593Q870 606 750 630Q584 664 521 710Q458 756 458 850Q458 970 561 1074T825 1198Z" />
<glyph unicode="%" glyph-name="percent" d="M704 756Q616 756 558 814T500 962Q500 1082 597 1178T819 1275Q908 1275 966 1218T1024 1074Q1024 949 927 853T704 756ZM718 817Q813 817 887 891T962 1060Q962 1127 918 1171T806 1215Q710 1215 636 1141T561 974Q561
905 605 861T718 817ZM1228 725L396 472Q382 468 374 468Q366 468 359 475T352 491Q352 503 360 513T390 530L1222 783Q1236 787 1244 787Q1253 787 1259 780T1266 764Q1266 752 1258 742T1228 725ZM797 -24Q708 -24 650 34T592 181Q592 302 689 398T911 495Q1000
495 1058 438T1116 293Q1116 169 1019 73T797 -24ZM810 36Q906 36 980 110T1055 280Q1055 346 1011 390T898 434Q802 434 728 360T654 193Q654 125 698 81T810 36Z" />
<glyph unicode="&amp;" glyph-name="ampersand" d="M855 0L812 99Q694 -33 552 -33Q450 -33 381 38T312 223Q312 346 394 451T614 596Q573 696 565 727T556 786Q556 893 652 985T869 1078Q903 1078 935 1068T996 1037Q1044 1059 1054 1059Q1069 1059 1078 1050T1088
1026Q1088 1011 1079 998T1043 973L970 938Q945 966 916 979T852 993Q772 993 707 930T641 796Q641 739 691 620L845 251Q930 367 997 517H1079Q1101 517 1108 514T1121 502T1127 483Q1127 470 1118 456T1094 437Q1084 432 1042 432Q961 266 877 170L916 84H987Q1015
84 1025 76T1035 51Q1035 30 1019 15T969 0H855ZM635 522Q530 499 464 419T398 238Q398 157 447 104T568 51Q679 51 780 177L635 522Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" d="M748 1255H1014L832 730Q817 687 798 671T753 655Q732 655 719 668T706 711Q706 719 707 730L748 1255Z" />
<glyph unicode="(" glyph-name="parenleft" d="M1167 1255Q1182 1255 1192 1246T1202 1222Q1202 1208 1190 1192Q986 925 899 701T812 253Q812 52 892 -189Q897 -205 897 -210Q897 -229 882 -244T845 -259Q832 -259 823 -250Q792 -218 741 -41T689 268Q689 447
739 601T864 880T1041 1134Q1117 1229 1141 1246Q1154 1255 1167 1255Z" />
<glyph unicode=")" glyph-name="parenright" d="M288 -260Q273 -260 263 -251T253 -227Q253 -212 265 -196Q468 69 555 293T643 742Q643 943 562 1185Q557 1200 557 1205Q557 1224 573 1239T610 1255Q623 1255 632 1246Q663 1214 714 1037T766 728Q766 549 717
397T593 120T415 -136Q339 -233 314 -250Q301 -260 288 -260Z" />
<glyph unicode="*" glyph-name="asterisk" d="M762 911L823 1198Q830 1229 844 1242T878 1255Q892 1255 901 1246T911 1224Q911 1215 908 1198L846 911L1139 1000Q1159 1006 1170 1006Q1182 1006 1191 997T1201 974Q1201 956 1190 942T1148 919L856 830L975 598Q984
579 984 568Q984 550 968 535T932 519Q911 519 896 548L776 781L558 548Q531 519 509 519Q494 519 485 529T475 554Q475 571 500 598L719 831L464 920Q443 927 437 934T430 955Q430 975 445 990T480 1006Q490 1006 507 1000L762 911Z" />
<glyph unicode="+" glyph-name="plus" d="M772 543L682 123Q676 92 662 80T628 67Q614 67 605 76T595 97Q595 106 598 123L687 543H315Q287 543 277 551T267 576Q267 597 283 612T333 627H705L794 1045Q800 1075 815 1088T849 1101Q863 1101 872 1092T882 1070Q882
1062 879 1045L790 627H1162Q1184 627 1192 624T1205 612T1210 593Q1210 573 1194 558T1144 543H772Z" />
<glyph unicode="," glyph-name="comma" d="M632 302H906L491 -250Q453 -300 416 -300Q394 -300 381 -287T367 -254Q367 -237 376 -218L632 302Z" />
<glyph unicode="-" glyph-name="hyphen" d="M1179 639L1153 519H296L322 639H1179Z" />
<glyph unicode="." glyph-name="period" d="M648 241H684Q732 241 763 211T794 134Q794 70 743 20T626 -30H590Q541 -30 511 0T480 78Q480 142 531 191T648 241Z" />
<glyph unicode="/" glyph-name="slash" d="M1272 1316L289 -132Q273 -155 262 -162T237 -169Q222 -169 213 -160T203 -135Q203 -121 220 -96L1203 1352Q1219 1375 1230 1382T1256 1389Q1271 1389 1280 1380T1290 1355Q1290 1342 1272 1316Z" />
<glyph unicode="0" glyph-name="zero" d="M1156 731L1111 523Q1054 251 892 94Q764 -30 613 -30Q513 -30 446 18T354 143Q320 253 320 351Q320 427 340 523L385 731Q442 1004 605 1161Q732 1285 883 1285Q984 1285 1051 1237T1142 1110Q1176 1000 1176 903Q1176
828 1156 731ZM1069 720Q1085 797 1085 862Q1085 999 1057 1069T983 1169T869 1200Q727 1200 617 1055T467 720L427 535Q411 457 411 393Q411 257 439 187T513 85T627 54Q769 54 879 199T1029 535L1069 720Z" />
<glyph unicode="1" glyph-name="one" d="M926 1272L674 84H962Q990 84 1000 76T1010 51Q1010 30 994 15T944 0H284Q256 0 246 9T236 34Q236 54 252 69T302 84H590L817 1156L525 1070Q504 1064 494 1064Q482 1064 473 1073T464 1097Q464 1114 475 1128T517 1151L926 1272Z" />
<glyph unicode="2" glyph-name="two" d="M271 84H916Q929 145 940 156Q956 173 978 173Q992 173 1001 164T1011 143Q1011 133 1008 117L983 0H171L198 124Q522 370 814 607Q952 721 1005 778T1079 881T1100 975Q1100 1069 1032 1134T858 1200Q748 1200 649 1138T504
981Q484 940 452 940Q438 940 429 949T419 971Q419 1005 471 1074Q548 1175 656 1230T878 1285Q1009 1285 1097 1199T1186 990Q1186 932 1162 871T1080 747T886 572Q513 265 272 90L271 84Z" />
<glyph unicode="3" glyph-name="three" d="M933 683Q1021 639 1064 568T1107 417Q1107 321 1039 212T846 36T590 -30Q437 -30 299 57Q225 104 225 135Q225 154 240 169T273 184Q290 184 307 169Q437 54 609 54Q775 54 898 165T1021 399Q1021 464 984 522T870 615T711
651Q680 651 672 658Q660 668 660 684Q660 705 676 720T719 735L794 734Q921 734 1013 820Q1105 905 1105 1005Q1105 1087 1044 1144T873 1201Q787 1201 707 1172T572 1089Q542 1060 522 1060Q506 1060 497 1069T488 1092Q488 1109 507 1129Q570 1196 677 1240T893
1285Q1031 1285 1111 1210T1191 1025Q1191 924 1124 830T933 683Z" />
<glyph unicode="4" glyph-name="four" d="M846 351H289L310 448L948 1255H1123L949 435H1019Q1047 435 1056 428Q1067 418 1067 402Q1067 381 1051 366T1001 351H931L874 84H945Q973 84 983 76T993 51Q993 30 977 15T927 0H614Q586 0 576 9T566 34Q566 54 582
69T632 84H790L846 351ZM864 435L1020 1170H976L395 435H864Z" />
<glyph unicode="5" glyph-name="five" d="M632 1170L544 759Q625 790 696 805T830 821Q963 821 1044 740T1125 523Q1125 388 1051 252T854 43T599 -30Q498 -30 408 9T253 120Q231 145 231 160Q231 181 246 197T281 213Q298 213 314 195Q434 54 613 54Q722 54 820
113T978 284T1038 504Q1038 610 975 673T803 737Q672 737 526 668Q491 652 477 652Q463 652 454 660T445 683Q445 690 447 698L565 1255H1151Q1174 1255 1181 1252T1194 1240T1200 1221Q1200 1201 1183 1186T1133 1170H632Z" />
<glyph unicode="6" glyph-name="six" d="M477 531Q583 650 677 703T873 756Q984 756 1061 674T1139 456Q1139 361 1095 265T987 106T849 7T686 -30Q552 -30 467 67T382 374Q382 653 498 864T837 1197Q999 1285 1157 1285Q1232 1285 1283 1255Q1305 1241 1305 1221Q1305
1200 1291 1185T1257 1170Q1243 1170 1227 1180Q1191 1200 1130 1200Q1018 1200 895 1138T675 971T528 745Q495 664 477 531ZM467 392Q467 209 531 132T708 54Q838 54 945 171T1052 442Q1052 545 993 608T851 672Q753 672 648 592Q574 536 467 392Z" />
<glyph unicode="7" glyph-name="seven" d="M1138 1132L1146 1170H545L529 1096Q522 1066 508 1053T474 1040Q460 1040 451 1049T441 1071Q441 1080 444 1096L478 1255H1249L1220 1121L653 41Q639 15 627 7T599 -2Q584 -2 575 7T566 31Q566 42 579 66L1138 1132Z" />
<glyph unicode="8" glyph-name="eight" d="M924 651Q1001 609 1039 548T1078 406Q1078 308 1016 203T838 34T604 -30Q470 -30 382 55T294 263Q294 378 368 483T581 651Q510 698 478 750T445 878Q445 952 483 1026T580 1156T719 1248T891 1285Q1019 1285 1101 1205T1184
1005Q1184 904 1122 813T924 651ZM761 693Q897 693 996 784T1096 988Q1096 1079 1033 1139T871 1200Q735 1200 633 1103T530 889Q530 810 594 752T761 693ZM625 54Q781 54 886 163T991 387Q991 481 924 545T745 610Q597 610 489 508T380 283Q380 185 447 120T625
54Z" />
<glyph unicode="9" glyph-name="nine" d="M1111 710Q1020 595 919 537T719 479Q606 479 529 561T452 784Q452 953 581 1119T901 1285Q1034 1285 1120 1186T1206 878Q1206 692 1153 517Q1119 406 1064 322T909 153T686 19T443 -30Q362 -30 312 0Q287 15 287 34Q287
54 302 69T337 84Q350 84 370 73Q405 54 456 54Q555 54 652 90T831 189T968 320T1054 472T1111 710ZM1124 850Q1114 1052 1052 1126T884 1200Q758 1200 648 1080T538 800Q538 693 597 628T743 563Q835 563 935 639Q1009 696 1124 850Z" />
<glyph unicode=":" glyph-name="colon" d="M780 866H816Q865 866 895 836T926 758Q926 706 893 664T807 602Q786 594 722 594Q674 594 644 624T613 702Q613 766 663 816T780 866ZM648 241H684Q732 241 763 211T794 134Q794 70 743 20T626 -30H590Q541 -30 511
0T480 78Q480 142 531 191T648 241Z" />
<glyph unicode=";" glyph-name="semicolon" d="M883 866H919Q968 866 998 836T1029 758Q1029 694 978 644T861 594H825Q777 594 746 624T715 702Q715 766 766 816T883 866ZM617 302H881L499 -162Q470 -197 456 -205T425 -214Q404 -214 392 -203T379 -174Q379 -157
392 -132L617 302Z" />
<glyph unicode="&lt;" glyph-name="less" d="M222 583L1238 1089Q1263 1101 1273 1101Q1288 1101 1297 1092T1307 1068Q1307 1037 1263 1015L393 583L1078 151Q1104 135 1104 117Q1104 97 1088 81T1052 65Q1041 65 1022 77L222 583Z" />
<glyph unicode="=" glyph-name="equal" d="M1220 695H304Q276 695 266 704T256 729Q256 749 273 764T322 780H1238Q1266 780 1276 771T1286 746Q1286 725 1270 710T1220 695ZM1156 394H240Q212 394 202 402T192 427Q192 448 208 463T258 478H1174Q1202 478 1210
470Q1222 460 1222 445Q1222 424 1206 409T1156 394Z" />
<glyph unicode="&gt;" glyph-name="greater" d="M1255 583L239 77Q215 65 204 65Q189 65 180 74T170 99Q170 129 214 151L1084 583L399 1015Q373 1031 373 1050Q373 1070 389 1085T425 1101Q436 1101 455 1089L1255 583Z" />
<glyph unicode="?" glyph-name="question" d="M770 514L752 429Q745 398 731 386T697 373Q683 373 674 382T664 403Q664 412 667 429L697 570Q962 661 1047 747Q1105 806 1105 897Q1105 994 1042 1055T866 1116Q799 1116 738 1101T582 1045L564 959Q557 928 543
916T509 903Q495 903 486 912T476 933Q476 942 479 959L509 1100Q681 1169 730 1181Q811 1200 890 1200Q1036 1200 1114 1125T1192 923Q1192 799 1116 709T770 514ZM612 178H697Q734 178 757 155T781 96Q781 46 742 8T653 -30H568Q531 -30 508 -7T484 52Q484 102
523 140T612 178Z" />
<glyph unicode="@" glyph-name="at" d="M923 302L926 313Q875 305 839 305Q732 305 671 364T609 512Q609 626 701 726Q829 865 1043 865L1064 962Q1070 990 1070 1020Q1070 1109 1019 1160T879 1212Q801 1212 729 1171T574 1018T458 744L388 413Q373 343 373 272Q373
108 448 19Q504 -46 621 -46Q771 -46 861 25Q881 41 897 41Q912 41 920 33Q930 22 930 8Q930 -9 915 -25Q876 -67 788 -98T590 -130Q453 -130 381 -46Q285 65 285 252Q285 327 303 413L375 749Q429 1007 600 1167Q737 1297 896 1297Q1013 1297 1084 1226T1156 1032Q1156
1000 1148 962L1026 386Q1043 384 1050 376T1058 355Q1058 341 1050 328T1030 308T991 302H923ZM1025 782Q878 781 787 703T695 532Q695 468 738 429T868 389Q902 389 944 398L1025 782Z" />
<glyph unicode="A" glyph-name="A" d="M1017 391H465L286 84H447Q476 84 486 76T496 51Q496 30 479 15T429 0H116Q88 0 78 9T68 34Q68 54 84 69T134 84H198L783 1086H535Q507 1086 497 1094T487 1120Q487 1140 503 1155T553 1170H975L1155 84H1220Q1248 84 1258
76T1268 51Q1268 30 1252 15T1202 0H888Q860 0 850 9T840 34Q840 54 856 69T906 84H1067L1017 391ZM1003 475L901 1086H870L514 475H1003Z" />
<glyph unicode="B" glyph-name="B" d="M274 84L487 1086H374Q346 1086 336 1094T326 1120Q326 1140 342 1155T392 1170H920Q1058 1170 1136 1099T1215 925Q1215 829 1159 753T991 618Q1095 578 1141 517T1187 379Q1187 305 1147 229T1049 105T904 23Q844 0 771
0H143Q115 0 105 9T95 34Q95 54 111 69T161 84H274ZM478 650H775Q873 650 957 685T1085 786T1129 906Q1129 979 1070 1032T903 1086H571L478 650ZM358 84H783Q867 84 941 125T1058 233T1100 358Q1100 457 1015 511T762 565H460L358 84Z" />
<glyph unicode="C" glyph-name="C" d="M1219 1055L1232 1114Q1238 1144 1252 1157T1286 1170Q1301 1170 1310 1161T1320 1139Q1320 1131 1316 1114L1266 881Q1260 850 1246 837T1212 824Q1198 824 1189 833T1179 855Q1179 862 1181 874T1183 900Q1183 976 1109
1035Q1013 1113 876 1113Q781 1113 685 1071Q612 1039 565 993Q478 909 421 815Q382 750 363 663L332 516Q322 469 322 423Q322 264 426 158T685 51Q790 51 885 97T1084 240Q1106 261 1126 261Q1142 261 1150 253T1159 231Q1159 210 1137 187Q1040 84 914 26T669
-33Q569 -33 479 8Q412 38 373 79Q313 142 274 228T234 397Q234 451 245 504L281 675Q308 799 403 929T628 1128T891 1197Q995 1197 1077 1162T1219 1055Z" />
<glyph unicode="D" glyph-name="D" d="M290 84L503 1086H433Q405 1086 395 1094T385 1120Q385 1140 401 1155T451 1170H902Q1065 1170 1172 1056T1280 754Q1280 704 1267 643L1242 527Q1215 397 1131 274T884 59Q779 0 653 0H202Q174 0 164 9T154 34Q154 54 170
69T220 84H290ZM375 84H680Q748 84 805 106T956 199Q1022 249 1079 336T1154 509L1186 661Q1195 700 1195 733Q1195 894 1107 990T893 1086H588L375 84Z" />
<glyph unicode="E" glyph-name="E" d="M461 565L359 84H1005L1057 332Q1064 362 1078 375T1112 388Q1126 388 1135 379T1145 358Q1145 349 1142 332L1071 0H144Q116 0 106 9T96 34Q96 54 112 69T162 84H275L488 1086H375Q347 1086 337 1094T327 1120Q327 1140
343 1155T393 1170H1276L1214 881Q1208 850 1194 838T1160 825Q1145 825 1136 834T1126 855Q1126 864 1130 881L1173 1086H572L479 649H780L800 744Q807 774 821 787T855 800Q869 800 879 791T889 769Q889 761 885 744L827 470Q820 440 806 427T772 414Q758 414
749 423T739 445Q739 454 742 470L762 565H461Z" />
<glyph unicode="F" glyph-name="F" d="M551 565L449 84H737Q765 84 775 76T785 51Q785 30 769 15T719 0H234Q206 0 196 9T186 34Q186 54 202 69T252 84H365L578 1086H465Q437 1086 427 1094T417 1120Q417 1140 433 1155T483 1170H1407L1346 881Q1340 850 1325
838T1291 825Q1277 825 1268 834T1258 855Q1258 864 1262 881L1305 1086H662L569 649H870L890 744Q897 774 911 787T945 800Q959 800 969 791T979 769Q979 761 975 744L917 470Q910 440 896 427T862 414Q848 414 839 423T829 445Q829 454 832 470L852 565H551Z"
/>
<glyph unicode="G" glyph-name="G" d="M1163 434L1087 74Q873 -33 678 -33Q446 -33 317 100Q221 200 221 376Q221 436 236 506L269 660Q298 798 395 929T626 1129T898 1197Q999 1197 1079 1170T1217 1086Q1229 1142 1240 1153Q1257 1170 1278 1170Q1292 1170 1301
1161T1311 1139Q1311 1131 1308 1114L1267 924Q1261 893 1247 881T1213 868Q1199 868 1190 876T1181 897Q1181 904 1183 920Q1185 929 1185 939Q1185 1001 1124 1046Q1033 1113 887 1113Q768 1113 663 1061T441 858Q377 775 353 659L320 506Q307 443 307 382Q307
235 409 143T703 51Q779 51 847 66T1013 123L1079 434H790Q762 434 752 443T742 468Q742 488 758 503T808 519L1211 518Q1239 518 1248 511Q1259 501 1259 485Q1259 471 1250 457T1226 438Q1215 434 1163 434Z" />
<glyph unicode="H" glyph-name="H" d="M1020 566H462L360 84H455Q501 84 511 76T521 51Q521 30 505 15T455 0H163Q135 0 126 11T117 39Q117 59 132 71T181 84H276L489 1086H395Q353 1086 339 1094T326 1123Q326 1142 339 1154T396 1171H677Q713 1166 722 1163T735
1139Q735 1118 723 1104T668 1086H573L480 650H1038L1130 1086H1035Q989 1086 979 1094T969 1120Q969 1140 985 1155T1035 1170H1285Q1339 1169 1356 1162T1375 1137Q1377 1116 1363 1103T1310 1086H1215L1002 84H1096Q1137 86 1149 73T1162 43Q1162 22 1142 11T1078
0H807Q779 0 768 7T756 31Q756 51 765 65T822 84H917L1020 566Z" />
<glyph unicode="I" glyph-name="I" d="M888 1086L675 84H963Q991 84 1001 76T1011 51Q1011 30 995 15T945 0H285Q257 0 247 9T237 34Q237 54 253 69T303 84H591L804 1086H516Q488 1086 478 1094T468 1120Q468 1140 484 1155T534 1170H1193Q1222 1170 1232 1162T1242
1137Q1242 1116 1225 1101T1176 1086H888Z" />
<glyph unicode="J" glyph-name="J" d="M1174 1086L1016 344Q984 190 846 79T551 -33Q454 -33 373 10T204 153L270 463Q276 493 290 506T325 519Q339 519 348 510T358 488Q358 479 354 463L297 193Q420 51 569 51Q648 51 719 85T852 191T932 344L1090 1086H760Q732
1086 722 1094T712 1120Q712 1140 728 1155T778 1170H1392Q1420 1170 1430 1162T1440 1137Q1440 1116 1424 1101T1374 1086H1174Z" />
<glyph unicode="K" glyph-name="K" d="M482 458L402 84H557Q585 84 595 76T605 51Q605 30 589 15T539 0H187Q159 0 149 9T139 34Q139 54 155 69T205 84H318L531 1086H418Q390 1086 380 1094T370 1120Q370 1140 386 1155T436 1170H788Q816 1170 826 1162T836 1137Q836
1116 820 1101T770 1086H615L505 569L1194 1086H1102Q1074 1086 1064 1094T1054 1120Q1054 1140 1070 1155T1120 1170H1367Q1396 1170 1406 1162T1416 1137Q1416 1122 1406 1108T1382 1089Q1371 1086 1315 1086L766 673Q861 631 915 568T1008 388Q1030 321 1075
84H1180Q1208 84 1218 76T1228 51Q1228 30 1212 15T1162 0H1000Q945 361 877 464T682 610L482 458Z" />
<glyph unicode="L" glyph-name="L" d="M700 1086L487 84H1045L1116 418Q1122 448 1137 461T1170 474Q1185 474 1194 465T1204 443Q1204 435 1201 418L1112 0H184Q156 0 146 9T136 34Q136 54 152 69T202 84H402L615 1086H415Q387 1086 377 1094T367 1120Q367 1140
383 1155T433 1170H918Q946 1170 956 1162T966 1137Q966 1116 950 1101T900 1086H700Z" />
<glyph unicode="M" glyph-name="M" d="M745 351H648L482 1086H466L253 84H408Q436 84 446 76T456 51Q456 30 440 15T390 0H80Q52 0 42 9T32 34Q32 54 48 69T98 84H168L381 1086H329Q301 1086 291 1094T281 1120Q281 1140 297 1155T347 1170H553L717 446L1183 1170H1390Q1418
1170 1428 1162T1438 1137Q1438 1116 1422 1101T1372 1086H1320L1107 84H1177Q1206 84 1216 76T1226 51Q1226 30 1209 15T1159 0H850Q822 0 812 9T801 34Q801 54 818 69T868 84H1022L1235 1086H1218L745 351Z" />
<glyph unicode="N" glyph-name="N" d="M1027 0H919L523 1047L318 84H473Q501 84 511 76T521 51Q521 30 505 15T455 0H145Q117 0 107 9T97 34Q97 54 113 69T163 84H233L446 1086H334Q306 1086 296 1094T286 1120Q286 1140 302 1155T352 1170H571L968 121L1173 1086H1018Q990
1086 980 1094T970 1120Q970 1140 986 1155T1036 1170H1346Q1374 1170 1384 1162T1394 1137Q1394 1116 1378 1101T1328 1086H1258L1027 0Z" />
<glyph unicode="O" glyph-name="O" d="M609 -33Q438 -33 325 90T211 424Q211 589 277 739T443 992T651 1146T870 1197Q1072 1197 1170 1056T1268 746Q1268 545 1169 358T915 69T609 -33ZM624 51Q749 51 882 140T1098 393T1181 724Q1181 902 1086 1007T857 1113Q763
1113 672 1069T496 935T354 716T297 448Q297 263 392 157T624 51Z" />
<glyph unicode="P" glyph-name="P" d="M564 480L480 84H768Q796 84 806 76T816 51Q816 30 800 15T750 0H265Q237 0 227 9T217 34Q217 54 233 69T283 84H396L609 1086H496Q468 1086 458 1094T448 1120Q448 1140 464 1155T514 1170H1002Q1154 1170 1241 1090T1328
893Q1328 825 1296 753T1202 623Q1166 589 1100 554T985 502Q918 480 827 480H564ZM582 564H850Q947 564 1059 617Q1142 658 1191 731T1241 870Q1241 960 1174 1023T992 1086H693L582 564Z" />
<glyph unicode="Q" glyph-name="Q" d="M618 -33L489 -117Q575 -100 630 -100Q717 -100 796 -132Q851 -155 884 -155Q942 -155 1023 -108Q1055 -90 1067 -90Q1082 -90 1091 -98T1100 -122Q1100 -140 1088 -154Q1069 -176 994 -207T861 -239Q819 -239 751 -212T613
-185Q565 -185 492 -197Q386 -214 321 -231Q300 -236 291 -236Q276 -236 267 -227T258 -203Q258 -176 290 -156L506 -21Q378 11 295 129T211 424Q211 589 277 739T443 992T651 1146T870 1197Q1041 1197 1154 1074T1268 740Q1268 543 1170 358T918 71T618 -33ZM624
51Q749 51 882 140T1098 393T1181 724Q1181 902 1086 1007T857 1113Q763 1113 672 1069T496 935T354 716T297 448Q297 263 392 157T624 51Z" />
<glyph unicode="R" glyph-name="R" d="M453 522L360 84H515Q543 84 553 76T563 51Q563 30 547 15T497 0H145Q117 0 107 9T97 34Q97 54 113 69T163 84H276L489 1086H376Q348 1086 338 1094T328 1120Q328 1140 344 1155T394 1170H901Q1039 1170 1124 1091T1210 901Q1210
797 1127 701T852 544Q928 483 975 407T1112 84H1177Q1205 84 1215 76T1225 51Q1225 30 1209 15T1159 0H1046Q952 278 886 373T719 522H453ZM471 606H699Q815 606 921 652T1076 762T1125 882Q1125 962 1057 1024T882 1086H573L471 606Z" />
<glyph unicode="S" glyph-name="S" d="M1146 1086Q1158 1142 1168 1153Q1185 1170 1207 1170Q1221 1170 1230 1161T1240 1139Q1240 1131 1236 1114L1191 900Q1184 870 1170 857T1136 844Q1122 844 1113 853T1103 875Q1103 882 1105 895T1108 923Q1108 998 1040
1055T853 1113Q695 1113 595 1026T494 831Q494 752 554 711Q614 669 765 643T969 596Q1043 566 1081 514T1119 385Q1119 281 1058 184T871 27T612 -33Q503 -33 423 1T292 104L282 56Q276 26 261 13T227 0Q213 0 204 9T194 31Q194 40 197 56L247 288Q253 319 267
332T301 345Q316 345 325 336T335 315Q335 308 333 294T330 266Q330 180 408 116T631 51Q740 51 838 97T984 217T1033 364Q1033 419 1004 459T915 523Q876 539 742 563Q563 594 486 650Q408 706 408 814Q408 961 539 1079T867 1197Q955 1197 1025 1170T1146 1086Z"
/>
<glyph unicode="T" glyph-name="T" d="M887 1086L674 84H892Q920 84 930 76T940 51Q940 30 924 15T874 0H353Q325 0 315 9T305 34Q305 54 321 69T371 84H589L802 1086H458L396 795Q390 764 376 751T342 738Q327 738 318 747T308 769Q308 778 312 795L392 1170H1333L1253
795Q1247 764 1232 751T1198 738Q1184 738 1175 747T1165 769Q1165 778 1169 795L1231 1086H887Z" />
<glyph unicode="U" glyph-name="U" d="M1252 1086L1103 384Q1065 205 921 86T605 -33Q463 -33 372 58T281 296Q281 336 291 384L440 1086H370Q342 1086 332 1094T322 1119Q322 1140 338 1155T388 1170H698Q726 1170 736 1162T746 1137Q746 1116 729 1101T680 1086H525L376
384Q368 348 368 311Q368 198 440 125T620 51Q705 51 781 88T927 205T1018 384L1168 1086H1013Q985 1086 975 1094T964 1120Q964 1140 981 1155T1031 1170H1340Q1369 1170 1378 1162T1388 1137Q1388 1116 1372 1101T1322 1086H1252Z" />
<glyph unicode="V" glyph-name="V" d="M677 0H560L368 1086H303Q281 1086 273 1089T260 1101T255 1120Q255 1133 263 1145T284 1164T321 1170H633Q656 1170 663 1167T676 1155T682 1137Q682 1123 674 1111T653 1092T615 1086H455L632 84H638L1236 1086H1076Q1053
1086 1045 1089T1032 1101T1027 1120Q1027 1133 1035 1145T1056 1164T1094 1170H1406Q1428 1170 1436 1167T1449 1155T1454 1137Q1454 1123 1446 1111T1426 1092T1388 1086H1324L677 0Z" />
<glyph unicode="W" glyph-name="W" d="M983 0H852L790 831L380 0H248L356 1086H325Q297 1086 287 1094T276 1120Q276 1140 293 1155T343 1170H655Q683 1170 693 1162T703 1137Q703 1116 687 1101T637 1086H440L341 96L742 911H870L930 96L1249 1086H1052Q1024
1086 1014 1094T1004 1120Q1004 1140 1020 1155T1070 1170H1381Q1409 1170 1419 1162T1429 1137Q1429 1122 1419 1109T1395 1090Q1385 1086 1332 1086L983 0Z" />
<glyph unicode="X" glyph-name="X" d="M792 599L1082 84H1113Q1142 84 1152 76T1162 51Q1162 30 1145 15T1095 0H826Q798 0 788 9T778 34Q778 54 794 69T844 84H978L726 530L288 84H422Q450 84 460 76T470 51Q470 30 454 15T404 0H136Q108 0 98 9T88 34Q88 48
98 62T122 81Q132 84 185 84L689 599L416 1086H385Q357 1086 347 1094T337 1120Q337 1140 353 1155T403 1170H632Q660 1170 670 1162T680 1137Q680 1116 664 1101T614 1086H519L755 667L1166 1086H1071Q1043 1086 1033 1094T1023 1120Q1023 1140 1039 1155T1089
1170H1319Q1347 1170 1357 1162T1367 1137Q1367 1122 1358 1109T1334 1090Q1323 1086 1270 1086L792 599Z" />
<glyph unicode="Y" glyph-name="Y" d="M770 528L676 84H894Q922 84 932 76T942 51Q942 30 926 15T876 0H355Q327 0 317 9T307 34Q307 54 323 69T373 84H591L686 528L435 1086H385Q357 1086 347 1094T337 1120Q337 1140 353 1155T403 1170H634Q662 1170 672 1162T682
1137Q682 1116 666 1101T616 1086H533L746 613L1154 1086H1072Q1043 1086 1033 1094T1023 1120Q1023 1140 1039 1155T1089 1170H1320Q1348 1170 1358 1162T1368 1137Q1368 1116 1352 1101T1302 1086H1252L770 528Z" />
<glyph unicode="Z" glyph-name="Z" d="M1022 0H213L239 122L1124 1079L1126 1086H567L514 839Q507 808 493 795T459 782Q445 782 436 791T426 813Q426 822 430 839L500 1170H1225L1200 1051L313 93L312 84H956L1018 377Q1024 408 1039 421T1072 434Q1087 434 1096
425T1106 403Q1106 394 1102 377L1022 0Z" />
<glyph unicode="[" glyph-name="bracketleft" d="M906 1170L620 -175H823Q852 -175 862 -183T872 -209Q872 -229 855 -244T806 -259H518L840 1255H1127Q1150 1255 1157 1252T1170 1240T1176 1221Q1176 1201 1159 1186T1109 1170H906Z" />
<glyph unicode="\" glyph-name="backslash" d="M600 1346L967 -102Q972 -118 972 -127Q972 -144 956 -159T920 -175Q906 -175 898 -168T883 -138L516 1311Q512 1326 512 1335Q512 1352 528 1367T563 1383Q578 1383 586 1376T600 1346Z" />
<glyph unicode="]" glyph-name="bracketright" d="M538 -175L824 1170H621Q593 1170 584 1178Q573 1188 573 1204Q573 1224 589 1239T639 1255H927L605 -259H317Q289 -259 280 -252Q269 -242 269 -226Q269 -205 285 -190T335 -175H538Z" />
<glyph unicode="^" glyph-name="asciicircum" d="M886 1279L1156 816Q1168 797 1168 787Q1168 768 1152 753T1115 737Q1095 737 1079 763L858 1147L475 763Q448 736 427 736Q412 736 403 745T393 770Q393 781 397 789T420 816L886 1279Z" />
<glyph unicode="_" glyph-name="underscore" d="M1081 -561H-90Q-112 -561 -119 -558T-132 -546T-138 -527Q-138 -507 -122 -492T-72 -477H1099Q1127 -477 1136 -484Q1148 -494 1148 -510Q1148 -531 1131 -546T1081 -561Z" />
<glyph unicode="`" glyph-name="grave" d="M663 1309L856 1105Q874 1080 874 1073Q874 1053 858 1037T821 1021Q805 1021 787 1041L594 1245Q577 1264 577 1277Q577 1297 593 1313T630 1329Q638 1329 645 1326T663 1309Z" />
<glyph unicode="a" glyph-name="a" d="M857 0L882 121Q667 -33 458 -33Q324 -33 256 27T188 177Q188 314 308 412Q457 535 697 535Q812 535 964 504L993 640Q996 655 996 670Q996 728 950 763Q888 811 773 811Q676 811 475 751Q452 744 442 744Q429 744 420 753T411
777Q411 796 425 811T538 851Q711 896 795 896Q938 896 1010 833T1083 691Q1083 665 1077 640L959 84H1072Q1100 84 1110 76T1120 51Q1120 30 1104 15T1054 0H857ZM946 418Q833 451 688 451Q487 451 366 358Q275 288 275 198Q275 133 322 92T469 51Q578 51 681
93T906 233L946 418Z" />
<glyph unicode="b" glyph-name="b" d="M565 1255L447 698Q639 896 855 896Q1012 896 1113 795T1215 539Q1215 402 1138 265T925 48T659 -33Q437 -33 333 165L298 0H101Q73 0 63 9T53 34Q53 54 69 69T119 84H232L462 1170H350Q322 1170 312 1179T302 1204Q302 1224
318 1239T368 1255H565ZM675 51Q754 51 833 87T978 184T1085 333T1128 522Q1128 643 1044 727T834 811Q733 811 618 745T442 568T381 344Q381 220 465 136T675 51Z" />
<glyph unicode="c" glyph-name="c" d="M1131 781Q1143 838 1154 849Q1171 866 1192 866Q1206 866 1215 857T1225 835Q1225 826 1222 809L1181 619Q1174 588 1160 575T1127 562Q1112 562 1103 571T1093 592Q1093 598 1095 612Q1096 620 1096 628Q1096 696 1032
745Q948 811 809 811Q687 811 579 752T404 574T337 341Q337 210 420 131T650 51Q746 51 855 86T1065 203Q1090 223 1107 223Q1121 223 1130 215T1139 192Q1139 172 1119 151Q1048 77 907 22T621 -33Q452 -33 351 64T250 318Q250 437 300 545T428 728T606 849T831
896Q928 896 1003 868T1131 781Z" />
<glyph unicode="d" glyph-name="d" d="M1292 1255L1043 84H1156Q1184 84 1194 76T1204 51Q1204 30 1188 15T1138 0H940L976 167Q788 -33 559 -33Q407 -33 307 69T207 335Q207 468 287 605T500 819T761 896Q981 896 1089 696L1189 1170H1077Q1049 1170 1039 1179T1028
1204Q1028 1224 1045 1239T1095 1255H1292ZM583 51Q673 51 752 88T896 188T1001 339T1041 519Q1041 645 959 728T751 811Q574 811 434 670T293 350Q293 218 375 135T583 51Z" />
<glyph unicode="e" glyph-name="e" d="M1158 413H302Q299 382 299 366Q299 229 392 140T644 51Q737 51 846 81T1033 164Q1056 179 1070 179Q1083 179 1092 170T1101 145Q1101 127 1085 111Q1039 62 901 15T621 -33Q437 -33 326 76T214 353Q214 464 262 562T388
732T569 850T793 896Q965 896 1069 795T1174 537Q1174 485 1158 413ZM1090 498Q1095 636 1008 724Q920 811 772 811Q628 811 503 726T320 498H1090Z" />
<glyph unicode="f" glyph-name="f" d="M725 781L577 84H946Q974 84 984 76T994 51Q994 30 978 15T928 0H271Q243 0 233 9T223 34Q223 54 239 69T289 84H492L640 781H458Q430 781 420 790T410 815Q410 835 426 850T476 866H658L685 993Q708 1100 810 1177T1056
1255Q1167 1255 1295 1235Q1350 1226 1358 1217T1367 1195Q1367 1174 1352 1159T1312 1144Q1305 1144 1287 1147Q1141 1170 1039 1170Q926 1170 855 1116T770 993L743 866H1136Q1164 866 1173 858Q1184 848 1184 832Q1184 812 1168 797T1118 781H725Z" />
<glyph unicode="g" glyph-name="g" d="M1048 712L1081 866H1278Q1306 866 1315 858Q1327 848 1327 832Q1327 812 1310 797T1260 781H1148L969 -58Q952 -139 904 -205Q870 -251 801 -299T684 -366T558 -386H320Q292 -386 282 -377T272 -353Q272 -332 288 -317T338
-301L579 -302Q650 -302 717 -266T841 -154Q873 -112 887 -46L941 206Q766 21 550 21Q405 21 309 118T213 369Q213 476 263 574T384 740T545 852T740 896Q953 896 1048 712ZM573 106Q658 106 733 141T868 233T965 372T1003 539Q1003 656 925 733T729 811Q562 811
431 680T299 384Q299 262 377 184T573 106Z" />
<glyph unicode="h" glyph-name="h" d="M606 1255L496 738Q596 826 677 861T847 896Q977 896 1047 830T1118 662Q1118 635 1112 605L1001 84H1096Q1124 84 1134 76T1144 51Q1144 30 1128 15T1078 0H804Q776 0 766 9T756 34Q756 54 772 69T822 84H917L1026 599Q1031
621 1031 644Q1031 718 980 765T827 812Q743 812 681 781T470 616L357 84H452Q480 84 490 76T500 51Q500 30 484 15T434 0H160Q132 0 122 9T112 34Q112 54 128 69T178 84H273L503 1170H391Q363 1170 353 1179T343 1204Q343 1224 359 1239T409 1255H606Z" />
<glyph unicode="i" glyph-name="i" d="M931 1297L885 1080H762L808 1297H931ZM843 866L677 84H1007Q1035 84 1045 76T1055 51Q1055 30 1039 15T989 0H245Q217 0 207 9T197 34Q197 54 213 69T263 84H593L741 781H496Q468 781 458 790T447 815Q447 835 464 850T514
866H843Z" />
<glyph unicode="j" glyph-name="j" d="M1010 1297L964 1080H841L887 1297H1010ZM906 781H407Q379 781 369 790T359 815Q359 835 375 850T425 866H1008L812 -59Q788 -169 728 -240T569 -356Q503 -386 421 -386H154Q126 -386 116 -377T106 -353Q106 -332 122 -317T172
-301L437 -302Q544 -302 613 -242Q705 -163 727 -59L906 781Z" />
<glyph unicode="k" glyph-name="k" d="M464 374L384 0H187Q159 0 149 9T139 34Q139 54 155 69T205 84H318L548 1170H436Q408 1170 398 1179T388 1204Q388 1224 404 1239T454 1255H651L486 481L907 781H864Q836 781 826 790T816 815Q816 835 832 850T882 866H1151Q1179
866 1188 858Q1200 848 1200 832Q1200 812 1183 797T1133 781H1036L650 507L975 84H1072Q1100 84 1110 76T1120 51Q1120 30 1104 15T1054 0H782Q754 0 744 9T734 34Q734 54 750 69T800 84H858L577 455L464 374Z" />
<glyph unicode="l" glyph-name="l" d="M925 1255L676 84H1006Q1034 84 1044 76T1054 51Q1054 30 1038 15T988 0H244Q216 0 206 9T196 34Q196 54 212 69T262 84H592L823 1170H580Q552 1170 542 1179T532 1204Q532 1224 548 1239T598 1255H925Z" />
<glyph unicode="m" glyph-name="m" d="M416 866L398 781Q529 896 639 896Q699 896 742 861T804 757Q875 827 940 861T1064 896Q1138 896 1187 846T1236 715Q1236 695 1230 671L1106 84H1176Q1205 84 1215 76T1225 51Q1225 30 1208 15T1158 0H1003L1144 663Q1148
680 1148 697Q1148 750 1120 780T1049 811Q1003 811 953 783Q886 744 798 641L679 84H750Q778 84 788 76T798 51Q798 30 782 15T732 0H577L717 657Q721 677 721 696Q721 747 692 779T623 811Q578 811 529 784Q458 743 368 641L250 84H320Q349 84 359 76T369 51Q369
30 352 15T302 0H77Q49 0 39 9T29 34Q29 54 45 69T95 84H165L314 781H243Q215 781 205 790T195 815Q195 835 211 850T261 866H416Z" />
<glyph unicode="n" glyph-name="n" d="M527 866L500 739Q610 830 687 863T855 896Q979 896 1049 830T1120 659Q1120 639 1115 613L1002 84H1073Q1101 84 1111 76T1121 51Q1121 30 1105 15T1055 0H829Q801 0 791 9T781 34Q781 54 797 69T847 84H918L1027 599Q1032
622 1032 643Q1032 716 981 763T835 811Q748 811 680 776T473 611L361 84H456Q484 84 494 76T504 51Q504 30 488 15T438 0H164Q136 0 126 9T116 34Q116 54 132 69T182 84H277L425 781H354Q326 781 316 790T306 815Q306 835 322 850T372 866H527Z" />
<glyph unicode="o" glyph-name="o" d="M604 -33Q439 -33 333 71T227 337Q227 468 307 603T526 817T809 896Q973 896 1079 792T1185 533Q1185 397 1108 263T890 48T604 -33ZM623 51Q741 51 856 117T1035 294T1099 515Q1099 641 1012 726T790 811Q693 811 610 773T462
674T355 529T313 354Q313 223 400 137T623 51Z" />
<glyph unicode="p" glyph-name="p" d="M482 866L450 713Q546 806 641 851T853 896Q1020 896 1119 800T1218 550Q1218 347 1052 184T667 21Q443 21 342 204L234 -302H437Q460 -302 467 -305T480 -316T486 -335Q486 -356 469 -371T419 -386H19Q-9 -386 -19 -377T-29
-353Q-29 -332 -13 -317T37 -302H150L380 781H267Q239 781 229 790T219 815Q219 835 235 850T285 866H482ZM682 106Q861 106 996 237T1131 535Q1131 652 1049 731T838 811Q659 811 524 680T388 388Q388 267 470 187T682 106Z" />
<glyph unicode="q" glyph-name="q" d="M1092 713L1125 866H1322Q1350 866 1360 857T1370 832Q1370 812 1354 797T1304 781H1191L961 -302H1073Q1096 -302 1103 -305T1116 -316T1122 -335Q1122 -356 1105 -371T1055 -386H655Q627 -386 617 -377T607 -353Q607 -332
623 -317T673 -302H876L984 204Q806 21 579 21Q417 21 317 119T216 367Q216 493 290 620T497 821T767 896Q992 896 1092 713ZM596 106Q708 106 817 167T985 330T1045 533Q1045 651 963 731T751 811Q573 811 438 680T302 387Q302 267 384 187T596 106Z" />
<glyph unicode="r" glyph-name="r" d="M698 866L653 654Q852 804 941 845T1099 887Q1167 887 1221 841T1276 769Q1276 748 1260 732T1222 716Q1212 716 1206 719T1185 742Q1158 777 1135 790T1087 803Q1031 803 945 759T630 544L532 84H904Q933 84 943 76T953
51Q953 30 936 15T886 0H227Q199 0 189 8T179 32Q179 52 195 66T244 81H447L596 781H441Q413 781 403 790T393 814Q393 835 409 850T459 866H698Z" />
<glyph unicode="s" glyph-name="s" d="M1065 811Q1071 840 1086 853T1119 866Q1134 866 1143 857T1153 835Q1153 826 1149 809L1119 665Q1112 635 1098 622T1064 609Q1050 609 1041 618T1031 639L1032 656Q1033 664 1033 671Q1033 725 985 759Q914 811 786 811Q632
811 541 745Q473 696 473 641Q473 587 532 553Q575 529 714 514T913 478Q997 451 1038 400T1079 285Q1079 211 1025 137T860 15T610 -33Q511 -33 435 -8T306 68Q298 27 286 15Q269 0 249 0Q235 0 226 9T216 31Q216 40 219 56L256 229Q262 259 277 272T311 285Q325
285 334 276T344 253Q344 245 341 230T338 208Q338 151 397 108Q475 51 625 51Q804 51 898 122T992 263Q992 301 965 337T881 395T698 430T512 464T420 527T387 623Q387 686 430 746T573 851T799 896Q886 896 952 875T1065 811Z" />
<glyph unicode="t" glyph-name="t" d="M630 866H1086Q1115 866 1124 858T1134 833Q1134 815 1127 804T1110 787Q1097 781 1068 781H612L493 222Q488 198 488 178Q488 130 537 91T682 51Q771 51 875 76T1042 134Q1065 147 1078 147Q1092 147 1101 138T1110 112Q1110
91 1085 73Q1024 29 870 -7Q759 -33 664 -33Q539 -33 471 25T402 165Q402 191 408 222L527 781H372Q344 781 334 790T324 815Q324 835 340 850T390 866H545L598 1114Q604 1144 619 1157T653 1170Q667 1170 676 1161T686 1139Q686 1131 682 1114L630 866Z" />
<glyph unicode="u" glyph-name="u" d="M902 0L928 123Q723 -33 520 -33Q420 -33 362 24T303 171Q303 203 311 239L426 781H313Q285 781 275 790T265 815Q265 835 281 850T331 866H528L395 239Q391 218 391 196Q391 130 430 91T536 51Q743 51 953 239L1068 781H913Q885
781 875 790T865 815Q865 835 881 850T931 866H1170L1004 84H1075Q1103 84 1113 76T1123 51Q1123 30 1107 15T1057 0H902Z" />
<glyph unicode="v" glyph-name="v" d="M688 0H546L367 781H281Q253 781 243 790T233 815Q233 835 249 850T299 866H614Q642 866 651 858Q662 848 662 832Q662 812 646 797T596 781H457L617 84H654L1104 781H964Q936 781 926 790T916 815Q916 835 932 850T982 866H1298Q1326
866 1335 858Q1346 848 1346 832Q1346 812 1330 797T1280 781H1195L688 0Z" />
<glyph unicode="w" glyph-name="w" d="M905 0L800 -1L730 539L432 -1L328 0L320 781H279Q251 781 241 790T231 815Q231 835 247 850T297 866H528Q556 866 565 858Q576 848 576 832Q576 812 560 797T510 781H403L411 115L702 647H802L873 115L1158 781H1052Q1024
781 1014 790T1003 815Q1003 835 1020 850T1070 866H1300Q1328 866 1337 858Q1348 848 1348 832Q1348 812 1332 797T1282 781H1242L905 0Z" />
<glyph unicode="x" glyph-name="x" d="M769 453L1075 84Q1111 84 1119 82T1133 71T1139 51Q1139 30 1123 15T1073 0H802Q774 0 764 9T754 34Q754 54 770 69T820 84H960L699 397L308 84H448Q476 84 486 76T496 51Q496 30 480 15T430 0H157Q129 0 119 9T109 34Q109
48 118 61T141 80Q151 84 191 84L654 453L382 781Q348 781 340 784T326 795T320 815Q320 835 336 850T386 866H616Q644 866 653 858Q664 848 664 832Q664 812 648 797T598 781H497L723 508L1066 781H966Q938 781 928 790T917 815Q917 835 933 850T984 866H1213Q1241
866 1249 858Q1261 848 1261 832Q1261 819 1252 806T1231 787T1181 781L769 453Z" />
<glyph unicode="y" glyph-name="y" d="M571 0L348 781H323Q295 781 285 790T274 815Q274 828 282 841T303 860T341 866H570Q592 866 600 863T613 851T618 832Q618 812 602 797T552 781H440L635 92L1120 781H1008Q980 781 970 790T959 815Q959 835 975 850T1026
866H1255Q1283 866 1291 858Q1303 848 1303 832Q1303 818 1294 805T1270 785Q1259 781 1211 781L449 -302H580Q602 -302 610 -305T623 -316T628 -335Q628 -356 612 -371T562 -386H78Q50 -386 40 -377T30 -353Q30 -332 46 -317T96 -302H360L571 0Z" />
<glyph unicode="z" glyph-name="z" d="M1166 866L1150 791L371 84H939L964 200Q970 230 984 243T1018 256Q1033 256 1042 247T1052 226Q1052 216 1048 200L1005 0H237L253 75L1030 781H507L483 667Q476 636 462 624T428 611Q414 611 405 620T395 641Q395 650 398
667L441 866H1166Z" />
<glyph unicode="{" glyph-name="braceleft" d="M671 498Q705 467 716 445Q731 416 731 378Q731 353 724 319L648 -40Q644 -57 644 -75Q644 -117 669 -144T734 -175Q763 -177 770 -184Q780 -193 780 -208Q780 -229 764 -244T721 -260Q650 -260 604 -213T557 -90Q557
-67 563 -41L639 319Q643 335 643 352Q643 395 618 422T551 453Q526 455 519 463Q509 472 509 487Q509 509 523 524T570 542Q623 547 663 584T715 676L792 1036Q812 1131 885 1193T1043 1255Q1064 1255 1074 1246T1084 1221Q1084 1202 1070 1188T1020 1170Q968
1165 928 1128T876 1036L800 676Q787 614 759 575T671 498Z" />
<glyph unicode="|" glyph-name="bar" d="M657 1198L656 -203Q656 -233 645 -246T614 -259Q596 -259 584 -246T572 -203V1198Q572 1229 584 1242T614 1255Q633 1255 645 1242T657 1198Z" />
<glyph unicode="}" glyph-name="braceright" d="M770 498Q735 528 724 550Q710 580 710 617Q710 643 717 676L793 1036Q797 1053 797 1070Q797 1112 772 1139T707 1170Q678 1173 671 1179Q661 1189 661 1203Q661 1224 677 1239T721 1255Q791 1255 837 1208T883
1084Q883 1062 878 1036L801 676Q798 660 798 644Q798 601 823 573T890 542Q915 540 922 533Q932 523 932 509Q932 486 918 471T871 453Q818 449 778 412T725 319L649 -41Q629 -136 556 -198T398 -260Q377 -260 367 -251T357 -226Q357 -206 371 -193T421 -175Q473
-170 513 -132T565 -40L641 319Q654 381 682 420T770 498Z" />
<glyph unicode="~" glyph-name="asciitilde" d="M1145 668Q1158 668 1167 659T1177 636Q1177 619 1158 598Q1089 520 1002 469Q939 432 888 432Q845 432 804 456T706 549T622 634T573 651Q541 651 507 632T398 544Q364 512 354 507T333 501Q319 501 310 509T301
533Q301 554 348 599T448 683Q521 735 588 735Q628 735 663 717T751 639Q835 543 856 530T900 517Q970 517 1072 619Q1110 656 1121 662T1145 668Z" />
</font>

<font horiz-adv-x="1229" ><font-face
    font-family="CourierNew"
    units-per-em="2048"
    panose-1="2 7 3 9 2 2 5 2 4 4"
    ascent="1705"
    descent="-615"
    alphabetic="0" />
<missing-glyph d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" />
<glyph unicode="!" glyph-name="exclam" d="M695 1170L657 492Q655 460 644 447T615 434Q597 434 586 447T572 492L535 1170Q533 1194 533 1205Q533 1239 556 1262T615 1285Q650 1285 673 1262T696 1204Q696 1194 695 1170ZM595 178H634Q677 178 707 148T738 74Q738
30 707 0T634 -30H595Q552 -30 522 0T491 73Q491 118 522 148T595 178Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" d="M266 1234H532L462 748Q456 710 440 695T399 679Q374 679 358 694T336 748L266 1234ZM695 1234H961L891 748Q885 710 869 695T829 679Q803 679 787 694T766 748L695 1234Z" />
<glyph unicode="#" glyph-name="numbersign" d="M800 740L782 476H943Q973 476 986 465T999 434Q999 415 986 404T943 392H776L743 -76Q741 -106 730 -118T701 -130L684 -126Q659 -111 659 -85V-70L692 392H502L470 -76Q468 -106 456 -118T428 -130L410 -126Q385
-111 385 -85L386 -70L418 392H243Q213 392 200 403T187 434Q187 453 200 464T243 476H424L442 740H286Q255 740 242 751T229 782Q229 801 242 812T286 824H448L481 1292Q483 1321 495 1333T523 1346L541 1342Q566 1326 566 1302L565 1286L533 824H722L755 1292Q757
1321 768 1333T797 1346L814 1342Q840 1326 840 1302L839 1286L806 824H985Q1015 824 1028 813T1041 782Q1041 763 1028 752T985 740H800ZM716 740H527L508 476H698L716 740Z" />
<glyph unicode="$" glyph-name="dollar" d="M571 1198V1304Q571 1335 582 1348T613 1361Q632 1361 643 1348T655 1304V1198Q723 1192 767 1177T871 1121Q872 1146 884 1158T913 1170Q932 1170 944 1157T956 1114V989Q956 959 944 946T913 933Q897 933 886 943T871
979Q865 1026 809 1064Q727 1118 616 1118Q503 1118 430 1052T356 903Q356 820 421 776Q470 742 627 713T841 657Q921 622 960 562T1000 417Q1000 303 911 217T655 113V-134Q655 -165 644 -178T613 -191Q594 -191 583 -178T571 -134V113Q417 123 312 213Q312 169
309 160T294 143T270 135Q252 135 240 148T228 191V355Q228 385 239 398T270 412Q288 412 301 399Q310 390 312 359Q318 306 397 251T613 195Q754 195 835 262T916 418Q916 477 886 519T792 588Q750 605 616 630Q422 668 347 728Q271 788 271 904Q271 1012 353
1097T571 1198Z" />
<glyph unicode="%" glyph-name="percent" d="M742 1016Q742 908 667 832T486 756Q380 756 305 832T230 1016Q230 1124 305 1199T486 1275Q592 1275 667 1200T742 1016ZM682 1016Q682 1099 625 1157T486 1215Q405 1215 348 1157T290 1016Q290 933 347 875T486 817Q567
817 624 875T682 1016ZM1014 725L236 472Q222 468 215 468Q204 468 196 477T187 498Q187 508 194 518Q199 524 217 530L995 783Q1009 787 1017 787Q1027 787 1035 778T1044 757Q1044 747 1037 737Q1032 731 1014 725ZM1001 235Q1001 127 926 52T744 -24Q639 -24
564 52T488 235Q488 343 563 419T744 495Q850 495 925 419T1001 235ZM940 235Q940 319 883 376T744 434Q663 434 606 376T548 235Q548 153 605 95T744 36Q825 36 882 94T940 235Z" />
<glyph unicode="&amp;" glyph-name="ampersand" d="M852 0L788 99Q698 -33 556 -33Q436 -33 345 62T254 294Q254 400 315 482T485 596Q411 715 397 752T382 830Q382 929 457 1003T637 1078Q671 1078 705 1068T773 1037Q816 1059 826 1059Q843 1059 855 1047T868
1016Q868 1004 861 994T833 973L768 938Q737 966 705 979T638 993Q569 993 518 942T466 828Q466 763 556 620L788 251Q849 366 884 517H966Q996 517 1009 505T1022 475Q1022 462 1015 451T997 436T948 432Q900 263 838 170L895 84H966Q996 84 1009 73T1022 42Q1022
24 1009 12T966 0H852ZM521 522Q437 502 388 441T338 294Q338 193 404 122T554 51Q666 51 739 177L521 522Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" d="M481 1255H747L677 730Q671 688 655 672T614 655Q589 655 573 671T551 730L481 1255Z" />
<glyph unicode="(" glyph-name="parenleft" d="M605 498Q605 613 635 742T750 1040T874 1244Q886 1255 900 1255Q918 1255 930 1243T943 1214Q943 1204 936 1192Q826 990 779 826T732 498Q732 333 779 169T936 -196Q943 -208 943 -218Q943 -235 931 -247T900 -260Q886
-260 874 -249Q837 -215 753 -50T637 242T605 498Z" />
<glyph unicode=")" glyph-name="parenright" d="M639 497Q639 382 609 254T494 -44T370 -248Q358 -260 344 -260Q326 -260 314 -248T301 -218Q301 -208 308 -196Q418 5 465 169T512 497Q512 662 465 826T308 1192Q301 1204 301 1214Q301 1231 313 1243T344 1255Q358
1255 370 1244Q407 1210 491 1045T607 753T639 497Z" />
<glyph unicode="*" glyph-name="asterisk" d="M342 911V1198Q342 1229 354 1242T385 1255Q403 1255 415 1242T427 1198V911L700 1000Q719 1006 729 1006Q745 1006 757 994T769 964Q769 949 761 938T726 919L453 830L622 598Q638 575 638 562Q638 544 626 532T596
519Q574 519 553 548L384 781L215 548Q194 519 173 519Q155 519 143 531T130 562Q130 575 147 598L316 830L42 920Q17 928 9 938T0 964Q0 981 12 993T39 1006Q50 1006 69 1000L342 911Z" />
<glyph unicode="+" glyph-name="plus" d="M657 543V123Q657 93 645 80T614 67Q596 67 584 80T572 123V543H200Q170 543 157 554T144 585Q144 604 157 615T200 627H572V1045Q572 1075 584 1088T615 1101Q633 1101 645 1088T657 1045V627H1029Q1059 627 1072 616T1085
585Q1085 566 1072 555T1029 543H657Z" />
<glyph unicode="," glyph-name="comma" d="M448 302H721L424 -250Q397 -300 359 -300Q334 -300 317 -283T299 -240Q299 -230 302 -218L448 302Z" />
<glyph unicode="-" glyph-name="hyphen" d="M1043 639V519H186V639H1043Z" />
<glyph unicode="." glyph-name="period" d="M597 241H633Q689 241 729 202T769 106Q769 48 729 9T633 -30H597Q541 -30 501 9T461 105Q461 163 501 202T597 241Z" />
<glyph unicode="/" glyph-name="slash" d="M992 1316L316 -132Q299 -169 272 -169Q255 -169 243 -157T230 -129Q230 -117 240 -96L915 1352Q926 1375 936 1382T960 1389Q977 1389 989 1377T1002 1349Q1002 1338 992 1316Z" />
<glyph unicode="0" glyph-name="zero" d="M1000 731V523Q1000 252 871 94Q770 -30 616 -30Q542 -30 477 -1T365 82Q336 115 302 188T252 322Q229 408 229 523V731Q229 1003 358 1161Q459 1285 613 1285Q688 1285 753 1256T864 1173Q894 1139 928 1066T978 933Q1000
847 1000 731ZM916 720Q916 839 883 941T807 1105Q782 1140 742 1165Q685 1200 614 1200Q473 1200 393 1056T313 720V535Q313 416 346 313T423 149Q447 115 487 90Q544 54 616 54Q756 54 836 198T916 535V720Z" />
<glyph unicode="1" glyph-name="one" d="M656 1272V84H944Q974 84 987 73T1000 42Q1000 24 987 12T944 0H284Q254 0 241 12T228 42Q228 61 241 72T284 84H572V1156L298 1070Q278 1064 269 1064Q254 1064 242 1076T229 1106Q229 1121 239 1134Q247 1142 272 1151L656
1272Z" />
<glyph unicode="2" glyph-name="two" d="M253 84H898V117Q898 147 910 160T941 173Q959 173 971 160T983 117V0H171V124Q427 354 669 592Q782 703 824 755T881 846T897 926Q897 1034 810 1117T600 1200Q490 1200 405 1137T295 981Q289 957 280 950Q268 940 252
940Q235 940 224 951T212 979Q212 1027 264 1109T409 1238T599 1285Q756 1285 869 1176T982 929Q982 871 963 823T899 717T735 543Q439 251 253 90V84Z" />
<glyph unicode="3" glyph-name="three" d="M787 683Q903 631 964 541T1025 352Q1025 201 903 86T596 -30Q488 -30 372 16T210 110Q195 126 195 144Q195 160 206 172T234 184Q250 184 270 169Q425 54 598 54Q744 54 842 145T941 349Q941 424 893 496T753 609T569
651Q539 651 526 662T513 693Q513 711 525 723T563 735L635 734Q748 734 821 803T895 963Q895 1057 818 1129T617 1201Q530 1201 457 1171T340 1089Q324 1069 316 1065T296 1060Q279 1060 267 1071T255 1099Q255 1139 342 1200Q463 1285 617 1285Q776 1285 878
1190T980 962Q980 878 931 803T787 683Z" />
<glyph unicode="4" glyph-name="four" d="M771 351H214V448L681 1255H856V435H926Q957 435 970 424T983 393Q983 375 970 363T926 351H856V84H926Q957 84 970 73T983 42Q983 24 970 12T926 0H614Q583 0 570 12T557 42Q557 61 570 72T614 84H771V351ZM771 435V1170H727L302
435H771Z" />
<glyph unicode="5" glyph-name="five" d="M383 1170V759Q457 790 525 805T654 821Q812 821 918 710T1025 418Q1025 218 905 94T605 -30Q486 -30 376 23Q298 60 234 115Q196 148 196 170Q196 188 208 200T236 213Q253 213 272 195Q423 54 601 54Q748 54 844 154T940
422Q940 564 857 650T646 737Q515 737 384 668Q352 652 339 652Q321 652 310 664T299 698V1255H885Q915 1255 928 1243T941 1212Q941 1194 928 1182T885 1170H383Z" />
<glyph unicode="6" glyph-name="six" d="M364 531Q442 646 524 701T708 756Q842 756 946 645T1050 369Q1050 219 955 95T693 -30Q584 -30 490 37T341 243Q274 416 274 626Q274 784 337 920Q385 1025 465 1104T651 1234T882 1285Q966 1285 1022 1251Q1046 1236
1046 1211Q1046 1193 1035 1182T1007 1170Q994 1170 976 1180Q935 1200 874 1200Q679 1200 519 1033T358 634Q358 601 364 531ZM383 392Q421 210 502 132T695 54Q807 54 886 141T966 369Q966 500 886 586T705 672Q608 672 518 589Q458 534 383 392Z" />
<glyph unicode="7" glyph-name="seven" d="M897 1132V1170H295V1096Q295 1066 284 1053T253 1040Q235 1040 223 1053T211 1096V1255H982V1121L644 41Q636 15 625 7T600 -2Q582 -2 570 10T558 38Q558 48 564 66L897 1132Z" />
<glyph unicode="8" glyph-name="eight" d="M787 651Q892 600 945 517T999 337Q999 188 887 79T615 -30Q455 -30 343 79T231 337Q231 432 284 515T444 651Q352 704 310 761Q252 842 252 940Q252 1078 358 1181T615 1285Q766 1285 872 1182T978 940Q978 842 920
762Q879 704 787 651ZM892 937Q892 1045 812 1122T614 1200Q498 1200 418 1122T337 938Q337 840 416 767T614 693Q733 693 812 766T892 937ZM915 335Q915 446 829 528T615 610Q487 610 401 528T315 336Q315 222 401 138T615 54Q742 54 828 138T915 335Z" />
<glyph unicode="9" glyph-name="nine" d="M959 710Q894 595 805 537T621 479Q534 479 453 529T323 675T275 878Q275 1032 370 1158T626 1285Q740 1285 834 1214T980 1008Q1047 835 1047 606Q1047 428 990 310Q952 230 879 155T713 33Q587 -30 451 -30Q361 -30
304 4Q278 20 278 44Q278 61 290 72T319 84Q331 84 354 73Q393 54 444 54Q657 54 810 207T963 592Q963 634 959 710ZM943 850Q890 1053 812 1126T628 1200Q521 1200 440 1110T359 879Q359 742 440 653T623 563Q682 563 739 595T848 691Q881 734 943 850Z" />
<glyph unicode=":" glyph-name="colon" d="M597 866H633Q689 866 729 826T769 731Q769 672 729 633T633 594H597Q541 594 501 634T461 729Q461 788 501 827T597 866ZM597 241H633Q689 241 729 202T769 106Q769 48 729 9T633 -30H597Q541 -30 501 9T461 105Q461
163 501 202T597 241Z" />
<glyph unicode=";" glyph-name="semicolon" d="M596 866H633Q689 866 728 826T768 731Q768 672 728 633T633 594H596Q540 594 501 634T461 729Q461 788 501 827T596 866ZM450 302H714L431 -162Q410 -196 398 -205T368 -214Q344 -214 328 -199T312 -163Q312 -151
318 -132L450 302Z" />
<glyph unicode="&lt;" glyph-name="less" d="M0 583L908 1089Q930 1101 941 1101Q958 1101 970 1089T983 1059Q983 1034 949 1015L171 583L948 151Q982 132 982 107Q982 90 970 78T940 65Q929 65 907 77L0 583Z" />
<glyph unicode="=" glyph-name="equal" d="M1073 695H157Q127 695 114 707T101 738Q101 756 114 768T157 780H1073Q1103 780 1116 768T1129 737Q1129 719 1116 707T1073 695ZM1073 394H157Q127 394 114 405T101 436Q101 455 114 466T157 478H1073Q1103 478 1116
467T1129 436Q1129 417 1116 406T1073 394Z" />
<glyph unicode="&gt;" glyph-name="greater" d="M983 583L75 77Q53 65 42 65Q25 65 13 77T0 107Q0 132 34 151L812 583L35 1015Q1 1034 1 1059Q1 1076 13 1088T43 1101Q54 1101 76 1089L983 583Z" />
<glyph unicode="?" glyph-name="question" d="M385 514V429Q385 399 373 386T343 373Q324 373 312 386T300 429V570Q519 651 599 732Q644 777 644 845Q644 957 563 1036T351 1116Q285 1116 227 1101T84 1045V959Q84 929 73 916T42 903Q24 903 12 916T0 959V1100Q156
1169 202 1181Q280 1200 358 1200Q525 1200 626 1100T728 847Q728 753 668 681T385 514ZM299 178H383Q427 178 457 148T488 74Q488 30 457 0T383 -30H299Q256 -30 226 0T195 73Q195 118 226 148T299 178Z" />
<glyph unicode="@" glyph-name="at" d="M859 302V313Q834 309 813 307T774 305Q651 305 573 381T494 565Q494 688 591 776T859 865V962Q859 1072 791 1142T621 1212Q550 1212 487 1176Q444 1151 416 1115Q368 1052 334 964T299 744V413Q299 219 388 87T630 -46Q780
-46 855 25Q872 41 888 41Q905 41 917 29T929 1Q929 -31 869 -69Q773 -130 618 -130Q538 -130 472 -101T360 -19Q332 12 293 87T238 220Q215 301 215 413V749Q215 1005 351 1167Q459 1297 617 1297Q699 1297 768 1263T890 1148T943 962V386Q963 384 973 373T983
345Q983 332 977 322T961 307T927 302H859ZM859 782Q727 781 653 716T578 567Q578 491 632 440T785 389Q802 389 820 391T859 398V782Z" />
<glyph unicode="A" glyph-name="A" d="M891 391H339L226 84H387Q417 84 430 73T443 42Q443 24 430 12T387 0H73Q43 0 30 12T17 42Q17 61 30 72T73 84H138L509 1086H261Q231 1086 218 1097T205 1128Q205 1147 218 1158T261 1170H684L1094 84H1159Q1189 84 1202
73T1215 42Q1215 24 1202 12T1159 0H846Q815 0 802 12T789 42Q789 61 802 72T846 84H1006L891 391ZM859 475L627 1086H596L371 475H859Z" />
<glyph unicode="B" glyph-name="B" d="M256 84V1086H143Q113 1086 100 1097T87 1128Q87 1147 100 1158T143 1170H671Q828 1170 926 1080T1025 867Q1025 713 860 618Q991 571 1052 493T1113 321Q1113 237 1073 168T951 49T771 0H143Q113 0 100 12T87 42Q87 61 100
72T143 84H256ZM340 650H637Q732 650 811 685Q872 713 906 766T940 874Q940 953 866 1019T673 1086H340V650ZM340 84H765Q846 84 906 120T997 209T1028 319Q1028 383 984 443T860 534T642 565H340V84Z" />
<glyph unicode="C" glyph-name="C" d="M984 1055V1114Q984 1144 995 1157T1026 1170Q1045 1170 1056 1157T1068 1114V881Q1068 850 1057 837T1026 824Q1009 824 998 836T984 875Q979 959 893 1024Q777 1113 629 1113Q532 1113 446 1070Q382 1039 344 994Q278 916
239 821Q211 751 211 663V516Q211 328 347 190T663 51Q771 51 856 98T1022 240Q1039 261 1060 261Q1078 261 1089 250T1100 222Q1100 199 1057 152Q975 60 873 14T665 -33Q574 -33 480 2Q408 29 361 65T246 186T152 344T127 504V675Q127 799 193 928T375 1127T626
1197Q834 1197 984 1055Z" />
<glyph unicode="D" glyph-name="D" d="M285 84V1086H214Q184 1086 171 1097T158 1128Q158 1147 171 1158T214 1170H666Q772 1170 859 1126T993 1026Q1072 931 1113 825Q1142 748 1142 643V527Q1142 398 1085 277T895 66Q796 0 666 0H214Q184 0 171 12T158 42Q158
61 171 72T214 84H285ZM369 84H674Q780 84 872 153T1011 318T1058 509V661Q1058 739 1033 800Q997 889 931 969Q895 1013 825 1049T674 1086H369V84Z" />
<glyph unicode="E" glyph-name="E" d="M341 565V84H987V332Q987 362 998 375T1029 388Q1048 388 1059 375T1071 332V0H144Q114 0 101 12T88 42Q88 61 101 72T144 84H257V1086H144Q114 1086 101 1097T88 1128Q88 1147 101 1158T144 1170H1027V881Q1027 851 1016
838T985 825Q966 825 955 838T943 881V1086H341V649H642V744Q642 774 654 787T685 800Q703 800 715 787T727 744V470Q727 440 715 427T685 414Q666 414 654 427T642 470V565H341Z" />
<glyph unicode="F" glyph-name="F" d="M412 565V84H700Q730 84 743 73T756 42Q756 24 743 12T700 0H215Q185 0 172 12T159 42Q159 61 172 72T215 84H328V1086H215Q185 1086 172 1097T159 1128Q159 1147 174 1160Q185 1170 215 1170H1140V881Q1140 851 1128 838T1098
825Q1079 825 1067 838T1055 881V1086H412V649H713V744Q713 774 725 787T756 800Q774 800 786 787T798 744V470Q798 440 786 427T756 414Q737 414 725 427T713 470V565H412Z" />
<glyph unicode="G" glyph-name="G" d="M1071 434V74Q975 21 880 -6T689 -33Q554 -33 452 7T278 119T168 280T128 506V660Q128 798 196 928T384 1128T643 1197Q846 1197 986 1086Q986 1135 989 1145T1004 1162T1029 1170Q1047 1170 1059 1157T1071 1114V924Q1071
893 1059 881T1029 868Q1012 868 1001 879T988 920Q982 1005 878 1059T650 1113Q534 1113 441 1063T266 870Q212 777 212 659V506Q212 297 340 174T693 51Q769 51 834 67T986 123V434H697Q667 434 654 445T641 476Q641 495 654 507T697 519L1101 518Q1131 518 1144
507T1157 476Q1157 463 1149 452T1131 438T1071 434Z" />
<glyph unicode="H" glyph-name="H" d="M899 566H342V84H455Q485 84 498 73T511 42Q511 24 498 12T455 0H163Q133 0 120 12T107 42Q107 61 120 72T163 84H258V1086H206Q175 1086 162 1097T149 1128Q149 1147 162 1158T206 1170H455Q485 1170 498 1159T511 1128Q511
1109 498 1098T455 1086H342V650H899V1086H787Q757 1086 744 1097T731 1128Q731 1147 743 1158T787 1170H1036Q1067 1170 1080 1159T1093 1128Q1093 1109 1080 1098T1036 1086H984V84H1079Q1109 84 1122 73T1135 42Q1135 24 1122 12T1079 0H787Q757 0 744 12T731
42Q731 61 743 72T787 84H899V566Z" />
<glyph unicode="I" glyph-name="I" d="M657 1086V84H945Q975 84 988 73T1001 42Q1001 24 988 12T945 0H285Q255 0 242 12T229 42Q229 61 242 72T285 84H573V1086H285Q255 1086 242 1097T229 1128Q229 1147 242 1158T285 1170H945Q975 1170 988 1159T1001 1128Q1001
1109 988 1098T945 1086H657Z" />
<glyph unicode="J" glyph-name="J" d="M943 1086V344Q943 191 829 79T557 -33Q462 -33 371 10T171 153V463Q171 493 183 506T213 519Q232 519 244 506T256 463L255 193Q332 122 407 87T557 51Q639 51 712 91Q767 121 812 192T858 344V1086H529Q498 1086 485 1097T472
1128Q472 1147 485 1158T529 1170H1143Q1173 1170 1186 1159T1199 1128Q1199 1109 1186 1098T1143 1086H943Z" />
<glyph unicode="K" glyph-name="K" d="M342 458V84H497Q528 84 541 73T554 42Q554 24 541 12T497 0H145Q115 0 102 12T89 42Q89 61 102 72T145 84H258V1086H145Q115 1086 102 1097T89 1128Q89 1147 102 1158T145 1170H497Q528 1170 541 1159T554 1128Q554 1109
541 1098T497 1086H342V569L922 1086H830Q799 1086 786 1097T773 1128Q773 1147 786 1158T830 1170H1077Q1107 1170 1120 1159T1133 1128Q1133 1109 1120 1098T1077 1086H1043L581 673Q684 631 752 568T883 389Q919 324 1015 84H1120Q1151 84 1164 73T1177 42Q1177
24 1164 12T1120 0H958Q826 361 736 464T511 610L342 458Z" />
<glyph unicode="L" glyph-name="L" d="M469 1086V84H1027V418Q1027 448 1039 461T1070 474Q1088 474 1100 462T1112 418V0H184Q154 0 141 12T128 42Q128 61 141 72T184 84H384V1086H184Q154 1086 141 1097T128 1128Q128 1147 141 1158T184 1170H669Q699 1170 712
1159T725 1128Q725 1109 712 1098T669 1086H469Z" />
<glyph unicode="M" glyph-name="M" d="M670 351H574L251 1086H235V84H390Q420 84 433 73T446 42Q446 24 433 12T390 0H80Q50 0 37 12T24 42Q24 61 37 72T80 84H151V1086H98Q68 1086 55 1097T42 1128Q42 1147 55 1158T98 1170H304L622 446L935 1170H1141Q1172 1170
1185 1159T1198 1128Q1198 1109 1185 1098T1141 1086H1089V84H1159Q1190 84 1203 73T1216 42Q1216 24 1203 12T1159 0H850Q820 0 807 12T793 42Q793 61 806 72T850 84H1005V1086H987L670 351Z" />
<glyph unicode="N" glyph-name="N" d="M1026 0H918L299 1047V84H454Q485 84 498 73T511 42Q511 24 498 12T454 0H145Q114 0 101 12T88 42Q88 61 101 72T145 84H215V1086H102Q72 1086 59 1097T46 1128Q46 1147 59 1158T102 1170H322L942 121V1086H787Q757 1086
744 1097T731 1128Q731 1147 743 1158T787 1170H1097Q1127 1170 1140 1159T1153 1128Q1153 1109 1140 1098T1097 1086H1026V0Z" />
<glyph unicode="O" glyph-name="O" d="M1024 582Q1024 414 956 271T769 47T512 -33Q309 -33 155 139T0 582Q0 853 154 1025T512 1197Q649 1197 768 1117T955 894T1024 582ZM939 582Q939 787 820 950T512 1113Q335 1113 210 958T84 582Q84 348 215 200T512 51Q701
51 820 213T939 582Z" />
<glyph unicode="P" glyph-name="P" d="M432 480V84H720Q750 84 763 73T776 42Q776 24 763 12T720 0H235Q205 0 192 12T179 42Q179 61 192 72T235 84H348V1086H235Q205 1086 192 1097T179 1128Q179 1147 192 1158T235 1170H723Q896 1170 1005 1068T1115 829Q1115
748 1080 683T994 581Q919 525 839 499Q781 480 695 480H432ZM432 564H700Q793 564 874 605T993 707T1031 829Q1031 928 946 1007T731 1086H432V564Z" />
<glyph unicode="Q" glyph-name="Q" d="M626 -33L514 -117Q597 -100 651 -100Q739 -100 824 -132Q884 -155 917 -155Q975 -155 1046 -108Q1074 -90 1086 -90Q1104 -90 1115 -101T1127 -132Q1127 -147 1117 -158Q1096 -182 1022 -214Q966 -239 912 -239Q870 -239
796 -212T653 -185Q604 -185 532 -197Q431 -214 370 -231Q350 -236 341 -236Q324 -236 312 -224T300 -192Q300 -172 323 -156L510 -21Q343 20 224 185T104 582Q104 853 258 1025T616 1197Q819 1197 973 1025T1128 582Q1128 315 976 143T626 -33ZM1043 582Q1043
787 924 950T616 1113Q439 1113 314 958T188 582Q188 348 319 200T616 51Q805 51 924 213T1043 582Z" />
<glyph unicode="R" glyph-name="R" d="M341 522V84H496Q527 84 540 73T553 42Q553 24 540 12T496 0H144Q114 0 101 12T88 42Q88 61 101 72T144 84H257V1086H144Q114 1086 101 1097T88 1128Q88 1147 101 1158T144 1170H652Q809 1170 916 1071T1024 846Q1024 756
958 677T735 544Q825 482 889 404T1094 84H1158Q1188 84 1201 73T1214 42Q1214 24 1201 12T1158 0H1046Q890 279 805 374T608 522H341ZM341 606H570Q680 606 769 646T899 740T940 850Q940 934 856 1010T650 1086H341V606Z" />
<glyph unicode="S" glyph-name="S" d="M915 1086V1114Q915 1144 926 1157T957 1170Q976 1170 987 1157T999 1114V900Q999 870 988 857T957 844Q939 844 928 856T915 895Q910 979 829 1046T615 1113Q476 1113 394 1042T312 873Q312 823 335 782T396 716T482 675T632
642Q803 614 868 585Q955 546 999 477T1044 314Q1044 170 929 69T619 -33Q400 -33 269 104V56Q269 26 258 13T227 0Q209 0 197 13T185 56V288Q185 319 196 332T227 345Q245 345 256 333T269 294Q274 202 367 127T619 51Q777 51 868 130T960 317Q960 383 925 434T821
516Q773 537 621 563Q412 598 320 670Q228 742 228 875Q228 1007 333 1102T612 1197Q788 1197 915 1086Z" />
<glyph unicode="T" glyph-name="T" d="M656 1086V84H874Q904 84 917 73T930 42Q930 24 917 12T874 0H353Q323 0 310 12T297 42Q297 61 310 72T353 84H571V1086H227V795Q227 764 216 751T185 738Q167 738 155 751T143 795V1170H1084V795Q1084 764 1073 751T1042
738Q1023 738 1012 751T1000 795V1086H656Z" />
<glyph unicode="U" glyph-name="U" d="M1021 1086V384Q1021 207 903 87T618 -33Q506 -33 419 16T271 164T210 384V1086H139Q109 1086 96 1097T83 1128Q83 1147 97 1160Q109 1170 139 1170H449Q479 1170 492 1159T505 1128Q505 1109 492 1098T449 1086H294V384Q294
245 389 148T614 51Q697 51 765 89T885 206T937 384V1086H782Q752 1086 739 1097T726 1128Q726 1147 739 1158T782 1170H1092Q1122 1170 1135 1159T1148 1128Q1148 1109 1135 1098T1092 1086H1021Z" />
<glyph unicode="V" glyph-name="V" d="M677 0H560L137 1086H72Q49 1086 39 1090T23 1105T16 1128Q16 1140 22 1150T39 1165T72 1170H385Q409 1170 418 1166T434 1151T441 1128Q441 1116 434 1106T418 1091T385 1086H224L614 84H620L1005 1086H845Q821 1086 811
1090T795 1105T788 1128Q788 1140 795 1150T811 1165T845 1170H1157Q1181 1170 1191 1166T1207 1151T1214 1128Q1214 1116 1207 1106T1191 1091T1157 1086H1093L677 0Z" />
<glyph unicode="W" glyph-name="W" d="M983 0H851L613 831L380 0H248L124 1086H93Q63 1086 50 1097T37 1128Q37 1147 50 1158T93 1170H405Q436 1170 449 1159T462 1128Q462 1109 449 1098T405 1086H209L320 96L547 911H676L909 96L1018 1086H821Q791 1086 778
1097T765 1128Q765 1147 778 1158T821 1170H1131Q1162 1170 1175 1159T1188 1128Q1188 1109 1175 1098T1131 1086H1100L983 0Z" />
<glyph unicode="X" glyph-name="X" d="M665 599L1064 84H1096Q1126 84 1139 73T1152 42Q1152 24 1139 12T1096 0H826Q796 0 783 12T770 42Q770 61 783 72T826 84H960L613 530L270 84H404Q434 84 447 73T460 42Q460 24 447 12T404 0H136Q106 0 93 12T80 42Q80 56
88 67T106 81T167 84L561 599L185 1086H154Q124 1086 111 1097T98 1128Q98 1147 111 1158T154 1170H383Q414 1170 427 1159T440 1128Q440 1109 427 1098T383 1086H289L613 667L935 1086H841Q810 1086 797 1097T784 1128Q784 1147 797 1158T841 1170H1071Q1101 1170
1114 1159T1127 1128Q1127 1109 1114 1098T1071 1086H1039L665 599Z" />
<glyph unicode="Y" glyph-name="Y" d="M659 528V84H877Q907 84 920 73T933 42Q933 24 920 12T877 0H356Q326 0 313 12T300 42Q300 61 312 72T356 84H574V528L205 1086H155Q125 1086 112 1097T99 1128Q99 1147 112 1158T155 1170H386Q416 1170 429 1159T442 1128Q442
1109 429 1098T386 1086H303L617 613L924 1086H842Q811 1086 798 1097T785 1128Q785 1147 798 1158T842 1170H1072Q1102 1170 1115 1159T1128 1128Q1128 1109 1115 1098T1072 1086H1022L659 528Z" />
<glyph unicode="Z" glyph-name="Z" d="M1022 0H213V122L895 1079V1086H336V839Q336 808 324 795T293 782Q275 782 263 795T251 839V1170H976V1051L294 93V84H938V377Q938 408 949 421T980 434Q999 434 1010 421T1022 377V0Z" />
<glyph unicode="[" glyph-name="bracketleft" d="M84 1170V-175H288Q318 -175 331 -186T344 -217Q344 -236 331 -247T288 -259H0V1255H288Q318 1255 331 1243T344 1212Q344 1194 331 1182T288 1170H84Z" />
<glyph unicode="\" glyph-name="backslash" d="M87 1346L762 -102Q772 -124 772 -134Q772 -150 760 -162T730 -175Q702 -175 685 -138L10 1311Q0 1332 0 1343Q0 1359 12 1371T42 1383Q69 1383 87 1346Z" />
<glyph unicode="]" glyph-name="bracketright" d="M259 -175V1170H56Q26 1170 13 1182T0 1212Q0 1231 13 1243T56 1255H344V-259H56Q26 -259 13 -248T0 -217Q0 -199 13 -187T56 -175H259Z" />
<glyph unicode="^" glyph-name="asciicircum" d="M614 1279L983 816Q1001 793 1001 779Q1001 761 989 749T958 737Q938 737 916 763L614 1147L312 763Q291 736 271 736Q253 736 241 748T228 779Q228 793 246 816L614 1279Z" />
<glyph unicode="_" glyph-name="underscore" d="M1250 -561H133Q103 -561 90 -550T77 -519Q77 -500 90 -489T133 -477H1250Q1281 -477 1293 -488T1306 -519Q1306 -538 1294 -549T1250 -561Z" />
<glyph unicode="`" glyph-name="grave" d="M525 1309L761 1105L783 1080Q786 1075 786 1064Q786 1046 774 1034T743 1021Q728 1021 705 1041L469 1245Q444 1267 444 1286Q444 1304 456 1316T487 1329Q502 1329 525 1309Z" />
<glyph unicode="a" glyph-name="a" d="M856 0V121Q673 -33 465 -33Q314 -33 229 43T144 231Q144 353 256 444T583 535Q641 535 709 528T856 504V640Q856 709 792 760T600 811Q502 811 325 754Q293 744 284 744Q268 744 257 756T245 786Q245 803 255 813Q269 828
368 854Q524 896 604 896Q763 896 852 818T941 640V84H1053Q1084 84 1097 73T1110 42Q1110 24 1097 12T1053 0H856ZM856 418Q797 435 731 443T592 451Q409 451 306 372Q228 313 228 231Q228 155 287 103T461 51Q570 51 663 94T856 233V418Z" />
<glyph unicode="b" glyph-name="b" d="M298 1255V698Q450 896 665 896Q849 896 980 763T1111 435Q1111 239 979 103T665 -33Q445 -33 298 165V0H101Q71 0 58 12T45 42Q45 61 58 72T101 84H214V1170H101Q71 1170 58 1182T45 1213Q45 1231 58 1243T101 1255H298ZM1027
431Q1027 590 918 700T663 811Q517 811 408 701T299 431Q299 272 408 162T663 51Q809 51 918 161T1027 431Z" />
<glyph unicode="c" glyph-name="c" d="M965 781V809Q965 840 977 853T1007 866Q1026 866 1038 853T1050 809V619Q1049 588 1038 575T1007 562Q990 562 979 573T965 612Q959 683 872 747T636 811Q449 811 352 694T255 426Q255 263 362 157T639 51Q737 51 838 87T1022
203Q1043 223 1059 223Q1076 223 1087 212T1099 183Q1099 140 998 74Q835 -33 635 -33Q432 -33 302 96T171 425Q171 628 304 762T641 896Q834 896 965 781Z" />
<glyph unicode="d" glyph-name="d" d="M1026 1255V84H1138Q1169 84 1182 73T1195 42Q1195 24 1182 12T1138 0H941V167Q795 -33 570 -33Q456 -33 352 27T187 200T126 431Q126 551 186 662T351 835T571 896Q791 896 941 696V1170H829Q798 1170 785 1182T772 1213Q772
1231 785 1243T829 1255H1026ZM941 431Q941 591 833 701T576 811Q426 811 318 701T210 431Q210 272 318 162T576 51Q725 51 833 161T941 431Z" />
<glyph unicode="e" glyph-name="e" d="M1069 413H213Q235 250 349 151T633 51Q727 51 830 82T998 164Q1017 179 1031 179Q1047 179 1059 167T1071 137Q1071 120 1055 104Q1007 54 885 11T633 -33Q417 -33 273 108T128 451Q128 634 263 765T599 896Q805 896 938
762T1069 413ZM984 498Q959 637 853 724T599 811Q452 811 346 725T214 498H984Z" />
<glyph unicode="f" glyph-name="f" d="M559 781V84H928Q958 84 971 73T984 42Q984 24 971 12T928 0H271Q241 0 228 12T215 42Q215 61 228 72T271 84H474V781H292Q262 781 249 793T236 824Q236 842 249 854T292 866H474V993Q474 1099 560 1177T788 1255Q907 1255
1042 1233Q1093 1225 1103 1214T1114 1185Q1114 1167 1102 1156T1070 1144Q1062 1144 1043 1147Q892 1170 788 1170Q678 1170 619 1116T559 993V866H952Q982 866 995 854T1008 823Q1008 805 995 793T952 781H559Z" />
<glyph unicode="g" glyph-name="g" d="M897 712V866H1094Q1124 866 1137 854T1150 823Q1150 805 1137 793T1094 781H981V-58Q981 -142 945 -208Q921 -252 865 -299T763 -366T640 -386H402Q372 -386 359 -375T346 -344Q346 -325 359 -313T402 -301L643 -302Q717
-302 776 -264T875 -153Q897 -111 897 -46V206Q762 21 549 21Q376 21 251 149T125 459Q125 640 250 768T549 896Q762 896 897 712ZM897 459Q897 607 796 709T553 811Q412 811 311 709T210 459Q210 311 311 209T553 106Q694 106 795 208T897 459Z" />
<glyph unicode="h" glyph-name="h" d="M338 1255V738Q418 825 491 860T656 896Q754 896 822 862T937 756T983 605V84H1077Q1108 84 1120 73T1133 42Q1133 24 1121 12T1077 0H804Q773 0 760 12T747 42Q747 61 760 72T804 84H898V599Q898 690 833 751T650 812Q558
812 493 767Q446 735 338 616V84H433Q463 84 476 73T489 42Q489 24 476 12T433 0H159Q129 0 116 12T103 42Q103 61 116 72T159 84H254V1170H141Q111 1170 98 1182T85 1213Q85 1231 98 1243T141 1255H338Z" />
<glyph unicode="i" glyph-name="i" d="M656 1297V1080H532V1297H656ZM659 866V84H989Q1020 84 1033 73T1046 42Q1046 24 1033 12T989 0H245Q215 0 202 12T189 42Q189 61 202 72T245 84H575V781H330Q300 781 287 793T273 823Q273 842 286 854T330 866H659Z" />
<glyph unicode="j" glyph-name="j" d="M735 1297V1080H611V1297H735ZM740 781H241Q211 781 198 793T185 824Q185 842 197 854T241 866H824V-59Q824 -166 780 -238T648 -355Q587 -386 503 -386H236Q206 -386 193 -375T180 -344Q180 -325 193 -313T236 -301L501
-302Q608 -302 674 -232T740 -59V781Z" />
<glyph unicode="k" glyph-name="k" d="M444 374V0H247Q217 0 204 12T191 42Q191 61 204 72T247 84H360V1170H247Q217 1170 204 1182T191 1213Q191 1231 204 1243T247 1255H444V481L801 781H758Q728 781 715 793T702 823Q702 842 715 854T758 866H1027Q1058 866
1071 854T1084 823Q1084 805 1071 793T1027 781H930L602 507L1017 84H1114Q1145 84 1158 73T1171 42Q1171 24 1158 12T1114 0H842Q812 0 799 12T786 42Q786 61 799 72T842 84H901L540 455L444 374Z" />
<glyph unicode="l" glyph-name="l" d="M657 1255V84H987Q1018 84 1031 73T1044 42Q1044 24 1031 12T987 0H243Q213 0 200 12T187 42Q187 61 200 72T243 84H573V1170H331Q301 1170 288 1182T274 1213Q274 1231 287 1243T331 1255H657Z" />
<glyph unicode="m" glyph-name="m" d="M232 866V781Q339 896 447 896Q512 896 561 862T643 757Q699 827 756 861T872 896Q963 896 1017 837Q1088 761 1088 671V84H1159Q1189 84 1202 73T1215 42Q1215 24 1202 12T1159 0H1004V663Q1004 727 965 769T875 811Q829
811 778 777T662 641V84H732Q762 84 775 73T788 42Q788 24 775 12T732 0H577V657Q577 724 538 767T449 811Q404 811 360 782Q299 741 232 641V84H303Q333 84 346 73T359 42Q359 24 346 12T303 0H77Q47 0 34 12T21 42Q21 61 34 72T77 84H148V781H77Q47 781 34 793T21
824Q21 842 34 854T77 866H232Z" />
<glyph unicode="n" glyph-name="n" d="M343 866V739Q431 828 502 862T662 896Q758 896 837 855Q893 825 938 756T984 613V84H1055Q1085 84 1098 73T1111 42Q1111 24 1098 12T1055 0H830Q799 0 786 12T773 42Q773 61 786 72T830 84H900V599Q900 688 835 749T661
811Q578 811 517 778T343 611V84H438Q468 84 481 73T494 42Q494 24 481 12T438 0H164Q134 0 121 12T108 42Q108 61 121 72T164 84H259V781H188Q158 781 145 793T132 824Q132 842 145 854T188 866H343Z" />
<glyph unicode="o" glyph-name="o" d="M1084 431Q1084 239 947 103T615 -33Q419 -33 282 103T145 431Q145 623 282 759T615 896Q809 896 946 760T1084 431ZM999 431Q999 589 887 700T614 811Q454 811 342 700T229 431Q229 275 341 163T614 51Q774 51 886 162T999 431Z" />
<glyph unicode="p" glyph-name="p" d="M298 866V713Q373 804 459 850T662 896Q786 896 891 838T1053 677T1111 459Q1111 278 982 150T663 21Q438 21 298 204V-302H502Q532 -302 545 -313T558 -344Q558 -362 545 -374T502 -386H101Q71 -386 58 -375T45 -344Q45
-325 58 -314T101 -302H214V781H101Q71 781 58 793T45 824Q45 842 58 854T101 866H298ZM1026 459Q1026 604 921 707T663 811Q510 811 404 707T298 459Q298 314 404 210T663 106Q814 106 920 209T1026 459Z" />
<glyph unicode="q" glyph-name="q" d="M940 713V866H1137Q1168 866 1181 854T1194 823Q1194 805 1181 793T1137 781H1025V-302H1137Q1168 -302 1181 -313T1194 -344Q1194 -362 1181 -374T1137 -386H737Q707 -386 694 -375T681 -344Q681 -325 694 -314T737 -302H940V204Q801
21 575 21Q387 21 258 149T128 459Q128 641 257 768T577 896Q801 896 940 713ZM940 459Q940 604 834 707T576 811Q424 811 318 708T212 459Q212 314 318 210T576 106Q728 106 834 210T940 459Z" />
<glyph unicode="r" glyph-name="r" d="M514 866V654Q678 802 759 844T910 887Q985 887 1049 837T1114 760Q1114 741 1102 729T1070 716Q1060 716 1053 719T1027 742Q992 777 966 790T915 803Q860 803 783 759T514 544V84H886Q917 84 930 73T943 42Q943 24 930
12T886 0H227Q197 0 184 11T171 41Q171 58 183 69T227 81H430V781H275Q245 781 232 793T219 824Q219 842 231 854T275 866H514Z" />
<glyph unicode="s" glyph-name="s" d="M892 811Q892 840 904 853T934 866Q953 866 965 853T977 809V665Q977 635 965 622T934 609Q917 609 906 620T892 656Q886 716 830 755Q748 811 613 811Q472 811 394 754Q335 711 335 658Q335 598 405 558Q453 530 587 515Q762
496 830 472Q927 437 974 375T1022 241Q1022 134 919 51T617 -33Q418 -33 291 68Q291 34 287 24T273 7T249 0Q231 0 219 13T207 56V229Q207 259 218 272T249 285Q267 285 279 273T292 239Q292 193 315 162Q350 114 426 83T614 51Q778 51 858 112T938 241Q938 319
857 366Q775 413 619 429T394 471T288 549T250 661Q250 769 356 832T609 896Q783 896 892 811Z" />
<glyph unicode="t" glyph-name="t" d="M442 866H898Q928 866 941 854T954 823Q954 805 941 793T898 781H442V222Q442 149 500 100T672 51Q757 51 856 76T1010 134Q1030 147 1043 147Q1059 147 1071 135T1083 105Q1083 90 1070 77Q1038 44 915 6T678 -33Q531 -33
444 36T357 222V781H202Q172 781 159 793T146 824Q146 842 159 854T202 866H357V1114Q357 1144 369 1157T399 1170Q418 1170 430 1157T442 1114V866Z" />
<glyph unicode="u" glyph-name="u" d="M902 0V123Q730 -33 530 -33Q407 -33 343 34Q260 122 260 239V781H147Q117 781 104 793T91 824Q91 842 104 854T147 866H344V239Q344 157 396 104T526 51Q731 51 902 239V781H747Q717 781 704 793T691 824Q691 842 704 854T747
866H986V84H1057Q1087 84 1100 73T1113 42Q1113 24 1100 12T1057 0H902Z" />
<glyph unicode="v" glyph-name="v" d="M688 0H546L201 781H115Q85 781 72 793T59 824Q59 842 72 854T115 866H430Q460 866 473 854T486 823Q486 805 473 793T430 781H291L599 84H636L938 781H798Q768 781 755 793T742 824Q742 842 755 854T798 866H1114Q1145 866
1157 854T1170 823Q1170 805 1158 793T1114 781H1029L688 0Z" />
<glyph unicode="w" glyph-name="w" d="M904 0L800 -1L615 539L431 -1L327 0L153 781H112Q82 781 69 793T56 824Q56 842 69 854T112 866H343Q373 866 386 854T399 823Q399 805 386 793T343 781H236L385 115L564 647H664L848 115L991 781H885Q855 781 842 793T828
824Q828 842 841 854T885 866H1115Q1146 866 1159 854T1172 823Q1172 805 1159 793T1115 781H1075L904 0Z" />
<glyph unicode="x" glyph-name="x" d="M672 453L1057 84Q1095 84 1105 81T1122 66T1130 42Q1130 24 1117 12T1073 0H803Q772 0 759 12T746 42Q746 61 759 72T803 84H942L615 397L290 84H430Q460 84 473 73T486 42Q486 24 473 12T430 0H157Q127 0 114 12T101 42Q101
55 108 66T125 80T173 84L558 453L216 781Q180 781 171 785T154 800T146 824Q146 842 159 854T203 866H432Q463 866 475 854T488 823Q488 805 476 793T432 781H332L615 508L900 781H800Q770 781 757 793T743 824Q743 842 756 854T800 866H1029Q1059 866 1072 854T1085
823Q1085 811 1078 800T1061 785T1015 781L672 453Z" />
<glyph unicode="y" glyph-name="y" d="M620 0L230 781H205Q175 781 162 793T149 823Q149 836 155 846T172 861T205 866H435Q465 866 478 854T491 823Q491 805 478 793T435 781H322L665 92L1003 781H890Q860 781 847 793T834 824Q834 842 847 854T890 866H1119Q1150
866 1163 854T1176 823Q1176 810 1168 799T1150 785T1094 781L562 -302H693Q723 -302 736 -313T749 -344Q749 -362 736 -374T693 -386H209Q179 -386 166 -375T153 -344Q153 -325 166 -314T209 -302H472L620 0Z" />
<glyph unicode="z" glyph-name="z" d="M982 866V791L353 84H921V200Q921 230 932 243T963 256Q982 256 994 243T1006 200L1005 0H237V75L863 781H341V667Q341 637 329 624T299 611Q280 611 268 624T256 667V866H982Z" />
<glyph unicode="{" glyph-name="braceleft" d="M161 498Q211 460 229 426Q252 381 252 319V-40Q252 -97 285 -133T367 -175Q398 -178 408 -187Q421 -199 421 -217Q421 -236 408 -247T370 -259Q291 -259 238 -209Q167 -140 167 -41V319Q167 374 134 411T50 453Q22
456 11 467T0 498Q0 517 11 528T50 542Q102 546 134 583T167 676V1036Q167 1130 227 1192T371 1255Q395 1255 408 1243T421 1213Q421 1195 408 1183Q399 1173 367 1170Q317 1165 285 1128T252 1036V676Q252 613 232 575T161 498Z" />
<glyph unicode="|" glyph-name="bar" d="M657 1198L656 -203Q656 -233 645 -246T614 -259Q596 -259 584 -246T572 -203V1198Q572 1229 584 1242T614 1255Q633 1255 645 1242T657 1198Z" />
<glyph unicode="}" glyph-name="braceright" d="M260 498Q209 536 192 570Q169 614 169 676V1036Q169 1092 136 1129T54 1170Q22 1173 13 1182Q0 1195 0 1213Q0 1231 12 1243T50 1255Q130 1255 182 1204Q253 1136 253 1036V676Q253 621 286 584T371 542Q398 539
409 528T421 498Q421 478 410 467T371 453Q319 449 286 412T253 319V-41Q253 -135 193 -197T50 -260Q25 -260 13 -248T0 -217Q0 -199 12 -187Q22 -178 54 -175Q104 -170 136 -133T169 -40V319Q169 382 189 421T260 498Z" />
<glyph unicode="~" glyph-name="asciitilde" d="M1003 668Q1019 668 1031 656T1043 628Q1043 593 956 513T796 432Q751 432 705 457T574 563Q517 617 488 634T434 651Q405 651 379 635Q344 615 283 544Q254 511 246 506T227 501Q210 501 199 512T187 541Q187 557
213 590Q279 672 331 703T432 735Q473 735 513 716T616 639Q717 546 741 532T790 517Q861 517 941 619Q970 656 980 662T1003 668Z" />
</font>

<font horiz-adv-x="874" ><font-face
    font-family="TimesNewRoman-Bold"
    units-per-em="2048"
    panose-1="2 2 8 3 7 5 5 2 3 4"
    ascent="1825"
    descent="-443"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1593" d="M284 0V1280H1308V0H284ZM316 32H1276V1248H316V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="512" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="682" d="M364 441H320Q313 555 274 717L222 935Q175 1131 175 1216Q175 1293 221 1340T341 1387Q413 1387 460 1340T508 1219Q508 1143 458 935L405 717Q377 601 364 441ZM343 298Q410 298 457 251T505 135Q505
68 458 21T343 -27Q276 -27 229 20T181 135Q181 202 228 250T343 298Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="1137" d="M349 721H300L196 1106Q176 1181 176 1238Q176 1300 219 1343T324 1387Q394 1387 433 1342T472 1243Q472 1198 448 1104L349 721ZM832 721H782L681 1105Q657 1193 657 1241Q657 1299 701
1343T808 1387Q879 1387 916 1340T954 1244Q954 1209 928 1105L832 721Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1024" d="M90 -28L176 396H40V529H202L261 821H40V951H287L374 1384H506L418 951H713L799 1384H931L843 951H983V821H818L758 529H983V396H733L647 -28H514L600 396H309L219 -28H90ZM335 529H629L687
821H393L335 529Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1024" d="M566 835Q805 684 871 607Q959 503 959 362Q959 208 855 102T566 -21V-138H479V-28Q373 -26 291 -11T103 46V369H145Q165 259 208 191T316 89T479 46V540Q238 691 159 781T79 992Q79 1122 179 1221T479
1346V1393H566V1346Q736 1334 908 1241V952H869Q840 1050 800 1113T695 1221Q646 1254 566 1276V835ZM479 1279Q406 1273 362 1239Q292 1186 292 1111Q292 1065 324 1018T479 890V1279ZM566 46Q652 66 692 114T732 236Q732 299 697 354T566 479V46Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="2048" d="M1573 1387L610 -57H476L1438 1387H1573ZM478 1387Q620 1387 717 1287T815 1027Q815 864 717 763T474 661Q331 661 237 759T142 1017Q142 1182 239 1284T478 1387ZM478 1334Q456 1334 442 1321Q417
1298 405 1242T392 1008Q392 867 409 790Q419 746 443 724Q458 711 478 711Q500 711 513 723Q536 744 547 791Q564 867 564 1004Q564 1172 548 1247Q537 1299 512 1323Q500 1334 478 1334ZM1566 671Q1711 671 1808 572T1906 311Q1906 148 1807 46T1568 -56Q1429
-56 1332 46T1234 308Q1234 469 1329 570T1566 671ZM1569 619Q1549 619 1535 607Q1511 585 1498 531T1485 322Q1485 158 1500 86Q1511 35 1537 12Q1550 0 1571 0Q1590 0 1602 11Q1627 34 1639 86Q1656 159 1656 307Q1656 463 1640 535Q1628 587 1604 608Q1592 619
1569 619Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1706" d="M1166 811H1582V772Q1512 762 1472 731T1368 584T1188 327Q1290 235 1354 199Q1399 174 1442 174Q1516 174 1576 271L1617 249Q1535 88 1442 20Q1371 -31 1280 -31Q1202 -31 1132 2T960 128Q835
44 725 7T496 -31Q306 -31 194 72T82 314Q82 464 189 575T500 767Q474 832 461 894T448 1014Q448 1174 560 1280T848 1387Q989 1387 1071 1317T1154 1152Q1154 1039 1070 959T802 811Q915 612 1133 382Q1280 547 1280 665Q1280 707 1251 736T1166 772V811ZM768
871Q873 910 909 954T945 1062Q945 1174 886 1251Q847 1302 790 1302Q743 1302 710 1265T676 1165Q676 1116 692 1060T768 871ZM528 703Q448 669 415 631Q368 575 368 506Q368 412 422 319T554 175T708 124Q746 124 793 140T897 190Q656 437 528 703Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="569" d="M313 722H265L160 1104Q140 1175 140 1235Q140 1300 182 1343T287 1387Q358 1387 396 1341T435 1241Q435 1196 412 1105L313 722Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M658 1387V1341Q554 1273 505 1208Q437 1118 399 977Q351 802 351 488Q351 192 394 28T513 -237Q565 -307 658 -360V-410Q417 -329 250 -80T82 494Q82 814 249 1060T658 1387Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M25 -410V-364Q129 -295 178 -230Q245 -140 284 0Q332 176 332 490Q332 786 289 949T170 1214Q118 1284 25 1337V1387Q266 1306 433 1057T601 483Q601 164 434 -82T25 -410Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="1024" d="M493 992Q490 1050 482 1080T441 1173T408 1271Q408 1317 440 1352T512 1387Q555 1387 586 1355T618 1270Q618 1229 587 1171T548 1083T534 992Q590 1015 614 1032T685 1099Q748 1166 806 1166Q850
1166 880 1137T910 1068Q910 1025 873 992T777 959Q757 959 706 962Q682 963 654 963Q617 963 542 959Q585 910 609 892T692 843T777 779Q796 754 796 715Q796 672 767 643T697 613Q654 613 620 648T572 775Q564 834 555 861T514 940Q481 887 470 858T451 775Q438
684 405 650T328 616Q287 616 258 644T228 711Q228 751 250 782T333 847T417 898T484 959L377 963Q349 963 324 962Q265 958 243 958Q186 958 150 990T114 1066Q114 1107 143 1136T218 1166Q281 1166 339 1106T414 1033Q438 1016 493 992Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1167" d="M40 744H521V1224H652V744H1133V612H652V136H521V612H40V744Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="512" d="M102 -359V-315Q218 -265 270 -186T323 -23Q323 -6 316 3Q309 11 302 11Q296 11 284 4Q255 -13 212 -13Q153 -13 110 33T66 141Q66 207 116 257T237 307Q323 307 384 241T445 58Q445 -85 359 -196T102 -359Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M633 367H50V574H633V367Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="512" d="M256 308Q326 308 374 259T423 141Q423 72 374 24T256 -25Q187 -25 139 23T90 141Q90 210 138 259T256 308Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M575 1387L130 -31H2L449 1387H575Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1024" d="M949 678Q949 475 892 299Q858 191 801 122T670 13T511 -28Q413 -28 334 22T194 165Q150 233 117 346Q74 499 74 662Q74 883 136 1068Q187 1221 291 1302T511 1384Q629 1384 731 1304T882 1087Q949
900 949 678ZM641 680Q641 1036 637 1095Q627 1234 589 1283Q564 1315 508 1315Q465 1315 440 1291Q403 1256 390 1168T377 550Q377 262 397 164Q412 93 440 69T514 45Q564 45 589 77Q631 133 637 250L641 680Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1024" d="M667 1384V275Q667 150 678 116T724 59T836 37H867V0H153V37H189Q276 37 313 57T363 112T376 275V978Q376 1072 367 1095T334 1135T277 1152Q226 1152 153 1120L135 1156L634 1384H667Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1024" d="M848 0H50V22Q417 459 495 610T574 905Q574 1010 509 1079T350 1149Q196 1149 111 995L74 1008Q128 1200 238 1292T492 1384Q595 1384 680 1336T813 1205T861 1048Q861 915 787 778Q686 593 346 262H639Q747
262 779 271T833 301T888 392H924L848 0Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1024" d="M303 680V715Q417 748 461 776T537 863T569 982Q569 1065 509 1124T358 1184Q218 1184 120 1036L83 1049Q155 1216 267 1300T518 1384Q659 1384 750 1298T842 1097Q842 1022 800 953T666 830Q783
773 844 690T906 480Q906 268 753 120T341 -29Q169 -29 90 28Q33 68 33 131Q33 177 66 209T142 242Q175 242 204 228Q220 220 317 141T500 61Q574 61 627 119T680 268Q680 405 584 520T303 680Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1024" d="M51 511L695 1384H817V511H941V304H817V0H542V304H51V511ZM148 511H542V1046L148 511Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1024" d="M312 1356H947L846 1098H312L261 963Q606 950 792 791Q945 660 945 465Q945 340 874 221T674 37T391 -28Q225 -28 136 34Q74 78 74 134Q74 177 106 210T182 243Q221 243 261 227T398 143Q459 101 503
85Q534 73 573 73Q655 73 712 133T770 277Q770 453 594 563T150 673Q123 673 69 672L312 1356Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1024" d="M962 1384V1356Q781 1310 672 1238T499 1062T400 805Q444 835 473 844Q538 864 604 864Q756 864 857 754T959 452Q959 318 904 206T748 33T532 -28Q407 -28 301 40T136 241T76 528Q76 756 185 952T496
1265T962 1384ZM387 724Q379 586 379 522Q379 384 405 255T478 74Q511 37 556 37Q602 37 638 90T674 308Q674 584 607 689Q564 757 491 757Q451 757 387 724Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1024" d="M363 -28L732 1091H451Q286 1091 203 1048Q145 1018 107 935H69L167 1356H975L520 -28H363Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1024" d="M698 766Q841 661 896 571T952 363Q952 199 829 86T493 -28Q292 -28 182 71T72 313Q72 422 135 504T347 654Q186 777 141 855T95 1036Q95 1172 210 1275T527 1379Q721 1379 825 1288T930 1068Q930
972 874 899T698 766ZM622 817Q659 867 677 929T695 1065Q695 1195 639 1264Q597 1317 523 1317Q456 1317 409 1269T362 1148Q362 1075 414 997T622 817ZM422 606Q391 578 378 555Q358 520 342 453T326 313Q326 219 350 156T418 64T510 36Q583 36 633 89T683 236Q683
430 422 606Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1024" d="M63 -28V0Q229 38 344 112T527 295T622 546Q560 514 517 502T425 489Q271 489 169 600T66 904Q66 1038 121 1149T280 1322T494 1384Q613 1384 719 1316T888 1119T951 825Q951 611 849 415T543 101T63
-28ZM637 630Q647 742 647 827Q647 1009 605 1166Q581 1253 534 1294Q509 1316 469 1316Q419 1316 391 1273Q352 1214 352 1048Q352 771 418 666Q461 598 534 598Q573 598 637 630Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="682" d="M342 962Q411 962 459 914T508 796Q508 727 460 679T342 630Q273 630 225 678T176 796Q176 865 224 913T342 962ZM341 308Q411 308 459 259T508 141Q508 72 459 24T341 -25Q272 -25 224 23T175 141Q175
210 223 259T341 308Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="682" d="M341 962Q410 962 458 914T506 797Q506 728 458 680T341 631Q272 631 224 679T175 797Q175 866 223 914T341 962ZM188 -359V-315Q304 -265 356 -186T409 -23Q409 -6 402 3Q395 11 388 11Q382 11
370 4Q341 -13 298 -13Q239 -13 196 33T152 141Q152 207 202 257T323 307Q409 307 470 241T531 58Q531 -85 445 -196T188 -359Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1167" d="M1133 185L41 631V712L1133 1163V1025L288 672L1133 325V185Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1167" d="M40 904H1134V774H40V904ZM40 577H1134V447H40V577Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1167" d="M41 1163L1133 718V636L41 185V324L886 676L41 1023V1163Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1024" d="M486 442H445Q443 553 455 608T520 759T589 914T606 1059Q606 1192 554 1255T431 1318Q377 1318 340 1289Q312 1267 312 1243Q312 1227 331 1193Q374 1116 374 1062Q374 1013 341 980T257 947Q201
947 163 986T125 1091Q125 1209 227 1298T512 1387Q706 1387 807 1295T909 1071Q909 976 857 896T656 717Q556 651 525 600T486 442ZM475 296Q542 296 589 249T636 135Q636 68 589 21T475 -27Q408 -27 361 20T314 135Q314 202 361 249T475 296Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1905" d="M1179 925L1423 935L1240 307Q1209 203 1209 151Q1209 119 1232 96T1290 72Q1359 72 1468 151T1649 378T1721 693Q1721 969 1544 1146T1081 1324Q835 1324 634 1209T315 873T197 401Q197 55 417 -165T979
-386Q1260 -386 1483 -235T1799 165H1860Q1740 -129 1511 -285T977 -442Q592 -442 342 -194T92 436Q92 698 216 921T564 1266T1060 1387Q1281 1387 1446 1299T1695 1050T1778 712Q1778 505 1689 334T1466 82T1178 0Q1079 0 1027 49T975 175Q975 229 999 316Q916
178 870 125Q807 54 745 21Q705 0 654 0Q583 0 535 56T486 222Q486 334 518 441T607 643T736 813T902 937Q949 963 1003 963Q1059 963 1095 928T1145 806L1179 925ZM1028 891Q990 891 953 849Q903 792 846 659Q744 420 744 275Q744 231 762 207T803 183Q822 183
858 211Q909 250 967 343T1062 549T1099 759Q1099 828 1073 864Q1054 891 1028 891Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1479" d="M852 386H373L316 254Q288 188 288 145Q288 88 334 61Q361 45 467 37V0H16V37Q89 48 136 97T252 302L737 1384H756L1245 272Q1315 114 1360 73Q1394 42 1456 37V0H800V37H827Q906 37 938 59Q960 75 960
105Q960 123 954 142Q952 151 924 217L852 386ZM818 460L616 927L408 460H818Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1366" d="M911 719Q1104 674 1182 610Q1294 519 1294 374Q1294 221 1171 121Q1020 0 732 0H43V37Q137 37 170 54T217 100T231 238V1118Q231 1228 218 1256T170 1302T43 1319V1356H693Q926 1356 1023 1315T1176
1191T1232 1015Q1232 917 1161 841T911 719ZM547 746Q689 746 756 778T860 868T896 1016Q896 1106 861 1163T759 1251T547 1280V746ZM547 668V233L546 183Q546 129 573 102T655 74Q735 74 802 109T906 212T942 363Q942 458 898 533T777 639T547 668Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1479" d="M1367 1387V917H1328Q1284 1101 1164 1199T892 1297Q765 1297 659 1224T504 1033Q441 882 441 697Q441 515 487 366T631 140T885 63Q1013 63 1119 119T1344 312V195Q1230 76 1107 23T818 -31Q601 -31
433 56T173 306T81 653Q81 847 182 1021T456 1291T823 1387Q966 1387 1125 1325Q1217 1289 1242 1289Q1274 1289 1297 1312T1328 1387H1367Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M27 0V37H72Q131 37 162 55T209 106Q218 127 218 232V1124Q218 1228 207 1254T163 1299T72 1319H27V1356H634Q877 1356 1025 1290Q1206 1209 1299 1045T1393 674Q1393 531 1347 411T1228 212T1060 86T826
12Q765 0 634 0H27ZM544 1279V221Q544 137 552 118T579 89Q606 74 657 74Q824 74 912 188Q1032 342 1032 666Q1032 927 950 1083Q885 1205 783 1249Q711 1280 544 1279Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M558 1278V726H585Q714 726 772 807T846 1046H884V336H846Q834 452 796 526T706 625T558 651V269Q558 157 567 132T603 91T687 75H768Q958 75 1072 163T1237 431H1274L1213 0H41V37H86Q145 37 181 58Q207
72 221 106Q232 130 232 232V1124Q232 1216 227 1237Q217 1272 190 1291Q152 1319 86 1319H41V1356H1176V955H1138Q1109 1102 1057 1166T908 1260Q852 1278 698 1278H558Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M563 1278V721H602Q692 721 749 748T845 839T897 1012H932V331H897Q878 524 794 585T602 647H563V232Q563 128 574 102T619 57T710 37H755V0H46V37H91Q150 37 186 58Q212 72 226 106Q237 130 237 232V1124Q237
1228 226 1254T182 1299T91 1319H46V1356H1190V967H1149Q1135 1104 1078 1170T911 1263Q851 1278 689 1278H563Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1593" d="M1413 1387V909H1376Q1309 1105 1175 1207T882 1309Q730 1309 629 1224T486 985T444 671Q444 476 490 329T638 113T882 44Q931 44 982 54T1088 85V367Q1088 447 1077 470T1032 513T948 532H913V569H1572V532Q1497
527 1468 512T1422 460Q1413 441 1413 367V85Q1283 27 1143 -2T851 -32Q658 -32 531 20T306 158T153 351Q83 489 83 660Q83 966 298 1177T839 1388Q940 1388 1021 1372Q1065 1364 1163 1327T1280 1289Q1308 1289 1332 1309T1376 1387H1413Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1593" d="M560 652V232Q560 128 571 102T616 57T707 37H752V0H43V37H88Q147 37 183 58Q209 72 223 106Q234 130 234 232V1124Q234 1228 223 1254T179 1299T88 1319H43V1356H752V1319H707Q648 1319 612 1298Q586
1284 571 1250Q560 1226 560 1124V740H1039V1124Q1039 1228 1028 1254T983 1299T892 1319H848V1356H1556V1319H1512Q1452 1319 1417 1298Q1391 1284 1376 1250Q1365 1226 1365 1124V232Q1365 128 1376 102T1421 57T1512 37H1556V0H848V37H892Q952 37 987 58Q1013
72 1028 106Q1039 130 1039 232V652H560Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="797" d="M750 37V0H41V37H86Q145 37 181 58Q207 72 221 106Q232 130 232 232V1124Q232 1228 221 1254T177 1299T86 1319H41V1356H750V1319H705Q646 1319 610 1298Q584 1284 569 1250Q558 1226 558 1124V232Q558
128 569 102T614 57T705 37H750Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1024" d="M291 1319V1356H1012V1319H968Q908 1319 872 1298Q847 1284 832 1250Q821 1226 821 1124V460Q821 265 782 177T644 29T404 -31Q233 -31 128 59T22 258Q22 328 65 371T170 415Q231 415 272 376T314 280Q314
252 307 231Q303 221 276 181T248 123Q248 97 274 78Q312 50 373 50Q416 50 444 72T483 140T495 399V1124Q495 1228 484 1254T439 1299T348 1319H291Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1593" d="M853 837L1330 240Q1431 114 1504 69Q1557 37 1616 37V0H910V37Q977 43 996 58T1016 95Q1016 137 924 253L613 644L563 602V232Q563 126 575 100T621 56T730 37V0H46V37H91Q150 37 186 58Q212 72 226
106Q237 130 237 232V1124Q237 1228 226 1254T182 1299T91 1319H46V1356H721V1319Q652 1319 616 1299Q590 1285 575 1252Q563 1227 563 1124V702L1066 1109Q1171 1194 1171 1245Q1171 1283 1128 1305Q1106 1316 1019 1319V1356H1548V1319Q1477 1314 1437 1294T1250
1155L853 837Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1366" d="M1293 476L1242 0H38V37H83Q142 37 178 58Q204 72 218 106Q229 130 229 232V1124Q229 1228 218 1254T174 1299T83 1319H38V1356H761V1319H702Q643 1319 607 1298Q581 1284 566 1250Q555 1226 555 1124V260Q555
156 567 128T614 85Q639 76 735 76H848Q956 76 1028 114T1152 234T1252 476H1293Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1933" d="M976 462L1344 1356H1896V1319H1852Q1792 1319 1756 1298Q1731 1284 1716 1251Q1705 1227 1705 1126V232Q1705 128 1716 102T1761 57T1852 37H1896V0H1188V37H1232Q1292 37 1328 58Q1353 72 1368 106Q1379
130 1379 232V1237L859 0H835L307 1228V273Q307 173 312 150Q325 100 368 69T505 37V0H41V37H55Q100 36 139 51T198 93T229 166Q231 177 231 268V1126Q231 1229 220 1254T175 1299T84 1319H41V1356H595L976 462Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M510 1356L1179 515V1098Q1179 1220 1144 1263Q1096 1321 983 1319V1356H1431V1319Q1345 1308 1316 1291T1270 1234T1253 1098V-31H1219L302 1098V236Q302 119 355 78T478 37H510V0H29V37Q141 38 185
83T229 236V1193L200 1229Q157 1283 124 1300T29 1319V1356H510Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1593" d="M791 1375Q1115 1387 1317 1186T1520 683Q1520 425 1369 229Q1169 -31 804 -31Q438 -31 238 217Q80 413 80 682Q80 984 285 1185T791 1375ZM803 1311Q617 1311 520 1121Q441 965 441 673Q441 326 563
160Q648 44 801 44Q904 44 973 94Q1061 158 1110 298T1159 665Q1159 934 1109 1067T982 1256T803 1311Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1251" d="M553 614V238Q553 128 566 100T614 54T741 37V0H52V37Q146 37 179 54T226 100T240 238V1118Q240 1228 227 1256T179 1302T52 1319V1356H643Q935 1356 1062 1252T1189 992Q1189 860 1107 766T881 638Q784
614 553 614ZM553 1278V692Q586 690 603 690Q725 690 791 762T857 987Q857 1138 791 1208T594 1278H553Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1593" d="M979 -12Q1025 -145 1122 -212T1365 -279Q1405 -279 1450 -271V-332Q1299 -370 1180 -370Q994 -370 848 -279T627 -12Q381 40 231 229T80 680Q80 984 284 1185T802 1387Q1115 1387 1318 1185T1521 680Q1521
416 1362 221T979 -12ZM801 1311Q621 1311 523 1124Q441 967 441 677Q441 329 564 161Q650 44 801 44Q953 44 1038 159Q1161 324 1161 655Q1161 981 1084 1127Q988 1311 801 1311Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1479" d="M544 618V238Q544 128 557 100T605 54T732 37V0H38V37Q132 37 165 54T212 100T226 238V1118Q226 1228 213 1256T165 1302T38 1319V1356H668Q914 1356 1028 1322T1214 1197T1286 982Q1286 832 1178 734Q1109
672 985 641L1311 182Q1375 93 1402 71Q1443 40 1497 37V0H1070L633 618H544ZM544 1283V689H601Q740 689 809 714T917 806T957 980Q957 1135 885 1209T651 1283H544Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1139" d="M962 1387L973 935H932Q903 1105 790 1208T544 1312Q442 1312 383 1258T323 1132Q323 1087 344 1052Q373 1005 437 959Q484 926 654 842Q892 725 975 621Q1057 517 1057 383Q1057 213 925 91T588 -32Q524
-32 467 -19T324 30Q276 50 245 50Q219 50 190 30T143 -31H106V481H143Q187 265 312 152T583 38Q695 38 761 99T828 241Q828 289 803 334T725 419T541 525Q356 616 275 680T151 823T107 997Q107 1159 226 1273T526 1387Q592 1387 654 1371Q701 1359 768 1327T863
1294Q889 1294 904 1310T932 1387H962Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1366" d="M1292 1356V989H1256Q1224 1116 1185 1171T1078 1260Q1040 1278 945 1278H844V232Q844 128 855 102T900 57T992 37H1037V0H327V37H372Q431 37 467 58Q493 72 508 106Q519 130 519 232V1278H421Q284 1278
222 1220Q135 1139 112 989H74V1356H1292Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M48 1356H748V1319H713Q634 1319 605 1303T563 1257T550 1112V448Q550 266 577 207T668 109T827 70Q937 70 1014 119T1130 256T1169 559V1112Q1169 1203 1150 1242T1102 1296Q1057 1319 975 1319V1356H1444V1319H1416Q1359
1319 1321 1296T1266 1227Q1253 1195 1253 1112V597Q1253 358 1222 252T1068 57T735 -32Q559 -32 463 15Q332 79 278 179T224 448V1112Q224 1229 211 1257T166 1303T48 1319V1356Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1479" d="M1458 1356V1319Q1384 1307 1326 1240Q1284 1190 1201 1005L734 -31H701L236 1047Q152 1242 124 1276T16 1319V1356H666V1319H644Q556 1319 524 1297Q501 1282 501 1253Q501 1235 509 1211T563 1079L852
404L1120 1005Q1168 1114 1179 1151T1190 1214Q1190 1244 1174 1267T1127 1302Q1084 1319 1013 1319V1356H1458Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="2048" d="M2030 1356V1319Q1992 1316 1966 1298T1920 1243Q1914 1231 1857 1088L1432 -31H1393L1057 843L687 -31H650L204 1076Q136 1243 109 1278T18 1319V1356H606V1319Q535 1317 512 1298T488 1249Q488 1211
537 1088L803 430L1016 944L960 1088Q914 1206 889 1245T832 1302T736 1319V1356H1393V1319Q1324 1318 1294 1308Q1273 1301 1261 1285T1249 1247Q1249 1224 1294 1106L1541 464L1762 1045Q1797 1135 1805 1168T1813 1229Q1813 1270 1785 1293T1678 1319V1356H2030Z"
/>
<glyph unicode="X" glyph-name="X" horiz-adv-x="1479" d="M865 795L1239 240Q1332 102 1371 73T1465 37V0H804V37Q883 43 906 61T929 105Q929 123 922 137Q908 167 852 249L654 542L447 289Q354 174 354 133Q354 104 378 79T449 43Q470 37 535 37V0H14V37Q103
50 154 85Q221 131 341 277L610 605L265 1112Q180 1237 168 1251Q141 1284 115 1298T43 1319V1356H716V1319H682Q624 1319 601 1301T578 1254Q578 1232 585 1216L654 1112L822 856L965 1031Q1075 1166 1075 1220Q1075 1247 1060 1270T1015 1306T925 1319V1356H1424V1319Q1365
1318 1329 1305T1252 1254Q1226 1230 1122 1105L865 795Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1479" d="M1456 1356V1319Q1389 1310 1353 1280Q1303 1238 1195 1051L901 560V232Q901 127 912 102T955 57T1042 37H1118V0H357V37H428Q488 37 523 58Q549 72 564 106Q575 130 575 232V504L256 1085Q161 1257 122
1287T18 1319V1356H668V1319H639Q580 1319 557 1302T533 1266Q533 1230 613 1085L858 636L1102 1045Q1193 1195 1193 1244Q1193 1271 1167 1289Q1133 1314 1042 1319V1356H1456Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1366" d="M1250 1356L453 76H711Q894 76 967 99Q1086 135 1172 231T1291 490H1330L1275 0H33L831 1282H630Q513 1282 476 1275Q406 1262 345 1224T243 1121T179 959H142L179 1356H1250Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="682" d="M214 -374V1356H616V1314H571Q505 1314 483 1301T449 1261T437 1133V-158Q437 -254 441 -268Q450 -304 474 -321T571 -338H616V-374H214Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M2 1387H128L575 -31H446L2 1387Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="682" d="M469 1356V-374H67V-336H112Q178 -336 200 -323T234 -283T246 -156V1136Q246 1232 242 1246Q233 1281 209 1298T112 1316H67V1356H469Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="1190" d="M147 666L558 1384H640L1044 666H885L590 1178L300 666H147Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1024" d="M-19 -311H1043V-442H-19V-311Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M38 1402H339L455 1055H370L38 1402Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1024" d="M585 138Q414 -13 278 -13Q198 -13 145 39T92 171Q92 278 184 363T585 591V685Q585 791 574 818T530 866T458 887Q393 887 351 858Q325 840 325 816Q325 795 353 764Q391 721 391 681Q391 632 355 598T259
563Q196 563 154 601T111 690Q111 762 168 827T327 928T539 963Q672 963 749 907T850 784Q864 742 864 591V228Q864 164 869 148T884 123T907 115Q933 115 960 152L990 128Q940 54 887 21T765 -13Q685 -13 640 24T585 138ZM585 211V524Q464 453 405 372Q366 318
366 263Q366 217 399 182Q424 155 469 155Q519 155 585 211Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1139" d="M431 1356V841Q549 963 689 963Q785 963 870 907T1003 746T1051 506Q1051 353 990 228T827 38T594 -28Q518 -28 459 -4T343 74L188 -27H154V1162Q154 1243 147 1262Q137 1290 116 1303T43 1319V1356H431ZM431
752V336Q431 209 437 174Q447 115 485 79T582 42Q633 42 669 71T730 186T755 496Q755 711 701 791Q662 849 596 849Q510 849 431 752Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="909" d="M832 241L863 217Q797 93 699 33T489 -28Q302 -28 190 113T78 452Q78 643 180 788Q303 963 519 963Q664 963 749 890T835 727Q835 670 801 636T710 602Q651 602 613 641T565 780Q559 843 536 868Q513 893
482 893Q434 893 400 842Q348 765 348 606Q348 474 390 354T505 174Q560 131 635 131Q684 131 728 154T832 241Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1139" d="M978 1356V280Q978 171 984 151Q992 118 1014 102T1093 82V49L698 -28V120Q627 34 572 3T446 -28Q267 -28 163 132Q79 262 79 451Q79 602 131 721T273 902T468 963Q535 963 587 937T698 846V1128Q698
1235 689 1257Q677 1286 653 1300T563 1314V1356H978ZM698 722Q624 864 517 864Q480 864 456 844Q419 813 396 735T372 496Q372 319 398 234T469 111Q492 92 532 92Q620 92 698 230V722Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="909" d="M861 501H348Q357 315 447 207Q516 124 613 124Q673 124 722 157T827 278L861 256Q785 101 693 37T480 -28Q272 -28 165 132Q79 261 79 452Q79 686 205 824T502 963Q644 963 748 847T861 501ZM615 568Q615
729 598 789T543 880Q522 898 487 898Q435 898 402 847Q343 758 343 603V568H615Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="682" d="M479 837V188Q479 94 499 70Q531 33 617 36V0H66V36Q129 37 155 50T192 88T202 188V837H66V935H202V1004L201 1051Q201 1195 306 1291T592 1387Q715 1387 774 1341T834 1239Q834 1194 797 1161T699 1128Q647
1128 617 1155T586 1215Q586 1224 592 1252Q596 1269 596 1284Q596 1305 584 1315Q568 1330 545 1330Q516 1330 497 1306T477 1229L479 1054V935H617V837H479Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1024" d="M669 924H984V814H805Q854 765 873 725Q897 671 897 612Q897 512 842 439T691 324T521 282Q515 282 401 287Q356 287 326 258T295 187Q295 151 322 128T412 105L585 107Q795 107 874 61Q987 -3 987 -136Q987
-221 935 -290T798 -393Q669 -442 501 -442Q375 -442 271 -418T122 -350T77 -258Q77 -212 111 -176T240 -114Q110 -50 110 64Q110 133 163 198T331 311Q197 360 137 440T77 625Q77 762 189 862T477 963Q570 963 669 924ZM496 901Q438 901 398 843T358 600Q358 451
397 396T491 340Q551 340 591 395T631 609Q631 788 586 853Q554 901 496 901ZM437 -138Q335 -138 302 -155Q245 -186 245 -239Q245 -290 304 -331T526 -373Q665 -373 744 -336T824 -232Q824 -207 809 -190Q782 -160 728 -149T437 -138Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1139" d="M451 1356V815Q528 896 592 929T725 963Q813 963 875 913T958 796T979 568V203Q979 96 999 70T1080 36V0H606V36Q656 43 681 76Q699 102 699 203V620Q699 736 690 765T660 811T611 828Q571 828 533 801T451
704V203Q451 103 466 78Q485 44 544 36V0H70V36Q129 42 154 74Q171 96 171 203V1153Q171 1259 152 1285T70 1319V1356H451Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M294 1388Q359 1388 404 1343T449 1233Q449 1169 404 1124T294 1079Q230 1079 185 1124T140 1233Q140 1297 185 1342T294 1388ZM434 935V194Q434 95 457 68T547 36V0H42V36Q104 38 134 72Q154 95 154 194V740Q154
839 131 866T42 898V935H434Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="682" d="M356 1387Q420 1387 464 1343T509 1235Q509 1171 464 1126T356 1081Q293 1081 248 1126T203 1235Q203 1298 247 1342T356 1387ZM496 935V-33Q496 -169 479 -234Q454 -328 380 -385T183 -442Q60 -442 2
-392T-57 -271Q-57 -227 -27 -195T45 -162Q83 -162 105 -184T127 -252Q127 -264 126 -280Q124 -301 124 -309Q124 -344 140 -361Q156 -378 181 -378Q204 -378 220 -358T237 -301Q237 -281 231 -220Q221 -109 220 -86L217 151V729L218 781Q218 844 197 867T106 898V935H496Z"
/>
<glyph unicode="k" glyph-name="k" horiz-adv-x="1139" d="M449 1356V464L666 677Q733 742 749 771T766 827Q766 854 744 872T658 898V935H1077V898Q1017 895 972 870T796 716L694 616L914 294Q1047 98 1072 74Q1106 40 1158 36V0H675V36Q707 36 721 48T736 74Q736
97 694 159L509 430L449 371V203Q449 96 469 70T551 36V0H68V36Q127 42 152 74Q169 96 169 203V1153Q169 1259 150 1285T68 1319V1356H449Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M435 1356V194Q435 95 458 68T548 36V0H43V36Q105 38 135 72Q155 95 155 194V1162Q155 1260 132 1287T43 1319V1356H435Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1706" d="M457 935V812Q534 896 599 929T743 963Q833 963 894 921T988 793Q1068 883 1141 923T1295 963Q1392 963 1449 919T1529 806T1552 587V204Q1552 96 1571 70T1653 36V0H1170V36Q1227 41 1254 80Q1272 107
1272 204V606Q1272 731 1262 765T1231 815T1180 832Q1137 832 1093 801T1004 706V204Q1004 103 1021 77Q1044 40 1109 36V0H625V36Q664 38 686 55T716 97T724 204V606Q724 733 714 765T681 815T630 833Q590 833 557 812Q510 781 457 706V204Q457 105 476 74T558
36V0H76V36Q135 42 160 74Q177 96 177 204V732Q177 838 158 864T76 898V935H457Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1139" d="M451 935V814Q523 892 589 927T731 963Q822 963 882 913T962 787Q978 730 978 568V204Q978 96 997 70T1079 36V0H606V36Q659 43 682 80Q698 105 698 204V620Q698 735 689 765T659 811T611 828Q525 828
451 705V204Q451 99 470 71T543 36V0H70V36Q129 42 154 74Q171 96 171 204V732Q171 838 152 864T70 898V935H451Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1024" d="M510 963Q632 963 737 900T896 721T951 467Q951 268 850 134Q728 -28 513 -28Q302 -28 188 120T74 463Q74 664 190 813T510 963ZM514 892Q463 892 427 854T379 702T367 386Q367 279 381 186Q392 115 428
78T510 41Q555 41 585 66Q624 100 637 161Q657 256 657 545Q657 715 638 778T582 871Q556 892 514 892Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1139" d="M431 95V-253Q431 -325 442 -351T478 -389T572 -401V-438H39V-401Q101 -399 131 -366Q151 -343 151 -247V740Q151 839 128 866T39 898V935H431V812Q480 884 531 916Q604 963 690 963Q793 963 877 898T1006
719T1050 472Q1050 330 1005 213T873 34T680 -28Q603 -28 536 6Q486 32 431 95ZM431 196Q517 74 615 74Q669 74 704 131Q756 215 756 451Q756 693 699 782Q661 841 597 841Q496 841 431 695V196Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1139" d="M697 98Q636 34 583 8Q513 -28 437 -28Q261 -28 159 129Q78 254 78 428Q78 573 139 700T308 895T536 963Q616 963 678 936T786 854L943 963H977V-248Q977 -340 993 -363Q1019 -400 1098 -401V-438H558V-401Q620
-401 648 -387T686 -350T697 -256V98ZM697 189V574Q697 735 680 787T615 877Q591 896 554 896Q478 896 436 829Q370 726 370 446Q370 231 427 144Q466 85 528 85Q564 85 609 110T697 189Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="909" d="M457 935V723Q550 868 620 915T755 963Q811 963 844 929T878 831Q878 764 846 727T767 690Q714 690 675 724T629 762Q619 768 606 768Q577 768 551 746Q510 712 489 649Q457 552 457 435V220L458 164Q458
107 465 91Q477 64 500 52T580 36V0H75V36Q136 41 157 69T179 220V737Q179 817 171 839Q161 867 142 880T75 898V935H457Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="797" d="M660 961L675 642H641Q580 784 515 836T384 888Q343 888 314 861T285 797Q285 770 305 745Q337 704 484 605T677 436T724 280Q724 202 685 127T575 12T418 -28Q351 -28 239 14Q209 25 198 25Q165 25 143
-25H110L94 311H128Q173 179 251 113T400 47Q448 47 478 76T509 148Q509 196 479 231T345 337Q192 443 147 499Q81 581 81 680Q81 788 155 875T371 963Q447 963 518 926Q545 911 562 911Q580 911 591 918T626 961H660Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="682" d="M440 1277V935H662V836H440V259Q440 178 447 155T474 117T509 102Q574 102 632 201L662 179Q581 -13 399 -13Q310 -13 249 36T170 147Q160 181 160 331V836H38V871Q164 960 252 1058T407 1277H440Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1139" d="M972 935V203Q972 96 992 70T1073 36V0H692V125Q625 45 558 9T408 -28Q329 -28 268 20T185 134T164 361V732Q164 838 145 864T63 898V935H444V296Q444 196 453 167T483 123T531 108Q567 108 596 127Q636
153 692 232V732Q692 838 673 864T591 898V935H972Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1024" d="M491 -28L176 697Q119 828 87 863Q64 889 19 898V935H516V898Q469 898 452 881Q428 859 428 829Q428 792 472 690L626 339L749 642Q802 772 802 826Q802 857 780 876T700 898V935H1006V898Q962 892 934
865T850 706L538 -28H491Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1479" d="M996 -28L740 658L489 -28H437L188 650Q132 805 93 852Q68 884 17 898V935H489V898Q441 898 423 884T405 852Q405 835 437 750L574 385L706 750L696 774Q666 849 644 869T574 898V935H1053V898Q997 895
982 883T967 847Q967 825 996 750L1128 385L1248 721Q1274 793 1274 819Q1274 858 1255 876T1181 898V935H1458V898Q1412 892 1385 866T1315 715L1053 -28H996Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1024" d="M622 573L784 265Q868 104 917 61Q944 38 991 36V0H470V36Q531 41 545 52T560 82Q560 110 528 170L447 322L378 221Q331 152 325 139Q317 120 317 105Q317 82 326 67T352 44T413 36V0H47V36Q115 36 171
73T336 270L413 384L252 682Q173 828 134 861T47 898V935H565V898L538 897L486 879Q478 872 478 856Q478 841 483 825Q486 818 511 771L584 635L622 689Q702 799 702 843Q702 864 685 878T622 898V935H953V898Q892 896 839 861T720 723L622 573Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1024" d="M498 -38L196 655Q128 812 96 848T17 898V935H514V898Q465 896 445 879T425 838Q425 800 475 688L635 322L744 605Q803 756 803 815Q803 852 779 874T692 898V935H1005V898Q959 893 930 863T833 655L566
-38Q465 -298 416 -358Q347 -442 243 -442Q160 -442 109 -395T57 -280Q57 -222 92 -184T180 -146Q230 -146 260 -178T292 -277Q293 -315 301 -326Q309 -337 324 -337Q348 -337 375 -308Q415 -266 469 -116L498 -38Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="909" d="M835 0H21V22L535 874H385Q288 874 246 857T178 801T124 663H89V935H876V908L366 64H430Q622 64 707 119T835 320H863L835 0Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="807" d="M720 1387V1342Q620 1323 573 1272T525 1154Q525 1087 549 988T573 814Q573 746 533 676T416 555Q363 520 247 489Q371 450 427 412Q501 361 538 292T575 161Q575 101 551 1T526 -173Q526 -244
571 -295T720 -367V-414H685Q583 -415 492 -367T354 -244T307 -97Q307 -28 338 92Q361 181 361 251Q361 330 311 385T165 457V518Q261 534 311 592T361 733Q361 801 339 886Q308 1005 308 1067Q308 1132 347 1199T445 1308T574 1369Q628 1384 720 1387Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="451" d="M159 -442V1387H289V-442H159Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="807" d="M91 -414V-368Q190 -349 238 -298T286 -180Q286 -114 262 -15T238 159Q238 228 278 298T395 419Q448 453 564 485Q440 524 384 562Q309 613 272 682T235 813Q235 873 259 973T284 1146Q284 1218
239 1269T91 1341V1387L126 1388Q227 1389 319 1341T457 1218T504 1070Q504 1002 473 882Q450 793 450 723Q450 644 499 588T646 517V456Q549 440 500 382T450 241Q450 173 472 88Q502 -31 502 -93Q502 -159 464 -225T366 -334T237 -395Q183 -410 91 -414Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1065" d="M1071 709H1128Q1122 550 1046 468T859 386Q806 386 747 403T484 505Q338 566 273 566Q205 566 160 525T97 387H39Q47 551 120 630T299 710Q352 710 403 696Q504 667 682 591Q778 549 829 535Q859
527 894 527Q965 527 1013 574T1071 709Z" />
<hkern g1="space" g2="A" k="113" />
<hkern g1="space" g2="T" k="37" />
<hkern g1="space" g2="V" k="37" />
<hkern g1="space" g2="W" k="37" />
<hkern g1="space" g2="Y" k="76" />
<hkern g1="space" g2="Alphatonos" k="113" />
<hkern g1="space" g2="Alpha" k="113" />
<hkern g1="space" g2="Delta" k="113" />
<hkern g1="space" g2="Lambda" k="113" />
<hkern g1="space" g2="Tau" k="37" />
<hkern g1="space" g2="Upsilon" k="76" />
<hkern g1="space" g2="Upsilondieresis" k="76" />
<hkern g1="one" g2="one" k="113" />
<hkern g1="A" g2="space" k="113" />
<hkern g1="A" g2="T" k="152" />
<hkern g1="A" g2="V" k="264" />
<hkern g1="A" g2="W" k="227" />
<hkern g1="A" g2="Y" k="188" />
<hkern g1="A" g2="v" k="152" />
<hkern g1="A" g2="w" k="152" />
<hkern g1="A" g2="y" k="152" />
<hkern g1="A" g2="quoteright" k="152" />
<hkern g1="F" g2="space" k="76" />
<hkern g1="F" g2="comma" k="188" />
<hkern g1="F" g2="period" k="188" />
<hkern g1="F" g2="A" k="152" />
<hkern g1="L" g2="space" k="113" />
<hkern g1="L" g2="T" k="188" />
<hkern g1="L" g2="V" k="188" />
<hkern g1="L" g2="W" k="188" />
<hkern g1="L" g2="Y" k="188" />
<hkern g1="L" g2="y" k="113" />
<hkern g1="L" g2="quoteright" k="188" />
<hkern g1="P" g2="space" k="113" />
<hkern g1="P" g2="comma" k="188" />
<hkern g1="P" g2="period" k="188" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="T" k="72" />
<hkern g1="R" g2="V" k="72" />
<hkern g1="R" g2="W" k="72" />
<hkern g1="R" g2="Y" k="72" />
<hkern g1="R" g2="y" k="72" />
<hkern g1="T" g2="space" k="37" />
<hkern g1="T" g2="comma" k="152" />
<hkern g1="T" g2="hyphen" k="188" />
<hkern g1="T" g2="period" k="152" />
<hkern g1="T" g2="colon" k="152" />
<hkern g1="T" g2="semicolon" k="152" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="188" />
<hkern g1="T" g2="c" k="188" />
<hkern g1="T" g2="e" k="188" />
<hkern g1="T" g2="i" k="37" />
<hkern g1="T" g2="o" k="188" />
<hkern g1="T" g2="r" k="152" />
<hkern g1="T" g2="s" k="188" />
<hkern g1="T" g2="u" k="188" />
<hkern g1="T" g2="w" k="152" />
<hkern g1="T" g2="y" k="152" />
<hkern g1="V" g2="space" k="37" />
<hkern g1="V" g2="comma" k="264" />
<hkern g1="V" g2="hyphen" k="152" />
<hkern g1="V" g2="period" k="264" />
<hkern g1="V" g2="colon" k="188" />
<hkern g1="V" g2="semicolon" k="188" />
<hkern g1="V" g2="A" k="264" />
<hkern g1="V" g2="O" k="41" />
<hkern g1="V" g2="a" k="188" />
<hkern g1="V" g2="e" k="188" />
<hkern g1="V" g2="i" k="76" />
<hkern g1="V" g2="o" k="188" />
<hkern g1="V" g2="r" k="152" />
<hkern g1="V" g2="u" k="188" />
<hkern g1="V" g2="y" k="188" />
<hkern g1="W" g2="space" k="37" />
<hkern g1="W" g2="comma" k="188" />
<hkern g1="W" g2="hyphen" k="76" />
<hkern g1="W" g2="period" k="188" />
<hkern g1="W" g2="colon" k="113" />
<hkern g1="W" g2="semicolon" k="113" />
<hkern g1="W" g2="A" k="227" />
<hkern g1="W" g2="a" k="113" />
<hkern g1="W" g2="e" k="113" />
<hkern g1="W" g2="i" k="37" />
<hkern g1="W" g2="o" k="113" />
<hkern g1="W" g2="r" k="37" />
<hkern g1="W" g2="u" k="37" />
<hkern g1="W" g2="y" k="76" />
<hkern g1="Y" g2="space" k="76" />
<hkern g1="Y" g2="comma" k="188" />
<hkern g1="Y" g2="hyphen" k="188" />
<hkern g1="Y" g2="period" k="188" />
<hkern g1="Y" g2="colon" k="188" />
<hkern g1="Y" g2="semicolon" k="188" />
<hkern g1="Y" g2="A" k="188" />
<hkern g1="Y" g2="a" k="227" />
<hkern g1="Y" g2="e" k="227" />
<hkern g1="Y" g2="i" k="76" />
<hkern g1="Y" g2="o" k="227" />
<hkern g1="Y" g2="p" k="188" />
<hkern g1="Y" g2="q" k="227" />
<hkern g1="Y" g2="u" k="188" />
<hkern g1="Y" g2="v" k="227" />
<hkern g1="f" g2="f" k="0" />
<hkern g1="f" g2="quoteright" k="-113" />
<hkern g1="r" g2="space" k="37" />
<hkern g1="r" g2="comma" k="188" />
<hkern g1="r" g2="hyphen" k="76" />
<hkern g1="r" g2="period" k="188" />
<hkern g1="r" g2="c" k="37" />
<hkern g1="r" g2="e" k="37" />
<hkern g1="r" g2="h" k="0" />
<hkern g1="r" g2="o" k="37" />
<hkern g1="r" g2="q" k="37" />
<hkern g1="r" g2="t" k="0" />
<hkern g1="r" g2="w" k="0" />
<hkern g1="r" g2="x" k="0" />
<hkern g1="r" g2="y" k="0" />
<hkern g1="r" g2="z" k="0" />
<hkern g1="r" g2="quoteright" k="-37" />
<hkern g1="v" g2="comma" k="113" />
<hkern g1="v" g2="period" k="113" />
<hkern g1="w" g2="comma" k="113" />
<hkern g1="w" g2="period" k="113" />
<hkern g1="y" g2="comma" k="113" />
<hkern g1="y" g2="period" k="113" />
<hkern g1="quoteleft" g2="quoteleft" k="152" />
<hkern g1="quoteright" g2="space" k="152" />
<hkern g1="quoteright" g2="s" k="76" />
<hkern g1="quoteright" g2="quoteright" k="152" />
<hkern g1="quotesinglbase" g2="afii10051" k="205" />
<hkern g1="quotesinglbase" g2="afii10060" k="205" />
<hkern g1="quotesinglbase" g2="afii10036" k="205" />
<hkern g1="quotesinglbase" g2="afii10041" k="385" />
<hkern g1="quotesinglbase" g2="afii10044" k="205" />
<hkern g1="quotedblbase" g2="afii10051" k="205" />
<hkern g1="quotedblbase" g2="afii10060" k="205" />
<hkern g1="quotedblbase" g2="afii10036" k="205" />
<hkern g1="quotedblbase" g2="afii10041" k="385" />
<hkern g1="quotedblbase" g2="afii10044" k="205" />
<hkern g1="Gamma" g2="space" k="76" />
<hkern g1="Gamma" g2="comma" k="248" />
<hkern g1="Gamma" g2="period" k="248" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-139" />
<hkern g1="Gamma" g2="Alpha" k="270" />
<hkern g1="Gamma" g2="Delta" k="244" />
<hkern g1="Gamma" g2="Lambda" k="270" />
<hkern g1="Gamma" g2="iota" k="70" />
<hkern g1="Theta" g2="Alpha" k="150" />
<hkern g1="Theta" g2="Delta" k="70" />
<hkern g1="Theta" g2="Lambda" k="150" />
<hkern g1="Theta" g2="Upsilon" k="53" />
<hkern g1="Theta" g2="Upsilondieresis" k="53" />
<hkern g1="Phi" g2="Alpha" k="178" />
<hkern g1="Phi" g2="Upsilon" k="27" />
<hkern g1="Phi" g2="Upsilondieresis" k="27" />
<hkern g1="delta" g2="chi" k="25" />
<hkern g1="phi" g2="chi" k="25" />
<hkern g1="Alphatonos" g2="space" k="113" />
<hkern g1="Alphatonos" g2="Theta" k="119" />
<hkern g1="Alphatonos" g2="Phi" k="150" />
<hkern g1="Alphatonos" g2="Omicron" k="119" />
<hkern g1="Alphatonos" g2="Tau" k="199" />
<hkern g1="Alphatonos" g2="Upsilon" k="262" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="262" />
<hkern g1="Alphatonos" g2="gamma" k="129" />
<hkern g1="Alphatonos" g2="nu" k="152" />
<hkern g1="Alphatonos" g2="chi" k="80" />
<hkern g1="Omicrontonos" g2="Upsilon" k="53" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="53" />
<hkern g1="Upsilontonos" g2="alpha" k="225" />
<hkern g1="Upsilontonos" g2="delta" k="225" />
<hkern g1="Upsilontonos" g2="sigma" k="225" />
<hkern g1="Upsilontonos" g2="phi" k="225" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-109" />
<hkern g1="Upsilontonos" g2="Alpha" k="274" />
<hkern g1="Upsilontonos" g2="Delta" k="238" />
<hkern g1="Upsilontonos" g2="Lambda" k="274" />
<hkern g1="Upsilontonos" g2="alphatonos" k="225" />
<hkern g1="Upsilontonos" g2="etatonos" k="88" />
<hkern g1="Upsilontonos" g2="iotatonos" k="76" />
<hkern g1="Upsilontonos" g2="eta" k="88" />
<hkern g1="Upsilontonos" g2="iota" k="88" />
<hkern g1="Upsilontonos" g2="kappa" k="88" />
<hkern g1="Upsilontonos" g2="mu" k="199" />
<hkern g1="Upsilontonos" g2="omicron" k="225" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="225" />
<hkern g1="Alpha" g2="space" k="113" />
<hkern g1="Alpha" g2="quoteright" k="152" />
<hkern g1="Alpha" g2="Theta" k="119" />
<hkern g1="Alpha" g2="Phi" k="150" />
<hkern g1="Alpha" g2="Omicron" k="119" />
<hkern g1="Alpha" g2="Tau" k="199" />
<hkern g1="Alpha" g2="Upsilon" k="262" />
<hkern g1="Alpha" g2="Upsilondieresis" k="262" />
<hkern g1="Alpha" g2="gamma" k="129" />
<hkern g1="Alpha" g2="nu" k="152" />
<hkern g1="Alpha" g2="chi" k="80" />
<hkern g1="Delta" g2="space" k="113" />
<hkern g1="Delta" g2="Theta" k="53" />
<hkern g1="Delta" g2="Omicron" k="49" />
<hkern g1="Delta" g2="Tau" k="143" />
<hkern g1="Delta" g2="Upsilon" k="201" />
<hkern g1="Delta" g2="Upsilondieresis" k="201" />
<hkern g1="Kappa" g2="Theta" k="88" />
<hkern g1="Kappa" g2="Phi" k="164" />
<hkern g1="Kappa" g2="alpha" k="39" />
<hkern g1="Kappa" g2="delta" k="39" />
<hkern g1="Kappa" g2="sigma" k="39" />
<hkern g1="Kappa" g2="phi" k="39" />
<hkern g1="Kappa" g2="Omicron" k="88" />
<hkern g1="Kappa" g2="alphatonos" k="39" />
<hkern g1="Kappa" g2="zeta" k="39" />
<hkern g1="Kappa" g2="theta" k="39" />
<hkern g1="Kappa" g2="xi" k="39" />
<hkern g1="Kappa" g2="omicron" k="39" />
<hkern g1="Kappa" g2="omega" k="39" />
<hkern g1="Kappa" g2="omicrontonos" k="39" />
<hkern g1="Kappa" g2="omegatonos" k="39" />
<hkern g1="Lambda" g2="Theta" k="119" />
<hkern g1="Lambda" g2="Omicron" k="119" />
<hkern g1="Lambda" g2="Tau" k="199" />
<hkern g1="Lambda" g2="Upsilon" k="262" />
<hkern g1="Lambda" g2="Upsilondieresis" k="262" />
<hkern g1="Omicron" g2="Alpha" k="150" />
<hkern g1="Omicron" g2="Delta" k="70" />
<hkern g1="Omicron" g2="Lambda" k="150" />
<hkern g1="Omicron" g2="Upsilon" k="53" />
<hkern g1="Omicron" g2="Upsilondieresis" k="53" />
<hkern g1="Rho" g2="space" k="113" />
<hkern g1="Rho" g2="comma" k="186" />
<hkern g1="Rho" g2="period" k="186" />
<hkern g1="Rho" g2="Alpha" k="301" />
<hkern g1="Rho" g2="Delta" k="209" />
<hkern g1="Rho" g2="Lambda" k="301" />
<hkern g1="Sigma" g2="tau" k="98" />
<hkern g1="Tau" g2="space" k="37" />
<hkern g1="Tau" g2="comma" k="152" />
<hkern g1="Tau" g2="hyphen" k="186" />
<hkern g1="Tau" g2="period" k="152" />
<hkern g1="Tau" g2="colon" k="152" />
<hkern g1="Tau" g2="semicolon" k="152" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="186" />
<hkern g1="Tau" g2="delta" k="164" />
<hkern g1="Tau" g2="epsilon" k="186" />
<hkern g1="Tau" g2="sigma" k="186" />
<hkern g1="Tau" g2="phi" k="186" />
<hkern g1="Tau" g2="iotadieresistonos" k="-119" />
<hkern g1="Tau" g2="Alpha" k="199" />
<hkern g1="Tau" g2="Delta" k="147" />
<hkern g1="Tau" g2="Lambda" k="199" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="186" />
<hkern g1="Tau" g2="epsilontonos" k="186" />
<hkern g1="Tau" g2="gamma" k="152" />
<hkern g1="Tau" g2="eta" k="106" />
<hkern g1="Tau" g2="iota" k="37" />
<hkern g1="Tau" g2="mu" k="106" />
<hkern g1="Tau" g2="nu" k="152" />
<hkern g1="Tau" g2="omicron" k="186" />
<hkern g1="Tau" g2="upsilon" k="109" />
<hkern g1="Tau" g2="chi" k="152" />
<hkern g1="Tau" g2="psi" k="106" />
<hkern g1="Tau" g2="upsilondieresis" k="106" />
<hkern g1="Tau" g2="omicrontonos" k="186" />
<hkern g1="Tau" g2="upsilontonos" k="106" />
<hkern g1="Upsilon" g2="comma" k="186" />
<hkern g1="Upsilon" g2="hyphen" k="186" />
<hkern g1="Upsilon" g2="period" k="186" />
<hkern g1="Upsilon" g2="colon" k="186" />
<hkern g1="Upsilon" g2="semicolon" k="186" />
<hkern g1="Upsilon" g2="Theta" k="74" />
<hkern g1="Upsilon" g2="Phi" k="88" />
<hkern g1="Upsilon" g2="alpha" k="225" />
<hkern g1="Upsilon" g2="delta" k="225" />
<hkern g1="Upsilon" g2="sigma" k="225" />
<hkern g1="Upsilon" g2="phi" k="225" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-109" />
<hkern g1="Upsilon" g2="Alpha" k="274" />
<hkern g1="Upsilon" g2="Delta" k="238" />
<hkern g1="Upsilon" g2="Lambda" k="274" />
<hkern g1="Upsilon" g2="Omicron" k="74" />
<hkern g1="Upsilon" g2="Omega" k="53" />
<hkern g1="Upsilon" g2="alphatonos" k="225" />
<hkern g1="Upsilon" g2="etatonos" k="88" />
<hkern g1="Upsilon" g2="iotatonos" k="76" />
<hkern g1="Upsilon" g2="gamma" k="150" />
<hkern g1="Upsilon" g2="eta" k="88" />
<hkern g1="Upsilon" g2="iota" k="76" />
<hkern g1="Upsilon" g2="kappa" k="88" />
<hkern g1="Upsilon" g2="mu" k="199" />
<hkern g1="Upsilon" g2="omicron" k="225" />
<hkern g1="Upsilon" g2="omicrontonos" k="225" />
<hkern g1="Chi" g2="omega" k="39" />
<hkern g1="Chi" g2="omegatonos" k="39" />
<hkern g1="Psi" g2="alpha" k="119" />
<hkern g1="Psi" g2="delta" k="119" />
<hkern g1="Psi" g2="sigma" k="119" />
<hkern g1="Psi" g2="phi" k="119" />
<hkern g1="Psi" g2="alphatonos" k="119" />
<hkern g1="Psi" g2="theta" k="39" />
<hkern g1="Psi" g2="omicron" k="119" />
<hkern g1="Psi" g2="omega" k="119" />
<hkern g1="Psi" g2="omicrontonos" k="119" />
<hkern g1="Psi" g2="omegatonos" k="119" />
<hkern g1="Omega" g2="Upsilon" k="27" />
<hkern g1="Omega" g2="Upsilondieresis" k="27" />
<hkern g1="Upsilondieresis" g2="Theta" k="74" />
<hkern g1="Upsilondieresis" g2="Phi" k="88" />
<hkern g1="Upsilondieresis" g2="alpha" k="225" />
<hkern g1="Upsilondieresis" g2="delta" k="225" />
<hkern g1="Upsilondieresis" g2="sigma" k="225" />
<hkern g1="Upsilondieresis" g2="phi" k="225" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-109" />
<hkern g1="Upsilondieresis" g2="Alpha" k="274" />
<hkern g1="Upsilondieresis" g2="Delta" k="238" />
<hkern g1="Upsilondieresis" g2="Lambda" k="274" />
<hkern g1="Upsilondieresis" g2="Omicron" k="74" />
<hkern g1="Upsilondieresis" g2="Omega" k="53" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="225" />
<hkern g1="Upsilondieresis" g2="etatonos" k="88" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="76" />
<hkern g1="Upsilondieresis" g2="eta" k="88" />
<hkern g1="Upsilondieresis" g2="iota" k="88" />
<hkern g1="Upsilondieresis" g2="kappa" k="88" />
<hkern g1="Upsilondieresis" g2="mu" k="199" />
<hkern g1="Upsilondieresis" g2="omicron" k="225" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="225" />
<hkern g1="zeta" g2="alpha" k="70" />
<hkern g1="zeta" g2="delta" k="70" />
<hkern g1="zeta" g2="sigma" k="70" />
<hkern g1="zeta" g2="tau" k="139" />
<hkern g1="zeta" g2="phi" k="70" />
<hkern g1="zeta" g2="alphatonos" k="70" />
<hkern g1="zeta" g2="etatonos" k="59" />
<hkern g1="zeta" g2="gamma" k="119" />
<hkern g1="zeta" g2="eta" k="59" />
<hkern g1="zeta" g2="theta" k="70" />
<hkern g1="zeta" g2="iota" k="49" />
<hkern g1="zeta" g2="kappa" k="49" />
<hkern g1="zeta" g2="nu" k="119" />
<hkern g1="zeta" g2="omicron" k="70" />
<hkern g1="zeta" g2="omega" k="70" />
<hkern g1="zeta" g2="omicrontonos" k="70" />
<hkern g1="zeta" g2="omegatonos" k="70" />
<hkern g1="kappa" g2="alpha" k="59" />
<hkern g1="kappa" g2="delta" k="59" />
<hkern g1="kappa" g2="sigma" k="59" />
<hkern g1="kappa" g2="phi" k="59" />
<hkern g1="kappa" g2="alphatonos" k="59" />
<hkern g1="kappa" g2="theta" k="29" />
<hkern g1="kappa" g2="omicron" k="59" />
<hkern g1="kappa" g2="sigma1" k="59" />
<hkern g1="kappa" g2="omega" k="59" />
<hkern g1="kappa" g2="omicrontonos" k="59" />
<hkern g1="kappa" g2="omegatonos" k="59" />
<hkern g1="lambda" g2="upsilondieresistonos" k="29" />
<hkern g1="lambda" g2="upsilon" k="29" />
<hkern g1="lambda" g2="upsilondieresis" k="29" />
<hkern g1="lambda" g2="upsilontonos" k="29" />
<hkern g1="xi" g2="alpha" k="88" />
<hkern g1="xi" g2="delta" k="88" />
<hkern g1="xi" g2="sigma" k="88" />
<hkern g1="xi" g2="phi" k="88" />
<hkern g1="xi" g2="alphatonos" k="88" />
<hkern g1="xi" g2="etatonos" k="45" />
<hkern g1="xi" g2="zeta" k="39" />
<hkern g1="xi" g2="eta" k="45" />
<hkern g1="xi" g2="omicron" k="88" />
<hkern g1="xi" g2="omicrontonos" k="88" />
<hkern g1="omicron" g2="chi" k="25" />
<hkern g1="chi" g2="alpha" k="59" />
<hkern g1="chi" g2="delta" k="59" />
<hkern g1="chi" g2="sigma" k="59" />
<hkern g1="chi" g2="phi" k="59" />
<hkern g1="chi" g2="alphatonos" k="59" />
<hkern g1="chi" g2="xi" k="61" />
<hkern g1="chi" g2="omicron" k="59" />
<hkern g1="chi" g2="sigma1" k="59" />
<hkern g1="chi" g2="omega" k="59" />
<hkern g1="chi" g2="omicrontonos" k="59" />
<hkern g1="chi" g2="omegatonos" k="59" />
<hkern g1="omega" g2="chi" k="25" />
<hkern g1="omicrontonos" g2="chi" k="25" />
<hkern g1="omegatonos" g2="chi" k="25" />
<hkern g1="afii10052" g2="comma" k="283" />
<hkern g1="afii10052" g2="period" k="283" />
<hkern g1="afii10052" g2="guillemotleft" k="129" />
<hkern g1="afii10052" g2="guillemotright" k="51" />
<hkern g1="afii10052" g2="emdash" k="51" />
<hkern g1="afii10058" g2="quoteright" k="102" />
<hkern g1="afii10059" g2="quoteright" k="102" />
<hkern g1="afii10017" g2="quoteright" k="180" />
<hkern g1="afii10017" g2="afii10025" k="51" />
<hkern g1="afii10017" g2="afii10032" k="102" />
<hkern g1="afii10017" g2="afii10033" k="51" />
<hkern g1="afii10017" g2="afii10035" k="102" />
<hkern g1="afii10017" g2="afii10036" k="180" />
<hkern g1="afii10017" g2="afii10037" k="180" />
<hkern g1="afii10017" g2="afii10038" k="129" />
<hkern g1="afii10017" g2="afii10041" k="311" />
<hkern g1="afii10017" g2="afii10047" k="51" />
<hkern g1="afii10017" g2="afii10065" k="27" />
<hkern g1="afii10017" g2="afii10066" k="104" />
<hkern g1="afii10017" g2="afii10070" k="51" />
<hkern g1="afii10017" g2="afii10080" k="104" />
<hkern g1="afii10017" g2="afii10083" k="51" />
<hkern g1="afii10017" g2="afii10084" k="102" />
<hkern g1="afii10017" g2="afii10085" k="102" />
<hkern g1="afii10017" g2="afii10086" k="78" />
<hkern g1="afii10018" g2="afii10017" k="27" />
<hkern g1="afii10018" g2="afii10021" k="78" />
<hkern g1="afii10018" g2="afii10024" k="51" />
<hkern g1="afii10018" g2="afii10029" k="51" />
<hkern g1="afii10018" g2="afii10032" k="14" />
<hkern g1="afii10018" g2="afii10035" k="14" />
<hkern g1="afii10018" g2="afii10036" k="27" />
<hkern g1="afii10018" g2="afii10037" k="72" />
<hkern g1="afii10018" g2="afii10038" k="31" />
<hkern g1="afii10018" g2="afii10039" k="51" />
<hkern g1="afii10018" g2="afii10041" k="102" />
<hkern g1="afii10018" g2="afii10044" k="78" />
<hkern g1="afii10018" g2="afii10049" k="68" />
<hkern g1="afii10018" g2="afii10069" k="51" />
<hkern g1="afii10018" g2="afii10077" k="27" />
<hkern g1="afii10018" g2="afii10085" k="51" />
<hkern g1="afii10019" g2="afii10017" k="129" />
<hkern g1="afii10019" g2="afii10021" k="78" />
<hkern g1="afii10019" g2="afii10024" k="51" />
<hkern g1="afii10019" g2="afii10029" k="78" />
<hkern g1="afii10019" g2="afii10036" k="27" />
<hkern g1="afii10019" g2="afii10037" k="166" />
<hkern g1="afii10019" g2="afii10039" k="51" />
<hkern g1="afii10019" g2="afii10041" k="102" />
<hkern g1="afii10019" g2="afii10044" k="109" />
<hkern g1="afii10019" g2="afii10049" k="102" />
<hkern g1="afii10019" g2="afii10069" k="51" />
<hkern g1="afii10019" g2="afii10085" k="27" />
<hkern g1="afii10019" g2="afii10087" k="27" />
<hkern g1="afii10019" g2="afii10089" k="51" />
<hkern g1="afii10020" g2="comma" k="231" />
<hkern g1="afii10020" g2="period" k="231" />
<hkern g1="afii10020" g2="guillemotleft" k="129" />
<hkern g1="afii10020" g2="guillemotright" k="51" />
<hkern g1="afii10020" g2="emdash" k="51" />
<hkern g1="afii10020" g2="afii10017" k="223" />
<hkern g1="afii10020" g2="afii10021" k="180" />
<hkern g1="afii10020" g2="afii10025" k="-51" />
<hkern g1="afii10020" g2="afii10029" k="309" />
<hkern g1="afii10020" g2="afii10030" k="27" />
<hkern g1="afii10020" g2="afii10032" k="51" />
<hkern g1="afii10020" g2="afii10035" k="27" />
<hkern g1="afii10020" g2="afii10049" k="154" />
<hkern g1="afii10020" g2="afii10065" k="180" />
<hkern g1="afii10020" g2="afii10067" k="78" />
<hkern g1="afii10020" g2="afii10069" k="154" />
<hkern g1="afii10020" g2="afii10070" k="156" />
<hkern g1="afii10020" g2="afii10074" k="78" />
<hkern g1="afii10020" g2="afii10077" k="231" />
<hkern g1="afii10020" g2="afii10078" k="78" />
<hkern g1="afii10020" g2="afii10079" k="78" />
<hkern g1="afii10020" g2="afii10080" k="180" />
<hkern g1="afii10020" g2="afii10082" k="129" />
<hkern g1="afii10020" g2="afii10085" k="78" />
<hkern g1="afii10020" g2="afii10093" k="129" />
<hkern g1="afii10020" g2="afii10094" k="129" />
<hkern g1="afii10020" g2="afii10096" k="102" />
<hkern g1="afii10020" g2="afii10097" k="154" />
<hkern g1="afii10021" g2="afii10025" k="-51" />
<hkern g1="afii10021" g2="afii10037" k="-25" />
<hkern g1="afii10021" g2="afii10038" k="27" />
<hkern g1="afii10021" g2="afii10047" k="-51" />
<hkern g1="afii10021" g2="afii10070" k="-25" />
<hkern g1="afii10021" g2="afii10073" k="-51" />
<hkern g1="afii10022" g2="afii10025" k="-25" />
<hkern g1="afii10022" g2="afii10029" k="27" />
<hkern g1="afii10024" g2="afii10025" k="51" />
<hkern g1="afii10024" g2="afii10032" k="51" />
<hkern g1="afii10024" g2="afii10035" k="51" />
<hkern g1="afii10024" g2="afii10036" k="35" />
<hkern g1="afii10024" g2="afii10037" k="29" />
<hkern g1="afii10024" g2="afii10044" k="20" />
<hkern g1="afii10024" g2="afii10065" k="51" />
<hkern g1="afii10024" g2="afii10066" k="102" />
<hkern g1="afii10024" g2="afii10070" k="104" />
<hkern g1="afii10024" g2="afii10080" k="154" />
<hkern g1="afii10024" g2="afii10085" k="156" />
<hkern g1="afii10025" g2="afii10021" k="125" />
<hkern g1="afii10025" g2="afii10024" k="27" />
<hkern g1="afii10025" g2="afii10029" k="90" />
<hkern g1="afii10025" g2="afii10037" k="51" />
<hkern g1="afii10025" g2="afii10041" k="78" />
<hkern g1="afii10025" g2="afii10049" k="78" />
<hkern g1="afii10025" g2="afii10069" k="51" />
<hkern g1="afii10025" g2="afii10077" k="27" />
<hkern g1="afii10028" g2="afii10032" k="51" />
<hkern g1="afii10028" g2="afii10035" k="51" />
<hkern g1="afii10028" g2="afii10037" k="41" />
<hkern g1="afii10028" g2="afii10038" k="152" />
<hkern g1="afii10028" g2="afii10041" k="27" />
<hkern g1="afii10028" g2="afii10047" k="-25" />
<hkern g1="afii10028" g2="afii10065" k="27" />
<hkern g1="afii10028" g2="afii10070" k="78" />
<hkern g1="afii10028" g2="afii10073" k="27" />
<hkern g1="afii10028" g2="afii10080" k="102" />
<hkern g1="afii10028" g2="afii10083" k="51" />
<hkern g1="afii10028" g2="afii10084" k="51" />
<hkern g1="afii10028" g2="afii10085" k="51" />
<hkern g1="afii10028" g2="afii10095" k="27" />
<hkern g1="afii10029" g2="afii10038" k="27" />
<hkern g1="afii10029" g2="afii10066" k="27" />
<hkern g1="afii10029" g2="afii10070" k="14" />
<hkern g1="afii10029" g2="afii10080" k="51" />
<hkern g1="afii10029" g2="afii10085" k="51" />
<hkern g1="afii10030" g2="afii10038" k="27" />
<hkern g1="afii10030" g2="afii10070" k="27" />
<hkern g1="afii10030" g2="afii10080" k="27" />
<hkern g1="afii10030" g2="afii10085" k="27" />
<hkern g1="afii10030" g2="afii10089" k="78" />
<hkern g1="afii10030" g2="afii10095" k="-25" />
<hkern g1="afii10032" g2="afii10017" k="102" />
<hkern g1="afii10032" g2="afii10021" k="102" />
<hkern g1="afii10032" g2="afii10024" k="51" />
<hkern g1="afii10032" g2="afii10029" k="102" />
<hkern g1="afii10032" g2="afii10035" k="-25" />
<hkern g1="afii10032" g2="afii10037" k="115" />
<hkern g1="afii10032" g2="afii10038" k="-25" />
<hkern g1="afii10032" g2="afii10039" k="160" />
<hkern g1="afii10032" g2="afii10041" k="51" />
<hkern g1="afii10032" g2="afii10049" k="102" />
<hkern g1="afii10032" g2="afii10069" k="27" />
<hkern g1="afii10032" g2="afii10072" k="-25" />
<hkern g1="afii10034" g2="comma" k="256" />
<hkern g1="afii10034" g2="period" k="256" />
<hkern g1="afii10034" g2="colon" k="-76" />
<hkern g1="afii10034" g2="semicolon" k="-76" />
<hkern g1="afii10034" g2="guillemotright" k="-51" />
<hkern g1="afii10034" g2="afii10017" k="262" />
<hkern g1="afii10034" g2="afii10021" k="219" />
<hkern g1="afii10034" g2="afii10024" k="72" />
<hkern g1="afii10034" g2="afii10025" k="-25" />
<hkern g1="afii10034" g2="afii10029" k="307" />
<hkern g1="afii10034" g2="afii10030" k="39" />
<hkern g1="afii10034" g2="afii10032" k="12" />
<hkern g1="afii10034" g2="afii10035" k="-25" />
<hkern g1="afii10034" g2="afii10036" k="-25" />
<hkern g1="afii10034" g2="afii10037" k="51" />
<hkern g1="afii10034" g2="afii10038" k="35" />
<hkern g1="afii10034" g2="afii10039" k="109" />
<hkern g1="afii10034" g2="afii10049" k="102" />
<hkern g1="afii10034" g2="afii10069" k="78" />
<hkern g1="afii10034" g2="afii10070" k="27" />
<hkern g1="afii10034" g2="afii10080" k="51" />
<hkern g1="afii10034" g2="afii10095" k="-51" />
<hkern g1="afii10034" g2="afii10097" k="53" />
<hkern g1="afii10035" g2="afii10017" k="102" />
<hkern g1="afii10035" g2="afii10021" k="102" />
<hkern g1="afii10035" g2="afii10029" k="51" />
<hkern g1="afii10035" g2="afii10037" k="27" />
<hkern g1="afii10035" g2="afii10039" k="53" />
<hkern g1="afii10035" g2="afii10041" k="51" />
<hkern g1="afii10035" g2="afii10044" k="27" />
<hkern g1="afii10035" g2="afii10066" k="-25" />
<hkern g1="afii10035" g2="afii10070" k="-25" />
<hkern g1="afii10035" g2="afii10083" k="-25" />
<hkern g1="afii10035" g2="afii10084" k="27" />
<hkern g1="afii10035" g2="afii10085" k="51" />
<hkern g1="afii10035" g2="afii10089" k="27" />
<hkern g1="afii10035" g2="afii10095" k="-25" />
<hkern g1="afii10036" g2="comma" k="205" />
<hkern g1="afii10036" g2="period" k="205" />
<hkern g1="afii10036" g2="guillemotleft" k="102" />
<hkern g1="afii10036" g2="guillemotright" k="53" />
<hkern g1="afii10036" g2="afii10017" k="102" />
<hkern g1="afii10036" g2="afii10021" k="129" />
<hkern g1="afii10036" g2="afii10029" k="102" />
<hkern g1="afii10036" g2="afii10030" k="27" />
<hkern g1="afii10036" g2="afii10032" k="27" />
<hkern g1="afii10036" g2="afii10038" k="45" />
<hkern g1="afii10036" g2="afii10049" k="78" />
<hkern g1="afii10036" g2="afii10065" k="51" />
<hkern g1="afii10036" g2="afii10067" k="102" />
<hkern g1="afii10036" g2="afii10070" k="78" />
<hkern g1="afii10036" g2="afii10074" k="51" />
<hkern g1="afii10036" g2="afii10076" k="51" />
<hkern g1="afii10036" g2="afii10077" k="102" />
<hkern g1="afii10036" g2="afii10078" k="51" />
<hkern g1="afii10036" g2="afii10080" k="92" />
<hkern g1="afii10036" g2="afii10081" k="78" />
<hkern g1="afii10036" g2="afii10082" k="78" />
<hkern g1="afii10036" g2="afii10083" k="78" />
<hkern g1="afii10036" g2="afii10085" k="102" />
<hkern g1="afii10036" g2="afii10087" k="102" />
<hkern g1="afii10036" g2="afii10091" k="78" />
<hkern g1="afii10036" g2="afii10093" k="102" />
<hkern g1="afii10036" g2="afii10094" k="129" />
<hkern g1="afii10036" g2="afii10096" k="102" />
<hkern g1="afii10036" g2="afii10097" k="78" />
<hkern g1="afii10037" g2="comma" k="334" />
<hkern g1="afii10037" g2="period" k="334" />
<hkern g1="afii10037" g2="colon" k="78" />
<hkern g1="afii10037" g2="semicolon" k="78" />
<hkern g1="afii10037" g2="guillemotleft" k="180" />
<hkern g1="afii10037" g2="guillemotright" k="129" />
<hkern g1="afii10037" g2="emdash" k="51" />
<hkern g1="afii10037" g2="afii10017" k="391" />
<hkern g1="afii10037" g2="afii10021" k="207" />
<hkern g1="afii10037" g2="afii10025" k="27" />
<hkern g1="afii10037" g2="afii10029" k="270" />
<hkern g1="afii10037" g2="afii10032" k="102" />
<hkern g1="afii10037" g2="afii10038" k="152" />
<hkern g1="afii10037" g2="afii10047" k="27" />
<hkern g1="afii10037" g2="afii10049" k="180" />
<hkern g1="afii10037" g2="afii10066" k="78" />
<hkern g1="afii10037" g2="afii10067" k="168" />
<hkern g1="afii10037" g2="afii10068" k="168" />
<hkern g1="afii10037" g2="afii10069" k="197" />
<hkern g1="afii10037" g2="afii10070" k="221" />
<hkern g1="afii10037" g2="afii10072" k="129" />
<hkern g1="afii10037" g2="afii10073" k="168" />
<hkern g1="afii10037" g2="afii10074" k="168" />
<hkern g1="afii10037" g2="afii10075" k="78" />
<hkern g1="afii10037" g2="afii10076" k="168" />
<hkern g1="afii10037" g2="afii10077" k="231" />
<hkern g1="afii10037" g2="afii10078" k="168" />
<hkern g1="afii10037" g2="afii10079" k="168" />
<hkern g1="afii10037" g2="afii10080" k="221" />
<hkern g1="afii10037" g2="afii10081" k="168" />
<hkern g1="afii10037" g2="afii10082" k="168" />
<hkern g1="afii10037" g2="afii10083" k="221" />
<hkern g1="afii10037" g2="afii10087" k="168" />
<hkern g1="afii10037" g2="afii10088" k="168" />
<hkern g1="afii10037" g2="afii10090" k="168" />
<hkern g1="afii10037" g2="afii10091" k="168" />
<hkern g1="afii10037" g2="afii10096" k="168" />
<hkern g1="afii10037" g2="afii10097" k="197" />
<hkern g1="afii10038" g2="afii10017" k="129" />
<hkern g1="afii10038" g2="afii10021" k="180" />
<hkern g1="afii10038" g2="afii10029" k="154" />
<hkern g1="afii10038" g2="afii10032" k="-25" />
<hkern g1="afii10038" g2="afii10036" k="51" />
<hkern g1="afii10038" g2="afii10037" k="156" />
<hkern g1="afii10038" g2="afii10041" k="129" />
<hkern g1="afii10038" g2="afii10049" k="102" />
<hkern g1="afii10038" g2="afii10077" k="102" />
<hkern g1="afii10039" g2="afii10025" k="51" />
<hkern g1="afii10039" g2="afii10032" k="104" />
<hkern g1="afii10039" g2="afii10035" k="78" />
<hkern g1="afii10039" g2="afii10038" k="143" />
<hkern g1="afii10039" g2="afii10047" k="27" />
<hkern g1="afii10039" g2="afii10080" k="63" />
<hkern g1="afii10039" g2="afii10085" k="78" />
<hkern g1="afii10040" g2="afii10032" k="27" />
<hkern g1="afii10043" g2="afii10085" k="-25" />
<hkern g1="afii10044" g2="quoteright" k="129" />
<hkern g1="afii10044" g2="afii10049" k="123" />
<hkern g1="afii10046" g2="quoteright" k="129" />
<hkern g1="afii10046" g2="afii10017" k="88" />
<hkern g1="afii10046" g2="afii10021" k="150" />
<hkern g1="afii10046" g2="afii10024" k="129" />
<hkern g1="afii10046" g2="afii10025" k="78" />
<hkern g1="afii10046" g2="afii10029" k="82" />
<hkern g1="afii10046" g2="afii10030" k="82" />
<hkern g1="afii10046" g2="afii10032" k="51" />
<hkern g1="afii10046" g2="afii10035" k="51" />
<hkern g1="afii10046" g2="afii10036" k="154" />
<hkern g1="afii10046" g2="afii10039" k="147" />
<hkern g1="afii10046" g2="afii10041" k="229" />
<hkern g1="afii10046" g2="afii10047" k="27" />
<hkern g1="afii10046" g2="afii10049" k="109" />
<hkern g1="afii10047" g2="afii10021" k="172" />
<hkern g1="afii10047" g2="afii10024" k="51" />
<hkern g1="afii10047" g2="afii10025" k="-25" />
<hkern g1="afii10047" g2="afii10029" k="129" />
<hkern g1="afii10047" g2="afii10032" k="-25" />
<hkern g1="afii10047" g2="afii10038" k="-10" />
<hkern g1="afii10047" g2="afii10039" k="104" />
<hkern g1="afii10047" g2="afii10049" k="150" />
<hkern g1="afii10047" g2="afii10069" k="51" />
<hkern g1="afii10047" g2="afii10077" k="27" />
<hkern g1="afii10048" g2="afii10017" k="78" />
<hkern g1="afii10048" g2="afii10021" k="154" />
<hkern g1="afii10048" g2="afii10024" k="143" />
<hkern g1="afii10048" g2="afii10029" k="102" />
<hkern g1="afii10048" g2="afii10032" k="-25" />
<hkern g1="afii10048" g2="afii10036" k="51" />
<hkern g1="afii10048" g2="afii10039" k="186" />
<hkern g1="afii10048" g2="afii10041" k="78" />
<hkern g1="afii10048" g2="afii10069" k="51" />
<hkern g1="afii10048" g2="afii10072" k="-25" />
<hkern g1="afii10048" g2="afii10077" k="27" />
<hkern g1="afii10065" g2="afii10077" k="-18" />
<hkern g1="afii10065" g2="afii10081" k="27" />
<hkern g1="afii10065" g2="afii10084" k="53" />
<hkern g1="afii10065" g2="afii10085" k="104" />
<hkern g1="afii10065" g2="afii10089" k="82" />
<hkern g1="afii10066" g2="afii10069" k="51" />
<hkern g1="afii10066" g2="afii10070" k="27" />
<hkern g1="afii10066" g2="afii10072" k="51" />
<hkern g1="afii10066" g2="afii10077" k="51" />
<hkern g1="afii10066" g2="afii10078" k="41" />
<hkern g1="afii10066" g2="afii10080" k="27" />
<hkern g1="afii10066" g2="afii10085" k="78" />
<hkern g1="afii10066" g2="afii10087" k="78" />
<hkern g1="afii10066" g2="afii10089" k="78" />
<hkern g1="afii10066" g2="afii10092" k="51" />
<hkern g1="afii10066" g2="afii10097" k="51" />
<hkern g1="afii10067" g2="afii10066" k="27" />
<hkern g1="afii10067" g2="afii10069" k="51" />
<hkern g1="afii10067" g2="afii10072" k="59" />
<hkern g1="afii10067" g2="afii10077" k="27" />
<hkern g1="afii10067" g2="afii10078" k="35" />
<hkern g1="afii10067" g2="afii10080" k="14" />
<hkern g1="afii10067" g2="afii10083" k="-25" />
<hkern g1="afii10067" g2="afii10084" k="51" />
<hkern g1="afii10067" g2="afii10085" k="70" />
<hkern g1="afii10067" g2="afii10086" k="12" />
<hkern g1="afii10067" g2="afii10089" k="78" />
<hkern g1="afii10067" g2="afii10092" k="51" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="comma" k="231" />
<hkern g1="afii10068" g2="period" k="231" />
<hkern g1="afii10068" g2="afii10069" k="102" />
<hkern g1="afii10068" g2="afii10070" k="27" />
<hkern g1="afii10068" g2="afii10077" k="104" />
<hkern g1="afii10068" g2="afii10078" k="27" />
<hkern g1="afii10068" g2="afii10080" k="51" />
<hkern g1="afii10068" g2="afii10097" k="51" />
<hkern g1="afii10069" g2="afii10073" k="-25" />
<hkern g1="afii10069" g2="afii10095" k="-51" />
<hkern g1="afii10070" g2="afii10069" k="27" />
<hkern g1="afii10070" g2="afii10083" k="-25" />
<hkern g1="afii10070" g2="afii10085" k="51" />
<hkern g1="afii10070" g2="afii10086" k="-25" />
<hkern g1="afii10070" g2="afii10087" k="41" />
<hkern g1="afii10070" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10066" k="27" />
<hkern g1="afii10072" g2="afii10070" k="27" />
<hkern g1="afii10072" g2="afii10073" k="-25" />
<hkern g1="afii10072" g2="afii10080" k="51" />
<hkern g1="afii10072" g2="afii10083" k="37" />
<hkern g1="afii10072" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10092" k="27" />
<hkern g1="afii10073" g2="afii10069" k="37" />
<hkern g1="afii10073" g2="afii10072" k="37" />
<hkern g1="afii10073" g2="afii10073" k="-25" />
<hkern g1="afii10073" g2="afii10078" k="29" />
<hkern g1="afii10073" g2="afii10080" k="12" />
<hkern g1="afii10073" g2="afii10085" k="43" />
<hkern g1="afii10073" g2="afii10086" k="14" />
<hkern g1="afii10073" g2="afii10089" k="41" />
<hkern g1="afii10073" g2="afii10092" k="35" />
<hkern g1="afii10076" g2="guillemotleft" k="53" />
<hkern g1="afii10076" g2="afii10065" k="31" />
<hkern g1="afii10076" g2="afii10066" k="51" />
<hkern g1="afii10076" g2="afii10070" k="51" />
<hkern g1="afii10076" g2="afii10073" k="27" />
<hkern g1="afii10076" g2="afii10080" k="27" />
<hkern g1="afii10076" g2="afii10083" k="51" />
<hkern g1="afii10076" g2="afii10085" k="29" />
<hkern g1="afii10076" g2="afii10086" k="51" />
<hkern g1="afii10076" g2="afii10089" k="80" />
<hkern g1="afii10076" g2="afii10095" k="27" />
<hkern g1="afii10078" g2="afii10065" k="14" />
<hkern g1="afii10078" g2="afii10080" k="27" />
<hkern g1="afii10078" g2="afii10095" k="-25" />
<hkern g1="afii10080" g2="afii10067" k="51" />
<hkern g1="afii10080" g2="afii10069" k="59" />
<hkern g1="afii10080" g2="afii10072" k="51" />
<hkern g1="afii10080" g2="afii10077" k="27" />
<hkern g1="afii10080" g2="afii10078" k="39" />
<hkern g1="afii10080" g2="afii10084" k="27" />
<hkern g1="afii10080" g2="afii10085" k="78" />
<hkern g1="afii10080" g2="afii10087" k="51" />
<hkern g1="afii10080" g2="afii10089" k="53" />
<hkern g1="afii10080" g2="afii10095" k="-25" />
<hkern g1="afii10080" g2="afii10097" k="39" />
<hkern g1="afii10082" g2="afii10069" k="27" />
<hkern g1="afii10082" g2="afii10073" k="-25" />
<hkern g1="afii10082" g2="afii10077" k="51" />
<hkern g1="afii10082" g2="afii10078" k="31" />
<hkern g1="afii10082" g2="afii10084" k="27" />
<hkern g1="afii10082" g2="afii10085" k="27" />
<hkern g1="afii10082" g2="afii10089" k="51" />
<hkern g1="afii10083" g2="afii10065" k="-25" />
<hkern g1="afii10083" g2="afii10066" k="-25" />
<hkern g1="afii10083" g2="afii10070" k="-25" />
<hkern g1="afii10083" g2="afii10073" k="-51" />
<hkern g1="afii10083" g2="afii10085" k="27" />
<hkern g1="afii10083" g2="afii10086" k="27" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="41" />
<hkern g1="afii10083" g2="afii10095" k="-25" />
<hkern g1="afii10084" g2="comma" k="154" />
<hkern g1="afii10084" g2="period" k="154" />
<hkern g1="afii10084" g2="afii10065" k="-25" />
<hkern g1="afii10084" g2="afii10069" k="27" />
<hkern g1="afii10084" g2="afii10072" k="-25" />
<hkern g1="afii10084" g2="afii10073" k="-25" />
<hkern g1="afii10084" g2="afii10077" k="51" />
<hkern g1="afii10084" g2="afii10080" k="27" />
<hkern g1="afii10084" g2="afii10082" k="-25" />
<hkern g1="afii10084" g2="afii10083" k="-25" />
<hkern g1="afii10084" g2="afii10085" k="27" />
<hkern g1="afii10084" g2="afii10095" k="-51" />
<hkern g1="afii10084" g2="afii10097" k="27" />
<hkern g1="afii10085" g2="comma" k="205" />
<hkern g1="afii10085" g2="period" k="205" />
<hkern g1="afii10085" g2="colon" k="27" />
<hkern g1="afii10085" g2="semicolon" k="27" />
<hkern g1="afii10085" g2="guillemotright" k="-51" />
<hkern g1="afii10085" g2="afii10065" k="27" />
<hkern g1="afii10085" g2="afii10066" k="27" />
<hkern g1="afii10085" g2="afii10069" k="129" />
<hkern g1="afii10085" g2="afii10070" k="63" />
<hkern g1="afii10085" g2="afii10072" k="27" />
<hkern g1="afii10085" g2="afii10077" k="51" />
<hkern g1="afii10085" g2="afii10078" k="27" />
<hkern g1="afii10085" g2="afii10080" k="51" />
<hkern g1="afii10085" g2="afii10083" k="63" />
<hkern g1="afii10085" g2="afii10086" k="51" />
<hkern g1="afii10085" g2="afii10097" k="51" />
<hkern g1="afii10086" g2="afii10069" k="51" />
<hkern g1="afii10086" g2="afii10077" k="51" />
<hkern g1="afii10086" g2="afii10085" k="51" />
<hkern g1="afii10086" g2="afii10089" k="55" />
<hkern g1="afii10086" g2="afii10097" k="27" />
<hkern g1="afii10087" g2="afii10065" k="27" />
<hkern g1="afii10087" g2="afii10066" k="78" />
<hkern g1="afii10087" g2="afii10070" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="78" />
<hkern g1="afii10087" g2="afii10083" k="59" />
<hkern g1="afii10087" g2="afii10084" k="51" />
<hkern g1="afii10087" g2="afii10085" k="78" />
<hkern g1="afii10087" g2="afii10086" k="78" />
<hkern g1="afii10087" g2="afii10089" k="102" />
<hkern g1="afii10087" g2="afii10092" k="78" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10073" k="-25" />
<hkern g1="afii10094" g2="afii10084" k="78" />
<hkern g1="afii10094" g2="afii10089" k="156" />
<hkern g1="afii10095" g2="afii10069" k="106" />
<hkern g1="afii10095" g2="afii10072" k="115" />
<hkern g1="afii10095" g2="afii10077" k="37" />
<hkern g1="afii10095" g2="afii10078" k="18" />
<hkern g1="afii10095" g2="afii10086" k="12" />
<hkern g1="afii10095" g2="afii10087" k="80" />
<hkern g1="afii10095" g2="afii10097" k="27" />
<hkern g1="afii10096" g2="afii10069" k="117" />
<hkern g1="afii10096" g2="afii10072" k="51" />
<hkern g1="afii10096" g2="afii10077" k="51" />
<hkern g1="afii10096" g2="afii10078" k="27" />
<hkern g1="afii10096" g2="afii10080" k="-25" />
<hkern g1="afii10096" g2="afii10084" k="27" />
<hkern g1="afii10096" g2="afii10086" k="12" />
<hkern g1="afii10096" g2="afii10087" k="80" />
<hkern g1="afii10096" g2="afii10089" k="78" />
<hkern g1="afii10110" g2="comma" k="205" />
<hkern g1="afii10110" g2="period" k="205" />
<hkern g1="afii10110" g2="guillemotright" k="-25" />
<hkern g1="afii10050" g2="comma" k="203" />
<hkern g1="afii10050" g2="period" k="203" />
<hkern g1="afii10050" g2="colon" k="51" />
<hkern g1="afii10050" g2="semicolon" k="51" />
<hkern g1="afii10050" g2="guillemotleft" k="180" />
<hkern g1="afii10050" g2="guillemotright" k="78" />
<hkern g1="afii10050" g2="emdash" k="51" />
</font>

<font horiz-adv-x="844" ><font-face
    font-family="TimesNewRoman-BoldItalic"
    units-per-em="2048"
    panose-1="2 2 7 3 6 5 5 9 3 4"
    ascent="1825"
    descent="-443"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1593" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="512" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="797" d="M368 387H330Q379 651 403 924T477 1292T609 1387Q652 1387 686 1349T720 1257Q720 1213 703 1160T598 924Q452 618 368 387ZM276 298Q344 298 391 250T439 135Q439 67 391 20T276 -28Q208 -28 161
19T113 135Q113 202 160 250T276 298Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="1137" d="M868 721H819L827 1105Q830 1210 848 1255Q874 1315 927 1351T1039 1387Q1086 1387 1115 1358T1145 1284Q1145 1255 1137 1232Q1124 1197 1074 1105L868 721ZM386 721H337L343 1106Q346 1249
407 1318T555 1387Q602 1387 632 1358T663 1287Q663 1231 594 1104L386 721Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1024" d="M90 -28L176 396H40V529H202L261 821H40V951H287L374 1384H506L418 951H713L799 1384H931L843 951H983V821H818L758 529H983V396H733L647 -28H514L600 396H309L219 -28H90ZM335 529H629L687
821H393L335 529Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1024" d="M640 841Q828 653 863 599Q926 500 926 382Q926 194 789 82T452 -30Q430 -30 388 -28L351 -155H274L314 -17Q248 -4 208 10T79 69L172 392H210Q217 243 247 182T343 80L495 606Q355 739 304 833T253
1024Q253 1118 303 1204T450 1339T654 1387Q676 1387 720 1384L737 1442H814L794 1373Q930 1343 1023 1283L929 990H891Q902 1056 902 1097Q902 1166 863 1223Q836 1264 771 1297L640 841ZM699 1315Q602 1319 541 1261Q479 1202 479 1112Q479 1004 579 900L699
1315ZM413 59Q444 55 463 55Q550 55 617 125T685 294Q685 361 656 419T554 550L413 59Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1706" d="M1595 1387L349 -55H229L1471 1387H1595ZM452 649Q350 649 286 718T221 914Q221 1110 353 1258Q460 1379 608 1379Q717 1379 783 1311T849 1122Q849 922 727 786T452 649ZM458 702Q492 702 513
719Q543 743 564 796Q574 822 642 1062Q680 1198 680 1251Q680 1285 661 1305T615 1326Q583 1326 565 1312Q532 1287 508 1230Q491 1189 427 956Q392 832 392 775Q392 742 411 722T458 702ZM1196 -58Q1098 -58 1033 13T968 211Q968 401 1090 537T1355 674Q1461
674 1529 604T1598 418Q1598 223 1472 83T1196 -58ZM1202 0Q1233 0 1255 17Q1287 43 1311 100Q1326 134 1392 363Q1428 488 1428 543Q1428 578 1407 600T1356 622Q1320 622 1291 588T1216 404Q1141 156 1141 72Q1141 38 1158 19T1202 0Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1593" d="M593 748Q586 802 582 845T578 922Q578 1122 702 1254T995 1387Q1103 1387 1168 1326T1234 1180Q1234 1073 1170 996Q1075 880 866 791Q933 576 958 513T1025 376Q1082 439 1107 498T1132
596Q1132 628 1113 652T1051 687L1063 723H1447L1432 687Q1378 674 1341 643T1204 478Q1133 382 1063 309Q1143 198 1209 156Q1251 128 1305 128Q1336 128 1359 138T1415 176H1447Q1399 73 1320 21T1141 -31Q1057 -31 990 2T848 116Q745 43 641 6T430 -31Q276 -31
185 55T94 257Q94 349 133 421T281 575T593 748ZM848 866Q931 925 969 987Q1022 1072 1022 1168Q1022 1240 992 1279Q968 1308 931 1308Q886 1308 860 1272Q822 1218 822 1105Q822 1054 828 995T848 866ZM608 673Q493 610 444 543T394 381Q394 266 465 188T625
109Q663 109 709 126T809 176Q748 268 692 408T608 673Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="569" d="M367 722H319L324 1104Q325 1247 387 1317T535 1387Q583 1387 613 1358T644 1285Q644 1229 576 1105L367 722Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M890 1387L872 1332Q729 1230 635 1095Q491 887 401 589T310 28Q310 -139 389 -332L372 -390Q103 -30 103 328Q103 534 193 736Q299 972 507 1155Q666 1295 890 1387Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M-231 -390L-213 -335Q-98 -253 -19 -155T145 116T282 488Q350 745 350 969Q350 1136 271 1330L287 1387Q556 1027 556 670Q556 463 466 261Q361 26 152 -157Q-7 -297 -231 -390Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="1024" d="M625 992Q622 1050 614 1080T573 1173T540 1271Q540 1317 572 1352T644 1387Q687 1387 718 1355T750 1270Q750 1229 719 1171T680 1083T666 992Q722 1015 746 1032T817 1099Q880 1166 938 1166Q982
1166 1012 1137T1042 1068Q1042 1025 1006 992T909 959Q890 959 840 962Q816 963 788 963Q751 963 676 959Q719 910 743 892T825 843T909 779Q928 754 928 715Q928 672 899 643T829 613Q786 613 752 648T704 775Q696 834 687 861T646 940Q613 887 602 858T583 775Q570
684 537 650T460 616Q419 616 390 644T360 711Q360 751 382 782T465 847T549 898T616 959L509 963Q481 963 456 962Q397 958 375 958Q318 958 282 990T246 1066Q246 1107 275 1136T350 1166Q413 1166 471 1106T546 1033Q570 1016 625 992Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1167" d="M40 744H521V1224H652V744H1133V612H652V136H521V612H40V744Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="512" d="M-35 -329L-58 -287Q95 -200 132 -155Q161 -120 161 -85Q161 -46 110 1T41 82Q28 107 28 146Q28 211 76 258T194 305Q261 305 310 252T360 120Q360 -5 265 -126T-35 -329Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M78 553H660L598 345H13L78 553Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="512" d="M137 300Q206 300 254 252T302 136Q302 68 254 20T137 -28Q69 -28 21 20T-27 136Q-27 204 21 252T137 300Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M849 1384L-24 -31H-166L708 1384H849Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1024" d="M725 1384Q822 1384 891 1328T990 1177T1021 991Q1021 832 980 663T864 352T700 114Q643 54 562 13T395 -28Q316 -28 252 20T150 160T113 357Q113 587 196 818Q265 1010 367 1149T554 1336T725 1384ZM732
1316Q702 1316 680 1305T633 1258T569 1109Q498 901 412 601Q346 370 333 305Q314 212 314 142Q314 93 340 65T406 37Q447 37 473 59Q526 104 561 211Q643 462 768 902Q823 1096 823 1207Q823 1258 797 1287T732 1316Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1024" d="M911 1384L580 246Q554 157 554 133Q554 109 572 84T612 51T742 37L731 0H48L59 37Q161 39 201 54T266 103T324 246L520 922Q565 1076 567 1085Q573 1111 573 1134Q573 1179 546 1205T467 1232Q442
1232 368 1224L360 1261L869 1384H911Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1024" d="M728 0H8V37Q289 297 482 515Q644 696 685 791T727 984Q727 1075 670 1132T526 1189Q387 1189 288 1036L251 1053Q303 1201 386 1278Q501 1384 656 1384Q800 1384 894 1295T989 1089Q989 986 943 886T753
633Q643 517 307 230H568Q694 230 744 258T839 373H886L728 0Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1024" d="M261 737L274 780Q413 800 498 839Q612 889 664 956T716 1100Q716 1166 669 1213T552 1260Q497 1260 450 1231T348 1130L308 1150Q392 1276 476 1330T666 1384Q798 1384 880 1310T962 1131Q962 1049
922 988T804 882Q747 849 625 815Q736 767 781 707Q848 618 848 492Q848 256 644 102Q473 -28 248 -28Q128 -28 67 17Q25 48 25 99Q25 145 57 175T136 205Q160 205 182 195Q220 179 296 128T422 76Q484 76 531 139Q600 232 600 372Q600 481 556 563T443 684T261
737Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1024" d="M479 286H36L85 454L897 1384H1028L756 454H913L860 286H707L615 -28H388L479 286ZM530 454L697 1047L183 454H530Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1024" d="M520 1356H1032L965 1122H490L430 1000Q574 977 668 923T821 767T879 544Q879 400 802 265T586 51T294 -29Q183 -29 131 12T78 107Q78 151 109 182T184 214Q220 214 248 202Q265 194 350 125Q404 81
461 81Q537 81 589 147Q659 233 659 366Q659 486 601 588T443 744Q366 785 244 788L520 1356Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1024" d="M1045 1395V1356Q893 1314 775 1204Q629 1068 524 833Q617 864 685 864Q798 864 873 780T949 540Q949 340 837 174Q699 -28 471 -28Q315 -28 219 79T123 382Q123 594 216 791T454 1123T763 1329Q892
1384 1045 1395ZM491 757Q423 579 379 393Q349 267 349 184Q349 108 381 71T463 34Q502 34 533 62Q584 108 628 246Q697 464 697 609Q697 683 656 733Q624 772 580 772Q545 772 491 757Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1024" d="M424 1356H1134V1311L338 -28L258 17L911 1115H584Q453 1115 392 1089T279 996H241L424 1356Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1024" d="M421 708Q358 792 327 871T295 1026Q295 1179 397 1281T669 1384Q825 1384 915 1299T1005 1092Q1005 1012 967 947T858 832Q812 800 717 766Q833 614 861 551T890 409Q890 226 765 99T446 -28Q273
-28 175 64T76 297Q76 392 119 472T248 617Q310 664 421 708ZM675 812Q728 850 745 892Q783 987 783 1145Q783 1243 753 1283T681 1324Q628 1324 600 1285Q551 1217 551 1099Q551 1027 577 965T675 812ZM457 663Q406 619 385 585Q353 534 326 434T298 220Q298 126
334 82T430 37Q502 37 554 103Q627 194 627 322Q627 406 593 478T457 663Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1024" d="M87 -29V12Q240 54 371 176T609 533Q515 501 448 501Q335 501 259 586T183 826Q183 1026 296 1192Q433 1394 662 1394Q818 1394 913 1287T1009 983Q1009 771 916 575T678 243T370 37Q241 -18 87 -29ZM641
609Q709 787 754 973Q783 1099 783 1182Q783 1257 751 1294T669 1332Q631 1332 600 1304Q548 1258 504 1120Q435 902 435 757Q435 683 477 633Q508 594 553 594Q588 594 641 609Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="682" d="M428 925Q496 925 544 877T592 760Q592 692 544 644T427 596Q359 596 311 644T263 760Q263 828 311 876T428 925ZM246 300Q315 300 363 252T411 136Q411 68 363 20T246 -28Q178 -28 130 20T82 136Q82
204 130 252T246 300Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="682" d="M431 926Q501 926 549 877T598 759Q598 691 549 642T431 593Q363 593 314 642T265 759Q265 828 313 877T431 926ZM24 -329L1 -287Q154 -200 191 -155Q220 -120 220 -85Q220 -46 169 1T100 82Q87
107 87 146Q87 211 135 258T253 305Q320 305 369 252T419 120Q419 -5 324 -126T24 -329Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1167" d="M1133 185L41 631V712L1133 1163V1025L288 672L1133 325V185Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1167" d="M40 904H1134V774H40V904ZM40 577H1134V447H40V577Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1167" d="M41 1163L1133 718V636L41 185V324L886 676L41 1023V1163Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1024" d="M385 382H344Q344 489 378 565T560 815Q665 939 706 1035Q733 1098 733 1169Q733 1254 693 1299T592 1345Q549 1345 524 1323T498 1273Q498 1254 516 1223Q551 1160 551 1113Q551 1063 512 1025T416
986Q358 986 318 1028T277 1142Q277 1260 377 1323T610 1387Q721 1387 805 1351T932 1250T975 1113Q975 1011 924 932Q853 822 676 713T450 542T385 382ZM345 298Q413 298 460 251T508 135Q508 67 460 19T345 -29Q277 -29 229 19T181 135Q181 203 228 250T345 298Z"
/>
<glyph unicode="@" glyph-name="at" horiz-adv-x="1704" d="M1179 925L1423 935L1240 307Q1209 203 1209 151Q1209 119 1232 96T1290 72Q1359 72 1468 151T1649 378T1721 693Q1721 969 1544 1146T1081 1324Q835 1324 634 1209T315 873T197 401Q197 55 417 -165T979
-386Q1260 -386 1483 -235T1799 165H1860Q1740 -129 1511 -285T977 -442Q592 -442 342 -194T92 436Q92 698 216 921T564 1266T1060 1387Q1281 1387 1446 1299T1695 1050T1778 712Q1778 505 1689 334T1466 82T1178 0Q1079 0 1027 49T975 175Q975 229 999 316Q916
178 870 125Q807 54 745 21Q705 0 654 0Q583 0 535 56T486 222Q486 334 518 441T607 643T736 813T902 937Q949 963 1003 963Q1059 963 1095 928T1145 806L1179 925ZM1028 891Q990 891 953 849Q903 792 846 659Q744 420 744 275Q744 231 762 207T803 183Q822 183
858 211Q909 250 967 343T1062 549T1099 759Q1099 828 1073 864Q1054 891 1028 891Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1366" d="M830 437H410L326 333L230 218Q202 181 189 151Q179 128 179 105Q179 81 204 61T289 37V0H-116L-106 37Q-52 46 -10 75Q46 115 151 240L1112 1387H1157L1112 277Q1109 190 1109 172Q1109 104 1136 73T1228
37L1218 0H631L642 37Q729 45 742 51Q770 65 793 109T821 264L830 437ZM830 519L856 961L479 519H830Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1366" d="M317 1356H853Q1032 1356 1109 1337Q1210 1313 1265 1244T1321 1086Q1321 1014 1277 939T1146 816T877 726Q1065 673 1138 590T1211 397Q1211 294 1139 194T948 47T512 0H-52L-39 37Q43 37 78 52T135
98T186 230L428 1064Q465 1191 465 1234Q465 1269 436 1292T307 1319L317 1356ZM624 757Q760 759 838 800T964 934T1012 1111Q1012 1189 963 1238T832 1285L777 1283L624 757ZM600 682L427 79Q477 77 502 77Q725 77 812 201T899 468Q899 536 866 588T779 661T600
682Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1366" d="M1476 1387L1376 956H1337Q1330 1132 1251 1218T1043 1305Q905 1305 768 1187T536 826Q459 629 459 437Q459 265 543 175T775 84Q894 84 992 136T1190 305H1238Q1114 119 988 44T678 -31Q433 -31 284
117T134 505Q134 729 253 932T595 1261T1040 1387Q1124 1387 1249 1351Q1313 1333 1338 1333Q1388 1333 1439 1387H1476Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M-74 0L-62 37Q36 37 86 77T170 229L416 1084Q440 1168 440 1222Q440 1268 412 1290T269 1319L281 1356H745Q1112 1356 1274 1208T1437 791Q1437 602 1362 474Q1215 224 1013 112T494 0H-74ZM773 1276L475
248Q454 177 454 146Q454 118 477 101Q507 78 566 78Q707 78 818 166Q960 279 1034 470T1109 849Q1109 985 1066 1086T933 1240Q870 1276 773 1276Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1366" d="M774 1281L623 755H669Q851 755 934 803T1076 973H1113L961 445H926Q935 498 935 531Q935 586 903 621T818 671Q784 681 677 681H599L469 226Q452 166 452 137Q452 114 474 100Q506 80 595 80Q766 80
917 152T1188 372H1229L1088 0H-72L-60 37Q42 37 89 75T174 245L429 1118Q450 1191 450 1233Q450 1271 423 1291T300 1319L311 1356H1392L1305 1017H1269Q1265 1117 1238 1158Q1196 1222 1127 1251T901 1281H774Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1366" d="M772 1280L622 768Q775 770 821 780Q896 795 957 843T1059 978H1098L943 443H903Q913 495 913 526Q913 588 888 625T822 675T602 693L480 270L456 185Q451 160 451 136Q451 101 464 81T508 50T622 37L611
0H-66L-55 37Q43 37 88 73T169 233L411 1063Q449 1194 451 1231Q449 1266 419 1290T296 1319L306 1356H1414L1323 998H1286Q1280 1110 1251 1164T1156 1249T943 1280H772Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1479" d="M1530 1387L1436 952H1398Q1390 1142 1313 1225T1095 1309Q951 1309 807 1208T562 895T460 450Q460 250 550 145T761 39Q812 39 885 68L989 426Q1015 516 1015 544Q1015 581 984 606T875 632L885 670H1470L1461
632Q1409 629 1380 613T1333 564Q1323 545 1302 466L1179 49Q969 -31 737 -31Q558 -31 433 34T225 240T142 561Q142 945 483 1194Q750 1387 1089 1387Q1148 1387 1198 1381Q1235 1376 1328 1353Q1388 1338 1410 1338Q1454 1338 1493 1387H1530Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1593" d="M609 732H1105L1215 1111Q1237 1189 1237 1230Q1237 1270 1210 1291T1080 1319L1091 1356H1765L1754 1319Q1655 1319 1604 1277T1517 1111L1265 243Q1240 158 1240 121Q1240 84 1267 65Q1302 39 1394
37L1384 0H723L738 37Q834 37 879 74T963 243L1080 647H586L470 243Q445 160 445 120Q445 84 475 62T596 37L586 0H-66L-55 37Q41 37 85 74T168 243L420 1111Q442 1186 442 1229Q442 1270 416 1291T289 1319L300 1356H963L948 1319Q856 1319 809 1280T723 1111L609
732Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="797" d="M283 1319L294 1356H956L943 1319Q853 1319 806 1279T722 1112L474 244Q447 152 447 121Q447 85 475 65Q511 39 611 37L601 0H-72L-61 37Q40 37 87 75T172 244L422 1112Q445 1192 445 1233Q445 1270 417
1291T283 1319Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="1024" d="M547 1319L558 1356H1224L1213 1319Q1121 1319 1071 1278T986 1118L841 610Q762 335 703 225T534 42T255 -31Q118 -31 51 26T-16 172Q-16 245 29 293T133 342Q185 342 220 309T256 228Q256 184 213 133Q187
101 187 82Q187 66 201 55Q225 37 256 37Q314 37 364 113T509 512L687 1118Q710 1198 710 1233Q710 1270 682 1291T547 1319Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1366" d="M1256 0H669L680 37Q738 42 766 70T794 141Q794 186 763 284L619 746L476 251Q452 168 452 131Q452 89 485 64T604 37L593 0H-66L-55 37Q24 39 63 58T125 117T180 270L408 1059Q447 1195 447 1232Q447
1266 416 1291T296 1319L307 1356H945L934 1319Q870 1319 836 1300Q791 1274 763 1224Q744 1191 711 1071L619 747L972 1071Q1075 1166 1087 1185Q1103 1210 1103 1238Q1103 1268 1082 1290T1007 1319L1018 1356H1529L1518 1319Q1459 1314 1422 1302Q1373 1286
1310 1248T1182 1157L1089 1071L874 878L1034 378Q1112 131 1155 86T1267 37L1256 0Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1251" d="M1027 0H-56L-45 37Q52 37 96 74T179 243L431 1114Q452 1186 452 1227Q452 1267 422 1291T304 1319L315 1356H966L955 1319Q861 1317 815 1277T732 1114L502 317Q458 165 458 132Q458 112 480 95T553
77Q719 77 873 153T1135 380H1177L1027 0Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1821" d="M775 1356L875 424L1520 1356H1995L1983 1319Q1885 1319 1834 1277T1747 1111L1497 243Q1473 161 1473 121Q1473 84 1503 62T1621 37L1612 0H935L947 37Q1056 37 1108 78T1196 243L1451 1122L675 0H634L512
1144L253 243Q237 188 237 151Q237 101 271 71T389 37L379 0H-69L-60 37Q21 40 64 71Q140 127 174 243L467 1245Q425 1291 392 1305T279 1319L291 1356H775Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M730 1356L1154 452L1345 1108Q1360 1162 1360 1204Q1360 1254 1329 1284T1220 1319L1231 1356H1661L1651 1319Q1569 1314 1516 1273T1425 1108L1094 -15H1056L512 1141L249 240Q236 193 236 156Q236
102 271 70T385 37L376 0H-66L-57 37Q0 37 24 47Q66 63 106 108T171 240L458 1225Q405 1284 369 1301T261 1319L272 1356H730Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1479" d="M576 -32Q412 -32 311 35T160 218T109 444Q109 666 236 891T578 1252T1004 1388Q1127 1388 1237 1326T1409 1153T1471 929Q1471 676 1310 422T948 53Q796 -32 576 -32ZM971 1306Q892 1306 837 1278T721
1182T599 991T483 652T428 295Q428 173 481 111T617 48Q727 48 804 121Q957 266 1053 546T1150 1046Q1150 1183 1099 1244T971 1306Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1251" d="M581 623L471 245Q448 165 448 132Q448 86 478 63T614 37L601 0H-61L-50 37Q34 38 69 53T127 104Q144 127 178 245L429 1106Q455 1192 455 1229Q455 1266 422 1291T302 1319L313 1356H850Q1071 1356 1168
1300Q1318 1212 1318 1036Q1318 866 1169 737T766 607Q690 607 581 623ZM601 700Q666 692 709 692Q847 692 926 818T1005 1081Q1005 1174 954 1225T813 1277Q794 1277 766 1275L601 700Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1479" d="M612 -31L436 -191Q535 -171 598 -171Q685 -171 843 -213T1092 -255Q1192 -255 1277 -219Q1330 -197 1386 -144L1416 -172Q1315 -295 1178 -360T833 -426Q716 -426 560 -393T312 -359Q239 -359 156 -381L137
-356L506 -31Q376 -9 307 39Q213 103 161 214T109 444Q109 666 236 891T578 1252T1004 1387Q1126 1387 1237 1326T1409 1154T1470 922Q1470 743 1383 555T1148 226T848 23Q746 -20 612 -31ZM971 1306Q892 1306 837 1278T721 1182T599 991T483 652T428 295Q428 173
481 111T617 48Q727 48 804 121Q957 266 1053 546T1150 1046Q1150 1183 1099 1244T971 1306Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1366" d="M588 662L468 251Q442 164 442 123Q442 85 473 62T602 37L588 0H-65L-53 37Q45 37 90 75T174 245L426 1115Q447 1188 447 1230Q447 1270 421 1291T300 1319L310 1356H872Q1113 1356 1211 1272T1309 1056Q1309
917 1195 805Q1123 735 940 684L1062 273Q1111 108 1147 74T1269 37V0H847L655 662L622 660Q611 660 588 662ZM602 722Q637 720 661 720Q807 720 901 820T995 1082Q995 1178 945 1228T813 1278Q793 1278 766 1277L602 722Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1139" d="M1195 1387L1082 927H1049Q1038 1035 1010 1100Q968 1194 899 1245T748 1296Q670 1296 612 1237T553 1102Q553 1028 593 957T785 741Q906 626 947 543T989 363Q989 254 931 162T763 20T512 -31Q426 -31
296 -6T122 20Q88 20 61 10T-6 -31H-45L76 486H114Q127 350 169 255T289 106T467 52Q566 52 632 117T699 271Q699 346 662 415T491 616T306 852Q269 929 269 1016Q269 1167 388 1277T699 1387Q786 1387 928 1348Q1011 1325 1045 1325Q1074 1325 1097 1337T1151
1387H1195Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M328 1356H1419L1316 991H1280Q1282 1020 1282 1042Q1282 1146 1221 1203T1015 1269L713 248Q688 163 688 122Q688 84 719 62T845 37L836 0H163L175 37Q278 37 325 75T411 248L713 1269Q557 1264 452
1201T260 991H221L328 1356Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M1197 1356H1656L1647 1319Q1568 1313 1525 1281Q1456 1230 1422 1113L1242 491Q1158 200 1014 85T648 -31Q522 -31 426 5T285 86T216 197T192 309Q192 380 232 519L404 1113Q427 1193 427 1232Q427 1270
399 1291T266 1319L277 1356H953L941 1319Q843 1319 792 1277T705 1113L532 519Q489 370 489 280Q489 198 555 137T739 76Q847 76 922 115T1048 226Q1114 321 1166 498L1343 1113Q1358 1166 1358 1201Q1358 1263 1314 1296Q1283 1319 1186 1319L1197 1356Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1366" d="M320 -31L364 1103Q367 1202 367 1207Q367 1262 341 1288T243 1319L255 1356H825L814 1319Q741 1319 704 1275T660 1093L628 386L1157 1000Q1260 1119 1284 1165T1308 1245Q1308 1270 1286 1289T1202
1319L1216 1356H1590V1319Q1542 1307 1512 1284Q1468 1251 1376 1144L364 -31H320Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1821" d="M267 -31L359 1129Q363 1180 363 1213Q363 1266 339 1291T252 1319L267 1356H815L804 1319H777Q723 1319 690 1284T649 1151L596 463L1005 1022L1015 1151Q1019 1191 1019 1215Q1019 1264 993 1290T905
1319L915 1356H1467L1456 1319Q1383 1319 1348 1284T1305 1151L1253 463L1647 1005Q1748 1144 1772 1194Q1789 1228 1789 1252Q1789 1275 1767 1293T1680 1319L1690 1356H2052L2043 1319Q1994 1310 1962 1285Q1917 1250 1845 1151L984 -31H925L994 884L327 -31H267Z"
/>
<glyph unicode="X" glyph-name="X" horiz-adv-x="1366" d="M616 627L405 1119Q349 1249 315 1280T206 1319V1356H805L794 1319Q731 1314 709 1294T687 1241Q687 1202 722 1119L842 835L1009 988Q1149 1115 1188 1178Q1211 1215 1211 1245Q1211 1272 1187 1294T1108
1319L1120 1356H1563L1554 1319Q1504 1310 1462 1283Q1395 1240 1238 1096L873 761L1078 284Q1149 121 1184 86T1290 37L1280 0H679L691 37Q754 38 783 62T812 123Q812 172 756 300L646 555L396 322Q277 212 258 179T238 115Q238 85 266 62T358 37L346 0H-124L-114
37Q-61 47 -23 70Q70 126 206 252L616 627Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1251" d="M542 599L428 1093Q399 1221 358 1268Q327 1304 245 1319L256 1356H907L895 1319Q800 1319 757 1281T713 1189Q713 1156 731 1074L819 673L1038 975Q1122 1091 1143 1138T1164 1222Q1164 1258 1137 1285T1050
1319L1061 1356H1468V1319Q1413 1313 1373 1283T1217 1093L832 563L742 249Q713 152 713 136Q713 93 746 65T857 37H895L884 0H190L200 37Q276 36 322 57T391 113Q407 137 438 241L542 599Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M1390 1319L353 74H434Q677 74 824 145T1096 382H1138L996 0H-56V37L980 1278H853Q609 1278 491 1218T289 1012H249L365 1356H1390V1319Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="682" d="M-59 -377L445 1356H878L867 1319H834Q761 1319 726 1304T667 1254T615 1128L244 -142Q213 -250 213 -284Q213 -298 221 -309Q232 -323 254 -332Q270 -338 322 -338H383L372 -377H-59Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M280 1384L416 -31H294L160 1384H280Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="682" d="M710 1356L206 -377H-227L-216 -338H-183Q-110 -338 -75 -323T-16 -274T36 -148L407 1122Q438 1229 438 1264Q438 1278 430 1289Q419 1304 397 1312Q381 1319 329 1319H268L279 1356H710Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="1167" d="M208 666L619 1384H701L1105 666H946L651 1178L361 666H208Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1024" d="M-21 -311H1041V-442H-21V-311Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M244 1387H538L645 1040H567L244 1387Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1024" d="M981 913L787 248L767 167Q764 152 764 145Q764 133 772 124T790 115Q811 115 848 147Q863 160 920 239L955 221Q884 91 804 32T630 -28Q573 -28 543 1T513 76Q513 115 545 221L569 302Q453 103 346 20Q284
-28 214 -28Q122 -28 81 47T40 218Q40 359 126 541T352 835Q467 927 568 927Q624 927 658 895T708 776L744 899L981 913ZM661 723Q661 804 636 840Q618 865 587 865Q556 865 523 835Q456 773 379 584T301 256Q301 203 318 180T357 156Q402 156 448 208Q514 282
567 389Q661 577 661 723Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1024" d="M647 1387L474 784Q553 870 606 898T721 927Q841 927 900 841T960 641Q960 371 764 159Q590 -28 368 -28Q203 -28 19 69L325 1130Q347 1205 347 1233Q347 1257 327 1271Q299 1291 242 1288L253 1328L587
1387H647ZM263 59Q310 29 348 29Q401 29 437 50Q494 84 556 173T661 388T703 639Q703 710 671 747T597 784Q527 784 475 716Q440 672 399 529L263 59Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="909" d="M773 241L803 214Q706 98 612 44Q487 -28 353 -28Q263 -28 194 10T91 118T58 261Q58 425 147 583T382 834T669 927Q782 927 839 877T896 753Q896 686 853 639T757 592Q711 592 681 622T650 693Q650 747
704 787Q741 815 741 836Q741 854 726 865Q706 881 674 881Q590 881 516 813Q418 723 366 585T314 323Q314 225 367 167T493 108Q557 108 631 141T773 241Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1024" d="M1117 1387L792 268Q761 163 761 141Q761 130 769 122T786 114Q803 114 825 131Q862 159 915 237L951 218Q810 -28 641 -28Q581 -28 549 3T516 84Q516 131 542 218L572 320Q447 99 355 26Q285 -28 219
-28Q144 -28 93 33T41 211Q41 360 107 505T259 747T424 885T579 927Q618 927 648 911T718 851L792 1100Q819 1192 819 1232Q819 1256 801 1273T753 1290Q739 1290 718 1287L728 1326L1057 1387H1117ZM677 753Q677 814 653 842T597 870Q565 870 528 837Q457 773
380 580T302 254Q302 206 319 183T357 160Q392 160 427 192Q512 268 594 453T677 753Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="909" d="M324 375Q315 310 315 268Q315 193 358 148T475 103Q545 103 615 137T779 256L809 229Q694 90 585 31T344 -28Q177 -28 113 52T49 237Q49 401 144 565T404 828T735 927Q819 927 862 887T905 786Q905 713
863 644Q805 550 717 493T520 405Q447 385 324 375ZM333 427Q421 440 469 462T564 534T645 659T679 801Q679 829 664 845T624 861Q576 861 516 794Q406 672 333 427Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="682" d="M536 782L419 320Q337 -7 259 -154T77 -371T-163 -442Q-248 -442 -288 -410T-328 -333Q-328 -292 -295 -262T-208 -232Q-163 -232 -139 -255T-115 -313Q-115 -345 -130 -360T-145 -381L-140 -388Q-134
-393 -126 -393Q-96 -393 -75 -374Q-22 -327 4 -260Q22 -214 73 -17L277 782H138L171 899Q246 898 280 918T352 1008Q462 1211 584 1299T856 1387Q952 1387 995 1350T1039 1254Q1039 1202 1010 1172T938 1141Q898 1141 872 1166T846 1226Q846 1251 862 1279T879
1317Q879 1328 872 1335T852 1342Q793 1342 731 1269Q629 1152 567 899H712L677 782H536Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1024" d="M792 866H1058L1026 756H888Q920 697 920 644Q920 553 871 476T725 353T510 307Q479 307 442 311T360 324Q294 290 277 270Q265 256 265 241Q265 223 280 210Q306 187 357 176Q561 132 626 105Q715 68
760 10T806 -130Q806 -255 691 -348T335 -442Q92 -442 -23 -362Q-106 -304 -106 -224Q-106 -163 -52 -111T182 -19Q121 15 100 43Q71 81 71 122Q71 189 124 240T304 341Q206 380 163 441T119 585Q119 672 171 750T326 878T562 927Q647 927 713 908Q747 898 792
866ZM583 878Q534 878 500 846Q446 797 406 682T365 464Q365 415 393 387T464 358Q505 358 535 386Q592 441 634 561T676 780Q676 824 649 851T583 878ZM238 -42Q143 -79 109 -122T74 -215Q74 -280 142 -332T361 -385Q486 -385 542 -340T598 -233Q598 -179 547
-145T349 -74Q281 -56 238 -42Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1139" d="M669 1387L409 486Q544 685 605 755Q696 856 761 891T887 927Q938 927 974 889T1011 786Q1011 732 987 651L860 225Q843 169 843 150Q843 141 850 134T866 126Q878 126 890 136Q922 161 958 216Q967 230
987 258L1026 236Q940 94 863 41T717 -12Q655 -12 620 20T585 100Q585 144 609 225L733 651Q745 695 745 715Q745 726 737 734T717 743Q681 743 618 683Q488 560 358 297L269 0H21L349 1130Q369 1202 369 1233Q369 1258 349 1272Q323 1291 269 1288L276 1328L609
1387H669Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M464 1387Q526 1387 568 1344T611 1240Q611 1179 568 1136T464 1093Q404 1093 361 1136T318 1240Q318 1301 360 1344T464 1387ZM526 927L321 216Q304 155 304 136Q304 125 313 116T332 106Q349 106 366
121Q411 158 474 255L508 235Q357 -28 187 -28Q122 -28 84 8T45 101Q45 138 62 195L201 673Q221 742 221 777Q221 799 202 816T150 833Q135 833 114 832L127 872L466 927H526Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="569" d="M465 1387Q527 1387 570 1344T613 1238Q613 1177 570 1134T465 1090Q403 1090 360 1133T316 1238Q316 1300 359 1343T465 1387ZM549 927L336 140Q270 -101 188 -241Q131 -339 36 -390T-161 -442Q-245 -442
-285 -409T-326 -334Q-326 -292 -293 -260T-207 -227Q-167 -227 -144 -248T-121 -300Q-121 -329 -148 -358Q-159 -370 -159 -376Q-159 -383 -153 -388T-133 -394Q-89 -394 -57 -344Q-35 -311 21 -96L225 674Q247 757 247 778Q247 798 225 816T167 835Q156 835 141
834L152 872L489 927H549Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1024" d="M667 1387L391 441L620 653L696 721Q729 755 742 779Q750 794 750 807Q750 828 730 842T633 861L644 899H1051L1041 861Q969 844 924 822Q889 805 838 766Q762 707 729 675L685 634L746 358Q781 198 798
173Q809 158 824 158Q859 158 907 240Q914 251 926 271L963 248Q888 108 794 35Q731 -14 680 -14Q629 -14 595 22T527 214L477 441L367 343L267 0H12L344 1129Q365 1201 365 1226Q365 1249 355 1263T328 1285T258 1292L267 1329L607 1387H667Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M651 1387L320 261Q291 161 291 136Q291 123 299 114T318 105Q336 105 352 119Q400 158 459 251L498 233Q403 81 311 16Q248 -28 177 -28Q111 -28 72 7T33 93Q33 130 57 212L327 1134Q349 1210 349 1235Q349
1259 328 1273Q300 1293 243 1290L254 1328L591 1387H651Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1593" d="M547 927L419 497Q548 695 607 764Q694 865 750 896T864 927Q929 927 958 888T987 802Q987 753 960 658L915 497Q1045 697 1102 763Q1190 865 1255 901Q1300 927 1351 927Q1404 927 1439 892T1475 799Q1475
735 1445 633L1334 260Q1309 177 1309 153Q1309 145 1315 138T1330 131Q1341 131 1349 138Q1385 167 1425 223Q1434 235 1452 260L1486 238Q1417 109 1335 49T1182 -11Q1121 -11 1084 22T1047 101Q1047 144 1072 231L1185 621Q1208 702 1208 722Q1208 729 1201
735T1187 742Q1174 742 1161 736Q1142 726 1103 684T989 534T887 364T830 206L769 0H516L703 653Q718 706 718 726Q718 733 712 739T698 745Q661 745 581 648Q459 498 359 287L278 0H23L211 643Q239 738 239 778Q239 794 231 805T205 823T136 830L146 868L487 927H547Z"
/>
<glyph unicode="n" glyph-name="n" horiz-adv-x="1139" d="M543 927L419 498Q544 686 606 755Q697 855 763 891T887 927Q939 927 976 889T1013 788Q1013 732 989 652L861 225Q845 169 845 152Q845 142 852 134T868 126Q878 126 889 134Q924 163 960 216Q969 230
989 258L1027 235Q880 -12 718 -12Q656 -12 621 20T586 100Q586 142 610 225L735 652Q748 694 748 714Q748 725 739 733T718 742Q680 742 626 690Q488 558 359 297L277 0H22L209 642Q236 737 236 777Q236 794 228 805T202 823T134 830L145 868L482 927H543Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1024" d="M673 927Q752 927 821 891T926 789T962 645Q962 483 872 321T633 66T335 -28Q199 -28 125 53T50 251Q50 390 105 511T246 723T443 870T673 927ZM632 874Q579 874 544 843Q474 780 386 549T298 131Q298
85 326 55T392 25Q431 25 461 49Q505 85 569 210T674 487T715 765Q715 817 690 845T632 874Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1024" d="M124 871L455 927H515L470 764Q575 860 642 893T775 927Q869 927 920 855T971 677Q971 390 772 168Q596 -28 388 -28Q351 -28 325 -21T252 10L200 -170Q172 -268 172 -319Q172 -351 194 -369T297 -401L288
-438H-250L-240 -401Q-176 -399 -134 -360T-54 -192L190 649Q217 743 217 782Q217 799 209 810T185 827T113 832L124 871ZM280 103Q310 54 334 38T390 21Q422 21 452 38T528 109T614 245T681 433T706 635Q706 712 679 747T612 782Q577 782 546 764Q501 738 440
667L280 103Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1024" d="M990 899L695 -112Q665 -216 659 -243Q650 -287 650 -317Q650 -348 675 -368Q708 -395 779 -401L768 -438H239L249 -401Q308 -392 336 -374T387 -312T437 -164L570 289Q458 97 362 26Q288 -28 215 -28Q142
-28 98 26Q39 98 39 221Q39 350 98 491T255 741T452 901Q502 927 565 927Q627 927 665 891T719 773L757 899H990ZM590 863Q554 863 517 830Q451 771 383 597Q301 383 301 260Q301 208 323 179Q339 158 364 158Q399 158 434 190Q518 265 598 440T679 724Q679 793
652 828T590 863Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="797" d="M485 927L334 365Q520 776 614 871Q669 927 730 927Q772 927 798 897T824 810Q824 713 777 647Q747 605 710 605Q670 605 650 642T622 685T605 692Q595 692 584 686Q562 674 527 628T439 472T358 288T277
0H35L200 663Q218 737 218 761Q218 788 209 803T183 825T114 832L123 861L425 927H485Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="797" d="M758 927L714 618H677Q669 738 604 807T463 876Q417 876 387 849T357 784Q357 752 370 724T428 648Q586 478 620 414T654 277Q654 198 614 128T495 15T329 -28Q271 -28 186 -5Q130 11 102 11Q77 11 63
4T32 -28H-5L44 305H76Q111 184 141 133T223 51T321 20Q376 20 412 54T448 137Q448 184 425 228T316 365Q199 492 162 561Q136 611 136 675Q136 783 214 855T435 927Q497 927 587 905Q632 894 659 894Q698 894 722 927H758Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="569" d="M590 1171L510 899H641L606 784H477L310 204Q294 150 294 122Q294 109 303 100T323 90Q340 90 358 104Q404 139 465 226L500 204Q431 84 348 28T185 -28Q117 -28 80 6T42 94Q42 152 68 243L226 784H90L110
858Q238 905 326 968T538 1171H590Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1139" d="M540 927L346 247Q332 200 332 182Q332 173 339 168Q347 160 358 160Q404 160 481 242Q591 361 712 584L803 890L1056 899L864 239Q840 155 840 143Q840 135 847 127T863 118Q877 118 890 130Q926 159
985 247L1019 223Q880 -28 713 -28Q651 -28 616 3T580 86Q580 140 605 223L654 392Q524 203 465 137Q375 38 314 5T196 -28Q143 -28 105 11T66 110Q66 161 91 247L204 647Q232 745 232 779Q232 794 224 805T198 823T129 830L139 868L480 927H540Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="909" d="M286 -28H250Q253 54 253 96Q253 210 236 425T196 713Q179 766 151 790Q132 806 102 806Q85 806 61 802V838L394 927Q494 654 491 228Q638 368 693 455T749 600Q749 646 715 693T672 761T663 805Q663 857
697 892T783 927Q838 927 868 892Q910 843 910 776Q910 707 886 641T802 484T669 319Q535 183 286 -28Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1366" d="M881 927L955 225Q1106 374 1152 460T1198 605Q1198 627 1188 649T1148 710T1114 759Q1107 778 1107 805Q1107 856 1142 891T1230 927Q1283 927 1314 891Q1358 839 1358 771Q1358 660 1252 480T768 -28H728L666
586L234 -28H191Q206 250 206 492Q206 650 189 720Q179 761 154 782T98 803Q82 803 57 799V836L401 927Q429 849 439 780Q456 674 456 533Q456 483 452 381L839 927H881Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1024" d="M93 867L442 927Q537 778 576 599Q674 744 724 802Q791 880 834 903T927 927Q982 927 1011 897T1041 816Q1041 768 1012 738T938 707Q906 707 865 718T807 730Q765 730 727 700Q675 659 599 525Q684 225
735 159Q765 120 796 120Q822 120 841 133Q870 154 930 238L966 217Q878 75 794 17Q730 -28 668 -28Q604 -28 562 0T486 93T408 300Q291 151 225 83T114 -7T20 -28Q-32 -28 -62 2T-93 80Q-93 131 -60 164T24 197Q51 197 85 181Q135 157 157 157Q186 157 209 169Q239
184 285 234Q313 265 388 366Q292 722 238 792Q204 837 152 837Q125 837 86 829L93 867Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="909" d="M56 837L364 927Q401 881 416 840Q443 769 454 644Q475 398 483 119Q590 260 728 492Q770 562 770 624Q770 663 722 698T661 752T649 803Q649 853 685 890T774 927Q829 927 869 885T910 786Q910 719 873
631T697 327Q520 52 350 -149Q241 -277 174 -333T35 -423Q-8 -442 -50 -442Q-107 -442 -147 -402T-188 -307Q-188 -252 -152 -214T-66 -176Q-5 -176 46 -240Q80 -283 102 -283Q125 -283 147 -270Q177 -254 231 -196Q237 -71 237 -7Q237 79 229 235L212 616Q203
721 167 767Q139 801 94 801Q77 801 56 798V837Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="797" d="M809 899L241 228Q305 209 336 171Q376 121 394 22T435 -104T482 -131Q498 -131 512 -117T526 -84Q526 -65 514 -22Q506 7 506 34Q506 90 541 128T627 166Q672 166 702 133T733 45Q733 -38 657 -106T470
-174Q342 -174 219 -56Q169 -9 138 8Q120 17 92 17Q68 17 39 0H-25L555 688H347Q258 688 219 666T144 580H101L184 899H809Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="713" d="M983 1387L970 1342Q878 1325 818 1283T731 1180T698 984T658 777T564 646T426 547Q369 519 252 489Q373 448 421 402Q496 331 496 226Q496 147 416 -1T335 -224Q335 -280 366 -315T480 -367L467
-414Q369 -415 317 -397Q231 -368 184 -307T136 -160Q136 -77 221 76T307 312Q307 369 272 407T162 457L179 518Q265 532 327 576T421 691T459 902T496 1109T600 1244T767 1348T983 1387Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="451" d="M159 -442V1387H289V-442H159Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="713" d="M-142 -414L-129 -368Q-37 -351 23 -309T110 -207T143 -10T183 197T277 328T415 427Q472 455 589 485Q468 526 420 572Q345 643 345 747Q345 826 425 975T506 1198Q506 1254 475 1289T361 1341L374
1387Q472 1388 524 1371Q610 1342 657 1281T705 1134Q705 1051 620 898T534 662Q534 605 569 567T679 517L662 456Q576 442 514 398T420 283T382 72T346 -135T241 -270T74 -374T-142 -414Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1167" d="M1071 709H1128Q1122 550 1046 468T859 386Q806 386 747 403T484 505Q338 566 273 566Q205 566 160 525T97 387H39Q47 551 120 630T299 710Q352 710 403 696Q504 667 682 591Q778 549 829 535Q859
527 894 527Q965 527 1013 574T1071 709Z" />
<hkern g1="space" g2="A" k="76" />
<hkern g1="space" g2="W" k="37" />
<hkern g1="space" g2="Y" k="37" />
<hkern g1="space" g2="Alphatonos" k="76" />
<hkern g1="space" g2="Upsilontonos" k="37" />
<hkern g1="space" g2="Alpha" k="76" />
<hkern g1="space" g2="Delta" k="76" />
<hkern g1="space" g2="Lambda" k="76" />
<hkern g1="space" g2="Upsilon" k="37" />
<hkern g1="space" g2="Upsilondieresis" k="37" />
<hkern g1="one" g2="one" k="113" />
<hkern g1="A" g2="space" k="113" />
<hkern g1="A" g2="T" k="113" />
<hkern g1="A" g2="V" k="152" />
<hkern g1="A" g2="W" k="188" />
<hkern g1="A" g2="Y" k="113" />
<hkern g1="A" g2="v" k="152" />
<hkern g1="A" g2="w" k="152" />
<hkern g1="A" g2="y" k="152" />
<hkern g1="A" g2="quoteright" k="152" />
<hkern g1="F" g2="space" k="37" />
<hkern g1="F" g2="comma" k="264" />
<hkern g1="F" g2="period" k="264" />
<hkern g1="F" g2="A" k="188" />
<hkern g1="L" g2="space" k="76" />
<hkern g1="L" g2="T" k="37" />
<hkern g1="L" g2="V" k="76" />
<hkern g1="L" g2="W" k="76" />
<hkern g1="L" g2="Y" k="76" />
<hkern g1="L" g2="y" k="76" />
<hkern g1="L" g2="quoteright" k="113" />
<hkern g1="P" g2="space" k="76" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="152" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="37" />
<hkern g1="R" g2="y" k="37" />
<hkern g1="T" g2="comma" k="188" />
<hkern g1="T" g2="hyphen" k="188" />
<hkern g1="T" g2="period" k="188" />
<hkern g1="T" g2="colon" k="152" />
<hkern g1="T" g2="semicolon" k="152" />
<hkern g1="T" g2="A" k="113" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="188" />
<hkern g1="T" g2="c" k="188" />
<hkern g1="T" g2="e" k="188" />
<hkern g1="T" g2="i" k="76" />
<hkern g1="T" g2="o" k="188" />
<hkern g1="T" g2="r" k="76" />
<hkern g1="T" g2="s" k="188" />
<hkern g1="T" g2="u" k="76" />
<hkern g1="T" g2="w" k="76" />
<hkern g1="T" g2="y" k="76" />
<hkern g1="V" g2="space" k="37" />
<hkern g1="V" g2="comma" k="264" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="264" />
<hkern g1="V" g2="colon" k="152" />
<hkern g1="V" g2="semicolon" k="152" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="a" k="227" />
<hkern g1="V" g2="e" k="227" />
<hkern g1="V" g2="i" k="113" />
<hkern g1="V" g2="o" k="227" />
<hkern g1="V" g2="r" k="113" />
<hkern g1="V" g2="u" k="113" />
<hkern g1="V" g2="y" k="152" />
<hkern g1="W" g2="space" k="37" />
<hkern g1="W" g2="comma" k="152" />
<hkern g1="W" g2="hyphen" k="76" />
<hkern g1="W" g2="period" k="152" />
<hkern g1="W" g2="colon" k="113" />
<hkern g1="W" g2="semicolon" k="113" />
<hkern g1="W" g2="A" k="152" />
<hkern g1="W" g2="a" k="152" />
<hkern g1="W" g2="e" k="152" />
<hkern g1="W" g2="i" k="76" />
<hkern g1="W" g2="o" k="152" />
<hkern g1="W" g2="r" k="152" />
<hkern g1="W" g2="u" k="113" />
<hkern g1="W" g2="y" k="113" />
<hkern g1="Y" g2="space" k="76" />
<hkern g1="Y" g2="comma" k="188" />
<hkern g1="Y" g2="hyphen" k="188" />
<hkern g1="Y" g2="period" k="152" />
<hkern g1="Y" g2="colon" k="188" />
<hkern g1="Y" g2="semicolon" k="188" />
<hkern g1="Y" g2="A" k="152" />
<hkern g1="Y" g2="a" k="188" />
<hkern g1="Y" g2="e" k="227" />
<hkern g1="Y" g2="i" k="113" />
<hkern g1="Y" g2="o" k="227" />
<hkern g1="Y" g2="p" k="152" />
<hkern g1="Y" g2="q" k="227" />
<hkern g1="Y" g2="u" k="188" />
<hkern g1="Y" g2="v" k="188" />
<hkern g1="f" g2="f" k="37" />
<hkern g1="f" g2="quoteright" k="-113" />
<hkern g1="r" g2="comma" k="113" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="76" />
<hkern g1="v" g2="period" k="76" />
<hkern g1="w" g2="comma" k="76" />
<hkern g1="w" g2="period" k="76" />
<hkern g1="y" g2="comma" k="76" />
<hkern g1="y" g2="period" k="76" />
<hkern g1="quoteleft" g2="quoteleft" k="152" />
<hkern g1="quoteright" g2="space" k="152" />
<hkern g1="quoteright" g2="s" k="152" />
<hkern g1="quoteright" g2="t" k="76" />
<hkern g1="quoteright" g2="quoteright" k="152" />
<hkern g1="quotesinglbase" g2="afii10051" k="231" />
<hkern g1="quotesinglbase" g2="afii10060" k="231" />
<hkern g1="quotesinglbase" g2="afii10036" k="231" />
<hkern g1="quotesinglbase" g2="afii10041" k="360" />
<hkern g1="quotesinglbase" g2="afii10044" k="180" />
<hkern g1="quotedblbase" g2="afii10051" k="231" />
<hkern g1="quotedblbase" g2="afii10060" k="231" />
<hkern g1="quotedblbase" g2="afii10036" k="231" />
<hkern g1="quotedblbase" g2="afii10041" k="256" />
<hkern g1="quotedblbase" g2="afii10044" k="102" />
<hkern g1="Gamma" g2="space" k="37" />
<hkern g1="Gamma" g2="comma" k="262" />
<hkern g1="Gamma" g2="period" k="262" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-156" />
<hkern g1="Gamma" g2="Alpha" k="307" />
<hkern g1="Gamma" g2="Delta" k="268" />
<hkern g1="Gamma" g2="Lambda" k="307" />
<hkern g1="Gamma" g2="iota" k="76" />
<hkern g1="Theta" g2="Alpha" k="90" />
<hkern g1="Theta" g2="Delta" k="39" />
<hkern g1="Theta" g2="Lambda" k="90" />
<hkern g1="Theta" g2="Upsilon" k="104" />
<hkern g1="Theta" g2="Upsilondieresis" k="104" />
<hkern g1="Phi" g2="Alpha" k="90" />
<hkern g1="Phi" g2="Upsilon" k="139" />
<hkern g1="Phi" g2="Upsilondieresis" k="139" />
<hkern g1="delta" g2="tau" k="29" />
<hkern g1="delta" g2="lambda" k="37" />
<hkern g1="delta" g2="chi" k="63" />
<hkern g1="delta" g2="pi" k="29" />
<hkern g1="tau" g2="alpha" k="29" />
<hkern g1="tau" g2="delta" k="29" />
<hkern g1="tau" g2="sigma" k="29" />
<hkern g1="tau" g2="phi" k="29" />
<hkern g1="tau" g2="alphatonos" k="29" />
<hkern g1="tau" g2="omicron" k="29" />
<hkern g1="tau" g2="sigma1" k="29" />
<hkern g1="tau" g2="omega" k="29" />
<hkern g1="tau" g2="omicrontonos" k="29" />
<hkern g1="tau" g2="omegatonos" k="29" />
<hkern g1="phi" g2="tau" k="29" />
<hkern g1="phi" g2="lambda" k="37" />
<hkern g1="phi" g2="chi" k="63" />
<hkern g1="Alphatonos" g2="space" k="113" />
<hkern g1="Alphatonos" g2="Theta" k="51" />
<hkern g1="Alphatonos" g2="Phi" k="51" />
<hkern g1="Alphatonos" g2="Omicron" k="51" />
<hkern g1="Alphatonos" g2="Tau" k="168" />
<hkern g1="Alphatonos" g2="Upsilon" k="190" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="190" />
<hkern g1="Alphatonos" g2="gamma" k="78" />
<hkern g1="Alphatonos" g2="nu" k="152" />
<hkern g1="Alphatonos" g2="chi" k="68" />
<hkern g1="Omicrontonos" g2="Upsilon" k="104" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="104" />
<hkern g1="Upsilontonos" g2="alpha" k="186" />
<hkern g1="Upsilontonos" g2="delta" k="186" />
<hkern g1="Upsilontonos" g2="sigma" k="186" />
<hkern g1="Upsilontonos" g2="phi" k="186" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-156" />
<hkern g1="Upsilontonos" g2="Alpha" k="152" />
<hkern g1="Upsilontonos" g2="Delta" k="152" />
<hkern g1="Upsilontonos" g2="Lambda" k="152" />
<hkern g1="Upsilontonos" g2="alphatonos" k="186" />
<hkern g1="Upsilontonos" g2="etatonos" k="53" />
<hkern g1="Upsilontonos" g2="iotatonos" k="53" />
<hkern g1="Upsilontonos" g2="eta" k="53" />
<hkern g1="Upsilontonos" g2="iota" k="53" />
<hkern g1="Upsilontonos" g2="kappa" k="53" />
<hkern g1="Upsilontonos" g2="mu" k="53" />
<hkern g1="Upsilontonos" g2="omicron" k="186" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="186" />
<hkern g1="Omegatonos" g2="Upsilon" k="94" />
<hkern g1="Alpha" g2="space" k="113" />
<hkern g1="Alpha" g2="quoteright" k="152" />
<hkern g1="Alpha" g2="Theta" k="51" />
<hkern g1="Alpha" g2="Phi" k="51" />
<hkern g1="Alpha" g2="Omicron" k="51" />
<hkern g1="Alpha" g2="Tau" k="168" />
<hkern g1="Alpha" g2="Upsilon" k="190" />
<hkern g1="Alpha" g2="Upsilondieresis" k="190" />
<hkern g1="Alpha" g2="gamma" k="78" />
<hkern g1="Alpha" g2="nu" k="152" />
<hkern g1="Alpha" g2="chi" k="68" />
<hkern g1="Delta" g2="space" k="113" />
<hkern g1="Delta" g2="Theta" k="39" />
<hkern g1="Delta" g2="Omicron" k="39" />
<hkern g1="Delta" g2="Tau" k="139" />
<hkern g1="Delta" g2="Upsilon" k="190" />
<hkern g1="Delta" g2="Upsilondieresis" k="190" />
<hkern g1="Kappa" g2="Theta" k="90" />
<hkern g1="Kappa" g2="Phi" k="152" />
<hkern g1="Kappa" g2="alpha" k="63" />
<hkern g1="Kappa" g2="delta" k="63" />
<hkern g1="Kappa" g2="sigma" k="63" />
<hkern g1="Kappa" g2="phi" k="63" />
<hkern g1="Kappa" g2="Omicron" k="90" />
<hkern g1="Kappa" g2="alphatonos" k="63" />
<hkern g1="Kappa" g2="zeta" k="63" />
<hkern g1="Kappa" g2="theta" k="63" />
<hkern g1="Kappa" g2="xi" k="63" />
<hkern g1="Kappa" g2="omicron" k="63" />
<hkern g1="Kappa" g2="omega" k="63" />
<hkern g1="Kappa" g2="omicrontonos" k="63" />
<hkern g1="Kappa" g2="omegatonos" k="63" />
<hkern g1="Lambda" g2="space" k="113" />
<hkern g1="Lambda" g2="Theta" k="51" />
<hkern g1="Lambda" g2="Omicron" k="51" />
<hkern g1="Lambda" g2="Tau" k="168" />
<hkern g1="Lambda" g2="Upsilon" k="190" />
<hkern g1="Lambda" g2="Upsilondieresis" k="190" />
<hkern g1="Omicron" g2="Alphatonos" k="90" />
<hkern g1="Omicron" g2="Alpha" k="90" />
<hkern g1="Omicron" g2="Delta" k="39" />
<hkern g1="Omicron" g2="Lambda" k="90" />
<hkern g1="Omicron" g2="Upsilon" k="104" />
<hkern g1="Omicron" g2="Upsilondieresis" k="104" />
<hkern g1="Rho" g2="space" k="76" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="297" />
<hkern g1="Rho" g2="Delta" k="244" />
<hkern g1="Rho" g2="Lambda" k="297" />
<hkern g1="Sigma" g2="tau" k="90" />
<hkern g1="Tau" g2="comma" k="186" />
<hkern g1="Tau" g2="hyphen" k="186" />
<hkern g1="Tau" g2="period" k="186" />
<hkern g1="Tau" g2="colon" k="152" />
<hkern g1="Tau" g2="semicolon" k="152" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="186" />
<hkern g1="Tau" g2="delta" k="186" />
<hkern g1="Tau" g2="epsilon" k="186" />
<hkern g1="Tau" g2="sigma" k="186" />
<hkern g1="Tau" g2="phi" k="186" />
<hkern g1="Tau" g2="iotadieresistonos" k="-195" />
<hkern g1="Tau" g2="Alpha" k="162" />
<hkern g1="Tau" g2="Delta" k="156" />
<hkern g1="Tau" g2="Lambda" k="162" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="186" />
<hkern g1="Tau" g2="epsilontonos" k="186" />
<hkern g1="Tau" g2="eta" k="76" />
<hkern g1="Tau" g2="iota" k="76" />
<hkern g1="Tau" g2="mu" k="76" />
<hkern g1="Tau" g2="omicron" k="186" />
<hkern g1="Tau" g2="upsilon" k="76" />
<hkern g1="Tau" g2="chi" k="76" />
<hkern g1="Tau" g2="psi" k="76" />
<hkern g1="Tau" g2="iotadieresis" k="-102" />
<hkern g1="Tau" g2="upsilondieresis" k="76" />
<hkern g1="Tau" g2="omicrontonos" k="186" />
<hkern g1="Tau" g2="upsilontonos" k="76" />
<hkern g1="Upsilon" g2="comma" k="186" />
<hkern g1="Upsilon" g2="hyphen" k="186" />
<hkern g1="Upsilon" g2="period" k="186" />
<hkern g1="Upsilon" g2="colon" k="186" />
<hkern g1="Upsilon" g2="semicolon" k="186" />
<hkern g1="Upsilon" g2="Theta" k="35" />
<hkern g1="Upsilon" g2="Phi" k="51" />
<hkern g1="Upsilon" g2="alpha" k="186" />
<hkern g1="Upsilon" g2="delta" k="186" />
<hkern g1="Upsilon" g2="sigma" k="186" />
<hkern g1="Upsilon" g2="phi" k="186" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-156" />
<hkern g1="Upsilon" g2="Alpha" k="152" />
<hkern g1="Upsilon" g2="Delta" k="117" />
<hkern g1="Upsilon" g2="Lambda" k="152" />
<hkern g1="Upsilon" g2="Omicron" k="35" />
<hkern g1="Upsilon" g2="alphatonos" k="186" />
<hkern g1="Upsilon" g2="etatonos" k="53" />
<hkern g1="Upsilon" g2="iotatonos" k="53" />
<hkern g1="Upsilon" g2="gamma" k="139" />
<hkern g1="Upsilon" g2="eta" k="53" />
<hkern g1="Upsilon" g2="iota" k="53" />
<hkern g1="Upsilon" g2="kappa" k="53" />
<hkern g1="Upsilon" g2="mu" k="53" />
<hkern g1="Upsilon" g2="omicron" k="186" />
<hkern g1="Upsilon" g2="omicrontonos" k="186" />
<hkern g1="Psi" g2="alpha" k="117" />
<hkern g1="Psi" g2="delta" k="117" />
<hkern g1="Psi" g2="sigma" k="117" />
<hkern g1="Psi" g2="phi" k="117" />
<hkern g1="Psi" g2="alphatonos" k="117" />
<hkern g1="Psi" g2="theta" k="39" />
<hkern g1="Psi" g2="omicron" k="117" />
<hkern g1="Psi" g2="omega" k="117" />
<hkern g1="Psi" g2="omicrontonos" k="117" />
<hkern g1="Psi" g2="omegatonos" k="117" />
<hkern g1="Omega" g2="Upsilon" k="94" />
<hkern g1="Omega" g2="Upsilondieresis" k="94" />
<hkern g1="Upsilondieresis" g2="Theta" k="35" />
<hkern g1="Upsilondieresis" g2="Phi" k="51" />
<hkern g1="Upsilondieresis" g2="alpha" k="186" />
<hkern g1="Upsilondieresis" g2="delta" k="186" />
<hkern g1="Upsilondieresis" g2="sigma" k="186" />
<hkern g1="Upsilondieresis" g2="phi" k="186" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-156" />
<hkern g1="Upsilondieresis" g2="Alpha" k="152" />
<hkern g1="Upsilondieresis" g2="Delta" k="117" />
<hkern g1="Upsilondieresis" g2="Lambda" k="152" />
<hkern g1="Upsilondieresis" g2="Omicron" k="35" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="186" />
<hkern g1="Upsilondieresis" g2="etatonos" k="53" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="53" />
<hkern g1="Upsilondieresis" g2="eta" k="53" />
<hkern g1="Upsilondieresis" g2="iota" k="53" />
<hkern g1="Upsilondieresis" g2="kappa" k="53" />
<hkern g1="Upsilondieresis" g2="mu" k="53" />
<hkern g1="Upsilondieresis" g2="omicron" k="186" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="186" />
<hkern g1="zeta" g2="alpha" k="102" />
<hkern g1="zeta" g2="delta" k="86" />
<hkern g1="zeta" g2="sigma" k="102" />
<hkern g1="zeta" g2="tau" k="170" />
<hkern g1="zeta" g2="phi" k="102" />
<hkern g1="zeta" g2="alphatonos" k="102" />
<hkern g1="zeta" g2="etatonos" k="57" />
<hkern g1="zeta" g2="gamma" k="86" />
<hkern g1="zeta" g2="eta" k="57" />
<hkern g1="zeta" g2="theta" k="86" />
<hkern g1="zeta" g2="iota" k="57" />
<hkern g1="zeta" g2="kappa" k="57" />
<hkern g1="zeta" g2="nu" k="86" />
<hkern g1="zeta" g2="omicron" k="102" />
<hkern g1="zeta" g2="omega" k="102" />
<hkern g1="zeta" g2="omicrontonos" k="102" />
<hkern g1="zeta" g2="omegatonos" k="102" />
<hkern g1="zeta" g2="pi" k="39" />
<hkern g1="kappa" g2="alpha" k="39" />
<hkern g1="kappa" g2="delta" k="39" />
<hkern g1="kappa" g2="sigma" k="39" />
<hkern g1="kappa" g2="phi" k="39" />
<hkern g1="kappa" g2="alphatonos" k="39" />
<hkern g1="kappa" g2="zeta" k="39" />
<hkern g1="kappa" g2="xi" k="39" />
<hkern g1="kappa" g2="omicron" k="39" />
<hkern g1="kappa" g2="sigma1" k="39" />
<hkern g1="kappa" g2="omega" k="39" />
<hkern g1="kappa" g2="omicrontonos" k="39" />
<hkern g1="kappa" g2="omegatonos" k="39" />
<hkern g1="lambda" g2="delta" k="37" />
<hkern g1="lambda" g2="sigma" k="37" />
<hkern g1="lambda" g2="upsilondieresistonos" k="31" />
<hkern g1="lambda" g2="zeta" k="18" />
<hkern g1="lambda" g2="xi" k="25" />
<hkern g1="lambda" g2="sigma1" k="43" />
<hkern g1="lambda" g2="upsilon" k="31" />
<hkern g1="lambda" g2="upsilondieresis" k="31" />
<hkern g1="lambda" g2="upsilontonos" k="31" />
<hkern g1="xi" g2="alpha" k="51" />
<hkern g1="xi" g2="delta" k="51" />
<hkern g1="xi" g2="sigma" k="51" />
<hkern g1="xi" g2="phi" k="51" />
<hkern g1="xi" g2="alphatonos" k="51" />
<hkern g1="xi" g2="zeta" k="51" />
<hkern g1="xi" g2="xi" k="51" />
<hkern g1="xi" g2="omicron" k="51" />
<hkern g1="xi" g2="sigma1" k="51" />
<hkern g1="xi" g2="omicrontonos" k="51" />
<hkern g1="omicron" g2="tau" k="29" />
<hkern g1="omicron" g2="lambda" k="37" />
<hkern g1="omicron" g2="chi" k="63" />
<hkern g1="omicron" g2="pi" k="29" />
<hkern g1="rho" g2="chi" k="63" />
<hkern g1="chi" g2="alpha" k="63" />
<hkern g1="chi" g2="delta" k="63" />
<hkern g1="chi" g2="sigma" k="63" />
<hkern g1="chi" g2="phi" k="31" />
<hkern g1="chi" g2="alphatonos" k="63" />
<hkern g1="chi" g2="zeta" k="31" />
<hkern g1="chi" g2="omicron" k="63" />
<hkern g1="chi" g2="sigma1" k="31" />
<hkern g1="chi" g2="omega" k="63" />
<hkern g1="chi" g2="omicrontonos" k="63" />
<hkern g1="chi" g2="omegatonos" k="63" />
<hkern g1="omega" g2="tau" k="29" />
<hkern g1="omega" g2="chi" k="63" />
<hkern g1="omega" g2="pi" k="29" />
<hkern g1="omicrontonos" g2="tau" k="29" />
<hkern g1="omicrontonos" g2="lambda" k="37" />
<hkern g1="omicrontonos" g2="chi" k="63" />
<hkern g1="omicrontonos" g2="pi" k="29" />
<hkern g1="omegatonos" g2="tau" k="29" />
<hkern g1="omegatonos" g2="chi" k="63" />
<hkern g1="omegatonos" g2="pi" k="29" />
<hkern g1="afii10052" g2="comma" k="129" />
<hkern g1="afii10052" g2="period" k="154" />
<hkern g1="afii10052" g2="colon" k="-51" />
<hkern g1="afii10058" g2="quoteright" k="248" />
<hkern g1="afii10059" g2="quoteright" k="180" />
<hkern g1="afii10017" g2="quoteright" k="207" />
<hkern g1="afii10017" g2="afii10021" k="-29" />
<hkern g1="afii10017" g2="afii10025" k="27" />
<hkern g1="afii10017" g2="afii10032" k="78" />
<hkern g1="afii10017" g2="afii10033" k="51" />
<hkern g1="afii10017" g2="afii10035" k="51" />
<hkern g1="afii10017" g2="afii10036" k="78" />
<hkern g1="afii10017" g2="afii10037" k="129" />
<hkern g1="afii10017" g2="afii10038" k="104" />
<hkern g1="afii10017" g2="afii10041" k="129" />
<hkern g1="afii10017" g2="afii10047" k="102" />
<hkern g1="afii10017" g2="afii10065" k="31" />
<hkern g1="afii10017" g2="afii10066" k="31" />
<hkern g1="afii10017" g2="afii10070" k="31" />
<hkern g1="afii10017" g2="afii10080" k="31" />
<hkern g1="afii10017" g2="afii10083" k="31" />
<hkern g1="afii10017" g2="afii10085" k="68" />
<hkern g1="afii10017" g2="afii10086" k="31" />
<hkern g1="afii10017" g2="afii10095" k="31" />
<hkern g1="afii10018" g2="afii10017" k="55" />
<hkern g1="afii10018" g2="afii10021" k="-25" />
<hkern g1="afii10018" g2="afii10025" k="-76" />
<hkern g1="afii10018" g2="afii10037" k="82" />
<hkern g1="afii10018" g2="afii10038" k="55" />
<hkern g1="afii10018" g2="afii10039" k="27" />
<hkern g1="afii10018" g2="afii10041" k="55" />
<hkern g1="afii10018" g2="afii10044" k="57" />
<hkern g1="afii10018" g2="afii10047" k="29" />
<hkern g1="afii10018" g2="afii10069" k="-25" />
<hkern g1="afii10018" g2="afii10085" k="25" />
<hkern g1="afii10018" g2="afii10097" k="-47" />
<hkern g1="afii10019" g2="afii10017" k="78" />
<hkern g1="afii10019" g2="afii10021" k="109" />
<hkern g1="afii10019" g2="afii10024" k="82" />
<hkern g1="afii10019" g2="afii10025" k="70" />
<hkern g1="afii10019" g2="afii10032" k="96" />
<hkern g1="afii10019" g2="afii10035" k="96" />
<hkern g1="afii10019" g2="afii10036" k="117" />
<hkern g1="afii10019" g2="afii10037" k="174" />
<hkern g1="afii10019" g2="afii10038" k="137" />
<hkern g1="afii10019" g2="afii10039" k="51" />
<hkern g1="afii10019" g2="afii10041" k="123" />
<hkern g1="afii10019" g2="afii10044" k="98" />
<hkern g1="afii10019" g2="afii10049" k="96" />
<hkern g1="afii10019" g2="afii10069" k="-25" />
<hkern g1="afii10019" g2="afii10078" k="27" />
<hkern g1="afii10019" g2="afii10084" k="-25" />
<hkern g1="afii10019" g2="afii10087" k="29" />
<hkern g1="afii10019" g2="afii10089" k="-25" />
<hkern g1="afii10019" g2="afii10097" k="-25" />
<hkern g1="afii10020" g2="comma" k="129" />
<hkern g1="afii10020" g2="period" k="154" />
<hkern g1="afii10020" g2="colon" k="-51" />
<hkern g1="afii10020" g2="afii10017" k="154" />
<hkern g1="afii10020" g2="afii10021" k="154" />
<hkern g1="afii10020" g2="afii10025" k="-39" />
<hkern g1="afii10020" g2="afii10029" k="141" />
<hkern g1="afii10020" g2="afii10030" k="51" />
<hkern g1="afii10020" g2="afii10032" k="27" />
<hkern g1="afii10020" g2="afii10049" k="27" />
<hkern g1="afii10020" g2="afii10065" k="51" />
<hkern g1="afii10020" g2="afii10067" k="78" />
<hkern g1="afii10020" g2="afii10069" k="37" />
<hkern g1="afii10020" g2="afii10070" k="61" />
<hkern g1="afii10020" g2="afii10074" k="39" />
<hkern g1="afii10020" g2="afii10077" k="109" />
<hkern g1="afii10020" g2="afii10078" k="82" />
<hkern g1="afii10020" g2="afii10079" k="61" />
<hkern g1="afii10020" g2="afii10080" k="106" />
<hkern g1="afii10020" g2="afii10082" k="57" />
<hkern g1="afii10020" g2="afii10085" k="88" />
<hkern g1="afii10020" g2="afii10093" k="109" />
<hkern g1="afii10020" g2="afii10094" k="102" />
<hkern g1="afii10020" g2="afii10096" k="133" />
<hkern g1="afii10020" g2="afii10097" k="82" />
<hkern g1="afii10021" g2="afii10038" k="39" />
<hkern g1="afii10021" g2="afii10085" k="-51" />
<hkern g1="afii10022" g2="afii10025" k="29" />
<hkern g1="afii10024" g2="afii10032" k="109" />
<hkern g1="afii10024" g2="afii10035" k="109" />
<hkern g1="afii10024" g2="afii10037" k="70" />
<hkern g1="afii10024" g2="afii10041" k="70" />
<hkern g1="afii10024" g2="afii10080" k="27" />
<hkern g1="afii10024" g2="afii10085" k="61" />
<hkern g1="afii10025" g2="afii10036" k="-25" />
<hkern g1="afii10025" g2="afii10037" k="27" />
<hkern g1="afii10025" g2="afii10041" k="102" />
<hkern g1="afii10025" g2="afii10069" k="-27" />
<hkern g1="afii10028" g2="afii10032" k="96" />
<hkern g1="afii10028" g2="afii10035" k="96" />
<hkern g1="afii10028" g2="afii10037" k="27" />
<hkern g1="afii10028" g2="afii10038" k="164" />
<hkern g1="afii10028" g2="afii10047" k="27" />
<hkern g1="afii10028" g2="afii10070" k="51" />
<hkern g1="afii10028" g2="afii10080" k="78" />
<hkern g1="afii10028" g2="afii10083" k="51" />
<hkern g1="afii10028" g2="afii10085" k="88" />
<hkern g1="afii10028" g2="afii10095" k="51" />
<hkern g1="afii10029" g2="afii10085" k="-39" />
<hkern g1="afii10030" g2="afii10038" k="51" />
<hkern g1="afii10030" g2="afii10065" k="29" />
<hkern g1="afii10030" g2="afii10070" k="29" />
<hkern g1="afii10030" g2="afii10080" k="29" />
<hkern g1="afii10030" g2="afii10083" k="29" />
<hkern g1="afii10032" g2="afii10017" k="98" />
<hkern g1="afii10032" g2="afii10021" k="51" />
<hkern g1="afii10032" g2="afii10024" k="78" />
<hkern g1="afii10032" g2="afii10029" k="51" />
<hkern g1="afii10032" g2="afii10037" k="119" />
<hkern g1="afii10032" g2="afii10038" k="-25" />
<hkern g1="afii10032" g2="afii10039" k="102" />
<hkern g1="afii10032" g2="afii10041" k="78" />
<hkern g1="afii10032" g2="afii10049" k="78" />
<hkern g1="afii10032" g2="afii10072" k="-39" />
<hkern g1="afii10032" g2="afii10087" k="-39" />
<hkern g1="afii10034" g2="comma" k="180" />
<hkern g1="afii10034" g2="period" k="205" />
<hkern g1="afii10034" g2="colon" k="-51" />
<hkern g1="afii10034" g2="afii10017" k="180" />
<hkern g1="afii10034" g2="afii10021" k="203" />
<hkern g1="afii10034" g2="afii10024" k="106" />
<hkern g1="afii10034" g2="afii10025" k="68" />
<hkern g1="afii10034" g2="afii10029" k="160" />
<hkern g1="afii10034" g2="afii10030" k="51" />
<hkern g1="afii10034" g2="afii10032" k="27" />
<hkern g1="afii10034" g2="afii10037" k="145" />
<hkern g1="afii10034" g2="afii10038" k="55" />
<hkern g1="afii10034" g2="afii10039" k="129" />
<hkern g1="afii10034" g2="afii10049" k="84" />
<hkern g1="afii10034" g2="afii10065" k="78" />
<hkern g1="afii10034" g2="afii10069" k="74" />
<hkern g1="afii10034" g2="afii10070" k="74" />
<hkern g1="afii10034" g2="afii10080" k="74" />
<hkern g1="afii10034" g2="afii10097" k="51" />
<hkern g1="afii10035" g2="afii10017" k="78" />
<hkern g1="afii10035" g2="afii10029" k="-25" />
<hkern g1="afii10035" g2="afii10037" k="27" />
<hkern g1="afii10035" g2="afii10039" k="27" />
<hkern g1="afii10035" g2="afii10041" k="27" />
<hkern g1="afii10035" g2="afii10065" k="-14" />
<hkern g1="afii10035" g2="afii10066" k="-14" />
<hkern g1="afii10035" g2="afii10070" k="-14" />
<hkern g1="afii10035" g2="afii10072" k="-14" />
<hkern g1="afii10035" g2="afii10073" k="-14" />
<hkern g1="afii10035" g2="afii10080" k="-14" />
<hkern g1="afii10035" g2="afii10083" k="-14" />
<hkern g1="afii10035" g2="afii10084" k="-29" />
<hkern g1="afii10035" g2="afii10086" k="-14" />
<hkern g1="afii10035" g2="afii10095" k="-14" />
<hkern g1="afii10036" g2="comma" k="102" />
<hkern g1="afii10036" g2="period" k="129" />
<hkern g1="afii10036" g2="colon" k="-76" />
<hkern g1="afii10036" g2="semicolon" k="-25" />
<hkern g1="afii10036" g2="guillemotleft" k="-51" />
<hkern g1="afii10036" g2="guillemotright" k="-51" />
<hkern g1="afii10036" g2="afii10017" k="129" />
<hkern g1="afii10036" g2="afii10021" k="-51" />
<hkern g1="afii10036" g2="afii10038" k="55" />
<hkern g1="afii10036" g2="afii10047" k="-14" />
<hkern g1="afii10036" g2="afii10065" k="74" />
<hkern g1="afii10036" g2="afii10067" k="74" />
<hkern g1="afii10036" g2="afii10070" k="74" />
<hkern g1="afii10036" g2="afii10074" k="49" />
<hkern g1="afii10036" g2="afii10076" k="74" />
<hkern g1="afii10036" g2="afii10077" k="74" />
<hkern g1="afii10036" g2="afii10078" k="74" />
<hkern g1="afii10036" g2="afii10080" k="74" />
<hkern g1="afii10036" g2="afii10081" k="49" />
<hkern g1="afii10036" g2="afii10082" k="51" />
<hkern g1="afii10036" g2="afii10083" k="74" />
<hkern g1="afii10036" g2="afii10085" k="49" />
<hkern g1="afii10036" g2="afii10087" k="49" />
<hkern g1="afii10036" g2="afii10091" k="49" />
<hkern g1="afii10036" g2="afii10093" k="74" />
<hkern g1="afii10036" g2="afii10094" k="74" />
<hkern g1="afii10036" g2="afii10096" k="74" />
<hkern g1="afii10036" g2="afii10097" k="49" />
<hkern g1="afii10037" g2="comma" k="104" />
<hkern g1="afii10037" g2="period" k="129" />
<hkern g1="afii10037" g2="colon" k="-51" />
<hkern g1="afii10037" g2="guillemotleft" k="-25" />
<hkern g1="afii10037" g2="guillemotright" k="-51" />
<hkern g1="afii10037" g2="afii10017" k="154" />
<hkern g1="afii10037" g2="afii10021" k="82" />
<hkern g1="afii10037" g2="afii10029" k="133" />
<hkern g1="afii10037" g2="afii10032" k="55" />
<hkern g1="afii10037" g2="afii10038" k="109" />
<hkern g1="afii10037" g2="afii10049" k="109" />
<hkern g1="afii10037" g2="afii10066" k="27" />
<hkern g1="afii10037" g2="afii10067" k="96" />
<hkern g1="afii10037" g2="afii10068" k="102" />
<hkern g1="afii10037" g2="afii10069" k="27" />
<hkern g1="afii10037" g2="afii10070" k="96" />
<hkern g1="afii10037" g2="afii10072" k="102" />
<hkern g1="afii10037" g2="afii10073" k="63" />
<hkern g1="afii10037" g2="afii10074" k="31" />
<hkern g1="afii10037" g2="afii10075" k="27" />
<hkern g1="afii10037" g2="afii10076" k="51" />
<hkern g1="afii10037" g2="afii10077" k="102" />
<hkern g1="afii10037" g2="afii10078" k="102" />
<hkern g1="afii10037" g2="afii10079" k="51" />
<hkern g1="afii10037" g2="afii10080" k="96" />
<hkern g1="afii10037" g2="afii10081" k="57" />
<hkern g1="afii10037" g2="afii10082" k="82" />
<hkern g1="afii10037" g2="afii10083" k="96" />
<hkern g1="afii10037" g2="afii10087" k="45" />
<hkern g1="afii10037" g2="afii10088" k="27" />
<hkern g1="afii10037" g2="afii10090" k="27" />
<hkern g1="afii10037" g2="afii10091" k="27" />
<hkern g1="afii10037" g2="afii10096" k="57" />
<hkern g1="afii10037" g2="afii10097" k="96" />
<hkern g1="afii10038" g2="afii10017" k="102" />
<hkern g1="afii10038" g2="afii10021" k="96" />
<hkern g1="afii10038" g2="afii10029" k="27" />
<hkern g1="afii10038" g2="afii10030" k="12" />
<hkern g1="afii10038" g2="afii10032" k="-25" />
<hkern g1="afii10038" g2="afii10036" k="27" />
<hkern g1="afii10038" g2="afii10037" k="158" />
<hkern g1="afii10038" g2="afii10041" k="70" />
<hkern g1="afii10038" g2="afii10049" k="27" />
<hkern g1="afii10038" g2="afii10077" k="31" />
<hkern g1="afii10039" g2="afii10032" k="104" />
<hkern g1="afii10039" g2="afii10035" k="78" />
<hkern g1="afii10039" g2="afii10038" k="51" />
<hkern g1="afii10039" g2="afii10080" k="41" />
<hkern g1="afii10044" g2="quoteright" k="248" />
<hkern g1="afii10044" g2="afii10049" k="37" />
<hkern g1="afii10046" g2="quoteright" k="248" />
<hkern g1="afii10046" g2="afii10017" k="70" />
<hkern g1="afii10046" g2="afii10021" k="27" />
<hkern g1="afii10046" g2="afii10024" k="57" />
<hkern g1="afii10046" g2="afii10025" k="27" />
<hkern g1="afii10046" g2="afii10030" k="41" />
<hkern g1="afii10046" g2="afii10032" k="51" />
<hkern g1="afii10046" g2="afii10035" k="41" />
<hkern g1="afii10046" g2="afii10036" k="104" />
<hkern g1="afii10046" g2="afii10039" k="82" />
<hkern g1="afii10046" g2="afii10041" k="229" />
<hkern g1="afii10046" g2="afii10047" k="78" />
<hkern g1="afii10046" g2="afii10049" k="27" />
<hkern g1="afii10047" g2="afii10024" k="27" />
<hkern g1="afii10047" g2="afii10025" k="-51" />
<hkern g1="afii10047" g2="afii10029" k="27" />
<hkern g1="afii10047" g2="afii10039" k="78" />
<hkern g1="afii10047" g2="afii10049" k="27" />
<hkern g1="afii10047" g2="afii10069" k="-29" />
<hkern g1="afii10047" g2="afii10072" k="-29" />
<hkern g1="afii10047" g2="afii10077" k="14" />
<hkern g1="afii10047" g2="afii10078" k="29" />
<hkern g1="afii10047" g2="afii10097" k="-29" />
<hkern g1="afii10048" g2="afii10017" k="115" />
<hkern g1="afii10048" g2="afii10021" k="27" />
<hkern g1="afii10048" g2="afii10024" k="51" />
<hkern g1="afii10048" g2="afii10029" k="51" />
<hkern g1="afii10048" g2="afii10032" k="27" />
<hkern g1="afii10048" g2="afii10036" k="27" />
<hkern g1="afii10048" g2="afii10039" k="104" />
<hkern g1="afii10048" g2="afii10041" k="51" />
<hkern g1="afii10048" g2="afii10069" k="-14" />
<hkern g1="afii10048" g2="afii10072" k="-14" />
<hkern g1="afii10065" g2="afii10085" k="27" />
<hkern g1="afii10065" g2="afii10089" k="27" />
<hkern g1="afii10066" g2="afii10072" k="27" />
<hkern g1="afii10066" g2="afii10073" k="27" />
<hkern g1="afii10066" g2="afii10077" k="51" />
<hkern g1="afii10066" g2="afii10078" k="78" />
<hkern g1="afii10066" g2="afii10080" k="27" />
<hkern g1="afii10066" g2="afii10083" k="27" />
<hkern g1="afii10066" g2="afii10085" k="27" />
<hkern g1="afii10066" g2="afii10086" k="27" />
<hkern g1="afii10066" g2="afii10087" k="41" />
<hkern g1="afii10066" g2="afii10089" k="27" />
<hkern g1="afii10066" g2="afii10092" k="51" />
<hkern g1="afii10066" g2="afii10095" k="27" />
<hkern g1="afii10066" g2="afii10097" k="51" />
<hkern g1="afii10067" g2="afii10065" k="14" />
<hkern g1="afii10067" g2="afii10066" k="27" />
<hkern g1="afii10067" g2="afii10069" k="39" />
<hkern g1="afii10067" g2="afii10070" k="25" />
<hkern g1="afii10067" g2="afii10073" k="27" />
<hkern g1="afii10067" g2="afii10080" k="27" />
<hkern g1="afii10067" g2="afii10083" k="27" />
<hkern g1="afii10067" g2="afii10086" k="14" />
<hkern g1="afii10067" g2="afii10092" k="27" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="period" k="27" />
<hkern g1="afii10068" g2="afii10077" k="27" />
<hkern g1="afii10069" g2="afii10085" k="27" />
<hkern g1="afii10069" g2="afii10092" k="27" />
<hkern g1="afii10069" g2="afii10095" k="27" />
<hkern g1="afii10070" g2="afii10065" k="27" />
<hkern g1="afii10070" g2="afii10066" k="27" />
<hkern g1="afii10070" g2="afii10069" k="51" />
<hkern g1="afii10070" g2="afii10072" k="51" />
<hkern g1="afii10070" g2="afii10073" k="27" />
<hkern g1="afii10070" g2="afii10077" k="51" />
<hkern g1="afii10070" g2="afii10078" k="51" />
<hkern g1="afii10070" g2="afii10080" k="27" />
<hkern g1="afii10070" g2="afii10083" k="27" />
<hkern g1="afii10070" g2="afii10084" k="27" />
<hkern g1="afii10070" g2="afii10086" k="51" />
<hkern g1="afii10070" g2="afii10087" k="27" />
<hkern g1="afii10070" g2="afii10089" k="27" />
<hkern g1="afii10072" g2="afii10065" k="27" />
<hkern g1="afii10072" g2="afii10066" k="27" />
<hkern g1="afii10072" g2="afii10070" k="27" />
<hkern g1="afii10072" g2="afii10073" k="27" />
<hkern g1="afii10072" g2="afii10080" k="51" />
<hkern g1="afii10072" g2="afii10083" k="51" />
<hkern g1="afii10072" g2="afii10089" k="27" />
<hkern g1="afii10072" g2="afii10092" k="27" />
<hkern g1="afii10073" g2="afii10069" k="27" />
<hkern g1="afii10073" g2="afii10072" k="27" />
<hkern g1="afii10073" g2="afii10073" k="27" />
<hkern g1="afii10073" g2="afii10077" k="51" />
<hkern g1="afii10073" g2="afii10078" k="51" />
<hkern g1="afii10073" g2="afii10080" k="27" />
<hkern g1="afii10073" g2="afii10083" k="27" />
<hkern g1="afii10073" g2="afii10085" k="14" />
<hkern g1="afii10073" g2="afii10089" k="27" />
<hkern g1="afii10073" g2="afii10092" k="27" />
<hkern g1="afii10076" g2="guillemotleft" k="55" />
<hkern g1="afii10076" g2="afii10065" k="51" />
<hkern g1="afii10076" g2="afii10066" k="51" />
<hkern g1="afii10076" g2="afii10070" k="61" />
<hkern g1="afii10076" g2="afii10073" k="27" />
<hkern g1="afii10076" g2="afii10077" k="-41" />
<hkern g1="afii10076" g2="afii10080" k="78" />
<hkern g1="afii10076" g2="afii10083" k="78" />
<hkern g1="afii10076" g2="afii10084" k="27" />
<hkern g1="afii10076" g2="afii10086" k="51" />
<hkern g1="afii10076" g2="afii10089" k="27" />
<hkern g1="afii10076" g2="afii10095" k="27" />
<hkern g1="afii10077" g2="afii10085" k="27" />
<hkern g1="afii10077" g2="afii10089" k="27" />
<hkern g1="afii10080" g2="afii10069" k="27" />
<hkern g1="afii10080" g2="afii10072" k="51" />
<hkern g1="afii10080" g2="afii10073" k="27" />
<hkern g1="afii10080" g2="afii10077" k="51" />
<hkern g1="afii10080" g2="afii10078" k="78" />
<hkern g1="afii10080" g2="afii10085" k="41" />
<hkern g1="afii10080" g2="afii10087" k="41" />
<hkern g1="afii10080" g2="afii10089" k="53" />
<hkern g1="afii10080" g2="afii10095" k="27" />
<hkern g1="afii10080" g2="afii10097" k="27" />
<hkern g1="afii10082" g2="afii10069" k="27" />
<hkern g1="afii10082" g2="afii10072" k="51" />
<hkern g1="afii10082" g2="afii10073" k="27" />
<hkern g1="afii10082" g2="afii10077" k="78" />
<hkern g1="afii10082" g2="afii10078" k="102" />
<hkern g1="afii10082" g2="afii10084" k="27" />
<hkern g1="afii10082" g2="afii10085" k="27" />
<hkern g1="afii10082" g2="afii10087" k="41" />
<hkern g1="afii10082" g2="afii10089" k="27" />
<hkern g1="afii10082" g2="afii10095" k="27" />
<hkern g1="afii10082" g2="afii10097" k="27" />
<hkern g1="afii10083" g2="afii10065" k="53" />
<hkern g1="afii10083" g2="afii10066" k="27" />
<hkern g1="afii10083" g2="afii10070" k="27" />
<hkern g1="afii10083" g2="afii10072" k="27" />
<hkern g1="afii10083" g2="afii10073" k="27" />
<hkern g1="afii10083" g2="afii10080" k="51" />
<hkern g1="afii10083" g2="afii10085" k="14" />
<hkern g1="afii10083" g2="afii10086" k="51" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="27" />
<hkern g1="afii10083" g2="afii10092" k="27" />
<hkern g1="afii10084" g2="comma" k="-51" />
<hkern g1="afii10084" g2="period" k="-25" />
<hkern g1="afii10084" g2="afii10069" k="27" />
<hkern g1="afii10084" g2="afii10070" k="27" />
<hkern g1="afii10084" g2="afii10073" k="-25" />
<hkern g1="afii10084" g2="afii10080" k="27" />
<hkern g1="afii10084" g2="afii10085" k="51" />
<hkern g1="afii10084" g2="afii10097" k="-25" />
<hkern g1="afii10085" g2="comma" k="102" />
<hkern g1="afii10085" g2="period" k="129" />
<hkern g1="afii10085" g2="colon" k="27" />
<hkern g1="afii10085" g2="semicolon" k="78" />
<hkern g1="afii10085" g2="afii10069" k="6" />
<hkern g1="afii10085" g2="afii10072" k="51" />
<hkern g1="afii10085" g2="afii10073" k="27" />
<hkern g1="afii10085" g2="afii10077" k="55" />
<hkern g1="afii10085" g2="afii10078" k="51" />
<hkern g1="afii10085" g2="afii10082" k="27" />
<hkern g1="afii10085" g2="afii10087" k="27" />
<hkern g1="afii10085" g2="afii10097" k="31" />
<hkern g1="afii10086" g2="afii10077" k="51" />
<hkern g1="afii10086" g2="afii10078" k="78" />
<hkern g1="afii10086" g2="afii10085" k="53" />
<hkern g1="afii10086" g2="afii10089" k="27" />
<hkern g1="afii10086" g2="afii10097" k="27" />
<hkern g1="afii10087" g2="afii10065" k="27" />
<hkern g1="afii10087" g2="afii10066" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="51" />
<hkern g1="afii10087" g2="afii10083" k="51" />
<hkern g1="afii10087" g2="afii10086" k="51" />
<hkern g1="afii10087" g2="afii10089" k="27" />
<hkern g1="afii10087" g2="afii10092" k="51" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10085" k="-25" />
<hkern g1="afii10091" g2="afii10085" k="-63" />
<hkern g1="afii10094" g2="afii10089" k="78" />
<hkern g1="afii10095" g2="afii10066" k="27" />
<hkern g1="afii10095" g2="afii10069" k="27" />
<hkern g1="afii10095" g2="afii10072" k="51" />
<hkern g1="afii10095" g2="afii10073" k="27" />
<hkern g1="afii10095" g2="afii10077" k="51" />
<hkern g1="afii10095" g2="afii10078" k="78" />
<hkern g1="afii10095" g2="afii10080" k="27" />
<hkern g1="afii10095" g2="afii10083" k="27" />
<hkern g1="afii10095" g2="afii10084" k="27" />
<hkern g1="afii10095" g2="afii10086" k="27" />
<hkern g1="afii10095" g2="afii10087" k="41" />
<hkern g1="afii10095" g2="afii10097" k="51" />
<hkern g1="afii10096" g2="afii10066" k="27" />
<hkern g1="afii10096" g2="afii10072" k="27" />
<hkern g1="afii10096" g2="afii10077" k="51" />
<hkern g1="afii10096" g2="afii10078" k="78" />
<hkern g1="afii10096" g2="afii10080" k="27" />
<hkern g1="afii10096" g2="afii10083" k="27" />
<hkern g1="afii10096" g2="afii10087" k="57" />
<hkern g1="afii10096" g2="afii10089" k="27" />
<hkern g1="afii10096" g2="afii10095" k="27" />
<hkern g1="afii10110" g2="comma" k="102" />
<hkern g1="afii10110" g2="period" k="129" />
<hkern g1="afii10110" g2="colon" k="27" />
<hkern g1="afii10110" g2="semicolon" k="78" />
<hkern g1="afii10110" g2="guillemotleft" k="-25" />
<hkern g1="afii10110" g2="guillemotright" k="-25" />
<hkern g1="afii10050" g2="comma" k="51" />
<hkern g1="afii10050" g2="period" k="78" />
<hkern g1="afii10050" g2="colon" k="-51" />
<hkern g1="afii10050" g2="guillemotleft" k="-51" />
<hkern g1="afii10050" g2="guillemotright" k="-51" />
<hkern g1="pi" g2="omicron" k="29" />
</font>

<font horiz-adv-x="823" ><font-face
    font-family="TimesNewRoman-Italic"
    units-per-em="2048"
    panose-1="2 2 5 3 5 4 5 9 3 4"
    ascent="1825"
    descent="-443"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1593" d="M256 0V1280H1280V0H256ZM288 32H1248V1248H288V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="512" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="682" d="M323 330H285Q334 511 354 606T399 856Q449 1174 460 1227Q480 1317 525 1364Q546 1387 583 1387Q611 1387 630 1365T650 1306Q650 1265 631 1202Q590 1064 469 749Q411 600 405 583Q386 527 323
330ZM256 172Q299 172 329 142T359 69Q359 27 329 -3T256 -33Q214 -33 184 -3T154 69Q154 112 184 142T256 172Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="860" d="M661 803L690 1095Q702 1209 706 1229Q720 1293 740 1327Q756 1352 786 1369T852 1387Q887 1387 906 1368T926 1318Q926 1292 912 1252Q874 1147 849 1096L708 803H661ZM294 803L325 1099Q338
1226 351 1270Q370 1332 405 1359T483 1387Q518 1387 538 1367T559 1317Q559 1293 549 1264Q535 1222 476 1098L337 803H294Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1024" d="M115 -28L208 427H37V509H224L293 852H37V932H312L403 1387H486L395 932H732L829 1387H912L817 932H987V852H802L732 509H987V427H715L622 -28H541L632 427H293L198 -28H115ZM308 509H647L719
852H378L308 509Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1024" d="M780 1284L641 804Q797 681 860 574Q904 498 904 403Q904 291 840 186T669 31T399 -18L367 -135H301L336 -18Q256 -2 203 22T86 95L168 378H209Q198 314 198 271Q198 194 240 133T359 46L533 658Q399
763 346 848T293 1031Q293 1181 404 1271T646 1362Q679 1362 735 1356L758 1434H822L796 1347Q865 1327 906 1304T1001 1232L935 991H894Q898 1037 898 1065Q898 1149 859 1214Q836 1252 780 1284ZM720 1302Q675 1309 650 1309Q564 1309 502 1245T440 1083Q440
1027 471 974T589 843L720 1302ZM415 37Q445 34 460 34Q528 34 604 72T722 180T764 328Q764 394 726 459T585 613L415 37Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1706" d="M1673 1387L239 -54H144L1578 1387H1673ZM541 1387Q635 1387 704 1312T773 1115Q773 929 651 795T392 661Q291 661 221 737T151 934Q151 1115 276 1251T541 1387ZM548 1344Q499 1344 458 1305Q386
1239 333 1091T280 818Q280 764 310 732T382 699Q425 699 457 729Q528 795 587 942T647 1222Q647 1278 618 1311T548 1344ZM1432 669Q1529 669 1599 594T1669 393Q1669 279 1612 172T1463 5T1287 -55Q1187 -55 1118 19T1048 209Q1048 394 1172 531T1432 669ZM1444
628Q1393 628 1355 592Q1287 529 1231 378T1174 106Q1174 51 1203 18T1273 -15Q1321 -15 1355 18Q1426 85 1483 234T1540 500Q1540 561 1512 594T1444 628Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1593" d="M1077 711H1482V673Q1394 661 1339 625T1209 481Q1110 337 1045 252Q1164 51 1302 51Q1387 51 1456 124H1501Q1441 42 1374 6T1215 -31Q1119 -31 1049 4T910 124Q799 41 699 5T476 -31Q295
-31 197 63T98 308Q98 487 249 623Q348 711 652 814Q647 852 645 885T642 947Q642 1151 749 1269T1007 1387Q1109 1387 1168 1331T1228 1189Q1228 1082 1142 984T834 814Q906 516 1011 315Q1166 502 1166 614Q1166 638 1147 654T1077 673V711ZM821 878Q973 943
1026 1002Q1099 1084 1099 1181Q1099 1245 1064 1282T973 1319Q901 1319 851 1256T801 1048Q801 1014 806 972T821 878ZM662 751Q469 679 384 575T299 358Q299 232 379 150T589 67Q660 67 716 88T872 180Q808 280 749 441T662 751Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="438" d="M269 803L300 1099Q313 1225 326 1269Q345 1332 379 1359T457 1387Q493 1387 514 1367T535 1316Q535 1293 525 1265Q512 1227 451 1098L313 803H269Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M385 -422L351 -438Q232 -211 180 -37Q140 99 140 237Q140 559 289 814Q472 1126 882 1422L906 1387Q721 1250 604 1080Q458 868 365 568T272 22Q272 -166 385 -422Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M298 1403L332 1422Q451 1196 502 1022Q543 886 543 748Q543 425 394 171Q210 -142 -199 -438L-223 -407Q-38 -269 79 -100Q225 112 318 412T411 959Q411 1147 298 1403Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="1024" d="M494 1044Q490 1113 466 1181Q432 1279 432 1316Q432 1368 456 1395T517 1422Q548 1422 571 1395T594 1318Q594 1273 568 1193T535 1044Q590 1079 634 1129Q702 1208 735 1227T802 1246Q835 1246
857 1224T880 1170Q880 1133 847 1104T682 1046Q605 1029 554 1007Q606 980 681 966Q802 944 839 911T877 839Q877 809 855 787T802 765Q772 765 736 786T637 880Q596 929 535 972Q537 915 558 848Q594 730 594 687Q594 647 570 620T519 592Q482 592 452 621Q431
642 431 688Q431 736 454 803T483 896T494 972Q435 933 391 885Q318 803 281 781Q255 765 227 765Q193 765 169 788T145 839Q145 864 165 891T227 937Q254 949 350 969Q412 982 471 1007Q417 1034 342 1049Q219 1075 190 1096Q145 1129 145 1176Q145 1203 167 1225T220
1248Q253 1248 290 1227T382 1143T494 1044Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1382" d="M534 141V640H37V722H534V1219H616V722H1115V640H616V141H534Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="512" d="M-21 -225Q54 -191 101 -139Q137 -99 137 -62Q137 -44 131 -29Q127 -21 103 3T76 36Q69 53 69 75Q69 118 98 149T168 180Q209 180 240 147T272 64Q272 -25 202 -116T-1 -257L-21 -225Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M613 511L572 378H54L95 511H613Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="512" d="M170 179Q213 179 242 150T272 78Q272 36 242 7T170 -23Q128 -23 99 6T69 78Q69 120 98 149T170 179Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M781 1422L19 -31H-69L698 1422H781Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1024" d="M708 1384Q836 1384 923 1277T1011 939Q1011 741 946 535T763 178Q669 59 566 6Q506 -24 427 -24Q297 -24 210 83T122 422Q122 651 210 882Q313 1152 473 1292Q578 1384 708 1384ZM709 1332Q651 1332
592 1287T469 1097T347 726Q272 429 272 220Q272 116 317 65T426 13Q487 13 530 53Q645 161 727 422Q860 849 860 1116Q860 1227 815 1279T709 1332Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1024" d="M855 1384L533 263Q505 164 505 120Q505 83 530 64T650 37L640 0H125L139 37Q221 39 247 50Q289 68 310 98Q343 144 377 263L609 1068Q630 1141 632 1152Q635 1172 635 1191Q635 1226 616 1246T564
1266Q538 1266 483 1254L470 1290L807 1384H855Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1024" d="M707 0H32V37Q548 489 714 746Q791 865 791 996Q791 1100 727 1165T561 1231Q420 1231 329 1096L294 1112Q345 1241 443 1312T655 1384Q784 1384 872 1296T960 1081Q960 993 929 918Q881 801 752 656Q556
434 229 145H569Q651 145 704 179T780 270H820L707 0Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1024" d="M313 741V770Q555 807 674 914Q760 990 760 1095Q760 1174 710 1225T589 1277Q477 1277 390 1138L353 1149Q405 1265 486 1324T665 1384Q783 1384 856 1314T929 1135Q929 1043 861 958T625 806Q729
763 782 683T835 489Q835 364 763 239T566 45T302 -24Q176 -24 111 20Q68 50 68 90Q68 125 93 150T156 175Q182 175 208 167Q224 162 286 127T384 81T456 69Q546 69 604 173T663 396Q663 492 624 567T499 688T313 741Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1024" d="M997 1356L738 464H900L864 340H700L595 -24H448L554 340H64L106 480L921 1356H997ZM775 1098L192 464H593L775 1098Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1024" d="M528 1356H981L935 1191H528L453 1024Q615 998 705 923Q844 806 844 596Q844 457 793 345T667 156T507 36Q391 -24 273 -24Q172 -24 113 20Q73 50 73 96Q73 132 99 157T163 183Q216 183 281 130Q321
97 347 86Q368 77 397 77Q510 77 605 189T700 482Q700 607 650 695T521 819T313 869L528 1356Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1024" d="M1076 1384V1345Q905 1305 744 1177T462 847Q570 893 638 893Q765 893 854 801T944 553Q944 314 790 145T458 -24Q296 -24 213 95T129 372Q129 577 224 776T481 1119T819 1330Q923 1370 1076 1384ZM414
763Q271 458 271 251Q271 144 325 83T449 21Q564 21 663 188T763 577Q763 695 705 759T565 823Q530 823 499 812T414 763Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1024" d="M397 1356H1072V1322L312 -24L232 13L897 1197H575Q442 1197 394 1174T281 1059H240L397 1356Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1024" d="M691 759Q787 655 831 564T876 382Q876 219 752 98T446 -24Q283 -24 181 75T78 306Q78 419 161 528T477 738Q388 847 357 918T325 1059Q325 1192 424 1288T675 1384Q819 1384 910 1301T1001 1107Q1001
997 928 907T691 759ZM652 801Q760 838 819 922T879 1115Q879 1217 822 1275T671 1334Q582 1334 527 1278T472 1133Q472 1066 501 1009Q543 925 652 801ZM514 697Q365 635 289 518T212 265Q212 156 279 90T457 23Q571 23 649 103T727 294Q727 378 682 470T514 697Z"
/>
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1024" d="M59 -24V8Q162 30 238 72Q373 146 480 255T672 508Q611 478 577 469T501 460Q350 460 270 563T190 803Q190 1042 345 1213T676 1384Q835 1384 920 1265T1005 985Q1005 782 911 584T656 243T318 31Q213
-10 59 -24ZM722 591Q863 877 863 1102Q863 1211 810 1271T685 1331Q567 1331 470 1166T372 774Q372 654 427 593T567 531Q605 531 637 542T722 591Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="682" d="M435 906Q477 906 507 877T537 805Q537 763 507 733T435 703Q393 703 363 733T333 805Q333 847 363 876T435 906ZM223 182Q265 182 294 153T323 81Q323 40 294 11T223 -19Q181 -19 152 10T122 81Q122
123 151 152T223 182Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="682" d="M438 904Q480 904 510 875T540 802Q540 760 510 730T438 700Q396 700 366 730T336 802Q336 845 365 874T438 904ZM36 -222Q141 -162 166 -129T191 -63Q191 -43 184 -28Q181 -19 159 6T132 43Q124
60 124 80Q124 122 154 153T223 184Q265 184 296 151T327 65Q327 -2 290 -66T186 -183Q162 -201 53 -257L36 -222Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1382" d="M39 706L1115 1172V1085L189 683L1115 277V187L39 657V706Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1382" d="M37 883H1116V801H37V883ZM37 557H1116V475H37V557Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1382" d="M1113 653L37 187V273L964 675L37 1081V1172L1113 702V653Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="1024" d="M360 333H322Q336 460 383 552T567 789T748 1024Q779 1087 779 1154Q779 1233 723 1287T579 1342Q494 1342 441 1306Q411 1286 411 1257Q411 1237 427 1202T444 1144Q444 1110 420 1087T361 1064Q326
1064 302 1089T277 1155Q277 1243 362 1315T596 1387Q750 1387 844 1301T939 1103Q939 1014 895 948Q837 862 675 751T452 554T360 333ZM300 172Q342 172 372 143T402 70Q402 28 372 -1T300 -31Q258 -31 228 -2T198 70Q198 113 227 142T300 172Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1884" d="M1408 958L1291 559Q1226 335 1212 275T1198 179Q1198 147 1219 125T1273 103Q1346 103 1448 176T1624 413T1697 755Q1697 926 1615 1071T1382 1293T1049 1371Q818 1371 620 1249T307 896T191 418Q191
188 292 0T578 -284T974 -381Q1237 -381 1449 -240T1778 172H1836Q1746 -102 1509 -272T969 -442Q731 -442 527 -330T210 -11T97 444Q97 708 221 936T568 1293T1043 1422Q1250 1422 1416 1337T1670 1087T1757 737Q1757 554 1676 375T1468 113T1205 31Q1129 31 1091
67T1052 168Q1052 224 1070 315Q922 136 833 83T676 30Q605 30 550 93T495 263Q495 408 589 588T840 881Q955 964 1046 964Q1113 964 1157 930T1218 826L1251 936L1408 958ZM1057 917Q982 917 905 838Q792 722 712 525Q653 381 653 293Q653 230 688 191T768 151Q826
151 890 195T1024 330T1126 514Q1182 673 1182 773Q1182 839 1146 878T1057 917Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1251" d="M1055 1387L952 259Q944 180 944 155Q944 115 959 94Q978 65 1010 51T1120 37L1109 0H575L586 37H609Q674 37 715 65Q744 84 760 128Q771 159 781 274L797 446H409L271 259Q224 196 212 169T200 117Q200
85 226 62T312 37L301 0H-100L-89 37Q-15 40 41 86T210 285L1020 1387H1055ZM857 1054L464 519H805L857 1054Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1251" d="M303 1319L317 1356H801Q923 1356 1018 1318T1161 1212T1209 1068Q1209 951 1125 857T849 717Q972 671 1030 595T1088 428Q1088 327 1036 235T903 92T706 17Q624 0 450 0H-47L-34 37Q44 39 72 52Q112
69 129 97Q153 135 193 271L436 1092Q467 1196 467 1238Q467 1275 440 1296T335 1318Q318 1318 303 1319ZM506 756Q571 754 600 754Q808 754 909 844T1011 1071Q1011 1174 949 1231T751 1289Q715 1289 659 1277L506 756ZM309 88Q417 74 478 74Q634 74 754 168T875
423Q875 546 801 615T560 684Q528 684 482 681L309 88Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1366" d="M1441 1387L1340 948H1304L1300 1058Q1295 1118 1277 1165T1223 1246T1132 1300T1010 1320Q831 1320 697 1222Q526 1097 429 869Q349 681 349 488Q349 291 464 174T763 56Q902 56 1010 118T1212 309H1259Q1149
134 1015 52T694 -31Q528 -31 400 38T205 234T138 505Q138 727 257 937T583 1267T1002 1387Q1101 1387 1224 1340Q1278 1320 1302 1320Q1326 1320 1344 1330T1404 1387H1441Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M300 1319L312 1356H745Q1020 1356 1152 1293T1364 1095T1443 804Q1443 671 1398 546T1295 345T1118 178T860 44T513 0H-61L-48 37Q31 39 58 51Q98 68 117 97Q146 139 182 266L422 1086Q450 1183 450
1238Q450 1277 424 1298T322 1319H300ZM655 1281L361 266Q328 152 328 125Q328 109 338 94T367 74Q393 65 451 65Q608 65 742 97T963 194Q1085 287 1158 450T1231 821Q1231 1056 1119 1170T792 1285Q739 1285 655 1281Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1251" d="M663 1283L508 747H635Q771 747 832 788T937 942H974L835 450H795Q813 512 813 556Q813 599 796 625T748 663T619 676H490L359 227Q340 162 340 128Q340 102 365 82Q382 68 450 68H570Q765 68 882 137T1093
377H1130L1002 0H-46L-33 37Q45 39 72 51Q112 69 130 97Q157 138 194 269L432 1087Q460 1186 460 1238Q460 1276 434 1297T330 1319H309L321 1356H1295L1211 1029H1174Q1181 1075 1181 1106Q1181 1159 1155 1195Q1121 1241 1056 1265Q1008 1283 835 1283H663Z"
/>
<glyph unicode="F" glyph-name="F" horiz-adv-x="1251" d="M666 1284L506 747H684Q804 747 863 784T986 942H1024L883 448H843Q858 508 858 547Q858 608 818 641T666 675H486L368 266Q336 157 336 121Q336 84 363 64T498 37L486 0H-50L-37 37Q41 39 67 51Q107
68 126 97Q153 138 190 266L429 1083Q458 1182 458 1238Q458 1264 445 1282T407 1310T305 1319L317 1356H1369L1269 1013H1231Q1242 1075 1242 1115Q1242 1181 1206 1219T1112 1274Q1072 1284 933 1284H666Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1479" d="M1474 1387L1373 960H1335Q1344 1035 1344 1071Q1344 1169 1258 1244T1019 1320Q708 1320 511 1028Q354 797 354 511Q354 321 451 183T750 45Q800 45 844 54T979 94L1078 443Q1099 515 1099 558Q1099
594 1073 613Q1031 642 937 642H909L920 681H1484L1474 642Q1397 641 1362 624T1302 566Q1285 539 1247 409L1147 66Q1010 7 926 -12T749 -32Q535 -32 402 48T206 261T142 525Q142 701 216 859T400 1127T641 1300Q820 1387 1017 1387Q1162 1387 1279 1339Q1326
1320 1348 1320Q1373 1320 1390 1331T1436 1387H1474Z" />
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M505 751H1131L1230 1086Q1258 1184 1258 1238Q1258 1264 1246 1282T1207 1310T1105 1319L1115 1356H1661L1649 1319Q1580 1320 1546 1305Q1498 1284 1475 1251Q1442 1204 1408 1086L1169 267Q1139 165
1139 121Q1139 83 1165 64T1292 37L1281 0H753L767 37Q845 39 871 51Q911 69 929 97Q955 136 993 267L1115 682H486L363 267Q334 167 334 121Q334 83 360 64T486 37L478 0H-54L-41 37Q38 39 64 51Q104 69 123 97Q149 138 187 267L427 1086Q456 1186 456 1238Q456
1264 444 1282T405 1310T301 1319L313 1356H848L837 1319Q770 1320 738 1305Q691 1285 669 1252Q639 1208 603 1086L505 751Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="682" d="M505 37L494 0H-64L-50 37Q34 39 61 51Q105 68 126 98Q159 145 194 266L430 1084Q460 1186 460 1238Q460 1264 447 1282T408 1309T304 1319L316 1356H840L829 1319Q765 1320 734 1305Q689 1285 666 1248T605
1084L370 266Q338 153 338 122Q338 97 350 80T390 53T505 37Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="909" d="M586 1356H1120L1109 1319Q1006 1318 964 1282T876 1086L704 489Q655 320 605 231Q538 111 425 40T170 -31Q54 -31 -8 22T-70 152Q-70 212 -33 252T57 292Q102 292 130 265T159 199Q159 167 133 137Q100
99 100 85Q100 64 119 47T170 30Q216 30 265 52T358 119T434 227T501 399L550 572L699 1086Q732 1199 732 1227Q732 1265 702 1289T575 1319L586 1356Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1366" d="M654 771L990 252Q1080 114 1139 76T1294 37L1283 0H705L714 37Q783 44 811 70T840 129Q840 159 830 187Q822 207 772 285L497 716L364 267Q331 159 331 122Q331 84 359 64T497 37L481 0H-55L-42 37Q36
39 63 51Q103 69 122 97Q148 138 186 267L425 1086Q452 1180 452 1237Q452 1277 427 1298T327 1319H307L319 1356H828L818 1319Q755 1320 724 1305Q681 1284 661 1251T602 1086L497 738L979 1101Q1075 1173 1105 1215Q1123 1241 1123 1262Q1123 1280 1105 1297T1048
1319L1058 1356H1492L1483 1319Q1412 1307 1364 1288T1264 1234Q1249 1224 1069 1086L654 771Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1139" d="M939 0H-66L-52 37Q28 39 55 50Q97 68 117 97Q148 143 183 263L422 1088Q452 1190 452 1238Q452 1276 425 1297T321 1318Q304 1318 294 1319L306 1356H859L851 1319Q758 1319 719 1301T654 1242Q636 1215
595 1074L360 263Q333 171 333 135Q333 111 360 89Q377 74 437 74H568Q711 74 795 110Q857 137 909 191Q937 221 1008 340L1034 385H1071L939 0Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1706" d="M649 1356L774 264L1561 1356H1892V1319Q1784 1312 1765 1305Q1732 1292 1705 1253T1645 1103L1394 243Q1372 168 1372 125Q1372 86 1399 66Q1437 37 1519 37H1543L1534 0H963L973 37H1000Q1076 37 1116
59Q1147 75 1171 119T1240 317L1464 1103L673 0H633L506 1103L264 264Q233 157 233 120Q233 83 260 64T391 37L380 0H-67L-56 37H-29Q70 37 114 87Q146 123 181 243L476 1254Q443 1288 413 1300T302 1319L312 1356H649Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1366" d="M587 1356L1006 293L1233 1087Q1261 1185 1261 1239Q1261 1276 1235 1297T1138 1318Q1126 1318 1113 1319L1124 1356H1560L1548 1319Q1480 1320 1447 1305Q1400 1284 1377 1251Q1345 1204 1312 1087L993
-31H957L506 1113L265 268Q238 172 238 121Q238 83 262 64T379 37L369 0H-57L-43 37Q37 39 64 51Q105 69 125 98Q154 142 190 268L459 1211Q420 1271 376 1293T237 1319L248 1356H587Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1479" d="M1009 1387Q1144 1387 1248 1329T1411 1156T1470 918Q1470 700 1344 461T1013 95T591 -31Q434 -31 329 38T173 222T122 443Q122 633 213 818T432 1128T703 1320T1009 1387ZM975 1323Q875 1323 780 1274T590
1112T421 817Q329 593 329 394Q329 252 402 143T626 33Q717 33 804 78T987 232Q1106 369 1187 581T1268 978Q1268 1114 1195 1218T975 1323Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1251" d="M320 1356H854Q1064 1356 1168 1266T1272 1045Q1272 942 1206 845T1010 688T729 627Q635 627 490 661L382 291Q344 159 344 117Q344 85 371 64T500 37L490 0H-49L-38 37Q68 37 109 73T199 275L423 1047Q463
1186 463 1233Q463 1268 435 1291T309 1319L320 1356ZM507 724Q620 695 689 695Q798 695 887 740T1027 875T1078 1062Q1078 1163 1016 1222T828 1281Q760 1281 663 1264L507 724Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1479" d="M599 -31L341 -240Q402 -229 454 -229Q504 -229 546 -235T728 -272T972 -304Q1083 -304 1160 -266T1311 -137L1344 -153Q1241 -301 1101 -366T804 -432Q717 -432 566 -398Q335 -347 243 -347Q208 -347
186 -352T120 -376L97 -349L507 -25Q317 1 219 142T121 443Q121 662 253 896T592 1258T998 1387Q1146 1387 1250 1327T1412 1153T1469 918Q1469 688 1338 452T1013 95T599 -31ZM974 1323Q874 1323 779 1274T589 1112T420 817Q329 593 329 394Q329 252 402 143T626
33Q716 33 804 78T986 231Q1106 369 1187 582T1268 978Q1268 1113 1195 1218T974 1323Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1251" d="M851 0L634 659Q558 658 478 674L361 264Q338 184 338 129Q338 87 367 63Q389 45 487 37L478 0H-47L-36 37Q38 40 64 52Q105 69 124 98Q156 145 191 264L428 1083Q452 1165 452 1210Q452 1256 415 1288T307
1319L319 1356H761Q983 1356 1081 1272T1179 1051Q1179 920 1079 812T803 674L935 277Q983 131 1031 87T1186 37L1175 0H851ZM495 731Q559 722 609 722Q781 722 881 817T981 1055Q981 1166 919 1225T731 1284Q699 1284 655 1276L495 731Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1024" d="M14 -31L126 472H160Q153 399 153 351Q153 214 240 128T469 42Q600 42 668 122T736 308Q736 376 705 432Q658 515 454 724Q355 824 327 873Q281 954 281 1043Q281 1185 387 1286T659 1387Q715 1387 765
1376Q796 1370 878 1336Q936 1313 942 1311Q956 1308 973 1308Q1002 1308 1023 1323T1072 1387H1110L1006 937H972Q976 997 976 1034Q976 1155 896 1232T685 1309Q581 1309 516 1248T451 1107Q451 1037 492 974T683 767T877 543T921 371Q921 268 867 172T710 22T487
-31Q427 -31 375 -20T209 34Q170 49 144 49Q85 49 52 -31H14Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1139" d="M300 1356H1330L1219 996H1181Q1200 1075 1200 1137Q1200 1210 1155 1247Q1121 1275 980 1275H873L605 341Q554 165 554 124Q554 86 586 62T699 37H745L733 0H143L154 37H180Q258 37 300 62Q329 79 352
123T418 312L699 1275H618Q501 1275 430 1245T314 1158T242 996H205L300 1356Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M268 1356H841L830 1319Q742 1317 705 1303T641 1251T585 1114L446 634Q409 506 402 466Q390 402 390 347Q390 226 480 143T721 59Q820 59 898 96T1031 201T1133 384T1214 618L1334 1032Q1379 1187 1379
1234Q1379 1267 1349 1290T1225 1319L1236 1356H1667L1656 1319Q1580 1319 1547 1305T1488 1253T1432 1107L1285 604Q1214 359 1151 243T969 48T672 -31Q468 -31 343 84T218 349Q218 408 229 475Q237 519 268 627L402 1088Q430 1188 430 1235Q430 1272 402 1292T258
1319L268 1356Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1251" d="M311 -31L423 1098Q431 1184 431 1214Q431 1259 398 1289T292 1319H256L266 1356H801L790 1319Q703 1318 671 1301T619 1243Q609 1221 598 1118L518 309L1047 1031Q1133 1148 1155 1194Q1170 1225 1170
1248Q1170 1275 1147 1295T1061 1319L1073 1356H1481L1471 1319Q1422 1315 1393 1300Q1338 1274 1284 1221T1111 1007L347 -31H311Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1706" d="M277 -31L394 1099Q401 1164 401 1199Q401 1257 368 1287T249 1319L260 1356H768L757 1319Q655 1320 618 1283T566 1099L491 367L1006 1162Q1007 1182 1007 1196Q1007 1252 974 1282T832 1319L840 1356H1389L1378
1319Q1283 1318 1250 1303Q1226 1292 1210 1268T1183 1184Q1180 1167 1159 952T1094 367L1523 1019Q1593 1126 1611 1169T1629 1242Q1629 1270 1605 1291T1523 1319L1531 1356H1933L1923 1319Q1870 1315 1829 1293T1732 1209Q1700 1173 1600 1019L919 -31H882L992
1019L311 -31H277Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1251" d="M1058 1356H1517L1506 1319Q1409 1305 1337 1261T1139 1083L787 723L886 360Q900 308 938 199Q962 129 986 100T1046 56T1157 37L1146 0H614L625 37Q707 40 743 68Q770 88 770 120Q770 148 744 243L649
584L331 263Q238 168 220 138Q209 120 209 103Q209 73 239 54Q253 46 324 37L314 0H-137L-126 37Q-41 45 13 76Q92 123 231 263L625 659L517 1050Q468 1230 432 1271T304 1319L314 1356H799L787 1319Q720 1319 697 1311T661 1285T648 1245Q648 1221 672 1133L764
799L977 1011Q1103 1137 1150 1214Q1167 1241 1167 1262Q1167 1285 1148 1298Q1121 1316 1047 1319L1058 1356Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1139" d="M716 721L974 1082Q1074 1223 1074 1262Q1074 1284 1053 1298T930 1319L940 1356H1366L1358 1319Q1296 1311 1273 1302Q1237 1287 1202 1255Q1155 1213 1066 1090L734 632L634 297Q597 171 597 123Q597
92 608 76T649 50Q687 38 765 37L755 0H184L196 37Q281 39 309 51Q354 69 376 99Q410 145 446 264L565 660L420 1128Q381 1252 349 1282T235 1319L245 1356H746L734 1319Q640 1312 627 1307Q605 1300 591 1279T577 1230Q577 1189 606 1090L716 721Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1139" d="M310 1356H1251V1319L244 65H401Q655 65 759 90T933 177T1050 353H1088L971 0H-4V29L1003 1283H722Q538 1283 463 1267T335 1200T244 1047H209L310 1356Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="797" d="M13 -408L539 1387H965L943 1318H664L180 -336H458L438 -408H13Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M289 1422L474 -31H400L218 1422H289Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="797" d="M747 1387L221 -408H-205L-184 -339H96L579 1315H302L322 1387H747Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="864" d="M517 1387L942 671H850L500 1257L150 671H56L487 1387H517Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1024" d="M1042 -442H-17V-358H1042V-442Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M581 1402L690 1058H658L360 1402H581Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="1024" d="M961 905L766 227L744 136Q741 123 741 114Q741 98 751 86Q759 77 771 77Q784 77 805 93Q844 122 909 213L943 189Q874 85 801 31T666 -24Q623 -24 602 -3T580 60Q580 109 602 189L623 264Q492 93 382
25Q303 -24 227 -24Q154 -24 101 36T48 203Q48 362 143 538T386 821Q501 905 603 905Q664 905 704 873T766 767L802 881L961 905ZM605 853Q541 853 469 793Q367 708 288 541T208 239Q208 171 242 132T320 92Q429 92 557 253Q728 467 728 692Q728 777 695 815T605
853Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1024" d="M591 1422L394 731Q490 831 561 868T711 905Q821 905 891 832T961 634Q961 473 869 314T638 65T364 -24Q213 -24 54 89L358 1136Q393 1257 393 1278Q393 1304 377 1317Q354 1335 309 1335Q288 1335 245
1328V1366L591 1422ZM204 78Q304 23 380 23Q468 23 562 87T726 305T796 614Q796 706 751 758T643 810Q550 810 461 736T334 528L204 78Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="909" d="M795 218Q691 93 585 35T361 -24Q219 -24 140 56T60 271Q60 424 145 572T375 812T659 905Q768 905 822 860T876 748Q876 686 838 642Q810 608 769 608Q738 608 718 628T697 678Q697 697 704 713T735 751T764
784T769 805Q769 826 750 840Q721 860 668 860Q570 860 474 791T310 595Q228 441 228 287Q228 185 286 126T444 66Q521 66 596 104T766 244L795 218Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1024" d="M1108 1422L764 242Q736 146 736 116Q736 106 744 97T762 88Q775 88 793 101Q827 125 907 221L941 200Q869 100 796 38T658 -24Q624 -24 602 0T580 68Q580 125 610 221L649 345Q504 121 385 35Q303 -24
228 -24Q152 -24 96 43T39 227Q39 376 134 545T385 820Q508 905 611 905Q665 905 704 883T781 810L879 1158Q890 1195 897 1217Q909 1257 909 1283Q909 1304 894 1318Q873 1335 840 1335Q817 1335 764 1328V1365L1108 1422ZM737 712Q737 776 700 815T606 854Q480
854 344 646T207 248Q207 173 240 134T319 94Q423 94 580 319T737 712Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="909" d="M244 377Q237 327 237 294Q237 205 300 143T453 80Q525 80 591 109T789 240L810 211Q573 -24 358 -24Q212 -24 138 68T64 271Q64 420 156 576T387 818T673 905Q779 905 830 862T881 760Q881 677 815 601Q728
502 559 441Q447 400 244 377ZM251 426Q399 443 492 484Q615 539 676 615T738 761Q738 803 712 829T636 855Q534 855 420 747T251 426Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="569" d="M611 881L593 815H447L337 378Q264 89 190 -69Q85 -292 -36 -377Q-128 -442 -220 -442Q-280 -442 -322 -406Q-353 -381 -353 -341Q-353 -309 -328 -286T-265 -262Q-238 -262 -220 -279T-201 -318Q-201
-340 -222 -359Q-238 -373 -238 -380Q-238 -389 -231 -394Q-222 -401 -203 -401Q-160 -401 -113 -374T-28 -294T42 -139Q56 -97 117 138L291 815H117L131 881Q214 881 247 892T307 936T379 1058Q438 1178 492 1244Q566 1333 647 1377T801 1422Q877 1422 923 1384T969
1300Q969 1265 946 1241T887 1217Q856 1217 837 1235T817 1278Q817 1294 830 1317T843 1349Q843 1363 834 1370Q821 1380 796 1380Q733 1380 683 1340Q616 1287 563 1174Q536 1115 464 881H611Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1024" d="M1067 843L1038 739H871Q890 685 890 638Q890 506 778 403Q665 300 468 289Q362 257 309 213Q289 197 289 180Q289 160 307 144T398 110L592 65Q753 27 805 -25Q856 -78 856 -147Q856 -229 796 -297T619
-403T361 -442Q237 -442 135 -413T-11 -333T-55 -230Q-55 -187 -27 -141T45 -64Q72 -45 198 26Q152 62 152 105Q152 145 192 190T364 289Q254 310 190 381T125 539Q125 681 249 793T581 905Q656 905 704 890T797 843H1067ZM720 686Q720 766 676 812T559 858Q446
858 373 745T299 508Q299 431 346 382T460 333Q513 333 562 362T646 442T700 572T720 686ZM241 0Q160 -37 119 -95T77 -209Q77 -275 137 -318Q223 -380 389 -380Q532 -380 633 -332T735 -206Q735 -167 698 -132T552 -75Q493 -63 241 0Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1024" d="M601 1422L320 451Q502 725 604 815T799 905Q847 905 879 872T911 784Q911 718 883 624L761 205Q738 129 738 121Q738 107 746 98T766 89Q779 89 796 102Q853 146 909 224L940 205Q906 152 846 89T742
1T664 -24Q627 -24 604 -1T580 60Q580 104 615 224L730 624Q752 699 752 742Q752 762 740 774T707 786Q678 786 641 764Q573 722 484 608Q460 577 324 358Q282 288 255 205L191 0H41L370 1144L405 1268Q405 1294 384 1314T331 1334Q313 1334 276 1328L255 1325V1364L601
1422Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M458 1302Q500 1302 529 1273T558 1202Q558 1161 529 1132T458 1102Q417 1102 388 1131T358 1202Q358 1244 387 1273T458 1302ZM471 905L273 204Q253 133 253 119Q253 103 262 93T285 83Q300 83 321 99Q378
144 436 227L471 204Q403 100 311 29Q243 -24 181 -24Q140 -24 114 0T88 62Q88 99 113 185L243 633Q275 743 275 771Q275 793 260 807T217 821Q195 821 126 810V849L471 905Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="569" d="M473 1301Q515 1301 544 1272T574 1200Q574 1158 545 1129T473 1099Q431 1099 402 1128T372 1200Q372 1242 401 1271T473 1301ZM489 905L230 10Q161 -230 41 -336T-220 -442Q-283 -442 -315 -413T-348
-344Q-348 -313 -324 -290T-267 -266Q-238 -266 -216 -285Q-198 -300 -198 -319Q-198 -345 -223 -364Q-237 -375 -237 -382L-235 -387Q-232 -391 -226 -393T-208 -395Q-127 -395 -70 -344T33 -138L257 630Q290 743 290 755Q290 779 269 798T214 817Q201 817 184
814Q171 812 146 808V843L489 905Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="909" d="M590 1422L306 439L420 536Q607 694 663 770Q681 795 681 808Q681 817 675 825T652 838T590 843H555L566 881H1003L993 843Q918 839 864 820T758 762Q657 687 625 658L539 582Q561 510 593 381Q647 167
666 127Q685 87 705 87Q722 87 745 104Q797 142 856 225L891 200Q782 63 724 20T618 -24Q576 -24 553 9Q513 68 420 474L283 355L180 0H24L356 1141L384 1238Q389 1263 389 1282Q389 1306 371 1322T317 1338Q294 1338 244 1328V1363L590 1422Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M609 1422L267 232Q242 143 242 123Q242 108 251 98T275 88Q294 88 316 105Q368 146 425 232L455 201Q360 67 280 14Q221 -24 168 -24Q130 -24 105 2T79 62Q79 98 111 210L382 1148Q415 1263 415 1280Q415
1304 396 1319T337 1335Q314 1335 267 1328V1365L609 1422Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1479" d="M444 905L314 454Q401 613 462 693Q557 817 647 873Q700 905 758 905Q808 905 841 873T874 791Q874 742 851 663L780 409Q943 714 1089 837Q1170 905 1249 905Q1295 905 1324 874T1354 776Q1354 718 1336
653L1226 264Q1190 137 1190 123Q1190 109 1199 99Q1205 92 1215 92Q1225 92 1250 111Q1307 155 1357 227L1390 206Q1365 166 1302 96T1193 1T1110 -24Q1075 -24 1052 0T1028 59Q1028 107 1069 252L1160 573Q1191 684 1193 696Q1196 715 1196 733Q1196 758 1185
772Q1173 786 1158 786Q1116 786 1069 743Q931 616 811 387Q732 236 663 0H512L683 605Q711 703 711 736Q711 763 700 776T673 789Q640 789 603 765Q543 726 449 598T302 353Q277 298 183 0H35L220 648L244 732Q251 751 251 760Q251 782 231 799T180 817Q167 817
108 805L99 842L444 905Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1024" d="M452 905L319 450Q506 729 605 817T797 905Q847 905 879 872T912 786Q912 726 883 626L761 205Q740 132 740 116Q740 102 748 93T765 83Q777 83 794 96Q847 138 910 224L941 205Q848 72 765 15Q707 -24
661 -24Q624 -24 602 -2T580 59Q580 107 614 224L730 626Q752 701 752 743Q752 763 739 775T707 788Q679 788 640 764Q566 719 486 616T317 351Q270 266 239 165L189 0H39L221 626Q253 739 253 762Q253 784 236 800T192 817Q180 817 150 813L112 807L106 843L452
905Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1024" d="M947 592Q947 442 868 295T646 62T370 -24Q233 -24 147 63T60 290Q60 437 144 585T370 819T644 905Q776 905 861 818T947 592ZM781 661Q781 754 736 803T618 853Q471 853 348 643T224 224Q224 129 272
78T393 26Q534 26 657 235T781 661Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1024" d="M453 905L384 675Q493 803 578 854T753 905Q842 905 905 835T968 651Q968 431 789 204T372 -24Q322 -24 284 -13T197 26L124 -232Q102 -308 102 -331Q102 -353 113 -368T151 -392T254 -401L245 -438H-226L-216
-401Q-123 -397 -91 -369T-22 -214L231 662Q254 745 254 765Q254 792 239 807T191 822Q162 822 110 815V854L453 905ZM220 105Q282 31 387 31Q439 31 493 60T598 146T691 277T764 453T797 653Q797 733 761 775T675 818Q567 818 462 694T307 404L220 105Z" />
<glyph unicode="q" glyph-name="q" horiz-adv-x="1024" d="M971 905L644 -225Q622 -303 622 -325Q622 -348 633 -364T665 -389Q696 -401 746 -401L736 -438H257L267 -401Q365 -393 389 -384Q427 -369 451 -335T506 -192L644 301Q512 108 398 30Q317 -25 247 -25Q147
-25 96 56T45 233Q45 384 138 550T383 822Q501 905 597 905Q668 905 714 871T783 760L814 872L971 905ZM743 710Q743 774 704 815T608 856Q486 856 351 646T216 250Q216 175 249 136T331 97Q392 97 469 165Q586 268 664 429T743 710Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="797" d="M103 849L448 905L304 419Q479 718 622 837Q703 905 754 905Q787 905 806 886T825 829Q825 763 791 703Q767 658 722 658Q699 658 683 673T662 719Q660 738 653 744Q645 752 634 752Q617 752 602 744Q576
730 523 666Q440 568 343 412Q301 346 271 263Q229 149 223 126L191 0H38L223 621Q255 729 255 775Q255 793 240 805Q220 821 187 821Q166 821 110 812L103 849Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="797" d="M743 905L682 598H645Q640 732 588 793T459 854Q397 854 361 820T324 738Q324 705 338 675T402 591Q532 449 570 377T608 241Q608 137 522 57T303 -24Q231 -24 137 10Q104 22 86 22Q41 22 18 -24H-19L42
300H79Q85 148 142 85T298 22Q374 22 418 64T463 169Q463 209 447 243Q419 303 330 409T215 568T189 674Q189 771 259 838T441 905Q473 905 499 900Q513 897 564 878T633 858Q676 858 705 905H743Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="569" d="M535 1153L457 881H614L597 818H441L269 228Q241 133 241 105Q241 88 249 79T268 70Q293 70 334 105Q358 125 441 228L474 203Q382 69 300 14Q244 -24 187 -24Q143 -24 115 3T87 74Q87 128 119 239L286
818H135L145 857Q255 887 328 946T491 1153H535Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1024" d="M964 881L790 285Q751 152 751 117Q751 99 757 91T775 82Q792 82 812 97T916 221L946 198Q867 73 784 14Q729 -24 678 -24Q639 -24 617 -2T595 55Q595 89 608 145Q624 219 699 467Q529 188 415 82T202
-24Q156 -24 124 8T92 89Q92 164 136 319L223 628Q255 739 255 766Q255 778 247 786T228 795Q207 795 186 780T91 669L60 691Q135 807 219 862Q283 905 337 905Q374 905 397 882T421 821Q421 767 381 628L287 305Q248 173 248 138Q248 119 260 108T294 96Q327 96
380 129T521 275T667 488T790 805L812 881H964Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="909" d="M44 843L333 905Q364 831 383 754Q410 641 427 486Q435 408 449 156Q574 294 598 327Q730 506 750 537Q783 590 796 630Q807 660 807 687Q807 713 761 747T714 823Q714 855 739 880T800 905Q842 905 874
871T906 785Q906 734 890 687Q864 611 793 502T564 208Q544 185 342 -24H305Q281 609 205 766Q180 817 122 817Q97 817 51 808L44 843Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1366" d="M858 905L927 155Q1101 359 1205 538Q1266 643 1266 690Q1266 712 1256 729Q1252 738 1225 755T1186 791T1175 831Q1175 862 1198 883T1257 905Q1298 905 1326 875T1355 793Q1355 741 1340 696Q1310 610
1223 474Q1117 311 1005 172T837 -24H800L735 668L322 -24H278Q271 403 235 650Q220 753 185 785Q160 808 109 808Q80 808 35 802V838L322 905Q382 738 400 392Q406 261 410 227L821 905H858Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="909" d="M359 905Q408 853 433 801Q451 765 492 612L580 744Q615 792 665 835T753 895Q777 905 806 905Q849 905 874 882T900 826Q900 788 885 774Q857 749 821 749Q800 749 776 758Q729 774 713 774Q689 774 656
746Q594 694 508 545L590 201Q609 122 622 107T648 91Q669 91 697 114Q752 160 791 234L826 216Q763 98 666 20Q611 -24 573 -24Q517 -24 484 39Q463 78 397 375Q241 104 147 26Q86 -24 29 -24Q-11 -24 -44 5Q-68 27 -68 64Q-68 97 -46 119T8 141Q40 141 76 109Q102
86 116 86Q128 86 147 102Q194 140 275 266T381 448Q319 691 314 705Q291 770 254 797T145 824Q122 824 92 822V858L359 905Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="909" d="M331 905Q365 847 378 797T404 598L448 106Q508 178 622 334Q677 410 758 541Q807 621 818 653Q824 669 824 686Q824 697 817 704T781 720T732 755T712 814Q712 855 736 880T796 905Q840 905 871 869T902
768Q902 689 848 588T640 276T267 -182Q116 -353 43 -397T-82 -442Q-113 -442 -136 -419T-160 -364Q-160 -325 -128 -293T-57 -261Q-37 -261 -24 -270Q-16 -275 -7 -298T11 -330Q16 -335 23 -335Q29 -335 44 -325Q99 -291 172 -217Q268 -119 314 -57L258 577Q244
734 216 768T122 802Q101 802 47 796L38 833L331 905Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="797" d="M168 881H803V856L111 136H404Q508 136 536 144T587 178T640 272H677L590 0H-61V29L631 749H343Q252 749 233 744Q205 738 178 713T121 628H83L168 881Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="819" d="M531 -407L520 -442Q389 -423 316 -342T242 -149Q242 -47 319 99T397 302Q397 366 354 412T224 470L236 511Q339 524 413 578T517 701Q537 748 545 886T608 1129T786 1318T1055 1422L1045 1387Q932
1361 862 1307T760 1178Q738 1126 731 997T688 786T557 623T313 493Q415 450 467 378T519 220Q519 133 441 -13T363 -227Q363 -292 401 -337T531 -407Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="563" d="M244 1422V-442H161V1422H244Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="819" d="M454 1387L464 1422Q595 1404 669 1323T743 1130Q743 1027 665 882T587 679Q587 615 631 569T761 511L749 470Q647 457 573 403T468 280Q448 234 440 95T377 -149T198 -338T-70 -442L-60 -407Q53
-380 123 -327T225 -198Q247 -145 254 -16T293 184Q332 275 428 357T672 488Q570 530 518 602T466 761Q466 848 544 994T622 1207Q622 1273 584 1318T454 1387Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1108" d="M1066 675H1111Q1107 545 1037 472T866 398Q820 398 767 413T493 519Q339 583 274 583Q204 583 156 540T88 400H44Q50 535 118 606T278 678Q322 678 368 664Q472 634 641 562T880 489Q955 489
1006 537T1066 675Z" />
<hkern g1="space" g2="A" k="37" />
<hkern g1="space" g2="Alphatonos" k="37" />
<hkern g1="space" g2="Alpha" k="37" />
<hkern g1="space" g2="Delta" k="37" />
<hkern g1="space" g2="Lambda" k="37" />
<hkern g1="one" g2="one" k="152" />
<hkern g1="A" g2="space" k="37" />
<hkern g1="A" g2="T" k="76" />
<hkern g1="A" g2="V" k="102" />
<hkern g1="A" g2="W" k="76" />
<hkern g1="A" g2="Y" k="113" />
<hkern g1="A" g2="v" k="113" />
<hkern g1="A" g2="w" k="113" />
<hkern g1="A" g2="y" k="113" />
<hkern g1="A" g2="quoteright" k="76" />
<hkern g1="F" g2="comma" k="264" />
<hkern g1="F" g2="period" k="264" />
<hkern g1="F" g2="A" k="264" />
<hkern g1="L" g2="space" k="37" />
<hkern g1="L" g2="T" k="41" />
<hkern g1="L" g2="V" k="76" />
<hkern g1="L" g2="W" k="76" />
<hkern g1="L" g2="Y" k="41" />
<hkern g1="L" g2="y" k="61" />
<hkern g1="L" g2="quoteright" k="76" />
<hkern g1="P" g2="space" k="37" />
<hkern g1="P" g2="comma" k="264" />
<hkern g1="P" g2="period" k="264" />
<hkern g1="P" g2="A" k="264" />
<hkern g1="R" g2="T" k="0" />
<hkern g1="R" g2="V" k="37" />
<hkern g1="R" g2="W" k="37" />
<hkern g1="R" g2="Y" k="37" />
<hkern g1="R" g2="y" k="37" />
<hkern g1="T" g2="space" k="37" />
<hkern g1="T" g2="comma" k="152" />
<hkern g1="T" g2="hyphen" k="152" />
<hkern g1="T" g2="period" k="152" />
<hkern g1="T" g2="colon" k="113" />
<hkern g1="T" g2="semicolon" k="133" />
<hkern g1="T" g2="A" k="152" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="188" />
<hkern g1="T" g2="c" k="188" />
<hkern g1="T" g2="e" k="188" />
<hkern g1="T" g2="i" k="113" />
<hkern g1="T" g2="o" k="188" />
<hkern g1="T" g2="r" k="113" />
<hkern g1="T" g2="s" k="188" />
<hkern g1="T" g2="u" k="113" />
<hkern g1="T" g2="w" k="152" />
<hkern g1="T" g2="y" k="152" />
<hkern g1="V" g2="space" k="37" />
<hkern g1="V" g2="comma" k="264" />
<hkern g1="V" g2="hyphen" k="113" />
<hkern g1="V" g2="period" k="264" />
<hkern g1="V" g2="colon" k="133" />
<hkern g1="V" g2="semicolon" k="152" />
<hkern g1="V" g2="A" k="152" />
<hkern g1="V" g2="O" k="61" />
<hkern g1="V" g2="a" k="227" />
<hkern g1="V" g2="e" k="227" />
<hkern g1="V" g2="i" k="152" />
<hkern g1="V" g2="o" k="227" />
<hkern g1="V" g2="r" k="152" />
<hkern g1="V" g2="u" k="152" />
<hkern g1="V" g2="y" k="188" />
<hkern g1="W" g2="comma" k="188" />
<hkern g1="W" g2="hyphen" k="76" />
<hkern g1="W" g2="period" k="188" />
<hkern g1="W" g2="colon" k="133" />
<hkern g1="W" g2="semicolon" k="133" />
<hkern g1="W" g2="A" k="143" />
<hkern g1="W" g2="a" k="188" />
<hkern g1="W" g2="e" k="188" />
<hkern g1="W" g2="i" k="113" />
<hkern g1="W" g2="o" k="188" />
<hkern g1="W" g2="r" k="113" />
<hkern g1="W" g2="u" k="113" />
<hkern g1="W" g2="y" k="188" />
<hkern g1="Y" g2="comma" k="188" />
<hkern g1="Y" g2="hyphen" k="152" />
<hkern g1="Y" g2="period" k="188" />
<hkern g1="Y" g2="colon" k="133" />
<hkern g1="Y" g2="semicolon" k="133" />
<hkern g1="Y" g2="A" k="143" />
<hkern g1="Y" g2="a" k="188" />
<hkern g1="Y" g2="e" k="188" />
<hkern g1="Y" g2="i" k="152" />
<hkern g1="Y" g2="o" k="188" />
<hkern g1="Y" g2="p" k="188" />
<hkern g1="Y" g2="q" k="227" />
<hkern g1="Y" g2="u" k="188" />
<hkern g1="Y" g2="v" k="188" />
<hkern g1="f" g2="quoteright" k="-188" />
<hkern g1="r" g2="comma" k="227" />
<hkern g1="r" g2="hyphen" k="41" />
<hkern g1="r" g2="period" k="227" />
<hkern g1="r" g2="c" k="76" />
<hkern g1="r" g2="d" k="76" />
<hkern g1="r" g2="e" k="76" />
<hkern g1="r" g2="g" k="76" />
<hkern g1="r" g2="h" k="37" />
<hkern g1="r" g2="o" k="76" />
<hkern g1="r" g2="q" k="76" />
<hkern g1="r" g2="r" k="0" />
<hkern g1="r" g2="t" k="0" />
<hkern g1="r" g2="u" k="0" />
<hkern g1="r" g2="v" k="0" />
<hkern g1="r" g2="w" k="0" />
<hkern g1="r" g2="x" k="0" />
<hkern g1="r" g2="y" k="0" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="152" />
<hkern g1="v" g2="period" k="152" />
<hkern g1="w" g2="comma" k="152" />
<hkern g1="w" g2="period" k="152" />
<hkern g1="y" g2="comma" k="113" />
<hkern g1="y" g2="period" k="113" />
<hkern g1="quoteleft" g2="quoteleft" k="227" />
<hkern g1="quoteright" g2="space" k="227" />
<hkern g1="quoteright" g2="s" k="264" />
<hkern g1="quoteright" g2="t" k="227" />
<hkern g1="quoteright" g2="quoteright" k="227" />
<hkern g1="quotesinglbase" g2="afii10051" k="231" />
<hkern g1="quotesinglbase" g2="afii10060" k="231" />
<hkern g1="quotesinglbase" g2="afii10036" k="231" />
<hkern g1="quotesinglbase" g2="afii10041" k="360" />
<hkern g1="quotesinglbase" g2="afii10044" k="180" />
<hkern g1="quotedblbase" g2="afii10051" k="231" />
<hkern g1="quotedblbase" g2="afii10060" k="231" />
<hkern g1="quotedblbase" g2="afii10036" k="231" />
<hkern g1="quotedblbase" g2="afii10041" k="256" />
<hkern g1="quotedblbase" g2="afii10044" k="102" />
<hkern g1="Gamma" g2="comma" k="262" />
<hkern g1="Gamma" g2="period" k="262" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-86" />
<hkern g1="Gamma" g2="Alpha" k="291" />
<hkern g1="Gamma" g2="Delta" k="291" />
<hkern g1="Gamma" g2="Lambda" k="291" />
<hkern g1="Gamma" g2="iota" k="113" />
<hkern g1="Theta" g2="Alpha" k="90" />
<hkern g1="Theta" g2="Delta" k="51" />
<hkern g1="Theta" g2="Lambda" k="90" />
<hkern g1="Theta" g2="Tau" k="37" />
<hkern g1="Theta" g2="Upsilon" k="84" />
<hkern g1="Theta" g2="Upsilondieresis" k="84" />
<hkern g1="Phi" g2="Alpha" k="90" />
<hkern g1="Phi" g2="Upsilon" k="158" />
<hkern g1="Phi" g2="Upsilondieresis" k="158" />
<hkern g1="delta" g2="chi" k="41" />
<hkern g1="tau" g2="zeta" k="-33" />
<hkern g1="phi" g2="lambda" k="43" />
<hkern g1="phi" g2="chi" k="41" />
<hkern g1="Alphatonos" g2="space" k="37" />
<hkern g1="Alphatonos" g2="Theta" k="90" />
<hkern g1="Alphatonos" g2="Phi" k="90" />
<hkern g1="Alphatonos" g2="Omicron" k="90" />
<hkern g1="Alphatonos" g2="Tau" k="76" />
<hkern g1="Alphatonos" g2="Upsilon" k="168" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="168" />
<hkern g1="Alphatonos" g2="gamma" k="92" />
<hkern g1="Alphatonos" g2="nu" k="113" />
<hkern g1="Alphatonos" g2="chi" k="92" />
<hkern g1="Omicrontonos" g2="Upsilon" k="84" />
<hkern g1="Upsilontonos" g2="Odieresis" k="74" />
<hkern g1="Upsilontonos" g2="Theta" k="74" />
<hkern g1="Upsilontonos" g2="Phi" k="121" />
<hkern g1="Upsilontonos" g2="alpha" k="186" />
<hkern g1="Upsilontonos" g2="delta" k="139" />
<hkern g1="Upsilontonos" g2="sigma" k="186" />
<hkern g1="Upsilontonos" g2="phi" k="186" />
<hkern g1="Upsilontonos" g2="iotadieresistonos" k="-59" />
<hkern g1="Upsilontonos" g2="Alpha" k="199" />
<hkern g1="Upsilontonos" g2="Delta" k="141" />
<hkern g1="Upsilontonos" g2="Lambda" k="199" />
<hkern g1="Upsilontonos" g2="Omicron" k="74" />
<hkern g1="Upsilontonos" g2="alphatonos" k="186" />
<hkern g1="Upsilontonos" g2="etatonos" k="96" />
<hkern g1="Upsilontonos" g2="iotatonos" k="104" />
<hkern g1="Upsilontonos" g2="eta" k="96" />
<hkern g1="Upsilontonos" g2="iota" k="104" />
<hkern g1="Upsilontonos" g2="kappa" k="96" />
<hkern g1="Upsilontonos" g2="mu" k="152" />
<hkern g1="Upsilontonos" g2="omicron" k="186" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="-59" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="186" />
<hkern g1="Alpha" g2="space" k="37" />
<hkern g1="Alpha" g2="quoteright" k="76" />
<hkern g1="Alpha" g2="Theta" k="90" />
<hkern g1="Alpha" g2="Phi" k="90" />
<hkern g1="Alpha" g2="Omicron" k="90" />
<hkern g1="Alpha" g2="Tau" k="76" />
<hkern g1="Alpha" g2="Upsilon" k="168" />
<hkern g1="Alpha" g2="Upsilondieresis" k="168" />
<hkern g1="Alpha" g2="gamma" k="92" />
<hkern g1="Alpha" g2="nu" k="113" />
<hkern g1="Alpha" g2="chi" k="92" />
<hkern g1="Delta" g2="space" k="37" />
<hkern g1="Delta" g2="Theta" k="39" />
<hkern g1="Delta" g2="Omicron" k="39" />
<hkern g1="Delta" g2="Tau" k="39" />
<hkern g1="Delta" g2="Upsilon" k="141" />
<hkern g1="Delta" g2="Upsilondieresis" k="141" />
<hkern g1="Kappa" g2="Theta" k="113" />
<hkern g1="Kappa" g2="Phi" k="168" />
<hkern g1="Kappa" g2="alpha" k="59" />
<hkern g1="Kappa" g2="delta" k="59" />
<hkern g1="Kappa" g2="sigma" k="59" />
<hkern g1="Kappa" g2="phi" k="59" />
<hkern g1="Kappa" g2="Omicron" k="113" />
<hkern g1="Kappa" g2="alphatonos" k="59" />
<hkern g1="Kappa" g2="zeta" k="59" />
<hkern g1="Kappa" g2="theta" k="59" />
<hkern g1="Kappa" g2="xi" k="59" />
<hkern g1="Kappa" g2="omicron" k="59" />
<hkern g1="Kappa" g2="omega" k="59" />
<hkern g1="Kappa" g2="omicrontonos" k="59" />
<hkern g1="Kappa" g2="omegatonos" k="59" />
<hkern g1="Lambda" g2="space" k="37" />
<hkern g1="Lambda" g2="Theta" k="90" />
<hkern g1="Lambda" g2="Omicron" k="90" />
<hkern g1="Lambda" g2="Tau" k="76" />
<hkern g1="Lambda" g2="Upsilon" k="168" />
<hkern g1="Lambda" g2="Upsilondieresis" k="168" />
<hkern g1="Omicron" g2="Alpha" k="90" />
<hkern g1="Omicron" g2="Delta" k="51" />
<hkern g1="Omicron" g2="Lambda" k="90" />
<hkern g1="Omicron" g2="Upsilon" k="84" />
<hkern g1="Omicron" g2="Upsilondieresis" k="84" />
<hkern g1="Rho" g2="comma" k="262" />
<hkern g1="Rho" g2="period" k="262" />
<hkern g1="Rho" g2="Alpha" k="262" />
<hkern g1="Rho" g2="Delta" k="180" />
<hkern g1="Rho" g2="Lambda" k="262" />
<hkern g1="Sigma" g2="tau" k="70" />
<hkern g1="Tau" g2="space" k="37" />
<hkern g1="Tau" g2="hyphen" k="152" />
<hkern g1="Tau" g2="period" k="152" />
<hkern g1="Tau" g2="colon" k="113" />
<hkern g1="Tau" g2="semicolon" k="113" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="186" />
<hkern g1="Tau" g2="delta" k="186" />
<hkern g1="Tau" g2="epsilon" k="186" />
<hkern g1="Tau" g2="sigma" k="186" />
<hkern g1="Tau" g2="phi" k="186" />
<hkern g1="Tau" g2="iotadieresistonos" k="-90" />
<hkern g1="Tau" g2="Alpha" k="152" />
<hkern g1="Tau" g2="Delta" k="90" />
<hkern g1="Tau" g2="Lambda" k="152" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="186" />
<hkern g1="Tau" g2="epsilontonos" k="98" />
<hkern g1="Tau" g2="gamma" k="152" />
<hkern g1="Tau" g2="eta" k="113" />
<hkern g1="Tau" g2="iota" k="113" />
<hkern g1="Tau" g2="mu" k="113" />
<hkern g1="Tau" g2="nu" k="152" />
<hkern g1="Tau" g2="omicron" k="186" />
<hkern g1="Tau" g2="chi" k="152" />
<hkern g1="Tau" g2="psi" k="113" />
<hkern g1="Tau" g2="omicrontonos" k="186" />
<hkern g1="Tau" g2="upsilontonos" k="113" />
<hkern g1="Upsilon" g2="comma" k="186" />
<hkern g1="Upsilon" g2="hyphen" k="152" />
<hkern g1="Upsilon" g2="period" k="186" />
<hkern g1="Upsilon" g2="colon" k="131" />
<hkern g1="Upsilon" g2="semicolon" k="131" />
<hkern g1="Upsilon" g2="Theta" k="37" />
<hkern g1="Upsilon" g2="Phi" k="121" />
<hkern g1="Upsilon" g2="alpha" k="186" />
<hkern g1="Upsilon" g2="delta" k="139" />
<hkern g1="Upsilon" g2="sigma" k="186" />
<hkern g1="Upsilon" g2="phi" k="186" />
<hkern g1="Upsilon" g2="iotadieresistonos" k="-59" />
<hkern g1="Upsilon" g2="Alpha" k="199" />
<hkern g1="Upsilon" g2="Delta" k="141" />
<hkern g1="Upsilon" g2="Lambda" k="199" />
<hkern g1="Upsilon" g2="Omicron" k="37" />
<hkern g1="Upsilon" g2="alphatonos" k="186" />
<hkern g1="Upsilon" g2="etatonos" k="96" />
<hkern g1="Upsilon" g2="iotatonos" k="104" />
<hkern g1="Upsilon" g2="gamma" k="94" />
<hkern g1="Upsilon" g2="eta" k="96" />
<hkern g1="Upsilon" g2="iota" k="104" />
<hkern g1="Upsilon" g2="kappa" k="96" />
<hkern g1="Upsilon" g2="mu" k="152" />
<hkern g1="Upsilon" g2="omicron" k="186" />
<hkern g1="Upsilon" g2="iotadieresis" k="-59" />
<hkern g1="Upsilon" g2="omicrontonos" k="186" />
<hkern g1="Chi" g2="omega" k="51" />
<hkern g1="Chi" g2="omegatonos" k="51" />
<hkern g1="Psi" g2="alpha" k="90" />
<hkern g1="Psi" g2="delta" k="90" />
<hkern g1="Psi" g2="sigma" k="90" />
<hkern g1="Psi" g2="phi" k="90" />
<hkern g1="Psi" g2="alphatonos" k="90" />
<hkern g1="Psi" g2="theta" k="51" />
<hkern g1="Psi" g2="omicron" k="90" />
<hkern g1="Psi" g2="omega" k="90" />
<hkern g1="Psi" g2="omicrontonos" k="90" />
<hkern g1="Psi" g2="omegatonos" k="90" />
<hkern g1="Omega" g2="Upsilon" k="47" />
<hkern g1="Omega" g2="Upsilondieresis" k="47" />
<hkern g1="Upsilondieresis" g2="Theta" k="37" />
<hkern g1="Upsilondieresis" g2="Phi" k="121" />
<hkern g1="Upsilondieresis" g2="alpha" k="186" />
<hkern g1="Upsilondieresis" g2="delta" k="139" />
<hkern g1="Upsilondieresis" g2="sigma" k="186" />
<hkern g1="Upsilondieresis" g2="phi" k="186" />
<hkern g1="Upsilondieresis" g2="iotadieresistonos" k="-59" />
<hkern g1="Upsilondieresis" g2="Alpha" k="199" />
<hkern g1="Upsilondieresis" g2="Delta" k="141" />
<hkern g1="Upsilondieresis" g2="Lambda" k="199" />
<hkern g1="Upsilondieresis" g2="Omicron" k="37" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="186" />
<hkern g1="Upsilondieresis" g2="etatonos" k="96" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="104" />
<hkern g1="Upsilondieresis" g2="eta" k="96" />
<hkern g1="Upsilondieresis" g2="iota" k="104" />
<hkern g1="Upsilondieresis" g2="kappa" k="96" />
<hkern g1="Upsilondieresis" g2="mu" k="152" />
<hkern g1="Upsilondieresis" g2="omicron" k="186" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="-59" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="186" />
<hkern g1="zeta" g2="alpha" k="117" />
<hkern g1="zeta" g2="delta" k="88" />
<hkern g1="zeta" g2="sigma" k="117" />
<hkern g1="zeta" g2="tau" k="141" />
<hkern g1="zeta" g2="phi" k="117" />
<hkern g1="zeta" g2="alphatonos" k="117" />
<hkern g1="zeta" g2="etatonos" k="66" />
<hkern g1="zeta" g2="gamma" k="102" />
<hkern g1="zeta" g2="eta" k="66" />
<hkern g1="zeta" g2="theta" k="88" />
<hkern g1="zeta" g2="iota" k="66" />
<hkern g1="zeta" g2="kappa" k="66" />
<hkern g1="zeta" g2="nu" k="102" />
<hkern g1="zeta" g2="omicron" k="117" />
<hkern g1="zeta" g2="omega" k="117" />
<hkern g1="zeta" g2="omicrontonos" k="117" />
<hkern g1="zeta" g2="omegatonos" k="117" />
<hkern g1="zeta" g2="pi" k="70" />
<hkern g1="lambda" g2="upsilon" k="35" />
<hkern g1="xi" g2="alpha" k="86" />
<hkern g1="xi" g2="delta" k="86" />
<hkern g1="xi" g2="sigma" k="86" />
<hkern g1="xi" g2="phi" k="86" />
<hkern g1="xi" g2="alphatonos" k="86" />
<hkern g1="xi" g2="zeta" k="86" />
<hkern g1="xi" g2="xi" k="86" />
<hkern g1="xi" g2="omicron" k="86" />
<hkern g1="xi" g2="sigma1" k="86" />
<hkern g1="xi" g2="omicrontonos" k="86" />
<hkern g1="omicron" g2="chi" k="41" />
<hkern g1="chi" g2="alpha" k="43" />
<hkern g1="chi" g2="delta" k="43" />
<hkern g1="chi" g2="sigma" k="43" />
<hkern g1="chi" g2="phi" k="43" />
<hkern g1="chi" g2="alphatonos" k="43" />
<hkern g1="chi" g2="zeta" k="43" />
<hkern g1="chi" g2="omicron" k="43" />
<hkern g1="chi" g2="sigma1" k="43" />
<hkern g1="chi" g2="omega" k="43" />
<hkern g1="chi" g2="omicrontonos" k="43" />
<hkern g1="chi" g2="omegatonos" k="43" />
<hkern g1="omega" g2="chi" k="41" />
<hkern g1="omicrontonos" g2="chi" k="41" />
<hkern g1="omegatonos" g2="chi" k="41" />
<hkern g1="afii10052" g2="comma" k="129" />
<hkern g1="afii10052" g2="period" k="154" />
<hkern g1="afii10052" g2="colon" k="-51" />
<hkern g1="afii10058" g2="quoteright" k="248" />
<hkern g1="afii10059" g2="quoteright" k="180" />
<hkern g1="afii10017" g2="quoteright" k="207" />
<hkern g1="afii10017" g2="afii10021" k="-29" />
<hkern g1="afii10017" g2="afii10025" k="27" />
<hkern g1="afii10017" g2="afii10029" k="41" />
<hkern g1="afii10017" g2="afii10032" k="78" />
<hkern g1="afii10017" g2="afii10033" k="51" />
<hkern g1="afii10017" g2="afii10035" k="51" />
<hkern g1="afii10017" g2="afii10036" k="78" />
<hkern g1="afii10017" g2="afii10037" k="129" />
<hkern g1="afii10017" g2="afii10038" k="104" />
<hkern g1="afii10017" g2="afii10041" k="129" />
<hkern g1="afii10017" g2="afii10047" k="102" />
<hkern g1="afii10017" g2="afii10065" k="31" />
<hkern g1="afii10017" g2="afii10066" k="31" />
<hkern g1="afii10017" g2="afii10070" k="31" />
<hkern g1="afii10017" g2="afii10080" k="31" />
<hkern g1="afii10017" g2="afii10083" k="31" />
<hkern g1="afii10017" g2="afii10085" k="68" />
<hkern g1="afii10017" g2="afii10086" k="31" />
<hkern g1="afii10017" g2="afii10095" k="31" />
<hkern g1="afii10018" g2="afii10017" k="55" />
<hkern g1="afii10018" g2="afii10021" k="-25" />
<hkern g1="afii10018" g2="afii10024" k="-51" />
<hkern g1="afii10018" g2="afii10025" k="-76" />
<hkern g1="afii10018" g2="afii10037" k="82" />
<hkern g1="afii10018" g2="afii10038" k="55" />
<hkern g1="afii10018" g2="afii10039" k="27" />
<hkern g1="afii10018" g2="afii10041" k="55" />
<hkern g1="afii10018" g2="afii10047" k="29" />
<hkern g1="afii10018" g2="afii10069" k="-25" />
<hkern g1="afii10018" g2="afii10085" k="25" />
<hkern g1="afii10018" g2="afii10097" k="-47" />
<hkern g1="afii10019" g2="afii10017" k="78" />
<hkern g1="afii10019" g2="afii10021" k="109" />
<hkern g1="afii10019" g2="afii10024" k="82" />
<hkern g1="afii10019" g2="afii10025" k="70" />
<hkern g1="afii10019" g2="afii10032" k="96" />
<hkern g1="afii10019" g2="afii10035" k="96" />
<hkern g1="afii10019" g2="afii10036" k="117" />
<hkern g1="afii10019" g2="afii10037" k="174" />
<hkern g1="afii10019" g2="afii10038" k="111" />
<hkern g1="afii10019" g2="afii10039" k="51" />
<hkern g1="afii10019" g2="afii10041" k="123" />
<hkern g1="afii10019" g2="afii10044" k="98" />
<hkern g1="afii10019" g2="afii10049" k="96" />
<hkern g1="afii10019" g2="afii10069" k="-25" />
<hkern g1="afii10019" g2="afii10078" k="27" />
<hkern g1="afii10019" g2="afii10084" k="-25" />
<hkern g1="afii10019" g2="afii10085" k="29" />
<hkern g1="afii10019" g2="afii10087" k="29" />
<hkern g1="afii10019" g2="afii10089" k="-25" />
<hkern g1="afii10019" g2="afii10097" k="-25" />
<hkern g1="afii10020" g2="comma" k="129" />
<hkern g1="afii10020" g2="period" k="154" />
<hkern g1="afii10020" g2="colon" k="-51" />
<hkern g1="afii10020" g2="afii10017" k="154" />
<hkern g1="afii10020" g2="afii10025" k="-39" />
<hkern g1="afii10020" g2="afii10029" k="27" />
<hkern g1="afii10020" g2="afii10030" k="51" />
<hkern g1="afii10020" g2="afii10032" k="27" />
<hkern g1="afii10020" g2="afii10049" k="27" />
<hkern g1="afii10020" g2="afii10065" k="51" />
<hkern g1="afii10020" g2="afii10067" k="78" />
<hkern g1="afii10020" g2="afii10069" k="37" />
<hkern g1="afii10020" g2="afii10070" k="61" />
<hkern g1="afii10020" g2="afii10074" k="39" />
<hkern g1="afii10020" g2="afii10077" k="109" />
<hkern g1="afii10020" g2="afii10078" k="82" />
<hkern g1="afii10020" g2="afii10079" k="61" />
<hkern g1="afii10020" g2="afii10080" k="106" />
<hkern g1="afii10020" g2="afii10082" k="57" />
<hkern g1="afii10020" g2="afii10085" k="88" />
<hkern g1="afii10020" g2="afii10093" k="109" />
<hkern g1="afii10020" g2="afii10094" k="102" />
<hkern g1="afii10020" g2="afii10096" k="133" />
<hkern g1="afii10020" g2="afii10097" k="82" />
<hkern g1="afii10022" g2="afii10025" k="29" />
<hkern g1="afii10024" g2="afii10032" k="109" />
<hkern g1="afii10024" g2="afii10035" k="109" />
<hkern g1="afii10024" g2="afii10037" k="70" />
<hkern g1="afii10024" g2="afii10041" k="70" />
<hkern g1="afii10024" g2="afii10080" k="27" />
<hkern g1="afii10024" g2="afii10085" k="61" />
<hkern g1="afii10025" g2="afii10036" k="-25" />
<hkern g1="afii10025" g2="afii10037" k="27" />
<hkern g1="afii10025" g2="afii10041" k="102" />
<hkern g1="afii10025" g2="afii10069" k="-27" />
<hkern g1="afii10028" g2="afii10032" k="96" />
<hkern g1="afii10028" g2="afii10035" k="96" />
<hkern g1="afii10028" g2="afii10037" k="27" />
<hkern g1="afii10028" g2="afii10038" k="164" />
<hkern g1="afii10028" g2="afii10047" k="27" />
<hkern g1="afii10028" g2="afii10070" k="51" />
<hkern g1="afii10028" g2="afii10080" k="78" />
<hkern g1="afii10028" g2="afii10083" k="51" />
<hkern g1="afii10028" g2="afii10085" k="88" />
<hkern g1="afii10028" g2="afii10095" k="51" />
<hkern g1="afii10030" g2="afii10038" k="51" />
<hkern g1="afii10030" g2="afii10065" k="29" />
<hkern g1="afii10030" g2="afii10070" k="29" />
<hkern g1="afii10030" g2="afii10080" k="29" />
<hkern g1="afii10030" g2="afii10083" k="29" />
<hkern g1="afii10032" g2="afii10017" k="98" />
<hkern g1="afii10032" g2="afii10021" k="51" />
<hkern g1="afii10032" g2="afii10024" k="78" />
<hkern g1="afii10032" g2="afii10029" k="51" />
<hkern g1="afii10032" g2="afii10037" k="119" />
<hkern g1="afii10032" g2="afii10038" k="-25" />
<hkern g1="afii10032" g2="afii10039" k="102" />
<hkern g1="afii10032" g2="afii10041" k="78" />
<hkern g1="afii10032" g2="afii10049" k="78" />
<hkern g1="afii10034" g2="comma" k="180" />
<hkern g1="afii10034" g2="period" k="205" />
<hkern g1="afii10034" g2="colon" k="-51" />
<hkern g1="afii10034" g2="afii10017" k="180" />
<hkern g1="afii10034" g2="afii10021" k="203" />
<hkern g1="afii10034" g2="afii10024" k="106" />
<hkern g1="afii10034" g2="afii10025" k="68" />
<hkern g1="afii10034" g2="afii10029" k="160" />
<hkern g1="afii10034" g2="afii10030" k="51" />
<hkern g1="afii10034" g2="afii10032" k="27" />
<hkern g1="afii10034" g2="afii10037" k="145" />
<hkern g1="afii10034" g2="afii10038" k="55" />
<hkern g1="afii10034" g2="afii10039" k="129" />
<hkern g1="afii10034" g2="afii10049" k="160" />
<hkern g1="afii10034" g2="afii10065" k="78" />
<hkern g1="afii10034" g2="afii10069" k="74" />
<hkern g1="afii10034" g2="afii10070" k="74" />
<hkern g1="afii10034" g2="afii10080" k="74" />
<hkern g1="afii10034" g2="afii10095" k="29" />
<hkern g1="afii10034" g2="afii10097" k="51" />
<hkern g1="afii10035" g2="afii10017" k="78" />
<hkern g1="afii10035" g2="afii10029" k="-25" />
<hkern g1="afii10035" g2="afii10037" k="27" />
<hkern g1="afii10035" g2="afii10039" k="27" />
<hkern g1="afii10035" g2="afii10041" k="27" />
<hkern g1="afii10035" g2="afii10065" k="-14" />
<hkern g1="afii10035" g2="afii10066" k="-14" />
<hkern g1="afii10035" g2="afii10070" k="-14" />
<hkern g1="afii10035" g2="afii10072" k="-14" />
<hkern g1="afii10035" g2="afii10073" k="-14" />
<hkern g1="afii10035" g2="afii10080" k="-14" />
<hkern g1="afii10035" g2="afii10083" k="-14" />
<hkern g1="afii10035" g2="afii10084" k="-29" />
<hkern g1="afii10035" g2="afii10086" k="-14" />
<hkern g1="afii10035" g2="afii10095" k="-14" />
<hkern g1="afii10036" g2="comma" k="102" />
<hkern g1="afii10036" g2="period" k="129" />
<hkern g1="afii10036" g2="colon" k="-76" />
<hkern g1="afii10036" g2="semicolon" k="-25" />
<hkern g1="afii10036" g2="guillemotleft" k="-51" />
<hkern g1="afii10036" g2="guillemotright" k="-51" />
<hkern g1="afii10036" g2="afii10017" k="129" />
<hkern g1="afii10036" g2="afii10021" k="-51" />
<hkern g1="afii10036" g2="afii10038" k="55" />
<hkern g1="afii10036" g2="afii10065" k="74" />
<hkern g1="afii10036" g2="afii10067" k="74" />
<hkern g1="afii10036" g2="afii10070" k="74" />
<hkern g1="afii10036" g2="afii10074" k="49" />
<hkern g1="afii10036" g2="afii10076" k="74" />
<hkern g1="afii10036" g2="afii10077" k="74" />
<hkern g1="afii10036" g2="afii10078" k="74" />
<hkern g1="afii10036" g2="afii10080" k="74" />
<hkern g1="afii10036" g2="afii10081" k="49" />
<hkern g1="afii10036" g2="afii10082" k="51" />
<hkern g1="afii10036" g2="afii10083" k="74" />
<hkern g1="afii10036" g2="afii10085" k="49" />
<hkern g1="afii10036" g2="afii10087" k="49" />
<hkern g1="afii10036" g2="afii10091" k="49" />
<hkern g1="afii10036" g2="afii10093" k="74" />
<hkern g1="afii10036" g2="afii10094" k="74" />
<hkern g1="afii10036" g2="afii10096" k="74" />
<hkern g1="afii10036" g2="afii10097" k="49" />
<hkern g1="afii10037" g2="comma" k="104" />
<hkern g1="afii10037" g2="period" k="129" />
<hkern g1="afii10037" g2="colon" k="-51" />
<hkern g1="afii10037" g2="guillemotleft" k="-25" />
<hkern g1="afii10037" g2="guillemotright" k="-51" />
<hkern g1="afii10037" g2="afii10017" k="154" />
<hkern g1="afii10037" g2="afii10021" k="82" />
<hkern g1="afii10037" g2="afii10029" k="133" />
<hkern g1="afii10037" g2="afii10032" k="55" />
<hkern g1="afii10037" g2="afii10038" k="109" />
<hkern g1="afii10037" g2="afii10049" k="109" />
<hkern g1="afii10037" g2="afii10066" k="27" />
<hkern g1="afii10037" g2="afii10067" k="96" />
<hkern g1="afii10037" g2="afii10068" k="102" />
<hkern g1="afii10037" g2="afii10069" k="27" />
<hkern g1="afii10037" g2="afii10070" k="96" />
<hkern g1="afii10037" g2="afii10072" k="102" />
<hkern g1="afii10037" g2="afii10073" k="102" />
<hkern g1="afii10037" g2="afii10074" k="31" />
<hkern g1="afii10037" g2="afii10075" k="27" />
<hkern g1="afii10037" g2="afii10076" k="51" />
<hkern g1="afii10037" g2="afii10077" k="102" />
<hkern g1="afii10037" g2="afii10078" k="102" />
<hkern g1="afii10037" g2="afii10079" k="51" />
<hkern g1="afii10037" g2="afii10080" k="96" />
<hkern g1="afii10037" g2="afii10081" k="57" />
<hkern g1="afii10037" g2="afii10082" k="82" />
<hkern g1="afii10037" g2="afii10083" k="96" />
<hkern g1="afii10037" g2="afii10087" k="96" />
<hkern g1="afii10037" g2="afii10088" k="27" />
<hkern g1="afii10037" g2="afii10090" k="27" />
<hkern g1="afii10037" g2="afii10091" k="27" />
<hkern g1="afii10037" g2="afii10096" k="57" />
<hkern g1="afii10037" g2="afii10097" k="96" />
<hkern g1="afii10038" g2="afii10017" k="102" />
<hkern g1="afii10038" g2="afii10021" k="96" />
<hkern g1="afii10038" g2="afii10029" k="27" />
<hkern g1="afii10038" g2="afii10030" k="12" />
<hkern g1="afii10038" g2="afii10032" k="-25" />
<hkern g1="afii10038" g2="afii10036" k="27" />
<hkern g1="afii10038" g2="afii10037" k="158" />
<hkern g1="afii10038" g2="afii10041" k="70" />
<hkern g1="afii10038" g2="afii10049" k="27" />
<hkern g1="afii10038" g2="afii10077" k="31" />
<hkern g1="afii10039" g2="afii10032" k="104" />
<hkern g1="afii10039" g2="afii10035" k="78" />
<hkern g1="afii10039" g2="afii10038" k="51" />
<hkern g1="afii10039" g2="afii10080" k="41" />
<hkern g1="afii10039" g2="afii10085" k="41" />
<hkern g1="afii10044" g2="quoteright" k="248" />
<hkern g1="afii10044" g2="afii10049" k="59" />
<hkern g1="afii10046" g2="quoteright" k="248" />
<hkern g1="afii10046" g2="afii10017" k="70" />
<hkern g1="afii10046" g2="afii10021" k="27" />
<hkern g1="afii10046" g2="afii10024" k="57" />
<hkern g1="afii10046" g2="afii10025" k="27" />
<hkern g1="afii10046" g2="afii10030" k="41" />
<hkern g1="afii10046" g2="afii10032" k="51" />
<hkern g1="afii10046" g2="afii10035" k="41" />
<hkern g1="afii10046" g2="afii10036" k="104" />
<hkern g1="afii10046" g2="afii10039" k="82" />
<hkern g1="afii10046" g2="afii10041" k="229" />
<hkern g1="afii10046" g2="afii10047" k="78" />
<hkern g1="afii10046" g2="afii10049" k="27" />
<hkern g1="afii10047" g2="afii10024" k="27" />
<hkern g1="afii10047" g2="afii10025" k="-51" />
<hkern g1="afii10047" g2="afii10029" k="27" />
<hkern g1="afii10047" g2="afii10039" k="78" />
<hkern g1="afii10047" g2="afii10049" k="27" />
<hkern g1="afii10047" g2="afii10069" k="-29" />
<hkern g1="afii10047" g2="afii10072" k="-29" />
<hkern g1="afii10047" g2="afii10077" k="14" />
<hkern g1="afii10047" g2="afii10078" k="29" />
<hkern g1="afii10047" g2="afii10097" k="-29" />
<hkern g1="afii10048" g2="afii10017" k="115" />
<hkern g1="afii10048" g2="afii10021" k="27" />
<hkern g1="afii10048" g2="afii10024" k="51" />
<hkern g1="afii10048" g2="afii10029" k="51" />
<hkern g1="afii10048" g2="afii10032" k="27" />
<hkern g1="afii10048" g2="afii10036" k="27" />
<hkern g1="afii10048" g2="afii10039" k="104" />
<hkern g1="afii10048" g2="afii10041" k="51" />
<hkern g1="afii10048" g2="afii10069" k="-14" />
<hkern g1="afii10048" g2="afii10072" k="-14" />
<hkern g1="afii10065" g2="afii10085" k="27" />
<hkern g1="afii10065" g2="afii10089" k="27" />
<hkern g1="afii10066" g2="afii10072" k="27" />
<hkern g1="afii10066" g2="afii10073" k="27" />
<hkern g1="afii10066" g2="afii10077" k="51" />
<hkern g1="afii10066" g2="afii10078" k="78" />
<hkern g1="afii10066" g2="afii10080" k="27" />
<hkern g1="afii10066" g2="afii10083" k="27" />
<hkern g1="afii10066" g2="afii10085" k="27" />
<hkern g1="afii10066" g2="afii10086" k="27" />
<hkern g1="afii10066" g2="afii10087" k="41" />
<hkern g1="afii10066" g2="afii10089" k="27" />
<hkern g1="afii10066" g2="afii10092" k="51" />
<hkern g1="afii10066" g2="afii10095" k="27" />
<hkern g1="afii10066" g2="afii10097" k="51" />
<hkern g1="afii10067" g2="afii10065" k="14" />
<hkern g1="afii10067" g2="afii10066" k="27" />
<hkern g1="afii10067" g2="afii10069" k="39" />
<hkern g1="afii10067" g2="afii10073" k="27" />
<hkern g1="afii10067" g2="afii10080" k="27" />
<hkern g1="afii10067" g2="afii10083" k="27" />
<hkern g1="afii10067" g2="afii10086" k="14" />
<hkern g1="afii10067" g2="afii10092" k="27" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="period" k="27" />
<hkern g1="afii10068" g2="afii10077" k="27" />
<hkern g1="afii10069" g2="afii10070" k="-25" />
<hkern g1="afii10069" g2="afii10085" k="27" />
<hkern g1="afii10069" g2="afii10092" k="27" />
<hkern g1="afii10069" g2="afii10095" k="27" />
<hkern g1="afii10070" g2="afii10065" k="27" />
<hkern g1="afii10070" g2="afii10066" k="27" />
<hkern g1="afii10070" g2="afii10069" k="51" />
<hkern g1="afii10070" g2="afii10072" k="51" />
<hkern g1="afii10070" g2="afii10073" k="27" />
<hkern g1="afii10070" g2="afii10077" k="51" />
<hkern g1="afii10070" g2="afii10078" k="51" />
<hkern g1="afii10070" g2="afii10080" k="27" />
<hkern g1="afii10070" g2="afii10083" k="27" />
<hkern g1="afii10070" g2="afii10084" k="27" />
<hkern g1="afii10070" g2="afii10086" k="51" />
<hkern g1="afii10070" g2="afii10087" k="27" />
<hkern g1="afii10070" g2="afii10089" k="27" />
<hkern g1="afii10072" g2="afii10065" k="27" />
<hkern g1="afii10072" g2="afii10066" k="27" />
<hkern g1="afii10072" g2="afii10070" k="27" />
<hkern g1="afii10072" g2="afii10073" k="27" />
<hkern g1="afii10072" g2="afii10080" k="51" />
<hkern g1="afii10072" g2="afii10083" k="51" />
<hkern g1="afii10072" g2="afii10089" k="27" />
<hkern g1="afii10072" g2="afii10092" k="27" />
<hkern g1="afii10073" g2="afii10069" k="27" />
<hkern g1="afii10073" g2="afii10072" k="27" />
<hkern g1="afii10073" g2="afii10073" k="27" />
<hkern g1="afii10073" g2="afii10077" k="51" />
<hkern g1="afii10073" g2="afii10078" k="51" />
<hkern g1="afii10073" g2="afii10080" k="27" />
<hkern g1="afii10073" g2="afii10083" k="27" />
<hkern g1="afii10073" g2="afii10085" k="14" />
<hkern g1="afii10073" g2="afii10089" k="27" />
<hkern g1="afii10073" g2="afii10092" k="27" />
<hkern g1="afii10076" g2="guillemotleft" k="55" />
<hkern g1="afii10076" g2="afii10065" k="51" />
<hkern g1="afii10076" g2="afii10066" k="51" />
<hkern g1="afii10076" g2="afii10070" k="51" />
<hkern g1="afii10076" g2="afii10073" k="27" />
<hkern g1="afii10076" g2="afii10077" k="-41" />
<hkern g1="afii10076" g2="afii10080" k="78" />
<hkern g1="afii10076" g2="afii10083" k="78" />
<hkern g1="afii10076" g2="afii10084" k="27" />
<hkern g1="afii10076" g2="afii10086" k="51" />
<hkern g1="afii10076" g2="afii10089" k="27" />
<hkern g1="afii10076" g2="afii10095" k="27" />
<hkern g1="afii10077" g2="afii10065" k="-25" />
<hkern g1="afii10077" g2="afii10066" k="-25" />
<hkern g1="afii10077" g2="afii10070" k="-51" />
<hkern g1="afii10077" g2="afii10073" k="-25" />
<hkern g1="afii10077" g2="afii10080" k="-25" />
<hkern g1="afii10077" g2="afii10083" k="-25" />
<hkern g1="afii10077" g2="afii10085" k="27" />
<hkern g1="afii10077" g2="afii10086" k="-25" />
<hkern g1="afii10077" g2="afii10089" k="27" />
<hkern g1="afii10080" g2="afii10066" k="27" />
<hkern g1="afii10080" g2="afii10069" k="27" />
<hkern g1="afii10080" g2="afii10072" k="51" />
<hkern g1="afii10080" g2="afii10073" k="27" />
<hkern g1="afii10080" g2="afii10077" k="51" />
<hkern g1="afii10080" g2="afii10078" k="78" />
<hkern g1="afii10080" g2="afii10085" k="41" />
<hkern g1="afii10080" g2="afii10087" k="41" />
<hkern g1="afii10080" g2="afii10089" k="53" />
<hkern g1="afii10080" g2="afii10095" k="27" />
<hkern g1="afii10080" g2="afii10097" k="27" />
<hkern g1="afii10082" g2="afii10069" k="27" />
<hkern g1="afii10082" g2="afii10072" k="51" />
<hkern g1="afii10082" g2="afii10073" k="27" />
<hkern g1="afii10082" g2="afii10077" k="78" />
<hkern g1="afii10082" g2="afii10078" k="102" />
<hkern g1="afii10082" g2="afii10084" k="27" />
<hkern g1="afii10082" g2="afii10085" k="27" />
<hkern g1="afii10082" g2="afii10087" k="41" />
<hkern g1="afii10082" g2="afii10089" k="27" />
<hkern g1="afii10082" g2="afii10095" k="27" />
<hkern g1="afii10082" g2="afii10097" k="27" />
<hkern g1="afii10083" g2="afii10065" k="53" />
<hkern g1="afii10083" g2="afii10066" k="27" />
<hkern g1="afii10083" g2="afii10070" k="27" />
<hkern g1="afii10083" g2="afii10072" k="27" />
<hkern g1="afii10083" g2="afii10073" k="27" />
<hkern g1="afii10083" g2="afii10080" k="51" />
<hkern g1="afii10083" g2="afii10085" k="14" />
<hkern g1="afii10083" g2="afii10086" k="51" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="27" />
<hkern g1="afii10083" g2="afii10092" k="27" />
<hkern g1="afii10084" g2="comma" k="-51" />
<hkern g1="afii10084" g2="period" k="-25" />
<hkern g1="afii10084" g2="afii10065" k="-25" />
<hkern g1="afii10084" g2="afii10073" k="-25" />
<hkern g1="afii10084" g2="afii10085" k="51" />
<hkern g1="afii10084" g2="afii10097" k="-25" />
<hkern g1="afii10085" g2="comma" k="102" />
<hkern g1="afii10085" g2="period" k="129" />
<hkern g1="afii10085" g2="colon" k="27" />
<hkern g1="afii10085" g2="semicolon" k="78" />
<hkern g1="afii10085" g2="afii10069" k="6" />
<hkern g1="afii10085" g2="afii10072" k="51" />
<hkern g1="afii10085" g2="afii10073" k="27" />
<hkern g1="afii10085" g2="afii10077" k="55" />
<hkern g1="afii10085" g2="afii10078" k="51" />
<hkern g1="afii10085" g2="afii10082" k="27" />
<hkern g1="afii10085" g2="afii10087" k="27" />
<hkern g1="afii10085" g2="afii10095" k="27" />
<hkern g1="afii10085" g2="afii10097" k="31" />
<hkern g1="afii10086" g2="afii10077" k="51" />
<hkern g1="afii10086" g2="afii10078" k="78" />
<hkern g1="afii10086" g2="afii10080" k="27" />
<hkern g1="afii10086" g2="afii10084" k="27" />
<hkern g1="afii10086" g2="afii10085" k="68" />
<hkern g1="afii10086" g2="afii10089" k="27" />
<hkern g1="afii10086" g2="afii10097" k="27" />
<hkern g1="afii10087" g2="afii10065" k="27" />
<hkern g1="afii10087" g2="afii10066" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="51" />
<hkern g1="afii10087" g2="afii10083" k="51" />
<hkern g1="afii10087" g2="afii10086" k="51" />
<hkern g1="afii10087" g2="afii10089" k="27" />
<hkern g1="afii10087" g2="afii10092" k="51" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10065" k="-25" />
<hkern g1="afii10088" g2="afii10070" k="-51" />
<hkern g1="afii10088" g2="afii10073" k="-25" />
<hkern g1="afii10088" g2="afii10080" k="-25" />
<hkern g1="afii10088" g2="afii10083" k="-25" />
<hkern g1="afii10088" g2="afii10085" k="27" />
<hkern g1="afii10091" g2="afii10065" k="-51" />
<hkern g1="afii10091" g2="afii10070" k="-51" />
<hkern g1="afii10091" g2="afii10080" k="-25" />
<hkern g1="afii10091" g2="afii10085" k="27" />
<hkern g1="afii10094" g2="afii10084" k="27" />
<hkern g1="afii10094" g2="afii10089" k="78" />
<hkern g1="afii10095" g2="afii10066" k="27" />
<hkern g1="afii10095" g2="afii10069" k="27" />
<hkern g1="afii10095" g2="afii10072" k="51" />
<hkern g1="afii10095" g2="afii10073" k="27" />
<hkern g1="afii10095" g2="afii10077" k="51" />
<hkern g1="afii10095" g2="afii10078" k="78" />
<hkern g1="afii10095" g2="afii10080" k="27" />
<hkern g1="afii10095" g2="afii10083" k="27" />
<hkern g1="afii10095" g2="afii10084" k="27" />
<hkern g1="afii10095" g2="afii10086" k="27" />
<hkern g1="afii10095" g2="afii10087" k="41" />
<hkern g1="afii10095" g2="afii10097" k="51" />
<hkern g1="afii10096" g2="afii10066" k="27" />
<hkern g1="afii10096" g2="afii10072" k="27" />
<hkern g1="afii10096" g2="afii10077" k="51" />
<hkern g1="afii10096" g2="afii10078" k="78" />
<hkern g1="afii10096" g2="afii10080" k="27" />
<hkern g1="afii10096" g2="afii10083" k="27" />
<hkern g1="afii10096" g2="afii10087" k="82" />
<hkern g1="afii10096" g2="afii10089" k="27" />
<hkern g1="afii10096" g2="afii10095" k="27" />
<hkern g1="afii10110" g2="comma" k="102" />
<hkern g1="afii10110" g2="period" k="129" />
<hkern g1="afii10110" g2="colon" k="27" />
<hkern g1="afii10110" g2="semicolon" k="78" />
<hkern g1="afii10110" g2="guillemotleft" k="-25" />
<hkern g1="afii10110" g2="guillemotright" k="-25" />
<hkern g1="afii10050" g2="comma" k="51" />
<hkern g1="afii10050" g2="period" k="78" />
<hkern g1="afii10050" g2="colon" k="-51" />
<hkern g1="afii10050" g2="guillemotleft" k="-51" />
<hkern g1="afii10050" g2="guillemotright" k="-51" />
<hkern g1="pi" g2="zeta" k="-33" />
</font>

<font horiz-adv-x="821" ><font-face
    font-family="TimesNewRoman"
    units-per-em="2048"
    panose-1="2 2 6 3 5 4 5 2 3 4"
    ascent="1825"
    descent="-443"
    alphabetic="0" />
<missing-glyph horiz-adv-x="1593" d="M284 0V1280H1308V0H284ZM316 32H1276V1248H316V32Z" />
<glyph unicode=" " glyph-name="space" horiz-adv-x="512" />
<glyph unicode="!" glyph-name="exclam" horiz-adv-x="682" d="M360 359H322L234 1169Q228 1222 228 1248Q228 1311 261 1349T342 1387Q389 1387 421 1349T454 1236Q454 1212 450 1169L360 359ZM340 193Q386 193 418 161T451 83Q451 37 419 5T340 -28Q294 -28
262 4T229 83Q229 128 261 160T340 193Z" />
<glyph unicode="&quot;" glyph-name="quotedbl" horiz-adv-x="836" d="M576 803L522 1095L500 1216Q498 1241 498 1266Q498 1329 526 1358T600 1387Q643 1387 671 1358T700 1280Q700 1195 681 1096L624 803H576ZM210 803L155 1099Q133 1221 133 1265Q133 1329
159 1358T231 1387Q275 1387 304 1358T333 1279Q333 1240 307 1098L253 803H210Z" />
<glyph unicode="#" glyph-name="numbersign" horiz-adv-x="1024" d="M115 -28L208 427H37V509H224L293 852H37V932H312L403 1387H486L395 932H732L829 1387H912L817 932H987V852H802L732 509H987V427H715L622 -28H541L632 427H293L198 -28H115ZM308 509H647L719
852H378L308 509Z" />
<glyph unicode="$" glyph-name="dollar" horiz-adv-x="1024" d="M108 334H152Q163 197 238 124T462 37V621Q237 760 162 867Q109 943 109 1052Q109 1175 200 1267T462 1378V1470H526V1378Q608 1373 664 1359Q693 1352 856 1290V991H817Q804 1150 735 1223T526
1311V803Q778 627 849 544T921 336Q921 198 817 93T526 -28V-156H462V-28Q368 -24 287 -7T108 51V334ZM462 845V1310Q362 1298 314 1247T265 1117Q265 1044 309 981T462 845ZM526 37Q601 50 641 74Q697 109 729 165T762 286Q762 352 723 411T526 578V37Z" />
<glyph unicode="%" glyph-name="percent" horiz-adv-x="1706" d="M1392 1387L404 -56H315L1303 1387H1392ZM364 1387Q499 1387 573 1275T648 1018Q648 844 564 749T362 654Q283 654 217 697T112 827T72 1018Q72 1123 112 1211T221 1343T364 1387ZM361 1331Q310
1331 271 1271T231 1019Q231 880 253 807Q270 752 306 722Q327 704 358 704Q406 704 440 756Q490 833 490 1013Q490 1203 441 1280Q409 1331 361 1331ZM1346 673Q1417 673 1487 628T1596 497T1635 308Q1635 131 1550 38T1349 -56Q1276 -56 1208 -11T1100 117T1060
308Q1060 413 1099 500T1207 630T1346 673ZM1347 620Q1299 620 1264 566Q1219 496 1219 301Q1219 122 1265 51Q1299 0 1347 0Q1393 0 1429 55Q1477 128 1477 306Q1477 494 1429 569Q1396 620 1347 620Z" />
<glyph unicode="&amp;" glyph-name="ampersand" horiz-adv-x="1593" d="M1045 873H1465V836Q1378 829 1337 798T1207 607T1009 310Q1098 206 1168 165T1309 123Q1378 123 1426 160T1494 271L1531 244Q1494 103 1412 36T1221 -31Q1139 -31 1055 13T870 164Q746
54 647 12T434 -31Q269 -31 172 57T75 267Q75 388 162 508T489 758Q442 862 425 928T408 1056Q408 1227 534 1317Q632 1387 757 1387Q876 1387 951 1317T1026 1143Q1026 1037 954 957T697 782Q824 556 962 368Q1138 578 1138 722Q1138 768 1108 804Q1086 831 1045
836V873ZM663 847Q787 906 848 981T910 1148Q910 1220 866 1267T755 1314Q668 1314 624 1254T579 1135Q579 1086 596 1026T663 847ZM818 222Q686 402 635 485T523 691Q403 622 343 539T282 359Q282 252 351 171T537 90Q600 90 658 115T818 222Z" />
<glyph unicode="&apos;" glyph-name="quotesingle" horiz-adv-x="369" d="M158 803L104 1099Q81 1222 81 1265Q81 1329 107 1358T178 1387Q223 1387 252 1358T282 1280Q282 1243 256 1098L202 803H158Z" />
<glyph unicode="(" glyph-name="parenleft" horiz-adv-x="682" d="M636 -401V-438Q485 -362 384 -260Q240 -115 162 82T84 491Q84 801 237 1056T636 1422V1380Q513 1312 434 1194T316 895T277 517Q277 303 310 128Q336 -10 373 -93T472 -254T636 -401Z" />
<glyph unicode=")" glyph-name="parenright" horiz-adv-x="682" d="M46 1380V1422Q198 1347 299 1245Q442 1099 520 903T598 493Q598 183 446 -72T46 -438V-401Q169 -332 248 -215T366 84T405 463Q405 676 372 852Q347 990 310 1073T210 1233T46 1380Z" />
<glyph unicode="*" glyph-name="asterisk" horiz-adv-x="1024" d="M494 1044Q490 1113 466 1181Q432 1279 432 1316Q432 1368 456 1395T517 1422Q548 1422 571 1395T594 1318Q594 1273 568 1193T535 1044Q590 1079 634 1129Q702 1208 735 1227T802 1246Q835 1246
857 1224T880 1170Q880 1133 847 1104T682 1046Q605 1029 554 1007Q606 980 681 966Q802 944 839 911T877 839Q877 809 855 787T802 765Q772 765 736 786T637 880Q596 929 535 972Q537 915 558 848Q594 730 594 687Q594 647 570 620T519 592Q482 592 452 621Q431
642 431 688Q431 736 454 803T483 896T494 972Q435 933 391 885Q318 803 281 781Q255 765 227 765Q193 765 169 788T145 839Q145 864 165 891T227 937Q254 949 350 969Q412 982 471 1007Q417 1034 342 1049Q219 1075 190 1096Q145 1129 145 1176Q145 1203 167 1225T220
1248Q253 1248 290 1227T382 1143T494 1044Z" />
<glyph unicode="+" glyph-name="plus" horiz-adv-x="1155" d="M535 141V640H37V722H535V1219H615V722H1115V640H615V141H535Z" />
<glyph unicode="," glyph-name="comma" horiz-adv-x="512" d="M110 -341V-297Q213 -263 269 -192T326 -40Q326 -21 317 -8Q310 1 303 1Q292 1 255 -19Q237 -28 217 -28Q168 -28 139 1T110 81Q110 130 147 165T239 200Q305 200 356 143T408 -10Q408 -113 337 -201T110
-341Z" />
<glyph unicode="-" glyph-name="hyphen" horiz-adv-x="682" d="M83 535H600V384H83V535Z" />
<glyph unicode="." glyph-name="period" horiz-adv-x="512" d="M256 194Q303 194 335 162T367 83Q367 37 335 5T256 -28Q210 -28 178 4T145 83Q145 130 177 162T256 194Z" />
<glyph unicode="/" glyph-name="slash" horiz-adv-x="569" d="M574 1422L83 -28H3L494 1422H574Z" />
<glyph unicode="0" glyph-name="zero" horiz-adv-x="1024" d="M74 670Q74 902 144 1069T330 1319Q420 1384 516 1384Q672 1384 796 1225Q951 1028 951 691Q951 455 883 290T710 51T506 -24Q312 -24 183 205Q74 398 74 670ZM270 645Q270 365 339 188Q396 39 509
39Q563 39 621 87T709 250Q755 422 755 735Q755 967 707 1122Q671 1237 614 1285Q573 1318 515 1318Q447 1318 394 1257Q322 1174 296 996T270 645Z" />
<glyph unicode="1" glyph-name="one" horiz-adv-x="1024" d="M240 1223L570 1384H603V239Q603 125 612 97T652 54T774 37V0H264V37Q360 39 388 53T427 92T438 239V971Q438 1119 428 1161Q421 1193 403 1208T358 1223Q321 1223 255 1192L240 1223Z" />
<glyph unicode="2" glyph-name="two" horiz-adv-x="1024" d="M939 261L844 0H44V37Q397 359 541 563T685 936Q685 1065 606 1148T417 1231Q317 1231 238 1173T120 1001H83Q108 1186 211 1285T470 1384Q635 1384 745 1278T856 1028Q856 925 808 822Q734 660 568
479Q319 207 257 151H611Q719 151 762 159T841 191T902 261H939Z" />
<glyph unicode="3" glyph-name="three" horiz-adv-x="1024" d="M104 1098Q162 1235 250 1309T471 1384Q634 1384 721 1278Q787 1199 787 1109Q787 961 601 803Q726 754 790 663T854 449Q854 273 742 144Q596 -24 319 -24Q182 -24 133 10T83 83Q83 112 106 134T163
156Q188 156 214 148Q231 143 291 112T374 74Q411 63 453 63Q555 63 630 142T706 329Q706 408 671 483Q645 539 614 568Q571 608 496 640T343 673H311V703Q390 713 469 760T585 873T621 1018Q621 1121 557 1184T396 1248Q241 1248 137 1082L104 1098Z" />
<glyph unicode="4" glyph-name="four" horiz-adv-x="1024" d="M953 500V358H771V0H606V358H32V486L661 1384H771V500H953ZM606 500V1173L130 500H606Z" />
<glyph unicode="5" glyph-name="five" horiz-adv-x="1024" d="M889 1356L811 1186H403L314 1004Q579 965 734 807Q867 671 867 487Q867 380 824 289T714 134T567 31Q452 -24 331 -24Q209 -24 154 17T98 109Q98 137 121 158T179 180Q205 180 224 172T291 131Q366
79 443 79Q560 79 648 167T737 383Q737 506 658 612T440 777Q331 822 143 829L403 1356H889Z" />
<glyph unicode="6" glyph-name="six" horiz-adv-x="1024" d="M918 1384V1347Q786 1334 703 1295T538 1174T403 994T313 757Q457 856 602 856Q741 856 843 744T945 456Q945 286 842 146Q718 -24 514 -24Q375 -24 278 68Q88 247 88 532Q88 714 161 878T369 1169T629
1340T860 1384H918ZM296 684Q278 549 278 466Q278 370 313 258T419 79Q470 32 543 32Q630 32 698 114T767 348Q767 519 699 644T506 769Q468 769 425 753T296 684Z" />
<glyph unicode="7" glyph-name="seven" horiz-adv-x="1024" d="M206 1356H933V1318L481 -28H369L774 1193H401Q288 1193 240 1166Q156 1120 105 1024L76 1035L206 1356Z" />
<glyph unicode="8" glyph-name="eight" horiz-adv-x="1024" d="M393 683Q232 815 186 895T139 1061Q139 1193 241 1288T512 1384Q676 1384 776 1295T876 1092Q876 1016 822 937T597 751Q773 615 830 537Q906 435 906 322Q906 179 797 78T511 -24Q318 -24 210 97Q124
194 124 309Q124 399 184 487T393 683ZM550 790Q670 898 702 960T734 1102Q734 1207 675 1266T514 1326Q412 1326 348 1267T284 1129Q284 1077 310 1025T386 926L550 790ZM440 645Q357 575 317 493T277 314Q277 185 347 108T527 30Q635 30 700 91T765 239Q765 311
727 368Q656 474 440 645Z" />
<glyph unicode="9" glyph-name="nine" horiz-adv-x="1024" d="M108 -28V9Q238 11 350 69T566 274T712 595Q555 494 428 494Q285 494 183 604T81 898Q81 1076 183 1215Q306 1384 504 1384Q671 1384 790 1246Q936 1075 936 824Q936 598 825 403T516 78Q355 -28 165
-28H108ZM728 669Q746 799 746 877Q746 974 713 1086T620 1259T482 1319Q393 1319 326 1239T259 1001Q259 790 348 671Q413 585 508 585Q554 585 617 607T728 669Z" />
<glyph unicode=":" glyph-name="colon" horiz-adv-x="569" d="M289 944Q335 944 367 912T400 833Q400 787 368 755T289 722Q243 722 211 754T178 833Q178 879 210 911T289 944ZM287 195Q334 195 366 162T399 83Q399 37 366 5T287 -28Q241 -28 209 4T176 83Q176
129 208 162T287 195Z" />
<glyph unicode=";" glyph-name="semicolon" horiz-adv-x="569" d="M282 945Q328 945 360 913T393 835Q393 789 361 757T282 724Q236 724 204 756T171 835Q171 881 203 913T282 945ZM142 -341V-297Q245 -263 301 -192T358 -40Q358 -21 349 -8Q342 1 335 1Q324 1
287 -19Q269 -28 249 -28Q200 -28 171 1T142 81Q142 130 179 165T271 200Q337 200 388 143T440 -10Q440 -113 369 -201T142 -341Z" />
<glyph unicode="&lt;" glyph-name="less" horiz-adv-x="1155" d="M39 706L1115 1172V1085L189 683L1115 277V187L39 657V706Z" />
<glyph unicode="=" glyph-name="equal" horiz-adv-x="1155" d="M37 883H1116V801H37V883ZM37 557H1116V475H37V557Z" />
<glyph unicode="&gt;" glyph-name="greater" horiz-adv-x="1155" d="M1113 653L37 187V273L964 675L37 1081V1172L1113 702V653Z" />
<glyph unicode="?" glyph-name="question" horiz-adv-x="909" d="M454 320H413Q420 446 444 528T546 758Q606 871 624 931T642 1054Q642 1181 575 1256T409 1331Q322 1331 272 1290T222 1201Q222 1164 252 1110T282 1028Q282 992 259 968T203 943Q161 943 127
984T92 1100Q92 1213 189 1300T452 1387Q658 1387 755 1267Q827 1179 827 1072Q827 999 795 922T671 741Q526 577 494 509T454 320ZM440 196Q487 196 519 164T552 84Q552 38 519 6T440 -27Q394 -27 362 5T329 84Q329 131 361 163T440 196Z" />
<glyph unicode="@" glyph-name="at" horiz-adv-x="1886" d="M1408 958L1291 559Q1226 335 1212 275T1198 179Q1198 147 1219 125T1273 103Q1346 103 1448 176T1624 413T1697 755Q1697 926 1615 1071T1382 1293T1049 1371Q818 1371 620 1249T307 896T191 418Q191
188 292 0T578 -284T974 -381Q1237 -381 1449 -240T1778 172H1836Q1746 -102 1509 -272T969 -442Q731 -442 527 -330T210 -11T97 444Q97 708 221 936T568 1293T1043 1422Q1250 1422 1416 1337T1670 1087T1757 737Q1757 554 1676 375T1468 113T1205 31Q1129 31 1091
67T1052 168Q1052 224 1070 315Q922 136 833 83T676 30Q605 30 550 93T495 263Q495 408 589 588T840 881Q955 964 1046 964Q1113 964 1157 930T1218 826L1251 936L1408 958ZM1057 917Q982 917 905 838Q792 722 712 525Q653 381 653 293Q653 230 688 191T768 151Q826
151 890 195T1024 330T1126 514Q1182 673 1182 773Q1182 839 1146 878T1057 917Z" />
<glyph unicode="A" glyph-name="A" horiz-adv-x="1479" d="M937 454H412L320 240Q286 161 286 122Q286 91 315 68T443 37V0H16V37Q101 52 126 76Q177 124 239 271L716 1387H751L1223 259Q1280 123 1326 83T1456 37V0H921V37Q1002 41 1030 64T1059 120Q1059 164
1019 259L937 454ZM909 528L679 1076L443 528H909Z" />
<glyph unicode="B" glyph-name="B" horiz-adv-x="1366" d="M946 692Q1087 662 1157 596Q1254 504 1254 371Q1254 270 1190 178T1015 43T674 0H34V37H85Q170 37 207 91Q230 126 230 240V1116Q230 1242 201 1275Q162 1319 85 1319H34V1356H620Q784 1356 883 1332Q1033
1296 1112 1205T1191 994Q1191 892 1129 812T946 692ZM422 746Q459 739 506 736T611 732Q757 732 830 763T943 860T982 1002Q982 1121 885 1205T602 1289Q502 1289 422 1267V746ZM422 98Q538 71 651 71Q832 71 927 152T1022 354Q1022 433 979 506T839 621T599 663Q537
663 493 661T422 654V98Z" />
<glyph unicode="C" glyph-name="C" horiz-adv-x="1366" d="M1233 1387L1264 926H1233Q1171 1133 1056 1224T780 1315Q645 1315 536 1247T365 1028T302 655Q302 471 361 336T538 129T809 57Q941 57 1042 113T1264 338L1295 318Q1193 137 1057 53T734 -31Q397 -31
212 219Q74 405 74 657Q74 860 165 1030T415 1293T764 1387Q911 1387 1054 1315Q1096 1293 1114 1293Q1141 1293 1161 1312Q1187 1339 1198 1387H1233Z" />
<glyph unicode="D" glyph-name="D" horiz-adv-x="1479" d="M35 0V37H86Q172 37 208 92Q230 125 230 240V1116Q230 1243 202 1275Q163 1319 86 1319H35V1356H587Q891 1356 1049 1287T1304 1057T1401 685Q1401 402 1229 212Q1036 0 641 0H35ZM422 98Q549 70 635
70Q867 70 1020 233T1173 675Q1173 956 1020 1118T627 1280Q537 1280 422 1251V98Z" />
<glyph unicode="E" glyph-name="E" horiz-adv-x="1251" d="M428 1282V746H726Q842 746 881 781Q933 827 939 943H976V471H939Q925 570 911 598Q893 633 852 653T726 673H428V226Q428 136 436 117T464 86T540 74H770Q885 74 937 90T1037 153Q1099 215 1164 340H1204L1087
0H42V37H90Q138 37 181 60Q213 76 224 108T236 239V1120Q236 1249 210 1279Q174 1319 90 1319H42V1356H1087L1102 1059H1063Q1042 1166 1017 1206T941 1267Q901 1282 800 1282H428Z" />
<glyph unicode="F" glyph-name="F" horiz-adv-x="1139" d="M419 1282V749H666Q751 749 790 786T843 935H880V476H843Q842 555 823 592T769 647T666 666H419V240Q419 137 432 104Q442 79 474 61Q518 37 566 37H615V0H33V37H81Q165 37 203 86Q227 118 227 240V1116Q227
1219 214 1252Q204 1277 173 1295Q130 1319 81 1319H33V1356H1042L1055 1058H1020Q994 1153 960 1197T875 1262T718 1282H419Z" />
<glyph unicode="G" glyph-name="G" horiz-adv-x="1479" d="M1257 1387L1292 959H1257Q1204 1119 1120 1200Q999 1317 809 1317Q550 1317 415 1112Q302 939 302 700Q302 506 377 346T573 112T823 37Q898 37 968 56T1103 112V504Q1103 606 1088 637T1040 685T925
702V740H1450V702H1425Q1347 702 1318 650Q1298 613 1298 504V89Q1183 27 1071 -2T822 -31Q429 -31 225 221Q72 410 72 657Q72 836 158 1000Q260 1195 438 1300Q587 1387 790 1387Q864 1387 924 1375T1096 1322Q1152 1301 1171 1301Q1190 1301 1203 1318T1220 1387H1257Z"
/>
<glyph unicode="H" glyph-name="H" horiz-adv-x="1479" d="M421 727H1051V1115Q1051 1219 1038 1252Q1028 1277 996 1295Q953 1319 905 1319H857V1356H1437V1319H1389Q1341 1319 1298 1296Q1266 1280 1255 1248T1243 1115V240Q1243 137 1256 104Q1266 79 1297
61Q1341 37 1389 37H1437V0H857V37H905Q988 37 1026 86Q1051 118 1051 240V653H421V240Q421 137 434 104Q444 79 476 61Q519 37 567 37H616V0H35V37H83Q167 37 205 86Q229 118 229 240V1115Q229 1219 216 1252Q206 1277 175 1295Q131 1319 83 1319H35V1356H616V1319H567Q519
1319 476 1296Q445 1280 433 1248T421 1115V727Z" />
<glyph unicode="I" glyph-name="I" horiz-adv-x="682" d="M632 37V0H51V37H99Q183 37 221 86Q245 118 245 240V1116Q245 1219 232 1252Q222 1277 191 1295Q147 1319 99 1319H51V1356H632V1319H583Q500 1319 462 1270Q437 1238 437 1116V240Q437 137 450 104Q460
79 492 61Q535 37 583 37H632Z" />
<glyph unicode="J" glyph-name="J" horiz-adv-x="797" d="M204 1319V1356H785V1319H736Q653 1319 615 1270Q591 1238 591 1116V453Q591 300 558 205T442 40T244 -31Q150 -31 96 15T42 122Q42 171 67 196Q100 227 144 227Q176 227 201 206T266 94Q289 40 325 40Q352
40 375 73T399 190V1116Q399 1219 386 1252Q376 1277 344 1295Q301 1319 253 1319H204Z" />
<glyph unicode="K" glyph-name="K" horiz-adv-x="1479" d="M612 752L1112 255Q1235 132 1322 88T1496 37V0H851V37Q909 37 934 56T960 100Q960 124 951 143T888 214L420 677V240Q420 137 433 104Q443 79 475 61Q518 37 566 37H612V0H34V37H82Q166 37 204 86Q228
118 228 240V1116Q228 1219 215 1253Q205 1277 174 1295Q130 1319 82 1319H34V1356H612V1319H566Q519 1319 475 1296Q444 1280 432 1248T420 1116V701Q440 720 557 828Q854 1100 916 1191Q943 1231 943 1261Q943 1284 922 1301T851 1319H820V1356H1318V1319Q1274
1318 1238 1307T1150 1265T1022 1163Q1000 1143 819 958L612 752Z" />
<glyph unicode="L" glyph-name="L" horiz-adv-x="1251" d="M1174 375L1207 368L1091 0H41V37H92Q178 37 215 93Q236 125 236 241V1116Q236 1243 208 1275Q169 1319 92 1319H41V1356H655V1319Q547 1320 504 1299T444 1246T428 1093V241Q428 158 444 127Q456 106
481 96T637 86H736Q892 86 955 109T1070 190T1174 375Z" />
<glyph unicode="M" glyph-name="M" horiz-adv-x="1821" d="M838 0L314 1141V235Q314 110 341 79Q378 37 458 37H506V0H34V37H82Q168 37 204 89Q226 121 226 235V1121Q226 1211 206 1251Q192 1280 155 1299T34 1319V1356H418L910 295L1394 1356H1778V1319H1731Q1644
1319 1608 1267Q1586 1235 1586 1121V235Q1586 110 1614 79Q1651 37 1731 37H1778V0H1202V37H1250Q1337 37 1372 89Q1394 121 1394 235V1141L871 0H838Z" />
<glyph unicode="N" glyph-name="N" horiz-adv-x="1479" d="M-27 1356H341L1170 339V1121Q1170 1246 1142 1277Q1105 1319 1025 1319H978V1356H1450V1319H1402Q1316 1319 1280 1267Q1258 1235 1258 1121V-22H1222L328 1070V235Q328 110 355 79Q393 37 472 37H520V0H48V37H95Q182
37 218 89Q240 121 240 235V1178Q181 1247 151 1269T61 1310Q32 1319 -27 1319V1356Z" />
<glyph unicode="O" glyph-name="O" horiz-adv-x="1479" d="M749 1387Q1013 1387 1206 1187T1400 686Q1400 377 1205 173T733 -31Q453 -31 263 168T72 683Q72 1006 292 1210Q483 1387 749 1387ZM730 1314Q548 1314 438 1179Q301 1011 301 687Q301 355 443 176Q552
40 731 40Q922 40 1046 189T1171 659Q1171 1007 1034 1178Q924 1314 730 1314Z" />
<glyph unicode="P" glyph-name="P" horiz-adv-x="1139" d="M420 635V240Q420 112 448 81Q486 37 563 37H615V0H34V37H85Q171 37 208 93Q228 124 228 240V1116Q228 1244 201 1275Q162 1319 85 1319H34V1356H531Q713 1356 818 1319T995 1192T1067 981Q1067 815 958
711T648 607Q599 607 542 614T420 635ZM420 692Q473 682 514 677T584 672Q688 672 763 752T839 961Q839 1049 803 1124T701 1237T551 1275Q500 1275 420 1256V692Z" />
<glyph unicode="Q" glyph-name="Q" horiz-adv-x="1479" d="M902 -15Q1004 -191 1122 -274T1392 -369V-401Q1254 -396 1097 -346T800 -206T557 -15Q413 43 329 108Q207 205 140 346T72 681Q72 985 269 1186T746 1387Q1012 1387 1206 1186T1401 677Q1401 428 1263
240T902 -15ZM734 1310Q552 1310 441 1180Q301 1017 301 681Q301 352 443 174Q553 37 734 37Q922 37 1037 174Q1172 336 1172 652Q1172 895 1098 1061Q1041 1189 947 1249T734 1310Z" />
<glyph unicode="R" glyph-name="R" horiz-adv-x="1366" d="M1384 0H1022L563 634Q512 632 480 632Q467 632 452 632T421 634V240Q421 112 449 81Q487 37 563 37H616V0H35V37H86Q172 37 209 93Q230 124 230 240V1116Q230 1244 202 1275Q163 1319 86 1319H35V1356H529Q745
1356 847 1325T1021 1209T1093 1007Q1093 882 1012 790T759 660L1039 271Q1135 137 1204 93T1384 37V0ZM421 697Q440 697 454 697T477 696Q671 696 769 780T868 994Q868 1121 789 1200T578 1280Q520 1280 421 1261V697Z" />
<glyph unicode="S" glyph-name="S" horiz-adv-x="1139" d="M939 1387V918H902Q884 1053 838 1133T705 1260T527 1307Q423 1307 355 1244T287 1099Q287 1037 330 986Q392 911 625 786Q815 684 884 630T991 501T1029 346Q1029 192 910 81T602 -31Q543 -31 491 -22Q460
-17 363 14T239 46Q214 46 200 31T178 -31H141V434H178Q204 288 248 216T382 95T581 47Q706 47 778 113T851 269Q851 319 824 370T738 465Q699 495 525 592T278 748T166 876T128 1030Q128 1176 240 1281T525 1387Q633 1387 754 1334Q810 1309 833 1309Q859 1309
875 1324T902 1387H939Z" />
<glyph unicode="T" glyph-name="T" horiz-adv-x="1251" d="M1185 1356L1200 1038H1162Q1151 1122 1132 1158Q1101 1216 1050 1243T914 1271H723V235Q723 110 750 79Q788 37 867 37H914V0H339V37H387Q473 37 509 89Q531 121 531 235V1271H368Q273 1271 233 1257Q181
1238 144 1184T100 1038H62L78 1356H1185Z" />
<glyph unicode="U" glyph-name="U" horiz-adv-x="1479" d="M977 1319V1356H1457V1319H1406Q1326 1319 1283 1252Q1262 1221 1262 1108V558Q1262 354 1222 242T1063 49T740 -32Q518 -32 403 45T240 252Q208 341 208 586V1116Q208 1241 174 1280T62 1319H11V1356H597V1319H545Q461
1319 425 1266Q400 1230 400 1116V525Q400 446 414 344T467 185T576 91T752 54Q885 54 990 112T1133 260T1172 567V1116Q1172 1243 1144 1275Q1105 1319 1028 1319H977Z" />
<glyph unicode="V" glyph-name="V" horiz-adv-x="1479" d="M1454 1356V1319Q1382 1306 1345 1273Q1292 1224 1251 1123L778 -31H741L233 1138Q194 1228 178 1248Q153 1279 117 1296T18 1319V1356H572V1319Q478 1310 450 1287T422 1228Q422 1178 468 1072L813 277L1133
1062Q1180 1178 1180 1223Q1180 1252 1151 1278T1053 1316Q1048 1317 1036 1319V1356H1454Z" />
<glyph unicode="W" glyph-name="W" horiz-adv-x="1933" d="M1917 1356V1319Q1864 1319 1831 1300T1768 1229Q1748 1194 1705 1062L1327 -31H1287L978 836L671 -31H635L232 1095Q187 1221 175 1244Q155 1282 121 1300T27 1319V1356H529V1319H505Q452 1319 424 1295T396
1237Q396 1202 440 1076L707 315L932 962L892 1076L860 1167Q839 1217 813 1255Q800 1274 781 1287Q756 1305 731 1313Q712 1319 671 1319V1356H1199V1319H1163Q1107 1319 1081 1295T1055 1230Q1055 1179 1100 1052L1360 315L1618 1062Q1662 1186 1662 1234Q1662
1257 1648 1277T1611 1305Q1573 1319 1512 1319V1356H1917Z" />
<glyph unicode="X" glyph-name="X" horiz-adv-x="1479" d="M836 751L1127 317Q1248 137 1306 90T1455 37V0H873V37Q931 38 959 49Q980 58 993 76T1007 114Q1007 137 998 160Q991 177 943 248L713 596L429 232Q384 174 375 155T366 114Q366 82 393 61T496 37V0H15V37Q66
42 103 58Q165 84 221 128T349 263L669 667L402 1058Q293 1217 217 1266T42 1319V1356H669V1319Q589 1316 560 1293T530 1242Q530 1205 578 1134L786 823L1027 1128Q1069 1182 1078 1202T1088 1243Q1088 1264 1076 1280Q1061 1301 1038 1309T943 1319V1356H1424V1319Q1367
1316 1331 1301Q1277 1278 1232 1239T1105 1095L836 751Z" />
<glyph unicode="Y" glyph-name="Y" horiz-adv-x="1479" d="M976 1356H1449V1319H1423Q1397 1319 1347 1296T1256 1230T1155 1090L828 575V235Q828 110 856 79Q894 37 976 37H1020V0H444V37H492Q578 37 614 89Q636 121 636 235V556L264 1124Q198 1224 175 1249T77
1309Q57 1319 19 1319V1356H599V1319H569Q522 1319 483 1297T443 1231Q443 1195 504 1101L787 664L1053 1082Q1113 1176 1113 1222Q1113 1250 1099 1272T1057 1306T976 1319V1356Z" />
<glyph unicode="Z" glyph-name="Z" horiz-adv-x="1251" d="M1178 1356L287 82H843Q971 82 1039 138T1161 365L1194 359L1130 0H26V37L896 1275H462Q354 1275 306 1252T232 1184T185 1017H147L175 1356H1178Z" />
<glyph unicode="[" glyph-name="bracketleft" horiz-adv-x="682" d="M608 -406H168V1387H608V1308H318V-328H608V-406Z" />
<glyph unicode="\" glyph-name="backslash" horiz-adv-x="569" d="M83 1422L573 -28H493L3 1422H83Z" />
<glyph unicode="]" glyph-name="bracketright" horiz-adv-x="682" d="M75 1387H515V-407H75V-328H365V1308H75V1387Z" />
<glyph unicode="^" glyph-name="asciicircum" horiz-adv-x="961" d="M498 1384L923 667H831L481 1253L131 667H37L468 1384H498Z" />
<glyph unicode="_" glyph-name="underscore" horiz-adv-x="1024" d="M1042 -442H-17V-358H1042V-442Z" />
<glyph unicode="`" glyph-name="grave" horiz-adv-x="682" d="M118 1390H341L447 1045H412L118 1390Z" />
<glyph unicode="a" glyph-name="a" horiz-adv-x="909" d="M583 132Q442 23 406 6Q352 -19 291 -19Q196 -19 135 46T73 217Q73 284 103 333Q144 401 245 461T583 607V643Q583 780 540 831T413 882Q350 882 313 848Q275 814 275 770L277 712Q277 666 254 641T192
616Q155 616 132 642T108 713Q108 799 196 871T443 943Q565 943 643 902Q702 871 730 805Q748 762 748 629V318Q748 187 753 158T769 118T796 108Q812 108 824 115Q845 128 905 188V132Q793 -18 691 -18Q642 -18 613 16T583 132ZM583 197V546Q432 486 388 461Q309
417 275 369T241 264Q241 192 284 145T383 97Q459 97 583 197Z" />
<glyph unicode="b" glyph-name="b" horiz-adv-x="1024" d="M315 758Q448 943 602 943Q743 943 848 823T953 493Q953 249 791 100Q652 -28 481 -28Q401 -28 319 1T150 88V1037Q150 1193 143 1229T119 1278T79 1291Q51 1291 9 1275L-5 1310L270 1422H315V758ZM315
694V146Q366 96 420 71T532 45Q623 45 701 145T780 436Q780 612 702 706T523 801Q470 801 417 774Q377 754 315 694Z" />
<glyph unicode="c" glyph-name="c" horiz-adv-x="909" d="M842 348Q805 167 697 70T458 -28Q302 -28 186 103T70 457Q70 673 198 808T507 943Q642 943 729 872T816 723Q816 685 792 662T723 638Q664 638 634 676Q617 697 612 756T571 846Q536 876 474 876Q374
876 313 802Q232 704 232 543Q232 379 312 254T530 128Q628 128 706 195Q761 241 813 362L842 348Z" />
<glyph unicode="d" glyph-name="d" horiz-adv-x="1024" d="M711 103Q644 33 580 3T442 -28Q292 -28 180 97T68 420Q68 617 192 780T511 944Q632 944 711 867V1036Q711 1193 704 1229T680 1278T640 1291Q614 1291 571 1275L558 1310L831 1422H876V363Q876 202 883
167T907 117T946 103Q973 103 1018 120L1029 85L757 -28H711V103ZM711 173V645Q705 713 675 769T596 853T499 882Q411 882 342 803Q251 699 251 499Q251 297 339 190T535 82Q626 82 711 173Z" />
<glyph unicode="e" glyph-name="e" horiz-adv-x="909" d="M218 571Q217 367 317 251Q417 135 552 135Q642 135 708 184T820 354L851 334Q830 197 729 85T476 -28Q311 -28 194 100T76 446Q76 681 196 812T499 944Q653 944 752 843T851 571H218ZM218 629H642Q637
717 621 753Q596 809 547 841T443 873Q360 873 295 809T218 629Z" />
<glyph unicode="f" glyph-name="f" horiz-adv-x="682" d="M422 844V242Q422 114 450 80Q487 36 549 36H632V0H85V36H126Q166 36 199 56T244 110T257 242V844H79V916H257V976Q257 1113 301 1208T435 1361T639 1420Q744 1420 832 1352Q890 1307 890 1251Q890 1221
864 1195T808 1168Q785 1168 760 1184T697 1255T629 1329Q598 1348 560 1348Q514 1348 482 1324T436 1248T422 982V916H658V844H422Z" />
<glyph unicode="g" glyph-name="g" horiz-adv-x="1024" d="M309 334Q225 375 180 448T135 611Q135 747 237 845T500 943Q631 943 727 879H921Q964 879 971 877T981 868Q987 859 987 836Q987 810 982 800Q979 795 972 792T921 789H802Q858 717 858 605Q858 477
760 386T497 295Q429 295 358 315Q314 277 299 249T283 200Q283 183 299 167T364 144Q392 140 504 137Q710 132 771 123Q864 110 919 54T975 -84Q975 -197 869 -296Q713 -442 462 -442Q269 -442 136 -355Q61 -305 61 -251Q61 -227 72 -203Q89 -166 142 -100Q149
-91 244 8Q192 39 171 63T149 119Q149 154 177 201T309 334ZM483 895Q409 895 359 836T309 655Q309 497 377 410Q429 344 509 344Q585 344 634 401T683 580Q683 739 614 829Q563 895 483 895ZM299 0Q252 -51 228 -95T204 -176Q204 -224 262 -260Q362 -322 551 -322Q731
-322 816 -259T902 -123Q902 -71 851 -49Q799 -27 645 -23Q420 -17 299 0Z" />
<glyph unicode="h" glyph-name="h" horiz-adv-x="1024" d="M333 1422V752Q444 874 509 908T639 943Q717 943 773 900T856 765Q875 701 875 531V207Q875 120 889 88Q899 64 923 50T1011 36V0H561V36H582Q646 36 671 55T706 113Q709 129 709 207V531Q709 681 694
728T644 798T562 822Q513 822 460 796T333 691V207Q333 113 343 90T382 52T481 36V0H27V36Q88 36 123 55Q143 65 155 93T167 207V1036Q167 1193 160 1229T137 1278T95 1291Q74 1291 27 1275L13 1310L287 1422H333Z" />
<glyph unicode="i" glyph-name="i" horiz-adv-x="569" d="M297 1422Q339 1422 368 1393T398 1321Q398 1279 369 1249T297 1219Q255 1219 225 1249T195 1321Q195 1363 224 1392T297 1422ZM380 943V207Q380 121 392 93T429 50T519 36V0H74V36Q141 36 164 49T200
92T214 207V560Q214 709 205 753Q198 785 183 797T142 810Q114 810 74 795L60 831L336 943H380Z" />
<glyph unicode="j" glyph-name="j" horiz-adv-x="569" d="M296 1423Q339 1423 369 1393T399 1320Q399 1278 369 1248T296 1218Q254 1218 224 1248T194 1320Q194 1363 224 1393T296 1423ZM382 943V21Q382 -214 282 -328T22 -442Q-69 -442 -113 -409T-157 -341Q-157
-306 -133 -281T-75 -256Q-49 -256 -22 -269Q-5 -276 43 -319T125 -363Q149 -363 172 -345T206 -283T217 -94V558Q217 709 208 752Q201 785 186 797T145 810Q117 810 77 795L63 831L339 943H382Z" />
<glyph unicode="k" glyph-name="k" horiz-adv-x="1024" d="M335 1422V510L568 723Q642 791 654 809Q662 821 662 833Q662 853 646 867T591 884V916H989V884Q907 882 853 859T733 777L498 560L733 263Q831 140 865 107Q913 60 949 46Q974 36 1036 36V0H591V36Q629
37 642 47T656 77Q656 100 616 151L335 510V206Q335 117 347 89T383 49T483 36V0H17V36Q87 36 122 53Q143 64 154 87Q169 120 169 201V1035Q169 1194 162 1229T139 1278T97 1292Q76 1292 34 1275L17 1310L289 1422H335Z" />
<glyph unicode="l" glyph-name="l" horiz-adv-x="569" d="M379 1422V207Q379 121 391 93T430 51T527 36V0H78V36Q141 36 164 49T200 92T213 207V1039Q213 1194 206 1229T184 1278T144 1291Q118 1291 78 1275L61 1310L334 1422H379Z" />
<glyph unicode="m" glyph-name="m" horiz-adv-x="1593" d="M336 748Q436 848 454 863Q499 901 551 922T654 943Q740 943 802 893T885 748Q988 868 1059 905T1205 943Q1278 943 1334 906T1424 783Q1446 725 1446 601V207Q1446 121 1459 89Q1469 67 1496 52T1584
36V0H1132V36H1151Q1210 36 1243 59Q1266 75 1276 110Q1280 127 1280 207V601Q1280 713 1253 759Q1214 823 1128 823Q1075 823 1022 797T892 698L890 687L892 644V207Q892 113 902 90T942 52T1041 36V0H578V36Q654 36 682 54T722 108Q727 125 727 207V601Q727 713
694 762Q650 826 571 826Q517 826 464 797Q381 753 336 698V207Q336 117 348 90T385 50T485 36V0H32V36Q95 36 120 49T158 92T171 207V557Q171 708 162 752Q155 785 140 797T99 810Q71 810 32 795L17 831L293 943H336V748Z" />
<glyph unicode="n" glyph-name="n" horiz-adv-x="1024" d="M331 749Q492 943 638 943Q713 943 767 906T853 782Q875 722 875 598V207Q875 120 889 89Q900 64 924 50T1015 36V0H562V36H581Q645 36 670 55T706 113Q710 128 710 207V582Q710 707 678 763T568 820Q449
820 331 690V207Q331 114 342 92Q356 63 380 50T480 36V0H27V36H47Q117 36 141 71T166 207V547Q166 712 159 748T136 797T94 810Q66 810 27 795L12 831L288 943H331V749Z" />
<glyph unicode="o" glyph-name="o" horiz-adv-x="1024" d="M512 943Q720 943 846 785Q953 650 953 475Q953 352 894 226T732 36T501 -28Q294 -28 172 137Q69 276 69 449Q69 575 131 699T296 883T512 943ZM481 878Q428 878 375 847T288 736T255 533Q255 333 334
188T544 43Q641 43 704 123T767 398Q767 642 662 782Q591 878 481 878Z" />
<glyph unicode="p" glyph-name="p" horiz-adv-x="1024" d="M-2 825L280 939H318V725Q389 846 460 894T611 943Q749 943 841 835Q954 703 954 491Q954 254 818 99Q706 -28 536 -28Q462 -28 408 -7Q368 8 318 53V-226Q318 -320 329 -345T369 -386T473 -401V-438H-7V-401H18Q73
-402 112 -380Q131 -369 141 -345T152 -220V646Q152 735 144 759T119 795T71 807Q47 807 10 793L-2 825ZM318 666V324Q318 213 327 178Q341 120 395 76T533 32Q633 32 695 110Q776 212 776 397Q776 607 684 720Q620 798 532 798Q484 798 437 774Q401 756 318 666Z"
/>
<glyph unicode="q" glyph-name="q" horiz-adv-x="1024" d="M875 943V-235Q875 -323 887 -348T924 -387T1024 -401V-438H562V-401H581Q637 -401 666 -385Q686 -374 698 -346T710 -235V159Q619 51 551 12T410 -28Q277 -28 173 93T68 417Q68 650 206 796T539 943Q596
943 644 927T730 879Q788 907 841 943H875ZM710 222V652Q710 727 691 770T621 843T508 873Q396 873 316 778T236 490Q236 305 317 209T514 113Q573 113 619 138T710 222Z" />
<glyph unicode="r" glyph-name="r" horiz-adv-x="682" d="M332 943V737Q447 943 568 943Q623 943 659 910T695 832Q695 793 669 766T607 739Q572 739 529 773T464 808Q446 808 425 788Q380 747 332 653V214Q332 138 351 99Q364 72 397 54T492 36V0H23V36Q93 36
127 58Q152 74 162 109Q167 126 167 206V561Q167 721 161 751T137 796T93 810Q62 810 23 795L13 831L290 943H332Z" />
<glyph unicode="s" glyph-name="s" horiz-adv-x="797" d="M656 943V631H623Q585 778 526 831T374 884Q304 884 261 847T218 765Q218 709 250 669Q281 628 376 582L522 511Q725 412 725 250Q725 125 631 49T419 -28Q335 -28 227 2Q194 12 173 12Q150 12 137 -14H104V313H137Q165
173 244 102T421 31Q490 31 533 71T577 169Q577 238 529 285T335 404T145 534Q100 591 100 678Q100 791 177 867T378 943Q432 943 509 920Q560 905 577 905Q593 905 602 912T623 943H656Z" />
<glyph unicode="t" glyph-name="t" horiz-adv-x="569" d="M330 1217V916H544V846H330V252Q330 163 355 132T421 101Q454 101 485 121T533 182H572Q537 84 473 35T341 -15Q295 -15 251 10T186 83T165 230V846H20V879Q75 901 132 953T235 1078Q258 1116 299 1217H330Z" />
<glyph unicode="u" glyph-name="u" horiz-adv-x="1024" d="M867 916V361Q867 202 874 167T898 117T937 103Q968 103 1007 120L1021 85L747 -28H702V166Q584 38 522 5T391 -28Q314 -28 258 16T179 131T157 329V738Q157 803 143 828T102 866T2 879V916H323V303Q323
175 367 135T475 95Q518 95 572 122T702 225V744Q702 822 674 849T555 879V916H867Z" />
<glyph unicode="v" glyph-name="v" horiz-adv-x="1024" d="M17 916H448V879H420Q381 879 361 860T340 809Q340 774 361 726L574 220L788 745Q811 801 811 830Q811 844 803 853Q792 868 775 873T706 879V916H1005V879Q953 875 933 858Q898 828 870 758L545 -28H504L177
745Q155 799 135 822T84 862Q67 871 17 879V916Z" />
<glyph unicode="w" glyph-name="w" horiz-adv-x="1479" d="M13 916H397V879Q344 875 328 860T311 817Q311 786 328 742L524 215L721 644L669 779Q645 839 606 862Q584 876 524 879V916H960V879Q888 876 858 853Q838 837 838 802Q838 782 846 761L1054 235L1247
742Q1267 796 1267 828Q1267 847 1248 862T1171 879V916H1460V879Q1373 866 1332 761L1026 -28H985L756 557L489 -28H452L158 742Q129 815 101 840T13 879V916Z" />
<glyph unicode="x" glyph-name="x" horiz-adv-x="1024" d="M27 916H458V879Q417 879 401 865T384 828Q384 804 419 754Q430 738 452 704L517 600L592 704Q664 803 664 829Q664 850 647 864T592 879V916H902V879Q853 876 817 852Q768 818 683 704L558 537L786 209Q870
88 906 64T999 36V0H567V36Q612 36 637 56Q656 70 656 93Q656 116 592 209L458 405L311 209Q243 118 243 101Q243 77 265 58T333 36V0H34V36Q70 41 97 61Q135 90 225 209L417 464L243 716Q169 824 129 851T27 879V916Z" />
<glyph unicode="y" glyph-name="y" horiz-adv-x="1024" d="M12 916H439V879H418Q373 879 351 860T328 811Q328 772 361 703L584 241L789 747Q806 788 806 828Q806 846 799 855Q791 866 774 872T714 879V916H1012V879Q975 875 955 863T911 818Q902 804 877 741L504
-173Q450 -306 363 -374T194 -442Q135 -442 97 -408T59 -330Q59 -288 86 -263T162 -237Q195 -237 252 -259Q292 -274 302 -274Q332 -274 367 -243T439 -123L504 36L175 727Q160 758 127 804Q102 839 86 851Q63 867 12 879V916Z" />
<glyph unicode="z" glyph-name="z" horiz-adv-x="909" d="M860 281L849 0H41V36L649 846H349Q252 846 222 834T173 786Q146 736 142 662H102L108 916H876V879L262 67H596Q701 67 738 84T799 146Q815 178 826 281H860Z" />
<glyph unicode="{" glyph-name="braceleft" horiz-adv-x="983" d="M841 -407V-442Q674 -419 570 -307T465 -57Q465 15 488 110T511 259Q511 331 451 393T283 470V511Q390 525 450 587T511 722Q511 775 488 870T465 1038Q465 1174 569 1287T841 1422V1387Q724 1359
670 1296T615 1156Q615 1097 637 1001T660 836Q660 735 586 640T365 493Q509 440 584 343T660 145Q660 77 638 -19T615 -175Q615 -251 669 -314T841 -407Z" />
<glyph unicode="|" glyph-name="bar" horiz-adv-x="410" d="M244 1422V-442H161V1422H244Z" />
<glyph unicode="}" glyph-name="braceright" horiz-adv-x="983" d="M177 1387V1422Q344 1400 448 1288T553 1037Q553 965 530 870T507 722Q507 650 567 588T735 511V470Q628 456 568 394T507 259Q507 206 530 111T553 -57Q553 -193 449 -306T177 -442V-407Q294
-378 348 -315T403 -175Q403 -116 380 -20T357 144Q357 246 431 341T653 488Q509 541 433 638T357 836Q357 904 380 1000T403 1156Q403 1232 349 1295T177 1387Z" />
<glyph unicode="~" glyph-name="asciitilde" horiz-adv-x="1108" d="M1066 675H1111Q1107 545 1037 472T866 398Q820 398 767 413T493 519Q339 583 274 583Q204 583 156 540T88 400H44Q50 535 118 606T278 678Q322 678 368 664Q472 634 641 562T880 489Q955 489
1006 537T1066 675Z" />
<hkern g1="space" g2="A" k="113" />
<hkern g1="space" g2="T" k="37" />
<hkern g1="space" g2="V" k="37" />
<hkern g1="space" g2="W" k="37" />
<hkern g1="space" g2="Y" k="76" />
<hkern g1="space" g2="Alphatonos" k="113" />
<hkern g1="space" g2="Alpha" k="113" />
<hkern g1="space" g2="Delta" k="113" />
<hkern g1="space" g2="Lambda" k="113" />
<hkern g1="space" g2="Tau" k="37" />
<hkern g1="space" g2="Upsilon" k="76" />
<hkern g1="space" g2="Upsilondieresis" k="76" />
<hkern g1="one" g2="one" k="76" />
<hkern g1="A" g2="space" k="113" />
<hkern g1="A" g2="T" k="227" />
<hkern g1="A" g2="V" k="264" />
<hkern g1="A" g2="W" k="164" />
<hkern g1="A" g2="Y" k="188" />
<hkern g1="A" g2="v" k="152" />
<hkern g1="A" g2="w" k="188" />
<hkern g1="A" g2="y" k="188" />
<hkern g1="A" g2="quoteright" k="227" />
<hkern g1="F" g2="comma" k="164" />
<hkern g1="F" g2="period" k="164" />
<hkern g1="F" g2="A" k="152" />
<hkern g1="L" g2="space" k="76" />
<hkern g1="L" g2="T" k="188" />
<hkern g1="L" g2="V" k="188" />
<hkern g1="L" g2="W" k="152" />
<hkern g1="L" g2="Y" k="205" />
<hkern g1="L" g2="y" k="113" />
<hkern g1="L" g2="quoteright" k="188" />
<hkern g1="P" g2="space" k="76" />
<hkern g1="P" g2="comma" k="227" />
<hkern g1="P" g2="period" k="227" />
<hkern g1="P" g2="A" k="188" />
<hkern g1="R" g2="T" k="123" />
<hkern g1="R" g2="V" k="164" />
<hkern g1="R" g2="W" k="113" />
<hkern g1="R" g2="Y" k="113" />
<hkern g1="R" g2="y" k="82" />
<hkern g1="T" g2="space" k="37" />
<hkern g1="T" g2="comma" k="152" />
<hkern g1="T" g2="hyphen" k="188" />
<hkern g1="T" g2="period" k="152" />
<hkern g1="T" g2="colon" k="102" />
<hkern g1="T" g2="semicolon" k="113" />
<hkern g1="T" g2="A" k="164" />
<hkern g1="T" g2="O" k="37" />
<hkern g1="T" g2="a" k="143" />
<hkern g1="T" g2="c" k="143" />
<hkern g1="T" g2="e" k="143" />
<hkern g1="T" g2="i" k="72" />
<hkern g1="T" g2="o" k="143" />
<hkern g1="T" g2="r" k="72" />
<hkern g1="T" g2="s" k="143" />
<hkern g1="T" g2="u" k="72" />
<hkern g1="T" g2="w" k="143" />
<hkern g1="T" g2="y" k="143" />
<hkern g1="V" g2="space" k="37" />
<hkern g1="V" g2="comma" k="264" />
<hkern g1="V" g2="hyphen" k="188" />
<hkern g1="V" g2="period" k="264" />
<hkern g1="V" g2="colon" k="152" />
<hkern g1="V" g2="semicolon" k="152" />
<hkern g1="V" g2="A" k="264" />
<hkern g1="V" g2="a" k="227" />
<hkern g1="V" g2="e" k="227" />
<hkern g1="V" g2="i" k="123" />
<hkern g1="V" g2="o" k="264" />
<hkern g1="V" g2="r" k="123" />
<hkern g1="V" g2="u" k="123" />
<hkern g1="V" g2="y" k="227" />
<hkern g1="W" g2="space" k="37" />
<hkern g1="W" g2="comma" k="188" />
<hkern g1="W" g2="hyphen" k="113" />
<hkern g1="W" g2="period" k="188" />
<hkern g1="W" g2="colon" k="76" />
<hkern g1="W" g2="semicolon" k="76" />
<hkern g1="W" g2="A" k="227" />
<hkern g1="W" g2="a" k="164" />
<hkern g1="W" g2="e" k="164" />
<hkern g1="W" g2="i" k="82" />
<hkern g1="W" g2="o" k="164" />
<hkern g1="W" g2="r" k="82" />
<hkern g1="W" g2="u" k="82" />
<hkern g1="W" g2="y" k="123" />
<hkern g1="Y" g2="space" k="76" />
<hkern g1="Y" g2="comma" k="264" />
<hkern g1="Y" g2="hyphen" k="227" />
<hkern g1="Y" g2="period" k="264" />
<hkern g1="Y" g2="colon" k="188" />
<hkern g1="Y" g2="semicolon" k="188" />
<hkern g1="Y" g2="A" k="227" />
<hkern g1="Y" g2="a" k="205" />
<hkern g1="Y" g2="e" k="205" />
<hkern g1="Y" g2="i" k="113" />
<hkern g1="Y" g2="o" k="205" />
<hkern g1="Y" g2="p" k="188" />
<hkern g1="Y" g2="q" k="227" />
<hkern g1="Y" g2="u" k="227" />
<hkern g1="Y" g2="v" k="205" />
<hkern g1="f" g2="f" k="37" />
<hkern g1="f" g2="quoteright" k="-113" />
<hkern g1="r" g2="comma" k="82" />
<hkern g1="r" g2="hyphen" k="41" />
<hkern g1="r" g2="period" k="113" />
<hkern g1="r" g2="g" k="37" />
<hkern g1="r" g2="quoteright" k="-76" />
<hkern g1="v" g2="comma" k="133" />
<hkern g1="v" g2="period" k="133" />
<hkern g1="w" g2="comma" k="133" />
<hkern g1="w" g2="period" k="133" />
<hkern g1="y" g2="comma" k="133" />
<hkern g1="y" g2="period" k="133" />
<hkern g1="quoteleft" g2="quoteleft" k="152" />
<hkern g1="quoteright" g2="space" k="152" />
<hkern g1="quoteright" g2="s" k="113" />
<hkern g1="quoteright" g2="t" k="37" />
<hkern g1="quoteright" g2="quoteright" k="152" />
<hkern g1="quotesinglbase" g2="afii10051" k="205" />
<hkern g1="quotesinglbase" g2="afii10060" k="205" />
<hkern g1="quotesinglbase" g2="afii10036" k="205" />
<hkern g1="quotesinglbase" g2="afii10041" k="385" />
<hkern g1="quotesinglbase" g2="afii10044" k="205" />
<hkern g1="quotedblbase" g2="afii10051" k="205" />
<hkern g1="quotedblbase" g2="afii10060" k="205" />
<hkern g1="quotedblbase" g2="afii10036" k="205" />
<hkern g1="quotedblbase" g2="afii10041" k="385" />
<hkern g1="quotedblbase" g2="afii10044" k="205" />
<hkern g1="Gamma" g2="comma" k="246" />
<hkern g1="Gamma" g2="period" k="246" />
<hkern g1="Gamma" g2="iotadieresistonos" k="-76" />
<hkern g1="Gamma" g2="Alpha" k="317" />
<hkern g1="Gamma" g2="Delta" k="242" />
<hkern g1="Gamma" g2="Lambda" k="317" />
<hkern g1="Gamma" g2="iota" k="72" />
<hkern g1="Theta" g2="Alpha" k="98" />
<hkern g1="Theta" g2="Delta" k="51" />
<hkern g1="Theta" g2="Lambda" k="98" />
<hkern g1="Theta" g2="Upsilon" k="102" />
<hkern g1="Theta" g2="Upsilondieresis" k="102" />
<hkern g1="Phi" g2="Alpha" k="98" />
<hkern g1="Phi" g2="Upsilon" k="154" />
<hkern g1="Phi" g2="Upsilondieresis" k="154" />
<hkern g1="Alphatonos" g2="space" k="113" />
<hkern g1="Alphatonos" g2="Theta" k="84" />
<hkern g1="Alphatonos" g2="Phi" k="84" />
<hkern g1="Alphatonos" g2="Omicron" k="84" />
<hkern g1="Alphatonos" g2="Tau" k="225" />
<hkern g1="Alphatonos" g2="Upsilon" k="311" />
<hkern g1="Alphatonos" g2="Upsilondieresis" k="311" />
<hkern g1="Alphatonos" g2="gamma" k="141" />
<hkern g1="Alphatonos" g2="nu" k="152" />
<hkern g1="Alphatonos" g2="chi" k="141" />
<hkern g1="Omicrontonos" g2="Alpha" k="98" />
<hkern g1="Omicrontonos" g2="Delta" k="51" />
<hkern g1="Omicrontonos" g2="Lambda" k="98" />
<hkern g1="Omicrontonos" g2="Upsilon" k="102" />
<hkern g1="Omicrontonos" g2="Upsilondieresis" k="102" />
<hkern g1="Upsilontonos" g2="Theta" k="182" />
<hkern g1="Upsilontonos" g2="Phi" k="233" />
<hkern g1="Upsilontonos" g2="alpha" k="205" />
<hkern g1="Upsilontonos" g2="delta" k="170" />
<hkern g1="Upsilontonos" g2="sigma" k="229" />
<hkern g1="Upsilontonos" g2="phi" k="205" />
<hkern g1="Upsilontonos" g2="Alpha" k="336" />
<hkern g1="Upsilontonos" g2="Delta" k="256" />
<hkern g1="Upsilontonos" g2="Lambda" k="336" />
<hkern g1="Upsilontonos" g2="Omicron" k="182" />
<hkern g1="Upsilontonos" g2="Omega" k="182" />
<hkern g1="Upsilontonos" g2="alphatonos" k="205" />
<hkern g1="Upsilontonos" g2="etatonos" k="113" />
<hkern g1="Upsilontonos" g2="iotatonos" k="113" />
<hkern g1="Upsilontonos" g2="eta" k="113" />
<hkern g1="Upsilontonos" g2="iota" k="113" />
<hkern g1="Upsilontonos" g2="kappa" k="162" />
<hkern g1="Upsilontonos" g2="mu" k="162" />
<hkern g1="Upsilontonos" g2="omicron" k="205" />
<hkern g1="Upsilontonos" g2="iotadieresis" k="113" />
<hkern g1="Upsilontonos" g2="omicrontonos" k="205" />
<hkern g1="Omegatonos" g2="Upsilon" k="102" />
<hkern g1="Alpha" g2="space" k="113" />
<hkern g1="Alpha" g2="quoteright" k="225" />
<hkern g1="Alpha" g2="Theta" k="84" />
<hkern g1="Alpha" g2="Phi" k="84" />
<hkern g1="Alpha" g2="Omicron" k="84" />
<hkern g1="Alpha" g2="Tau" k="225" />
<hkern g1="Alpha" g2="Upsilon" k="311" />
<hkern g1="Alpha" g2="Upsilondieresis" k="311" />
<hkern g1="Alpha" g2="gamma" k="141" />
<hkern g1="Alpha" g2="nu" k="152" />
<hkern g1="Alpha" g2="chi" k="141" />
<hkern g1="Delta" g2="space" k="113" />
<hkern g1="Delta" g2="Omicron" k="37" />
<hkern g1="Delta" g2="Tau" k="141" />
<hkern g1="Delta" g2="Upsilon" k="190" />
<hkern g1="Delta" g2="Upsilondieresis" k="190" />
<hkern g1="Kappa" g2="Theta" k="141" />
<hkern g1="Kappa" g2="Phi" k="141" />
<hkern g1="Kappa" g2="alpha" k="76" />
<hkern g1="Kappa" g2="delta" k="76" />
<hkern g1="Kappa" g2="sigma" k="76" />
<hkern g1="Kappa" g2="phi" k="76" />
<hkern g1="Kappa" g2="Omicron" k="141" />
<hkern g1="Kappa" g2="Tau" k="90" />
<hkern g1="Kappa" g2="alphatonos" k="76" />
<hkern g1="Kappa" g2="zeta" k="76" />
<hkern g1="Kappa" g2="theta" k="76" />
<hkern g1="Kappa" g2="xi" k="76" />
<hkern g1="Kappa" g2="omega" k="76" />
<hkern g1="Kappa" g2="omegatonos" k="76" />
<hkern g1="Lambda" g2="space" k="53" />
<hkern g1="Lambda" g2="Theta" k="84" />
<hkern g1="Lambda" g2="Omicron" k="84" />
<hkern g1="Lambda" g2="Tau" k="225" />
<hkern g1="Lambda" g2="Upsilon" k="311" />
<hkern g1="Lambda" g2="Upsilondieresis" k="311" />
<hkern g1="Omicron" g2="Alpha" k="98" />
<hkern g1="Omicron" g2="Delta" k="51" />
<hkern g1="Omicron" g2="Lambda" k="98" />
<hkern g1="Omicron" g2="Upsilon" k="102" />
<hkern g1="Omicron" g2="Upsilondieresis" k="102" />
<hkern g1="Rho" g2="comma" k="225" />
<hkern g1="Rho" g2="period" k="225" />
<hkern g1="Rho" g2="Alpha" k="186" />
<hkern g1="Rho" g2="Delta" k="160" />
<hkern g1="Rho" g2="Lambda" k="186" />
<hkern g1="Sigma" g2="tau" k="37" />
<hkern g1="Tau" g2="space" k="37" />
<hkern g1="Tau" g2="comma" k="152" />
<hkern g1="Tau" g2="hyphen" k="186" />
<hkern g1="Tau" g2="period" k="152" />
<hkern g1="Tau" g2="colon" k="100" />
<hkern g1="Tau" g2="semicolon" k="100" />
<hkern g1="Tau" g2="Theta" k="37" />
<hkern g1="Tau" g2="Phi" k="37" />
<hkern g1="Tau" g2="alpha" k="141" />
<hkern g1="Tau" g2="delta" k="141" />
<hkern g1="Tau" g2="epsilon" k="141" />
<hkern g1="Tau" g2="sigma" k="141" />
<hkern g1="Tau" g2="phi" k="141" />
<hkern g1="Tau" g2="iotadieresistonos" k="-76" />
<hkern g1="Tau" g2="Alpha" k="164" />
<hkern g1="Tau" g2="Delta" k="172" />
<hkern g1="Tau" g2="Lambda" k="221" />
<hkern g1="Tau" g2="Omicron" k="37" />
<hkern g1="Tau" g2="Omega" k="37" />
<hkern g1="Tau" g2="alphatonos" k="141" />
<hkern g1="Tau" g2="epsilontonos" k="141" />
<hkern g1="Tau" g2="gamma" k="102" />
<hkern g1="Tau" g2="eta" k="76" />
<hkern g1="Tau" g2="iota" k="72" />
<hkern g1="Tau" g2="mu" k="76" />
<hkern g1="Tau" g2="nu" k="72" />
<hkern g1="Tau" g2="omicron" k="141" />
<hkern g1="Tau" g2="chi" k="72" />
<hkern g1="Tau" g2="psi" k="76" />
<hkern g1="Tau" g2="upsilondieresis" k="76" />
<hkern g1="Tau" g2="omicrontonos" k="141" />
<hkern g1="Tau" g2="upsilontonos" k="76" />
<hkern g1="Upsilon" g2="space" k="76" />
<hkern g1="Upsilon" g2="comma" k="262" />
<hkern g1="Upsilon" g2="hyphen" k="225" />
<hkern g1="Upsilon" g2="period" k="254" />
<hkern g1="Upsilon" g2="colon" k="186" />
<hkern g1="Upsilon" g2="semicolon" k="186" />
<hkern g1="Upsilon" g2="Theta" k="182" />
<hkern g1="Upsilon" g2="Phi" k="233" />
<hkern g1="Upsilon" g2="alpha" k="205" />
<hkern g1="Upsilon" g2="delta" k="170" />
<hkern g1="Upsilon" g2="sigma" k="229" />
<hkern g1="Upsilon" g2="phi" k="205" />
<hkern g1="Upsilon" g2="Alpha" k="336" />
<hkern g1="Upsilon" g2="Delta" k="256" />
<hkern g1="Upsilon" g2="Lambda" k="336" />
<hkern g1="Upsilon" g2="Omicron" k="182" />
<hkern g1="Upsilon" g2="Omega" k="182" />
<hkern g1="Upsilon" g2="alphatonos" k="205" />
<hkern g1="Upsilon" g2="etatonos" k="113" />
<hkern g1="Upsilon" g2="iotatonos" k="113" />
<hkern g1="Upsilon" g2="gamma" k="207" />
<hkern g1="Upsilon" g2="eta" k="113" />
<hkern g1="Upsilon" g2="iota" k="113" />
<hkern g1="Upsilon" g2="kappa" k="162" />
<hkern g1="Upsilon" g2="mu" k="162" />
<hkern g1="Upsilon" g2="omicron" k="205" />
<hkern g1="Upsilon" g2="iotadieresis" k="113" />
<hkern g1="Upsilon" g2="omicrontonos" k="205" />
<hkern g1="Chi" g2="omega" k="66" />
<hkern g1="Chi" g2="omegatonos" k="66" />
<hkern g1="Psi" g2="alpha" k="131" />
<hkern g1="Psi" g2="delta" k="131" />
<hkern g1="Psi" g2="sigma" k="131" />
<hkern g1="Psi" g2="phi" k="131" />
<hkern g1="Psi" g2="alphatonos" k="131" />
<hkern g1="Psi" g2="theta" k="37" />
<hkern g1="Psi" g2="omicron" k="131" />
<hkern g1="Psi" g2="omega" k="131" />
<hkern g1="Psi" g2="omicrontonos" k="131" />
<hkern g1="Psi" g2="omegatonos" k="131" />
<hkern g1="Omega" g2="Upsilon" k="102" />
<hkern g1="Omega" g2="Upsilondieresis" k="102" />
<hkern g1="Upsilondieresis" g2="space" k="76" />
<hkern g1="Upsilondieresis" g2="Theta" k="182" />
<hkern g1="Upsilondieresis" g2="Phi" k="182" />
<hkern g1="Upsilondieresis" g2="alpha" k="205" />
<hkern g1="Upsilondieresis" g2="delta" k="170" />
<hkern g1="Upsilondieresis" g2="sigma" k="229" />
<hkern g1="Upsilondieresis" g2="phi" k="205" />
<hkern g1="Upsilondieresis" g2="Alpha" k="336" />
<hkern g1="Upsilondieresis" g2="Delta" k="256" />
<hkern g1="Upsilondieresis" g2="Lambda" k="336" />
<hkern g1="Upsilondieresis" g2="Omicron" k="182" />
<hkern g1="Upsilondieresis" g2="Omega" k="182" />
<hkern g1="Upsilondieresis" g2="alphatonos" k="205" />
<hkern g1="Upsilondieresis" g2="etatonos" k="113" />
<hkern g1="Upsilondieresis" g2="iotatonos" k="113" />
<hkern g1="Upsilondieresis" g2="eta" k="113" />
<hkern g1="Upsilondieresis" g2="iota" k="113" />
<hkern g1="Upsilondieresis" g2="kappa" k="162" />
<hkern g1="Upsilondieresis" g2="mu" k="162" />
<hkern g1="Upsilondieresis" g2="omicron" k="205" />
<hkern g1="Upsilondieresis" g2="iotadieresis" k="113" />
<hkern g1="Upsilondieresis" g2="omicrontonos" k="205" />
<hkern g1="gamma" g2="epsilon" k="35" />
<hkern g1="zeta" g2="alpha" k="74" />
<hkern g1="zeta" g2="delta" k="74" />
<hkern g1="zeta" g2="sigma" k="74" />
<hkern g1="zeta" g2="tau" k="150" />
<hkern g1="zeta" g2="phi" k="74" />
<hkern g1="zeta" g2="alphatonos" k="74" />
<hkern g1="zeta" g2="etatonos" k="80" />
<hkern g1="zeta" g2="gamma" k="74" />
<hkern g1="zeta" g2="eta" k="80" />
<hkern g1="zeta" g2="theta" k="74" />
<hkern g1="zeta" g2="iota" k="121" />
<hkern g1="zeta" g2="kappa" k="59" />
<hkern g1="zeta" g2="nu" k="74" />
<hkern g1="zeta" g2="omicron" k="76" />
<hkern g1="zeta" g2="omega" k="74" />
<hkern g1="zeta" g2="omicrontonos" k="74" />
<hkern g1="zeta" g2="omegatonos" k="74" />
<hkern g1="kappa" g2="alpha" k="18" />
<hkern g1="kappa" g2="delta" k="45" />
<hkern g1="kappa" g2="sigma" k="45" />
<hkern g1="kappa" g2="phi" k="18" />
<hkern g1="kappa" g2="alphatonos" k="18" />
<hkern g1="kappa" g2="xi" k="45" />
<hkern g1="kappa" g2="omicron" k="45" />
<hkern g1="kappa" g2="sigma1" k="45" />
<hkern g1="kappa" g2="omega" k="18" />
<hkern g1="kappa" g2="omicrontonos" k="45" />
<hkern g1="kappa" g2="omegatonos" k="18" />
<hkern g1="lambda" g2="etatonos" k="18" />
<hkern g1="lambda" g2="upsilondieresistonos" k="37" />
<hkern g1="lambda" g2="eta" k="18" />
<hkern g1="lambda" g2="iota" k="25" />
<hkern g1="lambda" g2="kappa" k="18" />
<hkern g1="lambda" g2="nu" k="39" />
<hkern g1="lambda" g2="upsilon" k="37" />
<hkern g1="lambda" g2="upsilondieresis" k="37" />
<hkern g1="lambda" g2="upsilontonos" k="37" />
<hkern g1="xi" g2="alpha" k="76" />
<hkern g1="xi" g2="delta" k="76" />
<hkern g1="xi" g2="sigma" k="76" />
<hkern g1="xi" g2="phi" k="76" />
<hkern g1="xi" g2="alphatonos" k="76" />
<hkern g1="xi" g2="zeta" k="76" />
<hkern g1="xi" g2="xi" k="76" />
<hkern g1="xi" g2="omicron" k="76" />
<hkern g1="xi" g2="sigma1" k="76" />
<hkern g1="xi" g2="omicrontonos" k="76" />
<hkern g1="chi" g2="alpha" k="45" />
<hkern g1="chi" g2="delta" k="45" />
<hkern g1="chi" g2="sigma" k="45" />
<hkern g1="chi" g2="phi" k="45" />
<hkern g1="chi" g2="alphatonos" k="45" />
<hkern g1="chi" g2="omicron" k="45" />
<hkern g1="chi" g2="sigma1" k="45" />
<hkern g1="chi" g2="omega" k="45" />
<hkern g1="chi" g2="omicrontonos" k="45" />
<hkern g1="chi" g2="omegatonos" k="45" />
<hkern g1="afii10052" g2="comma" k="283" />
<hkern g1="afii10052" g2="period" k="283" />
<hkern g1="afii10052" g2="guillemotleft" k="129" />
<hkern g1="afii10052" g2="guillemotright" k="51" />
<hkern g1="afii10052" g2="emdash" k="51" />
<hkern g1="afii10058" g2="quoteright" k="102" />
<hkern g1="afii10059" g2="quoteright" k="102" />
<hkern g1="afii10017" g2="quoteright" k="180" />
<hkern g1="afii10017" g2="afii10025" k="51" />
<hkern g1="afii10017" g2="afii10032" k="102" />
<hkern g1="afii10017" g2="afii10035" k="102" />
<hkern g1="afii10017" g2="afii10036" k="180" />
<hkern g1="afii10017" g2="afii10037" k="180" />
<hkern g1="afii10017" g2="afii10038" k="129" />
<hkern g1="afii10017" g2="afii10041" k="311" />
<hkern g1="afii10017" g2="afii10047" k="51" />
<hkern g1="afii10017" g2="afii10065" k="27" />
<hkern g1="afii10017" g2="afii10066" k="104" />
<hkern g1="afii10017" g2="afii10070" k="51" />
<hkern g1="afii10017" g2="afii10080" k="104" />
<hkern g1="afii10017" g2="afii10083" k="51" />
<hkern g1="afii10017" g2="afii10084" k="102" />
<hkern g1="afii10017" g2="afii10085" k="102" />
<hkern g1="afii10017" g2="afii10086" k="78" />
<hkern g1="afii10018" g2="afii10017" k="27" />
<hkern g1="afii10018" g2="afii10021" k="78" />
<hkern g1="afii10018" g2="afii10024" k="51" />
<hkern g1="afii10018" g2="afii10029" k="51" />
<hkern g1="afii10018" g2="afii10032" k="14" />
<hkern g1="afii10018" g2="afii10035" k="14" />
<hkern g1="afii10018" g2="afii10036" k="27" />
<hkern g1="afii10018" g2="afii10037" k="72" />
<hkern g1="afii10018" g2="afii10038" k="31" />
<hkern g1="afii10018" g2="afii10039" k="51" />
<hkern g1="afii10018" g2="afii10041" k="102" />
<hkern g1="afii10018" g2="afii10044" k="78" />
<hkern g1="afii10018" g2="afii10049" k="68" />
<hkern g1="afii10018" g2="afii10069" k="51" />
<hkern g1="afii10018" g2="afii10077" k="27" />
<hkern g1="afii10018" g2="afii10085" k="51" />
<hkern g1="afii10019" g2="afii10017" k="129" />
<hkern g1="afii10019" g2="afii10021" k="78" />
<hkern g1="afii10019" g2="afii10024" k="51" />
<hkern g1="afii10019" g2="afii10029" k="78" />
<hkern g1="afii10019" g2="afii10036" k="27" />
<hkern g1="afii10019" g2="afii10037" k="166" />
<hkern g1="afii10019" g2="afii10039" k="51" />
<hkern g1="afii10019" g2="afii10041" k="102" />
<hkern g1="afii10019" g2="afii10044" k="109" />
<hkern g1="afii10019" g2="afii10049" k="102" />
<hkern g1="afii10019" g2="afii10069" k="51" />
<hkern g1="afii10019" g2="afii10085" k="27" />
<hkern g1="afii10019" g2="afii10087" k="27" />
<hkern g1="afii10019" g2="afii10089" k="51" />
<hkern g1="afii10020" g2="comma" k="231" />
<hkern g1="afii10020" g2="period" k="231" />
<hkern g1="afii10020" g2="guillemotleft" k="129" />
<hkern g1="afii10020" g2="guillemotright" k="51" />
<hkern g1="afii10020" g2="emdash" k="51" />
<hkern g1="afii10020" g2="afii10017" k="223" />
<hkern g1="afii10020" g2="afii10021" k="180" />
<hkern g1="afii10020" g2="afii10025" k="-51" />
<hkern g1="afii10020" g2="afii10029" k="154" />
<hkern g1="afii10020" g2="afii10030" k="27" />
<hkern g1="afii10020" g2="afii10032" k="51" />
<hkern g1="afii10020" g2="afii10035" k="27" />
<hkern g1="afii10020" g2="afii10049" k="154" />
<hkern g1="afii10020" g2="afii10065" k="51" />
<hkern g1="afii10020" g2="afii10067" k="78" />
<hkern g1="afii10020" g2="afii10069" k="154" />
<hkern g1="afii10020" g2="afii10070" k="156" />
<hkern g1="afii10020" g2="afii10074" k="78" />
<hkern g1="afii10020" g2="afii10077" k="154" />
<hkern g1="afii10020" g2="afii10078" k="78" />
<hkern g1="afii10020" g2="afii10079" k="78" />
<hkern g1="afii10020" g2="afii10080" k="180" />
<hkern g1="afii10020" g2="afii10082" k="129" />
<hkern g1="afii10020" g2="afii10085" k="78" />
<hkern g1="afii10020" g2="afii10093" k="129" />
<hkern g1="afii10020" g2="afii10094" k="129" />
<hkern g1="afii10020" g2="afii10096" k="102" />
<hkern g1="afii10020" g2="afii10097" k="154" />
<hkern g1="afii10021" g2="afii10025" k="-51" />
<hkern g1="afii10021" g2="afii10037" k="-25" />
<hkern g1="afii10021" g2="afii10047" k="-51" />
<hkern g1="afii10021" g2="afii10070" k="-25" />
<hkern g1="afii10021" g2="afii10073" k="-51" />
<hkern g1="afii10022" g2="afii10025" k="-25" />
<hkern g1="afii10022" g2="afii10029" k="27" />
<hkern g1="afii10024" g2="afii10025" k="51" />
<hkern g1="afii10024" g2="afii10032" k="51" />
<hkern g1="afii10024" g2="afii10035" k="51" />
<hkern g1="afii10024" g2="afii10036" k="35" />
<hkern g1="afii10024" g2="afii10037" k="29" />
<hkern g1="afii10024" g2="afii10044" k="20" />
<hkern g1="afii10024" g2="afii10065" k="51" />
<hkern g1="afii10024" g2="afii10066" k="102" />
<hkern g1="afii10024" g2="afii10070" k="104" />
<hkern g1="afii10024" g2="afii10080" k="104" />
<hkern g1="afii10024" g2="afii10085" k="100" />
<hkern g1="afii10025" g2="afii10021" k="125" />
<hkern g1="afii10025" g2="afii10024" k="27" />
<hkern g1="afii10025" g2="afii10029" k="90" />
<hkern g1="afii10025" g2="afii10037" k="51" />
<hkern g1="afii10025" g2="afii10041" k="78" />
<hkern g1="afii10025" g2="afii10049" k="78" />
<hkern g1="afii10025" g2="afii10069" k="51" />
<hkern g1="afii10025" g2="afii10077" k="27" />
<hkern g1="afii10028" g2="afii10032" k="51" />
<hkern g1="afii10028" g2="afii10035" k="51" />
<hkern g1="afii10028" g2="afii10037" k="41" />
<hkern g1="afii10028" g2="afii10038" k="90" />
<hkern g1="afii10028" g2="afii10041" k="27" />
<hkern g1="afii10028" g2="afii10047" k="-25" />
<hkern g1="afii10028" g2="afii10065" k="27" />
<hkern g1="afii10028" g2="afii10070" k="78" />
<hkern g1="afii10028" g2="afii10073" k="27" />
<hkern g1="afii10028" g2="afii10080" k="102" />
<hkern g1="afii10028" g2="afii10083" k="51" />
<hkern g1="afii10028" g2="afii10084" k="78" />
<hkern g1="afii10028" g2="afii10085" k="154" />
<hkern g1="afii10028" g2="afii10095" k="27" />
<hkern g1="afii10029" g2="afii10038" k="27" />
<hkern g1="afii10029" g2="afii10066" k="27" />
<hkern g1="afii10029" g2="afii10070" k="14" />
<hkern g1="afii10029" g2="afii10080" k="51" />
<hkern g1="afii10029" g2="afii10085" k="51" />
<hkern g1="afii10030" g2="afii10038" k="27" />
<hkern g1="afii10030" g2="afii10070" k="27" />
<hkern g1="afii10030" g2="afii10080" k="51" />
<hkern g1="afii10030" g2="afii10085" k="51" />
<hkern g1="afii10030" g2="afii10089" k="78" />
<hkern g1="afii10032" g2="afii10017" k="102" />
<hkern g1="afii10032" g2="afii10021" k="102" />
<hkern g1="afii10032" g2="afii10024" k="51" />
<hkern g1="afii10032" g2="afii10029" k="102" />
<hkern g1="afii10032" g2="afii10035" k="-25" />
<hkern g1="afii10032" g2="afii10037" k="115" />
<hkern g1="afii10032" g2="afii10038" k="-25" />
<hkern g1="afii10032" g2="afii10039" k="160" />
<hkern g1="afii10032" g2="afii10041" k="51" />
<hkern g1="afii10032" g2="afii10049" k="147" />
<hkern g1="afii10032" g2="afii10069" k="27" />
<hkern g1="afii10034" g2="comma" k="256" />
<hkern g1="afii10034" g2="period" k="256" />
<hkern g1="afii10034" g2="colon" k="-76" />
<hkern g1="afii10034" g2="semicolon" k="-76" />
<hkern g1="afii10034" g2="guillemotright" k="-51" />
<hkern g1="afii10034" g2="afii10017" k="262" />
<hkern g1="afii10034" g2="afii10021" k="154" />
<hkern g1="afii10034" g2="afii10024" k="72" />
<hkern g1="afii10034" g2="afii10025" k="-25" />
<hkern g1="afii10034" g2="afii10029" k="154" />
<hkern g1="afii10034" g2="afii10032" k="-25" />
<hkern g1="afii10034" g2="afii10035" k="-25" />
<hkern g1="afii10034" g2="afii10036" k="-25" />
<hkern g1="afii10034" g2="afii10037" k="51" />
<hkern g1="afii10034" g2="afii10038" k="35" />
<hkern g1="afii10034" g2="afii10039" k="145" />
<hkern g1="afii10034" g2="afii10049" k="129" />
<hkern g1="afii10034" g2="afii10069" k="78" />
<hkern g1="afii10034" g2="afii10070" k="27" />
<hkern g1="afii10034" g2="afii10080" k="51" />
<hkern g1="afii10034" g2="afii10095" k="-51" />
<hkern g1="afii10034" g2="afii10097" k="78" />
<hkern g1="afii10035" g2="afii10017" k="102" />
<hkern g1="afii10035" g2="afii10021" k="102" />
<hkern g1="afii10035" g2="afii10029" k="51" />
<hkern g1="afii10035" g2="afii10037" k="27" />
<hkern g1="afii10035" g2="afii10039" k="53" />
<hkern g1="afii10035" g2="afii10041" k="51" />
<hkern g1="afii10035" g2="afii10044" k="27" />
<hkern g1="afii10035" g2="afii10066" k="-25" />
<hkern g1="afii10035" g2="afii10070" k="-25" />
<hkern g1="afii10035" g2="afii10083" k="-25" />
<hkern g1="afii10035" g2="afii10084" k="27" />
<hkern g1="afii10035" g2="afii10085" k="51" />
<hkern g1="afii10035" g2="afii10089" k="27" />
<hkern g1="afii10035" g2="afii10095" k="-25" />
<hkern g1="afii10036" g2="comma" k="205" />
<hkern g1="afii10036" g2="period" k="205" />
<hkern g1="afii10036" g2="guillemotleft" k="102" />
<hkern g1="afii10036" g2="guillemotright" k="53" />
<hkern g1="afii10036" g2="afii10017" k="102" />
<hkern g1="afii10036" g2="afii10021" k="129" />
<hkern g1="afii10036" g2="afii10029" k="102" />
<hkern g1="afii10036" g2="afii10030" k="27" />
<hkern g1="afii10036" g2="afii10032" k="27" />
<hkern g1="afii10036" g2="afii10038" k="45" />
<hkern g1="afii10036" g2="afii10049" k="78" />
<hkern g1="afii10036" g2="afii10065" k="51" />
<hkern g1="afii10036" g2="afii10067" k="102" />
<hkern g1="afii10036" g2="afii10070" k="78" />
<hkern g1="afii10036" g2="afii10074" k="51" />
<hkern g1="afii10036" g2="afii10076" k="51" />
<hkern g1="afii10036" g2="afii10077" k="102" />
<hkern g1="afii10036" g2="afii10078" k="51" />
<hkern g1="afii10036" g2="afii10080" k="154" />
<hkern g1="afii10036" g2="afii10081" k="78" />
<hkern g1="afii10036" g2="afii10082" k="78" />
<hkern g1="afii10036" g2="afii10083" k="78" />
<hkern g1="afii10036" g2="afii10085" k="102" />
<hkern g1="afii10036" g2="afii10087" k="102" />
<hkern g1="afii10036" g2="afii10091" k="78" />
<hkern g1="afii10036" g2="afii10093" k="102" />
<hkern g1="afii10036" g2="afii10094" k="129" />
<hkern g1="afii10036" g2="afii10096" k="102" />
<hkern g1="afii10036" g2="afii10097" k="78" />
<hkern g1="afii10037" g2="comma" k="334" />
<hkern g1="afii10037" g2="period" k="334" />
<hkern g1="afii10037" g2="colon" k="78" />
<hkern g1="afii10037" g2="semicolon" k="78" />
<hkern g1="afii10037" g2="guillemotleft" k="180" />
<hkern g1="afii10037" g2="guillemotright" k="129" />
<hkern g1="afii10037" g2="emdash" k="51" />
<hkern g1="afii10037" g2="afii10017" k="391" />
<hkern g1="afii10037" g2="afii10021" k="207" />
<hkern g1="afii10037" g2="afii10025" k="27" />
<hkern g1="afii10037" g2="afii10029" k="231" />
<hkern g1="afii10037" g2="afii10032" k="102" />
<hkern g1="afii10037" g2="afii10038" k="152" />
<hkern g1="afii10037" g2="afii10047" k="27" />
<hkern g1="afii10037" g2="afii10049" k="231" />
<hkern g1="afii10037" g2="afii10066" k="129" />
<hkern g1="afii10037" g2="afii10067" k="231" />
<hkern g1="afii10037" g2="afii10068" k="180" />
<hkern g1="afii10037" g2="afii10069" k="287" />
<hkern g1="afii10037" g2="afii10070" k="246" />
<hkern g1="afii10037" g2="afii10072" k="180" />
<hkern g1="afii10037" g2="afii10073" k="180" />
<hkern g1="afii10037" g2="afii10074" k="180" />
<hkern g1="afii10037" g2="afii10075" k="102" />
<hkern g1="afii10037" g2="afii10076" k="180" />
<hkern g1="afii10037" g2="afii10077" k="231" />
<hkern g1="afii10037" g2="afii10078" k="180" />
<hkern g1="afii10037" g2="afii10079" k="180" />
<hkern g1="afii10037" g2="afii10080" k="231" />
<hkern g1="afii10037" g2="afii10081" k="180" />
<hkern g1="afii10037" g2="afii10082" k="180" />
<hkern g1="afii10037" g2="afii10083" k="246" />
<hkern g1="afii10037" g2="afii10087" k="205" />
<hkern g1="afii10037" g2="afii10088" k="180" />
<hkern g1="afii10037" g2="afii10090" k="180" />
<hkern g1="afii10037" g2="afii10091" k="180" />
<hkern g1="afii10037" g2="afii10096" k="180" />
<hkern g1="afii10037" g2="afii10097" k="231" />
<hkern g1="afii10038" g2="afii10017" k="129" />
<hkern g1="afii10038" g2="afii10021" k="180" />
<hkern g1="afii10038" g2="afii10029" k="154" />
<hkern g1="afii10038" g2="afii10032" k="-25" />
<hkern g1="afii10038" g2="afii10036" k="51" />
<hkern g1="afii10038" g2="afii10037" k="156" />
<hkern g1="afii10038" g2="afii10041" k="129" />
<hkern g1="afii10038" g2="afii10049" k="180" />
<hkern g1="afii10038" g2="afii10077" k="102" />
<hkern g1="afii10039" g2="afii10025" k="51" />
<hkern g1="afii10039" g2="afii10032" k="104" />
<hkern g1="afii10039" g2="afii10035" k="78" />
<hkern g1="afii10039" g2="afii10038" k="180" />
<hkern g1="afii10039" g2="afii10047" k="27" />
<hkern g1="afii10039" g2="afii10080" k="129" />
<hkern g1="afii10039" g2="afii10085" k="180" />
<hkern g1="afii10040" g2="afii10032" k="27" />
<hkern g1="afii10040" g2="afii10080" k="27" />
<hkern g1="afii10043" g2="afii10085" k="-25" />
<hkern g1="afii10044" g2="quoteright" k="129" />
<hkern g1="afii10044" g2="afii10049" k="123" />
<hkern g1="afii10046" g2="quoteright" k="129" />
<hkern g1="afii10046" g2="afii10017" k="88" />
<hkern g1="afii10046" g2="afii10021" k="150" />
<hkern g1="afii10046" g2="afii10024" k="129" />
<hkern g1="afii10046" g2="afii10025" k="78" />
<hkern g1="afii10046" g2="afii10029" k="82" />
<hkern g1="afii10046" g2="afii10030" k="82" />
<hkern g1="afii10046" g2="afii10032" k="51" />
<hkern g1="afii10046" g2="afii10035" k="51" />
<hkern g1="afii10046" g2="afii10036" k="154" />
<hkern g1="afii10046" g2="afii10039" k="147" />
<hkern g1="afii10046" g2="afii10041" k="229" />
<hkern g1="afii10046" g2="afii10047" k="27" />
<hkern g1="afii10046" g2="afii10049" k="109" />
<hkern g1="afii10047" g2="afii10021" k="172" />
<hkern g1="afii10047" g2="afii10024" k="51" />
<hkern g1="afii10047" g2="afii10025" k="-25" />
<hkern g1="afii10047" g2="afii10029" k="129" />
<hkern g1="afii10047" g2="afii10032" k="-25" />
<hkern g1="afii10047" g2="afii10038" k="-10" />
<hkern g1="afii10047" g2="afii10039" k="104" />
<hkern g1="afii10047" g2="afii10049" k="111" />
<hkern g1="afii10047" g2="afii10069" k="51" />
<hkern g1="afii10047" g2="afii10077" k="27" />
<hkern g1="afii10048" g2="afii10017" k="78" />
<hkern g1="afii10048" g2="afii10021" k="154" />
<hkern g1="afii10048" g2="afii10024" k="143" />
<hkern g1="afii10048" g2="afii10029" k="102" />
<hkern g1="afii10048" g2="afii10032" k="-25" />
<hkern g1="afii10048" g2="afii10036" k="51" />
<hkern g1="afii10048" g2="afii10039" k="186" />
<hkern g1="afii10048" g2="afii10041" k="78" />
<hkern g1="afii10048" g2="afii10069" k="51" />
<hkern g1="afii10048" g2="afii10072" k="-25" />
<hkern g1="afii10048" g2="afii10077" k="27" />
<hkern g1="afii10065" g2="afii10077" k="-18" />
<hkern g1="afii10065" g2="afii10081" k="27" />
<hkern g1="afii10065" g2="afii10084" k="53" />
<hkern g1="afii10065" g2="afii10085" k="104" />
<hkern g1="afii10065" g2="afii10089" k="82" />
<hkern g1="afii10066" g2="afii10069" k="51" />
<hkern g1="afii10066" g2="afii10070" k="27" />
<hkern g1="afii10066" g2="afii10072" k="51" />
<hkern g1="afii10066" g2="afii10077" k="51" />
<hkern g1="afii10066" g2="afii10078" k="20" />
<hkern g1="afii10066" g2="afii10085" k="78" />
<hkern g1="afii10066" g2="afii10087" k="78" />
<hkern g1="afii10066" g2="afii10089" k="78" />
<hkern g1="afii10066" g2="afii10092" k="51" />
<hkern g1="afii10066" g2="afii10097" k="51" />
<hkern g1="afii10067" g2="afii10065" k="27" />
<hkern g1="afii10067" g2="afii10066" k="27" />
<hkern g1="afii10067" g2="afii10069" k="51" />
<hkern g1="afii10067" g2="afii10070" k="12" />
<hkern g1="afii10067" g2="afii10072" k="59" />
<hkern g1="afii10067" g2="afii10077" k="27" />
<hkern g1="afii10067" g2="afii10078" k="35" />
<hkern g1="afii10067" g2="afii10080" k="14" />
<hkern g1="afii10067" g2="afii10083" k="12" />
<hkern g1="afii10067" g2="afii10084" k="51" />
<hkern g1="afii10067" g2="afii10085" k="70" />
<hkern g1="afii10067" g2="afii10086" k="27" />
<hkern g1="afii10067" g2="afii10089" k="78" />
<hkern g1="afii10067" g2="afii10092" k="51" />
<hkern g1="afii10067" g2="afii10097" k="27" />
<hkern g1="afii10068" g2="comma" k="231" />
<hkern g1="afii10068" g2="period" k="231" />
<hkern g1="afii10068" g2="afii10069" k="102" />
<hkern g1="afii10068" g2="afii10070" k="27" />
<hkern g1="afii10068" g2="afii10077" k="104" />
<hkern g1="afii10068" g2="afii10078" k="27" />
<hkern g1="afii10068" g2="afii10080" k="51" />
<hkern g1="afii10068" g2="afii10097" k="51" />
<hkern g1="afii10069" g2="afii10073" k="-25" />
<hkern g1="afii10069" g2="afii10095" k="-51" />
<hkern g1="afii10070" g2="e" k="-25" />
<hkern g1="afii10070" g2="afii10065" k="-25" />
<hkern g1="afii10070" g2="afii10069" k="27" />
<hkern g1="afii10070" g2="afii10073" k="-25" />
<hkern g1="afii10070" g2="afii10083" k="-51" />
<hkern g1="afii10070" g2="afii10085" k="51" />
<hkern g1="afii10070" g2="afii10086" k="-25" />
<hkern g1="afii10070" g2="afii10087" k="27" />
<hkern g1="afii10070" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10066" k="27" />
<hkern g1="afii10072" g2="afii10070" k="27" />
<hkern g1="afii10072" g2="afii10073" k="-25" />
<hkern g1="afii10072" g2="afii10080" k="51" />
<hkern g1="afii10072" g2="afii10083" k="37" />
<hkern g1="afii10072" g2="afii10089" k="51" />
<hkern g1="afii10072" g2="afii10092" k="27" />
<hkern g1="afii10073" g2="afii10069" k="37" />
<hkern g1="afii10073" g2="afii10072" k="37" />
<hkern g1="afii10073" g2="afii10073" k="-25" />
<hkern g1="afii10073" g2="afii10078" k="29" />
<hkern g1="afii10073" g2="afii10080" k="12" />
<hkern g1="afii10073" g2="afii10085" k="43" />
<hkern g1="afii10073" g2="afii10086" k="14" />
<hkern g1="afii10073" g2="afii10089" k="41" />
<hkern g1="afii10073" g2="afii10092" k="35" />
<hkern g1="afii10076" g2="guillemotleft" k="53" />
<hkern g1="afii10076" g2="afii10065" k="31" />
<hkern g1="afii10076" g2="afii10066" k="51" />
<hkern g1="afii10076" g2="afii10070" k="51" />
<hkern g1="afii10076" g2="afii10073" k="27" />
<hkern g1="afii10076" g2="afii10080" k="104" />
<hkern g1="afii10076" g2="afii10083" k="51" />
<hkern g1="afii10076" g2="afii10084" k="27" />
<hkern g1="afii10076" g2="afii10085" k="29" />
<hkern g1="afii10076" g2="afii10086" k="51" />
<hkern g1="afii10076" g2="afii10089" k="80" />
<hkern g1="afii10076" g2="afii10095" k="27" />
<hkern g1="afii10078" g2="afii10065" k="14" />
<hkern g1="afii10078" g2="afii10095" k="-25" />
<hkern g1="afii10080" g2="afii10069" k="59" />
<hkern g1="afii10080" g2="afii10070" k="-25" />
<hkern g1="afii10080" g2="afii10072" k="51" />
<hkern g1="afii10080" g2="afii10077" k="27" />
<hkern g1="afii10080" g2="afii10078" k="39" />
<hkern g1="afii10080" g2="afii10083" k="-51" />
<hkern g1="afii10080" g2="afii10084" k="27" />
<hkern g1="afii10080" g2="afii10085" k="78" />
<hkern g1="afii10080" g2="afii10087" k="51" />
<hkern g1="afii10080" g2="afii10089" k="53" />
<hkern g1="afii10080" g2="afii10095" k="-25" />
<hkern g1="afii10080" g2="afii10097" k="39" />
<hkern g1="afii10082" g2="afii10069" k="27" />
<hkern g1="afii10082" g2="afii10073" k="-25" />
<hkern g1="afii10082" g2="afii10077" k="27" />
<hkern g1="afii10082" g2="afii10078" k="31" />
<hkern g1="afii10082" g2="afii10084" k="27" />
<hkern g1="afii10082" g2="afii10085" k="27" />
<hkern g1="afii10082" g2="afii10089" k="51" />
<hkern g1="afii10082" g2="afii10095" k="-51" />
<hkern g1="afii10083" g2="afii10065" k="-25" />
<hkern g1="afii10083" g2="afii10066" k="-25" />
<hkern g1="afii10083" g2="afii10070" k="-25" />
<hkern g1="afii10083" g2="afii10073" k="-51" />
<hkern g1="afii10083" g2="afii10085" k="27" />
<hkern g1="afii10083" g2="afii10086" k="-25" />
<hkern g1="afii10083" g2="afii10087" k="27" />
<hkern g1="afii10083" g2="afii10089" k="41" />
<hkern g1="afii10083" g2="afii10095" k="-25" />
<hkern g1="afii10084" g2="comma" k="154" />
<hkern g1="afii10084" g2="period" k="154" />
<hkern g1="afii10084" g2="afii10065" k="-25" />
<hkern g1="afii10084" g2="afii10069" k="27" />
<hkern g1="afii10084" g2="afii10072" k="-25" />
<hkern g1="afii10084" g2="afii10073" k="-25" />
<hkern g1="afii10084" g2="afii10077" k="51" />
<hkern g1="afii10084" g2="afii10080" k="27" />
<hkern g1="afii10084" g2="afii10082" k="-25" />
<hkern g1="afii10084" g2="afii10083" k="-25" />
<hkern g1="afii10084" g2="afii10085" k="27" />
<hkern g1="afii10084" g2="afii10095" k="-51" />
<hkern g1="afii10084" g2="afii10097" k="27" />
<hkern g1="afii10085" g2="comma" k="205" />
<hkern g1="afii10085" g2="period" k="205" />
<hkern g1="afii10085" g2="colon" k="27" />
<hkern g1="afii10085" g2="semicolon" k="27" />
<hkern g1="afii10085" g2="guillemotright" k="-51" />
<hkern g1="afii10085" g2="afii10065" k="27" />
<hkern g1="afii10085" g2="afii10066" k="27" />
<hkern g1="afii10085" g2="afii10069" k="129" />
<hkern g1="afii10085" g2="afii10070" k="27" />
<hkern g1="afii10085" g2="afii10072" k="27" />
<hkern g1="afii10085" g2="afii10077" k="90" />
<hkern g1="afii10085" g2="afii10078" k="27" />
<hkern g1="afii10085" g2="afii10080" k="51" />
<hkern g1="afii10085" g2="afii10086" k="51" />
<hkern g1="afii10085" g2="afii10097" k="51" />
<hkern g1="afii10086" g2="afii10069" k="51" />
<hkern g1="afii10086" g2="afii10077" k="51" />
<hkern g1="afii10086" g2="afii10085" k="51" />
<hkern g1="afii10086" g2="afii10086" k="12" />
<hkern g1="afii10086" g2="afii10089" k="55" />
<hkern g1="afii10086" g2="afii10097" k="27" />
<hkern g1="afii10087" g2="afii10065" k="27" />
<hkern g1="afii10087" g2="afii10066" k="78" />
<hkern g1="afii10087" g2="afii10070" k="51" />
<hkern g1="afii10087" g2="afii10073" k="27" />
<hkern g1="afii10087" g2="afii10080" k="78" />
<hkern g1="afii10087" g2="afii10083" k="59" />
<hkern g1="afii10087" g2="afii10084" k="51" />
<hkern g1="afii10087" g2="afii10085" k="78" />
<hkern g1="afii10087" g2="afii10086" k="78" />
<hkern g1="afii10087" g2="afii10089" k="102" />
<hkern g1="afii10087" g2="afii10092" k="78" />
<hkern g1="afii10087" g2="afii10095" k="27" />
<hkern g1="afii10088" g2="afii10073" k="-25" />
<hkern g1="afii10094" g2="afii10084" k="78" />
<hkern g1="afii10094" g2="afii10089" k="156" />
<hkern g1="afii10095" g2="afii10069" k="106" />
<hkern g1="afii10095" g2="afii10072" k="76" />
<hkern g1="afii10095" g2="afii10077" k="37" />
<hkern g1="afii10095" g2="afii10078" k="18" />
<hkern g1="afii10095" g2="afii10086" k="12" />
<hkern g1="afii10095" g2="afii10087" k="80" />
<hkern g1="afii10095" g2="afii10097" k="27" />
<hkern g1="afii10096" g2="afii10069" k="104" />
<hkern g1="afii10096" g2="afii10072" k="51" />
<hkern g1="afii10096" g2="afii10077" k="51" />
<hkern g1="afii10096" g2="afii10078" k="27" />
<hkern g1="afii10096" g2="afii10084" k="27" />
<hkern g1="afii10096" g2="afii10086" k="12" />
<hkern g1="afii10096" g2="afii10087" k="80" />
<hkern g1="afii10096" g2="afii10089" k="78" />
<hkern g1="afii10110" g2="comma" k="205" />
<hkern g1="afii10110" g2="period" k="205" />
<hkern g1="afii10110" g2="guillemotright" k="-25" />
<hkern g1="afii10050" g2="comma" k="203" />
<hkern g1="afii10050" g2="period" k="203" />
<hkern g1="afii10050" g2="colon" k="51" />
<hkern g1="afii10050" g2="semicolon" k="51" />
<hkern g1="afii10050" g2="guillemotleft" k="180" />
<hkern g1="afii10050" g2="guillemotright" k="78" />
<hkern g1="afii10050" g2="emdash" k="51" />
</font>
</defs>
=cut
