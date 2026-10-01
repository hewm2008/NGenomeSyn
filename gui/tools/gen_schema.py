#!/usr/bin/env python3
"""Generate gui/resources/params_schema.json for the NGenomeSyn GUI.

Sources of truth:
  1. bin/NGenomeSyn (single-file Perl engine):
       - every live key the engine actually reads  ($HashConfi{...}{...})
       - the 36 hard-coded RColorBrewer palettes  ($HashColData / %MaxColNum)
  2. META hand table below: zh/en labels & descriptions, types, ranges,
     categories, engine defaults (verified against the engine source).

The generator cross-validates 1 and 2 and records the result in the
"validation" block, so a typo can never slip into the schema silently.

Run:  python3 gui/tools/gen_schema.py
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
ENGINE = ROOT / "bin" / "NGenomeSyn"
OUT = ROOT / "gui" / "resources" / "params_schema.json"

# --------------------------------------------------------------------------
# categories (order = UI order)
# --------------------------------------------------------------------------
CATEGORIES = {
    "files":      {"zh": "数据分组",        "en": "Data grouping"},
    "canvas":     {"zh": "画布与字体",      "en": "Canvas & font"},
    "title":      {"zh": "主标题",          "en": "Main title"},
    "genome":     {"zh": "基因组与染色体",  "en": "Genome & chromosomes"},
    "genome_name": {"zh": "基因组名称",     "en": "Genome label"},
    "chr_name":   {"zh": "染色体名称",      "en": "Chromosome label"},
    "axis":       {"zh": "坐标轴",          "en": "Coordinate axis"},
    "spe_region": {"zh": "特殊区域与缩放",  "en": "Regions & zoom"},
    "link":       {"zh": "链接",            "en": "Links"},
    "style":      {"zh": "样式 (SVG)",      "en": "Style (SVG)"},
    "color":      {"zh": "调色板",          "en": "Color palettes"},
}

# --------------------------------------------------------------------------
# keys the engine reads but that are DEAD (never used afterwards) - they must
# exist in the code-extraction set and must NOT appear in META
# --------------------------------------------------------------------------
DEAD_KEYS = {
    ("global", "strokewidth"),
    ("global", "fill"),               # live only in genome/link sections
    ("global", "ShiftXaxisY"),
    ("genome", "crBG"),
    ("genome", "crStrokeBG"),
}

QUALITATIVE_PALETTES = {"Accent", "Dark2", "Paired", "Pastel1", "Pastel2",
                        "Set1", "Set2", "Set3"}

# engine literal values, used by validation (case-sensitive eq checks)
STYLE_CHOICES = ["UpDown", "DownUp", "UpUp", "DownDown", "line"]

# historical misspellings -> real key (engine silently ignores the typo)
ALIASES = {
    "HightRation": "HeightRatio",
    "MainCor": "MainColor",
    "GenomeNameRatio": "GenomeNameSizeRatio",
    "MoveX": "MoveToX",
    "MoveY": "MoveToY",
}

# value-level alias (StyleUpDown is compared with case-sensitive eq)
VALUE_ALIASES = {"StyleUpDown": {"UpUP": "UpUp"}}


def P(name, scope, cat, typ, lz, le, dz, de, *, old=(), imp=2, choices=None,
      mn=None, mx=None, default=None, presence=False):
    return {
        "name": name, "scope": scope, "category": cat, "old_names": list(old),
        "importance": imp, "type": typ, "choices": choices, "min": mn,
        "max": mx, "default": default,
        "label_zh": lz, "label_en": le, "desc_zh": dz, "desc_en": de,
        "plot_types": [], **({"presence_only": True} if presence else {}),
    }


META = [
    # ---------------------------------------------------------- canvas
    P("body", ["global"], "canvas", "int", "画布主体宽度", "Body width",
      "主绘图区宽度(px)。总画布宽 = left+body+right。", "Main drawing width (px). Total width = left+body+right.",
      imp=2, mn=50, default=1200),
    P("up", ["global"], "canvas", "int", "上边距", "Top margin",
      "画布上边距(px)，主标题基线与 up/2 相关。", "Top margin (px); main title baseline depends on up/2.",
      imp=1, mn=0, default=55),
    P("down", ["global"], "canvas", "int", "下边距", "Bottom margin",
      "画布下边距(px)。", "Bottom margin (px).", imp=1, mn=0, default=25),
    P("left", ["global"], "canvas", "int", "左边距", "Left margin",
      "画布左边距(px)，也参与主标题水平居中。", "Left margin (px); also used to centre the main title.",
      imp=1, mn=0, default=100),
    P("right", ["global"], "canvas", "int", "右边距", "Right margin",
      "画布右边距(px)，是各基因组 X 坐标的基准。", "Right margin (px); base of per-genome X positions.",
      imp=1, mn=0, default=120),
    P("font-size", ["global"], "canvas", "float", "基础字号", "Base font size",
      "全局基础字号。染色体名=×1.2，坐标标签=×1.0，主标题=×1.2，基因组名=×1.4。",
      "Base font size. Chr names ×1.2, axis labels ×1.0, main title ×1.2, genome labels ×1.4.",
      imp=2, mn=1, default=10),
    P("font-family", ["global"], "canvas", "text", "字体", "Font family",
      "全部文字的字体，原样传给 SVG（如 Arial / Times New Roman）。",
      "Font family passed verbatim to the SVG (e.g. Arial).",
      imp=1, default="Arial"),
    P("CanvasHeightRitao", ["global"], "canvas", "float", "画布高度比例", "Canvas height ratio",
      "整体高度缩放系数。注意引擎要求 >0.1，否则该参数被静默忽略（拼写 Ritao 是引擎历史拼写，必须照写）。",
      "Scales total height. Must be >0.1 or the engine silently ignores it (the 'Ritao' spelling is the engine's, keep it).",
      imp=2, mn=0.1, default=1.0),
    P("CanvasWidthRitao", ["global"], "canvas", "float", "画布宽度比例", "Canvas width ratio",
      "整体宽度缩放系数，同样要求 >0.1。", "Scales total width; also must be >0.1.",
      imp=1, mn=0.1, default=1.0),
    P("RotatePng", ["global"], "canvas", "int", "PNG 旋转角度", "PNG rotation",
      "仅对导出的 PNG 生效（convert -rotate），不改 SVG。", "Rotates the exported PNG only (never the SVG).",
      imp=0, mn=-360, mx=360, default=0),
    P("NoPng", ["global"], "canvas", "bool", "不输出 PNG", "No PNG output",
      "只要该键存在即不生成 PNG（写 0 也会生效）。GUI 预览渲染始终自带 PNG/PDF 导出，无需此项。",
      "The engine skips PNG whenever the key exists (even 0). The GUI renders PNG/PDF itself, so you normally never need it.",
      imp=0, presence=True),
    # ---------------------------------------------------------- title
    P("Main", ["global"], "title", "text", "主标题文字", "Main title",
      "整图顶部居中的大标题。", "Big centred title at the top of the figure.",
      imp=2),
    P("MainColor", ["global"], "title", "color", "主标题颜色", "Main title color",
      "标题颜色（默认 blue）。注意历史文档中的 MainCor 是无效拼写，GUI 会自动改写。",
      "Title color (default blue). The 'MainCor' spelling found in old docs is a typo the GUI auto-corrects.",
      old=["MainCor"], imp=2, default="blue"),
    P("MainRatioFontSize", ["global"], "title", "float", "标题字号比例", "Title font ratio",
      "标题字号 = font-size × 1.2 × 该比例。", "Title font = font-size × 1.2 × ratio.",
      imp=1, default=1.0),
    P("ShiftMainX", ["global"], "title", "float", "标题水平偏移", "Title shift X",
      "主标题水平微调(px)。", "Horizontal nudge for the title (px).", imp=0, default=0.0),
    P("ShiftMainY", ["global"], "title", "float", "标题垂直偏移", "Title shift Y",
      "主标题垂直微调(px)，基准为 up/2 - 2×font-size。", "Vertical nudge for the title (px); base is up/2 - 2×font-size.",
      imp=0, default=0.0),
    P("TotalGenomeNumber", ["global"], "genome", "int", "基因组总数(覆盖)", "Total genome number",
      "覆盖自动检测的基因组数量（高级用法；正常情况下由 GenomeInfoFileN 与 SetParaFor=GenomeN 自动推断）。",
      "Overrides the auto-detected genome count (advanced; normally inferred from GenomeInfoFileN / SetParaFor=GenomeN).",
      imp=0, mn=2),
    # ---------------------------------------------------------- genome
    P("ZoomChr", ["genome"], "genome", "float", "染色体长度缩放", "Chromosome zoom",
      ">1 放大、<1 缩小、=1 等长。不能为 0（会导致引擎除零崩溃）。",
      ">1 enlarge, <1 shrink. Must not be 0 (division by zero in the engine).",
      imp=2, default=1.0),
    P("ChrWidth", ["genome"], "genome", "int", "染色体条宽度", "Chromosome width",
      "染色体条在画布上的粗细(px)。", "Thickness of the chromosome bars (px).",
      imp=2, mn=1, default=20),
    P("LinkWidth", ["genome"], "genome", "int", "链接区高度", "Link band height",
      "本基因组与下一个基因组之间链接带的垂直空间(px)。",
      "Vertical band between this genome and the next one (px).",
      imp=2, mn=0, default=180),
    P("ChrSpacing", ["genome"], "genome", "int", "染色体间距", "Chromosome spacing",
      "同一基因组内相邻染色体之间的间隔(px)。", "Gap between neighbouring chromosomes of one genome (px).",
      imp=2, mn=0, default=10),
    P("NormalizedScale", ["genome"], "genome", "bool", "使用自有标尺", "Own scale",
      "0=与默认基因组共用标尺；1=该基因组使用自己的坐标比例。",
      "0=share the global scale; 1=this genome keeps its own scale.",
      imp=1, default="0"),
    P("EndCurveRadian", ["genome"], "genome", "int", "末端圆角半径", "End curve radius",
      "染色体末端圆角(px)。引擎要求 ≥2，小于 2 会被强制改回 2。",
      "Rounded-cap radius of chromosome ends (px). The engine clamps values <2 back to 2.",
      imp=1, mn=2, default=3),
    P("RotateChr", ["genome"], "genome", "float", "染色体旋转角度", "Chromosome rotation",
      "整组染色体绕起点旋转的角度，>0 顺时针、<0 逆时针。",
      "Rotates the whole chromosome block about its start point; >0 clockwise.",
      imp=2, default=0.0),
    P("ShiftX", ["genome"], "genome", "float", "相对平移 X", "Relative shift X",
      "在默认布局基础上平移该基因组(px)，与 MoveToX 叠加。",
      "Translates this genome relative to the default layout (px); additive with MoveToX.",
      imp=2, default=0.0),
    P("ShiftY", ["genome"], "genome", "float", "相对平移 Y", "Relative shift Y",
      "在默认布局基础上平移该基因组(px)，与 MoveToY 叠加。",
      "Translates this genome relative to the default layout (px); additive with MoveToY.",
      imp=2, default=0.0),
    P("MoveToX", ["genome"], "genome", "float", "绝对定位 X", "Absolute position X",
      "把该基因组起点放到画布绝对 X 坐标（与 ShiftX 叠加）。手册中的 MoveX 是无效拼写。",
      "Absolute canvas X of the chromosome start (combined with ShiftX). 'MoveX' in the manual is a typo.",
      old=["MoveX"], imp=1),
    P("MoveToY", ["genome"], "genome", "float", "绝对定位 Y", "Absolute position Y",
      "把该基因组起点放到画布绝对 Y 坐标（与 ShiftY 叠加）。手册中的 MoveY 是无效拼写。",
      "Absolute canvas Y of the chromosome start (combined with ShiftY). 'MoveY' in the manual is a typo.",
      old=["MoveY"], imp=1),
    # ---------------------------------------------------------- genome_name
    P("GenomeName", ["genome"], "genome_name", "text", "基因组名称", "Genome label",
      "左侧斜体基因组名。默认取 .len 文件名去掉扩展名。", "Italic genome label on the left. Defaults to the .len basename.",
      imp=2),
    P("GenomeNameColor", ["genome"], "genome_name", "color", "基因组名颜色", "Genome label color",
      "默认取该基因组染色体条的颜色。", "Defaults to this genome's chromosome bar color.",
      imp=1),
    P("GenomeNameSizeRatio", ["genome"], "genome_name", "float", "基因组名字号比例", "Genome label size ratio",
      "基因组名字号 = font-size × 1.4 × 比例。历史文档中的 GenomeNameRatio 是无效拼写。",
      "Label font = font-size × 1.4 × ratio. 'GenomeNameRatio' in old docs is a typo.",
      old=["GenomeNameRatio"], imp=1, default=1.0),
    P("GenomeNameShiftX", ["genome"], "genome_name", "float", "基因组名水平偏移", "Genome label shift X",
      "基因组名水平微调(px)。", "Horizontal nudge of the genome label (px).", imp=0, default=0.0),
    P("GenomeNameShiftY", ["genome"], "genome_name", "float", "基因组名垂直偏移", "Genome label shift Y",
      "基因组名垂直微调(px)。", "Vertical nudge of the genome label (px).", imp=0, default=0.0),
    # ---------------------------------------------------------- chr_name
    P("ChrNameShow", ["genome"], "chr_name", "bool", "显示染色体名", "Show chromosome names",
      "在染色体条上方显示染色体名称。", "Draw the chromosome name above each bar.",
      imp=2),
    P("ChrNameSizeRatio", ["genome"], "chr_name", "float", "染色体名字号比例", "Chr name size ratio",
      "染色体名字号 = font-size × 1.2 × 比例。", "Name font = font-size × 1.2 × ratio.",
      imp=1, default=1.0),
    P("ChrNameColor", ["genome"], "chr_name", "color", "染色体名颜色", "Chr name color",
      "默认取该基因组染色体条颜色。", "Defaults to this genome's chromosome bar color.",
      imp=1),
    P("ChrNameShiftX", ["genome"], "chr_name", "float", "染色体名水平偏移", "Chr name shift X",
      "染色体名水平微调(px)，可与 .len 行内属性叠加。", "Horizontal nudge (px); additive with per-row values.",
      imp=0, default=0.0),
    P("ChrNameShiftY", ["genome"], "chr_name", "float", "染色体名垂直偏移", "Chr name shift Y",
      "染色体名垂直微调(px)，可与 .len 行内属性叠加。", "Vertical nudge (px); additive with per-row values.",
      imp=0, default=0.0),
    P("ChrNameRotate", ["genome"], "chr_name", "float", "染色体名旋转", "Chr name rotation",
      "在 RotateChr 基础上追加的名称旋转角度。", "Extra rotation added on top of RotateChr.",
      imp=0, default=0.0),
    # ---------------------------------------------------------- axis
    P("ShowCoordinates", ["genome"], "axis", "bool", "显示坐标轴", "Show coordinate axis",
      "该基因组是否绘制坐标刻度与标签。", "Draw the coordinate scale for this genome.",
      imp=2),
    P("ScaleNum", ["genome"], "axis", "int", "刻度份数", "Scale divisions",
      "坐标轴刻度分割份数（0..N 共 N+1 个刻度）。", "Number of axis tick divisions (N+1 ticks).",
      imp=1, mn=1, default=10),
    P("ScaleUpDown", ["genome"], "axis", "enum", "坐标轴位置", "Axis side",
      "引擎只识别 “Up”（刻度画在染色体上方）；不设置时：基因组1默认上方，其余默认下方。",
      "The engine only recognises \"Up\" (ticks above the bar); unset = above for genome 1, below otherwise.",
      imp=1, choices=["Up"]),
    P("ScaleUnit", ["genome"], "axis", "int", "刻度单位(bp)", "Scale unit (bp)",
      "目标刻度间距(bp)。推导出的份数必须在 2..100 之间，否则引擎回退到 ScaleNum。",
      "Target tick spacing in bp; the derived count must land in 2..100 or the engine falls back to ScaleNum.",
      imp=1, mn=1),
    P("LabelUnit", ["genome"], "axis", "text", "坐标单位标签", "Label unit",
      "坐标后缀。默认按长度自动选 M / K / b，也可自定义字符串。",
      "Axis suffix. Auto M/K/b by default, or any custom string.",
      imp=1),
    P("LablefontsizeRatio", ["genome"], "axis", "float", "坐标字号比例", "Axis font ratio",
      "坐标标签字号 = 比例 × font-size。注意拼写是引擎历史拼写 Lable。",
      "Axis label font = ratio × font-size. Note the engine's 'Lable' spelling.",
      imp=1, default=1.0),
    P("LablePrecision", ["genome"], "axis", "int", "坐标小数位数", "Axis decimals",
      "坐标标签保留的小数位数（默认 1）。未写入官方文档但引擎真实读取。",
      "Decimal places in axis labels (default 1). Real but undocumented in the manual.",
      imp=0, mn=0, default=1),
    P("RotateAxisText", ["genome"], "axis", "float", "坐标文字旋转", "Axis text rotation",
      "在 RotateChr 基础上追加的坐标文字旋转角度。", "Extra rotation of the axis text on top of RotateChr.",
      imp=0, default=0.0),
    P("NoShowLabel", ["genome"], "axis", "bool", "隐藏坐标数字", "Hide axis numbers",
      "只要该键存在即隐藏坐标数字（保留刻度线）。写 0 也会生效。",
      "Hides the axis numbers whenever the key exists (ticks stay). Even 0 triggers it.",
      imp=0, presence=True),
    # ---------------------------------------------------------- spe_region
    P("SpeRegionFile", ["genome"], "spe_region", "file", "特殊区域文件", "Special region file",
      "高亮/注释区域文件（.gz 支持）。格式: chr start end [属性]。可对指定行加 SN=文字 或 CDS/UTR/mRNA 关键字改变样式。",
      "Region highlight/annotation file (.gz ok). Format: chr start end [attrs]. Rows accept SN=text or CDS/UTR/mRNA keywords.",
      imp=2),
    P("ZoomRegion", ["genome"], "spe_region", "text", "放大区域", "Zoom region",
      "只显示某条染色体的指定区间，格式 chr:start:end（如 Chr6:12914310:18879240），区域必须在该染色体范围内。",
      "Show a single chromosome region chr:start:end (must lie inside that chromosome).",
      imp=2),
    P("SpeRegionWidthRatio", ["genome"], "spe_region", "float", "特殊区域高度比例", "Region height ratio",
      "特殊区域条相对染色体条半高的倍数；也可在区域文件行内用 SpeRegionWidthRatio= 设置（乘法叠加）。",
      "Bar half-height multiplier for special regions; per-row values multiply.",
      imp=1, default=1.0),
    # ---------------------------------------------------------- link
    P("StyleUpDown", ["link"], "link", "enum", "链接方向", "Link direction",
      "五种取值(区分大小写): UpDown/DownUp/UpUp/DownDown/line(直线)。不设置时按两个基因组的上下顺序自动选择曲线方向。",
      "Case-sensitive: UpDown/DownUp/UpUp/DownDown/line. Unset = auto by genome order.",
      imp=2, choices=STYLE_CHOICES),
    P("lineType", ["link"], "link", "text", "直线模式", "Line type",
      "写 line 表示直线（与 StyleUpDown=line 等效，优先级更高）。",
      "\"line\" forces straight links (equivalent to StyleUpDown=line, higher priority).",
      imp=1),
    P("Reverse", ["link"], "link", "bool", "反向链接", "Reverse links",
      "交换链接在两条染色体上的起止附着点。", "Swaps the start/end attachment points of the ribbon.",
      imp=2, default="0"),
    P("HeightRatio", ["link"], "link", "float", "链接高度比例", "Link height ratio",
      "链接带高度的放大/缩小比例，可为负（示例中使用 -1.5）。历史文档中的 HightRation 是无效拼写，GUI 会自动改写。",
      "Scales the link band height; negative values are legal. The 'HightRation' typo in old docs is auto-corrected.",
      old=["HightRation"], imp=2, default=1.0),
    P("OutsideWidthDeta", ["link"], "link", "float", "链接外扩距离", "Outside width delta",
      "链接带与染色体条之间的间隙(px)，正值更远、负值更近（默认 -2）。",
      "Gap between ribbon and chromosome bar (px); default -2.",
      imp=0, default=-2.0),
    P("ShortLinkLineRefA", ["link"], "link", "float", "A端缩短量", "Shorten at RefA",
      "链接带在基因组A一侧的缩短量(px)，负值加长。",
      "Shortens the ribbon at the RefA end (px); negative lengthens.",
      imp=1, default=0.0),
    P("ShortLinkLineRefB", ["link"], "link", "float", "B端缩短量", "Shorten at RefB",
      "链接带在基因组B一侧的缩短量(px)，负值加长。",
      "Shortens the ribbon at the RefB end (px); negative lengthens.",
      imp=1, default=0.0),
    # ---------------------------------------------------------- style (shared)
    P("fill", ["genome", "link"], "style", "color", "填充色", "Fill color",
      "基因组: 染色体条填充色；链接: 共线性带填充色（设置后覆盖调色板）。",
      "Genome: chromosome bar fill; link: ribbon fill (overrides the palette).",
      imp=2),
    P("stroke", ["genome", "link"], "style", "color", "描边色", "Stroke color",
      "基因组: 染色体条描边；链接: 共线性带描边。", "Genome: bar outline; link: ribbon outline.",
      imp=2),
    P("stroke-width", ["genome", "link"], "style", "float", "描边宽度", "Stroke width",
      "描边线宽(px)，默认 1，0 表示无边框。", "Outline width (px), default 1; 0 = no outline.",
      imp=1, mn=0, default=1.0),
    P("stroke-opacity", ["genome", "link"], "style", "float", "描边不透明度", "Stroke opacity",
      "0..1。基因组默认 1；链接默认 0.92。", "0..1. Genome default 1; link default 0.92.",
      imp=1, mn=0, mx=1),
    P("fill-opacity", ["genome", "link"], "style", "float", "填充不透明度", "Fill opacity",
      "0..1。基因组默认 1；链接默认 0.92。", "0..1. Genome default 1; link default 0.92.",
      imp=1, mn=0, mx=1),
    # ---------------------------------------------------------- color
    P("GenomeColorBrewer", ["global"], "color", "enum", "基因组调色板", "Genome palette",
      "染色体条配色，取自引擎内置 RColorBrewer（36 个）。未知名字会导致引擎除零崩溃。",
      "Palette for chromosome bars (36 built-in RColorBrewer names). Unknown names crash the engine.",
      imp=2, default="Dark2"),
    P("ChrColorBrewer", ["global"], "color", "enum", "链接调色板", "Link palette",
      "共线性链接带配色（按染色体在 .len 中的行号循环取色，默认 Paired）。",
      "Palette for link ribbons (indexed by chr row number; default Paired).",
      imp=2, default="Paired"),
    P("SpeRegionColorBrewer", ["global"], "color", "enum", "特殊区域调色板", "Region palette",
      "特殊区域高亮配色（默认 Dark2）。", "Palette for special-region highlights (default Dark2).",
      imp=1, default="Dark2"),
]

# --------------------------------------------------------------------------
# code extraction
# --------------------------------------------------------------------------
_RE_READ = re.compile(
    r'\$HashConfi\{(?:"global"|\$ThisGG|\$Level|\$AA|\$BB|\$NumberLevel|'
    r'"GenomeALL"|"Link\$NLink")\}\{"([^"]+)"\}')
_RE_SEED = re.compile(
    r'\$HashConfi\{"(?:global|GenomeALL)"\}\{"([^"]+)"\}\s*=\s*([^;$]+);')
_RE_MAXCOL = re.compile(r'\$MaxColNum\{"([A-Za-z0-9]+)"\}\s*=\s*(\d+)\s*;')
_RE_COLDATA = re.compile(
    r'\$HashColData\{"([A-Za-z0-9]+)"\}\{(\d+)\}\{([RGB])\}\s*=\s*"([^"]*)"')

_SECTION_OF = {"global": "global", "$ThisGG": "genome", "$Level": "genome",
               "$AA": "genome", "$BB": "genome", "$NumberLevel": "genome",
               "GenomeALL": "genome", "Link$NLink": "link"}


def extract_code_keys(text):
    """{(scope, key)} actually read by the engine."""
    out = set()
    for m in _RE_READ.finditer(text):
        sec = _RE_READ_RECENT[0]
        out.add((sec, m.group(1)))
    return out


# the section variable is part of the whole match; recover it per occurrence
_READ_FULL = re.compile(
    r'\$HashConfi\{("global"|\$ThisGG|\$Level|\$AA|\$BB|\$NumberLevel|'
    r'"GenomeALL"|"Link\$NLink")\}\{"([^"]+)"\}')


def extract_code_keys2(text):
    out = set()
    for m in _READ_FULL.finditer(text):
        sec = m.group(1).strip('"')
        out.add((_SECTION_OF[sec], m.group(2)))
    return out


def extract_seed_defaults(text):
    """{scope.key: literal} from the engine's pre-seed block (dead keys kept)."""
    out = {}
    for m in _RE_SEED.finditer(text):
        val = m.group(2).strip().strip('"')
        if val.startswith("$"):          # copy-style assignments, not defaults
            continue
        # locate the scope of this seed line
        start = max(0, m.start() - 60)
        ctx = text[start:m.start()]
        scope = "genome" if '"GenomeALL"' in ctx else "global"
        out[(scope, m.group(1))] = val
    return out


def extract_palettes(text):
    """{name: {max, qualitative, colors:[hex...]}} from the hard-coded data.

    NOTE: PiYG has $HashColData entries but NO %MaxColNum entry, which makes
    the engine crash ("Illegal modulus zero", verified with the real engine)
    — it is deliberately excluded by keying on %MaxColNum.
    """
    maxcol = {m.group(1): int(m.group(2)) for m in _RE_MAXCOL.finditer(text)}
    data = {}
    for m in _RE_COLDATA.finditer(text):
        name, level, comp = m.group(1), int(m.group(2)), m.group(3)
        vals = [int(v) for v in m.group(4).split(",") if v.strip()]
        data.setdefault(name, {}).setdefault(level, {})[comp] = vals
    palettes = {}
    for name, mx in maxcol.items():
        levels = data.get(name, {})
        lvl = mx if mx in levels else (max(levels) if levels else None)
        comps = levels.get(lvl, {})
        colors = []
        if all(c in comps for c in "RGB"):
            n = min(len(comps["R"]), len(comps["G"]), len(comps["B"]))
            colors = ["#%02X%02X%02X" % (comps["R"][i], comps["G"][i], comps["B"][i])
                      for i in range(n)]
        palettes[name] = {"max": mx, "qualitative": name in QUALITATIVE_PALETTES,
                          "colors": colors}
    return palettes


def main():
    if not ENGINE.is_file():
        print(f"engine not found: {ENGINE}")
        return 2
    text = ENGINE.read_text(encoding="utf-8", errors="replace")

    code_keys = extract_code_keys2(text)
    meta_keys = {(s, p["name"]) for p in META for s in p["scope"]}

    in_meta_not_code = sorted(f"{s}.{k}" for s, k in meta_keys - code_keys)
    in_code_not_meta = sorted(f"{s}.{k}" for s, k in code_keys - meta_keys
                              if (s, k) not in DEAD_KEYS)
    dead_found = sorted(f"{s}.{k}" for s, k in DEAD_KEYS if (s, k) in code_keys)

    palettes = extract_palettes(text)
    bad_palettes = sorted(n for n, e in palettes.items() if not e["colors"])

    aliases = {}
    for p in META:
        for old in p["old_names"]:
            aliases[old] = p["name"]

    schema = {
        "meta": {
            "tool": "NGenomeSyn",
            "version": "1.50",
            "engine_source": str(ENGINE.relative_to(ROOT)),
            "generated_by": "gui/tools/gen_schema.py",
        },
        "categories": CATEGORIES,
        "plot_types": [],
        "palettes": {"builtin": palettes, "files": {}},
        "aliases": aliases,
        "value_aliases": VALUE_ALIASES,
        "style_choices": STYLE_CHOICES,
        "params": META,
        "validation": {
            "in_meta_not_in_code": in_meta_not_code,
            "in_code_not_in_meta": in_code_not_meta,
            "dead_keys_confirmed": dead_found,
            "palettes_without_colors": bad_palettes,
        },
    }
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(schema, ensure_ascii=False, indent=1) + "\n",
                   encoding="utf-8")

    print(f"params: {len(META)}  palettes: {len(palettes)}  aliases: {len(aliases)}")
    print(f"in META but never read by code: {in_meta_not_code or 'none'}")
    print(f"in code but not in META:        {in_code_not_meta or 'none'}")
    print(f"dead keys confirmed:            {dead_found or 'none'}")
    print(f"palettes without colors:        {bad_palettes or 'none'}")
    ok = not (in_meta_not_code or in_code_not_meta or bad_palettes)
    print("validation:", "OK" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
