#!/usr/bin/env python3
"""Generate the WeChat / social-media article draft for the NGenomeSyn GUI.

One content model, two renderers (same design as gen_gui_manual.py):
  gui/doc/NGenomeSyn_GUI_WeChat_Article.docx   editable in Word / WPS
  gui/doc/NGenomeSyn_GUI_WeChat_Article.md     paste-ready for the editor

Chinese (the WeChat account audience). Screenshots from gui/doc/*.png are
embedded when present; the .md always references them by relative path.

Run:  python3 gui/tools/gen_wechat_article.py
"""
import os
import sys
from pathlib import Path

os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

ROOT = Path(__file__).resolve().parents[2]
DOC = ROOT / "gui" / "doc"
SHOT_HOME = DOC / "GUI_Home.png"
SHOT_DATA = DOC / "GUI_Data.png"

GITHUB = "https://github.com/hewm2008/NGenomeSyn"
DOI = "https://doi.org/10.1093/bioinformatics/btad121"
MANUAL_ZH = "NGenomeSyn_GUI_manual_Chinese.pdf"
MANUAL_EN = "NGenomeSyn_GUI_manual_English.pdf"


def build_blocks():
    """[(kind, payload)] — kinds: h1 h2 h3 p note ul code img quote."""
    B = []
    B.append(("h1", "NGenomeSyn 图形界面：多基因组共线性可视化，一键出图"))
    B.append(("note", "作者：He W, Yang J, Jing Y, Xu L, Yu K, Fang X ｜ "
                       "Bioinformatics, 2023; btad121 ｜ %s" % DOI))

    B.append(("h2", "一、标题备选"))
    for t in [
        "NGenomeSyn GUI：拖几个文件，秒出多基因组共线性图",
        "不用手写 conf 了：NGenomeSyn 图形界面让共线性绘图快到点一下",
        "66 个参数、可视化调参：NGenomeSyn 图形界面使用指南",
        "从 .len/.link 到成图：NGenomeSyn 图形界面的 5 步工作流",
    ]:
        B.append(("ul", [t]))

    B.append(("h2", "二、导语"))
    B.append(("p", "做多基因组共线性（synteny）分析，最花时间的往往不是分析本身，"
                    "而是把比对结果整理成符合工具要求的 .len / .link / conf 文件——"
                    "格式写错一个字段，引擎就会在画图途中直接退出。"))
    B.append(("p", "NGenomeSyn 图形界面（GUI）把这条链路做成了三栏工作台："
                    "左边管理数据、中间实时预览、右边调参数，"
                    "全程不需要离开键盘去改配置文件。"))
    B.append(("p", "关键的是：<b>引擎一行代码都没有改</b>。"
                    "GUI 只做参数编排与出图，所有行为与命令行完全一致。"))

    B.append(("h2", "三、功能亮点"))

    B.append(("h3", "1｜两个数据列表，各司其职"))
    B.append(("p", "基因组文件 GenomeInfoFile1..N 与链接文件 LinkFileRefA VsRefB "
                    "分列上下两栏，格式提示常驻；点击任一行即可预览该文件前 8 行，"
                    "选中态在左右两栏同步。"))
    B.append(("p", "链接用 A:/B: 两个下拉直接指定它连接哪两个基因组，"
                    "不用记基因组编号与 Link 序号的对应关系。"))

    B.append(("h3", "2｜66 个参数，全部标注引擎真实默认值"))
    B.append(("p", "参数按画布、标题、基因组、坐标轴、链接、特殊区域、调色板分组，"
                    "中英双语说明、取值范围、默认值都来自对引擎源码的交叉校验，"
                    "不是抄文档。"))
    B.append(("p", "其中有 <b>17 个参数官方文档里从未提及</b>，但引擎真实读取——"
                    "例如 LablePrecision（坐标小数位）、OutsideWidthDeta（链接外扩）、"
                    "ShortLinkLineRefA/B（两端缩短量），GUI 让它们终于可见。"))

    B.append(("h3", "3｜35 个调色板，色块预览后再选"))
    B.append(("p", "调色板选择器直接画出 RColorBrewer 色条，"
                    "分别控制染色体条、链接带、特殊区域。"))
    B.append(("note", "顺带排掉一个坑：引擎的调色板名如果写错（例如 PiYG），"
                      "会直接触发除零崩溃；GUI 在运行前就会拦下。"))

    B.append(("h3", "4｜运行前先检查，不让引擎画到一半崩掉"))
    B.append(("p", ".len/.link 列数不足、Start 与 End 同时大于 1、ZoomRegion 越界、"
                    "调色板名非法、StyleUpDown 拼错……这些问题 GUI 会在运行前列成清单，"
                    "而不是等引擎报错。"))

    B.append(("h3", "5｜历史错拼自动改写"))
    B.append(("p", "HightRation → HeightRatio、MainCor → MainColor、"
                    "UpUP → UpUp、GenomeNameRatio → GenomeNameSizeRatio……"
                    "这些错拼在旧 conf、README 和官方 PDF 里都存在，引擎原本会静默忽略。"
                    "GUI 读入时自动改写，并在日志中逐条列出改写清单，绝不静默。"))

    B.append(("h3", "6｜零修改引擎，跨平台"))
    B.append(("p", "引擎保持原样。GUI 通过预解压 .gz（不再依赖系统 gzip）、"
                    "始终以 -NoPng 方式调用（不依赖 ImageMagick）、"
                    "以「SVG 是否生成」判定成功（规避引擎反置的退出码），"
                    "在 Windows / Linux / macOS 上行为一致。"))
    B.append(("p", "实时预览支持滚轮缩放、拖拽平移，可导出 SVG / 高分辨率 PNG / PDF。"))

    B.append(("h2", "四、五步出图"))
    for i, s in enumerate([
        "左侧「基因组文件」添加至少 2 个 .len 文件（顺序即图中顺序，支持 .gz）。",
        "「链接文件」添加 .link，用 A:/B: 指定该链接连接的两个基因组。",
        "（可选）在右侧参数页签调整画布、染色体样式、坐标轴、链接样式与调色板。",
        "点击「运行绘图」或按 F5；开启「自动刷新」后参数一改即刻重画。",
        "用预览区按钮导出 SVG / PNG / PDF。",
    ], 1):
        B.append(("ul", [f"{i}. {s}"]))

    B.append(("h2", "五、界面一览"))
    B.append(("p", "左：双数据列表 + 选中联动预览；中：实时预览与导出；"
                    "右：参数页签（全局参数 · GenomeALL · Genome 1..N · "
                    "LinkALL · Link 1..M · 参数总览）。"))
    B.append(("img", (str(SHOT_HOME), "主界面（已载入官方示例数据）")))
    B.append(("img", (str(SHOT_DATA),
                      "左栏细节：上下两个文件列表，点击任一行即预览，选中态两栏同步")))

    B.append(("h2", "六、下载与使用"))
    B.append(("code", "Linux / macOS:  ./NGenomeSynGUI.sh\n"
                      "Windows:          NGenomeSynGUI.bat"))
    B.append(("p", "首次运行会自动安装 PySide6；Windows 需安装 Perl，"
                    "或把便携版 Strawberry Perl 解压到 gui_runtime/perl/。"))
    B.append(("ul", [
        "代码与示例：%s" % GITHUB,
        "GUI 使用手册（中文）：gui/doc/%s" % MANUAL_ZH,
        "GUI manual (English)：gui/doc/%s" % MANUAL_EN,
    ]))

    B.append(("h2", "七、引用"))
    B.append(("p", "使用 NGenomeSyn 发表成果时，请引用："))
    B.append(("p", "He W, Yang J, Jing Y, Xu L, Yu K, Fang X. NGenomeSyn: an "
                    "easy-to-use and flexible tool for publication-ready "
                    "visualization of syntenic relationships across multiple "
                    "genomes. Bioinformatics, 2023; btad121. %s" % DOI))
    B.append(("note", "完整文章信息见项目 README 的 Citation 章节："
                      "https://github.com/hewm2008/NGenomeSyn#7-citation"))

    B.append(("h2", "八、联系"))
    B.append(("p", "邮箱：hewm2008@gmail.com / hewm2008@qq.com ｜ QQ 交流群：125293663"))
    B.append(("note", "本文为可编辑草稿，截图与文字均可自由修改后发布。"))
    return B


# ---------------------------------------------------------------- renderers
def _png_size(path):
    """(width, height) in pixels read from the PNG header, or None."""
    try:
        with open(path, "rb") as fh:
            head = fh.read(24)
        if head[:8] == b"\x89PNG\r\n\x1a\n":
            return (int.from_bytes(head[16:20], "big"),
                    int.from_bytes(head[20:24], "big"))
    except OSError:
        pass
    return None


def _fit_inches(path, max_w=6.0, max_h=7.5, dpi=96.0):
    """Display size in inches that fits the page box.

    A fixed width alone is not enough: a tall narrow screenshot (e.g. 300x651)
    stretched to 6in would be ~13in tall and spill over the page. Fit both
    dimensions and never enlarge past the native pixel size.
    """
    size = _png_size(path)
    if not size:
        return max_w, None                      # unknown size: width only
    pw, ph = size
    w = min(max_w, pw / dpi)
    h = w * ph / pw
    if h > max_h:
        h = max_h
        w = h * pw / ph
    return w, h


def _to_docx(B, path):
    import docx
    from docx.shared import Inches, Pt
    doc = docx.Document()
    for kind, payload in B:
        if kind in ("h1", "h2", "h3"):
            doc.add_heading(payload, level=int(kind[1]))
        elif kind == "p":
            doc.add_paragraph(payload)
        elif kind == "note":
            p = doc.add_paragraph(payload)
            for r in p.runs:
                r.italic = True
                r.font.size = Pt(9)
        elif kind == "ul":
            for item in payload:
                doc.add_paragraph(item, style="List Bullet")
        elif kind == "code":
            p = doc.add_paragraph()
            run = p.add_run(payload)
            run.font.name = "Consolas"
            run.font.size = Pt(9.5)
        elif kind == "img":
            img_path, cap = payload
            if Path(img_path).is_file():
                w_in, h_in = _fit_inches(img_path)
                kw = {"width": Inches(w_in)}
                if h_in:
                    kw["height"] = Inches(h_in)
                doc.add_picture(str(img_path), **kw)
                doc.add_paragraph(cap)
    doc.save(str(path))


def _to_md(B, dest):
    lines = []
    for kind, payload in B:
        if kind == "h1":
            lines.append("# %s" % payload)
        elif kind == "h2":
            lines.append("\n## %s" % payload)
        elif kind == "h3":
            lines.append("\n### %s" % payload)
        elif kind == "p":
            lines.append(payload)
        elif kind == "note":
            lines.append("> %s" % payload)
        elif kind == "ul":
            lines.append("")
            for item in payload:
                lines.append("- %s" % item)
        elif kind == "code":
            lines.append("\n```\n%s\n```" % payload)
        elif kind == "img":
            img_path, cap = payload
            try:
                rel = Path(img_path).relative_to(dest)
            except ValueError:
                rel = Path(img_path)
            lines.append("\n![%s](%s)" % (cap or "", rel.as_posix()))
            if cap:
                lines.append("*%s*" % cap)
    (dest / "NGenomeSyn_GUI_WeChat_Article.md").write_text(
        "\n".join(lines) + "\n", encoding="utf-8")


def generate(dest_dir=None):
    dest = Path(dest_dir or DOC)
    dest.mkdir(parents=True, exist_ok=True)
    B = build_blocks()
    docx_path = dest / "NGenomeSyn_GUI_WeChat_Article.docx"
    _to_docx(B, docx_path)
    _to_md(B, dest)
    return {"docx": docx_path,
            "md": dest / "NGenomeSyn_GUI_WeChat_Article.md"}


def main():
    out = generate()
    for k, v in out.items():
        print("%-5s -> %s  (%d bytes)" % (k, v, v.stat().st_size))
    return 0


if __name__ == "__main__":
    sys.path.insert(0, str(ROOT))
    sys.exit(main())
