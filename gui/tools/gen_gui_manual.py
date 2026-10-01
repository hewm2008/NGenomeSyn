#!/usr/bin/env python3
"""Generate the NGenomeSyn GUI manual (PDF via Qt, DOCX via python-docx).

One content model, two renderers — the same design as RectChr's generator.
Chapter 5 (parameter reference) is auto-built from gui/resources/params_schema.json,
so the manual can never drift from the schema. Runs headless (offscreen QPA).

Run:  python3 gui/tools/gen_gui_manual.py [dest_dir]
"""
import os
import re
import sys
from pathlib import Path

os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

ROOT = Path(__file__).resolve().parents[2]
SCHEMA = ROOT / "gui" / "resources" / "params_schema.json"
SHOTS_HOME = ROOT / "gui" / "doc" / "GUI_Home.png"
SHOTS_DATA = ROOT / "gui" / "doc" / "GUI_Data.png"

_TITLES = {
    "zh": "NGenomeSyn 图形界面使用手册",
    "en": "NGenomeSyn GUI Manual",
}


def _load_params():
    import json
    data = json.loads(SCHEMA.read_text(encoding="utf-8"))
    return data


# --------------------------------------------------------------------------
# content model: list of (kind, payload)
#   kinds: h1, h2, h3, p, note, code, ul, table
# --------------------------------------------------------------------------
def _build_blocks(lang, gui_ver, engine_ver, data):
    B = []
    zh = lang == "zh"
    cats = data["categories"]

    def T(zh_t, en_t):
        return zh_t if zh else en_t

    B.append(("h1", _TITLES[lang]))
    B.append(("p", T("GUI 版本", "GUI version") + f": {gui_ver}    |    "
              + T("引擎版本", "Engine") + f": NGenomeSyn {engine_ver} (hewm2008)"))

    B.append(("h2", T("1. 界面总览", "1. Interface overview")))
    B.append(("p", T("图形界面为三栏工作台：左侧管理数据文件（基因组 .len 与链接 .link 两个列表），"
                     "中间为实时 SVG 预览（滚轮缩放、拖拽平移，可导出 PNG/PDF），"
                     "右侧为参数页签（全局参数 · GenomeALL · Genome 1..N · LinkALL · Link 1..N · 参数总览）。"
                     "底部为运行日志。",
                     "The GUI is a three-column workbench: the left dock manages the two data lists "
                     "(genome .len files and link .link files), the centre shows a live SVG preview "
                     "(wheel zoom, drag pan, PNG/PDF export), and the right dock holds the parameter "
                     "tabs (Global · GenomeALL · Genome 1..N · LinkALL · Link 1..N · Parameters summary). "
                     "The run log sits at the bottom.")))
    B.append(("p", T("所有参数均带引擎真实默认值、取值范围与中英双语说明（悬停可见）；"
                     "打开已有 conf 时自动翻译历史错拼键名并在日志中列出改写清单。",
                     "Every parameter shows the engine's real default, its range and bilingual "
                     "descriptions (hover for details). Legacy misspelled keys are auto-corrected on "
                     "load and listed in the run log.")))

    B.append(("img", (str(SHOTS_HOME), T("主界面：左=数据文件与预览，中=实时预览，右=参数页签",
                                         "Main window: data files + preview (left), live preview (centre), parameter tabs (right)"))))

    B.append(("h2", T("2. 快速开始", "2. Quick start")))
    for i, step in enumerate([
            T("在左侧「基因组文件」面板添加至少 2 个 .len 文件（顺序即图中顺序，支持 .gz）。",
              "Add at least two .len files in the left Genome files panel (row order = figure order, .gz supported)."),
            T("在「链接文件」面板添加 .link 文件，并用 A:/B: 选框指定该链接连接的两个基因组编号。",
              "Add .link files in the Link files panel and pick the two genome numbers with the A:/B: boxes."),
            T("（可选）在右侧参数页签调整画布、染色体样式、坐标轴、链接样式与调色板。",
              "(Optional) Adjust canvas, chromosome style, axis, link style and palettes in the parameter tabs."),
            T("点击「运行绘图」或按 F5；打开「自动刷新」后参数一改即自动重画。",
              "Click Run (or F5). With Auto refresh on, every edit re-renders automatically."),
            T("用预览下方的按钮导出 SVG / PNG / PDF。",
              "Export SVG / PNG / PDF with the buttons above the preview.")], 1):
        B.append(("ul", [f"{i}. {step}"]))

    B.append(("h2", T("3. 数据格式与路径", "3. Data formats & paths")))
    B.append(("img", (str(SHOTS_DATA), T("左栏细节：上下两个文件列表（基因组 / 链接），"
                                        "点击任一行即可预览该文件的前 8 行，选中态两栏同步",
                                        "Left dock: the two file lists; click any row to preview "
                                        "its first 8 rows, selection syncs across both docks"))))
    B.append(("h3", T("基因组文件 GenomeInfoFileN（.len）", "Genome info files (GenomeInfoFileN, .len)")))
    B.append(("code", "Chr1  1  230000\nChr2  1  190000   fill=red stroke-width=0"))
    B.append(("ul", [
        T("空白分隔，至少 3 列：染色体 起点 终点 [属性…]；行顺序即图中顺序。",
          "Whitespace separated, at least 3 columns: chr start end [attrs…]; row order = figure order."),
        T("若一行写为「终点 起点」则该染色体反向互补显示。",
          "A row written as \"end start\" renders that chromosome reverse-complemented."),
        T("编号必须从 1 开始且连续（GenomeInfoFile1、GenomeInfoFile2 …）。",
          "Numbers must be contiguous from 1 (GenomeInfoFile1, GenomeInfoFile2, …)."),
        T("引擎要求：Start 与 End 不能同时 > 1（GUI 会提前检查）。",
          "Engine rule: Start and End must not both be > 1 (the GUI pre-checks this)."),
    ]))
    B.append(("h3", T("链接文件 LinkFileRefA VsRefB（.link）", "Link files (LinkFileRefA VsRefB, .link)")))
    B.append(("code", "Chr1  1000  50000  Chr1  900  49500\nChr1  60000  120000  Chr2  1000  61000"))
    B.append(("ul", [
        T("空白分隔，至少 6 列：chrA 起A 终A chrB 起B 终B [属性…]。",
          "Whitespace separated, at least 6 columns: chrA startA endA chrB startB endB [attrs…]."),
        T("conf 中该行出现的先后顺序决定 Link1、Link2 … 的编号。",
          "The ordinal position of the line in the conf IS the Link1, Link2, … index."),
    ]))
    B.append(("h3", T("路径与 .gz", "Paths & .gz")))
    B.append(("ul", [
        T("conf 中的相对路径以 conf 文件所在目录为基准（GUI 会自动写为绝对路径）。",
          "Relative paths in a conf resolve against the conf's own directory (the GUI always writes absolute paths)."),
        T(".gz 输入由 GUI 预先解压后交给引擎，不再依赖系统 gzip，且保留原文件名推导的基因组默认名。",
          ".gz inputs are pre-decompressed by the GUI (no system gzip needed) while keeping the original "
          "basename, so derived genome labels stay unchanged."),
    ]))

    B.append(("h2", T("4. 特殊区域与放大", "4. Special regions & zoom")))
    B.append(("ul", [
        T("ZoomRegion=chr:start:end（如 Chr6:12914310:18879240）只显示该区间，区间必须落在该染色体范围内。",
          "ZoomRegion=chr:start:end shows a single region; it must lie inside that chromosome."),
        T("SpeRegionFile 指向的区域文件每行为 chr start end [属性]，可用 SN=文字 添加标注文字；"
          "第 4 列写 CDS/UTR/mRNA 关键字可获得预置样式。",
          "SpeRegionFile rows are chr start end [attrs]; SN=text adds a label, and a bare CDS/UTR/mRNA "
          "keyword in column 4 picks a preset style."),
    ]))

    B.append(("h2", T("5. 参数参考", "5. Parameter reference")))
    B.append(("p", T("以下参数由 schema 自动生成，与 GUI 显示一致；「legacy」为可被自动改写的历史拼写。",
                     "Generated from the schema, matching the GUI; \"legacy\" lists misspellings that are auto-corrected.")))
    for cat, meta in cats.items():
        if cat == "files":
            continue
        params = [p for p in data["params"] if p["category"] == cat]
        if not params:
            continue
        B.append(("h3", meta.get(lang, meta.get("zh", cat))))
        rows = [[T("参数", "Parameter"), T("类型", "Type"), T("默认值", "Default"),
                 T("说明", "Description")]]
        for p in params:
            legacy = (" / legacy: " + ", ".join(p["old_names"])) if p.get("old_names") else ""
            d = p.get("default")
            rows.append([f"{p['name']}{legacy}",
                         str(p.get("type") or ""),
                         "" if d in (None, "") else str(d),
                         (p.get("desc_zh") if zh else p.get("desc_en")) or ""])
        B.append(("table", rows))

    B.append(("h2", T("6. 调色板", "6. Color palettes")))
    n_pal = len(data.get("palettes", {}).get("builtin", {}))
    B.append(("p", T(f"引擎内置 {n_pal} 个 RColorBrewer 调色板（GUI 调色板选择器可直接预览）。"
                     "三个键分别控制：GenomeColorBrewer（染色体条）、ChrColorBrewer（链接带，按染色体行号取色）、"
                     "SpeRegionColorBrewer（特殊区域）。未知名字会导致引擎崩溃，GUI 会提前校验。",
                     f"The engine ships {n_pal} built-in RColorBrewer palettes (preview them in the GUI picker). "
                     "Three keys control them: GenomeColorBrewer (chromosome bars), ChrColorBrewer (link ribbons, "
                     "indexed by chromosome row), SpeRegionColorBrewer (special regions). Unknown names crash the "
                     "engine; the GUI validates them before running.")))

    B.append(("h2", T("7. 常见问题", "7. FAQ")))
    for q, a in [
        (T("运行失败提示 no-svg？", "Run fails with no-svg?"),
         T("查看底部运行日志中引擎的输出；常见原因是文件路径不存在、.len/.link 列数不足，"
           "或 ZoomRegion 区间越界——GUI 的配置检查会在运行前拦截绝大多数问题。",
           "Check the engine output in the run log. Common causes: missing files, too few columns in "
           ".len/.link, or a ZoomRegion outside the chromosome — the GUI pre-check catches most of these.")),
        (T("打开旧 conf 后图变了对不对？", "The figure changed after opening an old conf — is that right?"),
         T("如果 conf 含有历史错拼键（如 HightRation、MainCor），引擎原本会静默忽略它们；GUI 自动改写为"
           "正确键名并在日志列出清单，因此图按「作者本意」渲染。",
           "If the conf contains legacy misspellings (HightRation, MainCor, …) the engine silently ignored "
           "them; the GUI corrects them and lists every rewrite in the log, so the figure follows the "
           "author's intent.")),
        (T("Linux/macOS 之外能运行吗？", "Does it run outside Linux/macOS?"),
         T("Windows 用户请将便携版 Strawberry Perl 解压到 gui_runtime/perl/（见发行包说明），"
           "或正常安装 Perl 后直接双击 NGenomeSynGUI.bat。",
           "On Windows, unzip portable Strawberry Perl into gui_runtime/perl/ (see the release notes) or "
           "install Perl normally and double-click NGenomeSynGUI.bat.")),
    ]:
        B.append(("h3", q))
        B.append(("p", a))

    B.append(("h2", T("8. 引用与联系", "8. Citation & contact")))
    B.append(("h3", T("引用文章", "Cite the article")))
    B.append(("p", T("使用 NGenomeSyn 发表的成果时，请引用：",
                     "If you use NGenomeSyn in your work, please cite:")))
    B.append(("code", "He W, Yang J, Jing Y, Xu L, Yu K, Fang X. NGenomeSyn: an easy-to-use and flexible "
                      "tool for publication-ready visualization of syntenic relationships across multiple "
                      "genomes. Bioinformatics, 2023, btad121.\n"
                      "https://doi.org/10.1093/bioinformatics/btad121"))
    B.append(("note", T("完整文章信息见项目 README 的 Citation 章节。",
                        "See the Citation section of the project README for the full article details.")))
    B.append(("h3", T("联系", "Contact")))
    B.append(("code", "https://github.com/hewm2008/NGenomeSyn"))
    B.append(("p", T("邮箱：hewm2008@gmail.com / hewm2008@qq.com    QQ 群：125293663",
                     "E-mail: hewm2008@gmail.com / hewm2008@qq.com    QQ group: 125293663")))
    return B


# --------------------------------------------------------------------------
# HTML rendering -> PDF (QTextDocument/QPrinter)
# --------------------------------------------------------------------------
_CSS = """
body { font-family: 'Noto Sans CJK SC','Microsoft YaHei','PingFang SC',sans-serif; font-size: 10pt; }
h1 { font-size: 19pt; } h2 { font-size: 14pt; border-bottom: 1px solid #bbb; }
h3 { font-size: 11.5pt; }
code, pre { font-family: Consolas, monospace; background: #f4f4f4; }
table { border-collapse: collapse; } td, th { border: 1px solid #999; padding: 3px 5px; font-size: 8.5pt; }
"""


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


def _fit_inches(path, max_w=6.3, max_h=7.5, dpi=96.0):
    """Display size in inches that fits the page box.

    A fixed width alone is not enough: a tall narrow screenshot (e.g. 300x651)
    stretched to 6.3in would be ~13in tall and spill over the page. Fit both
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


def _blocks_to_html(B):
    out = ["<html><head><meta charset='utf-8'><style>%s</style></head><body>" % _CSS]
    for kind, payload in B:
        import html as _h
        if kind == "h1":
            out.append(f"<h1>{_h.escape(payload)}</h1>")
        elif kind == "h2":
            out.append(f"<h2>{_h.escape(payload)}</h2>")
        elif kind == "h3":
            out.append(f"<h3>{_h.escape(payload)}</h3>")
        elif kind == "p":
            out.append(f"<p>{_h.escape(payload)}</p>")
        elif kind == "note":
            out.append(f"<p><i>{_h.escape(payload)}</i></p>")
        elif kind == "code":
            out.append(f"<pre>{_h.escape(payload)}</pre>")
        elif kind == "img":
            path, cap = payload
            if Path(path).is_file():
                import base64
                b64 = base64.b64encode(Path(path).read_bytes()).decode()
                w_in, h_in = _fit_inches(path)
                # explicit px keeps Qt from scaling a tall image past the page
                dim = "width='%d'" % round(w_in * 96)
                if h_in:
                    dim += " height='%d'" % round(h_in * 96)
                out.append(
                    "<p style='text-align:center'><img src='data:image/png;base64,%s' "
                    "%s style='max-width:100%%'/></p>" % (b64, dim))
                if cap:
                    out.append(f"<p><i>{_h.escape(cap)}</i></p>")
        elif kind == "ul":
            out.append("<ul>" + "".join(f"<li>{_h.escape(x)}</li>" for x in payload) + "</ul>")
        elif kind == "table":
            rows = payload
            head = "".join(f"<th>{_h.escape(c)}</th>" for c in rows[0])
            body = "".join("<tr>" + "".join(f"<td>{_h.escape(c)}</td>" for c in r) + "</tr>"
                           for r in rows[1:])
            out.append(f"<table><tr>{head}</tr>{body}</table>")
    out.append("</body></html>")
    return "\n".join(out)


def _blocks_to_docx(B, path):
    import docx
    from docx.shared import Inches, Pt
    doc = docx.Document()
    for kind, payload in B:
        if kind in ("h1", "h2", "h3"):
            doc.add_heading(payload, level=int(kind[1]))
        elif kind in ("p", "note"):
            p = doc.add_paragraph(payload)
            if kind == "note":
                p.runs[0].italic = True
        elif kind == "code":
            p = doc.add_paragraph()
            run = p.add_run(payload)
            run.font.name = "Consolas"
            run.font.size = Pt(9)
        elif kind == "img":
            # NOTE: do not rebind `path` here - it is the docx output path
            img_path, cap = payload
            if Path(img_path).is_file():
                w_in, h_in = _fit_inches(img_path)
                kw = {"width": Inches(w_in)}
                if h_in:
                    kw["height"] = Inches(h_in)
                doc.add_picture(str(img_path), **kw)
                if cap:
                    cp = doc.add_paragraph(cap)
                    cp.runs[0].italic = True
        elif kind == "ul":
            for item in payload:
                doc.add_paragraph(item, style="List Bullet")
        elif kind == "table":
            rows = payload
            t = doc.add_table(rows=len(rows), cols=len(rows[0]))
            t.style = "Table Grid"
            for r, row in enumerate(rows):
                for c, cell in enumerate(row):
                    t.cell(r, c).text = cell
    doc.save(str(path))


def generate(dest_dir, langs=("zh", "en"), gui_ver="", engine_ver=""):
    """Write the manuals; returns {lang: pdf_path}. Called by the GUI too."""
    from PySide6.QtCore import QCoreApplication
    from PySide6.QtGui import QTextDocument
    from PySide6.QtPrintSupport import QPrinter
    if QCoreApplication.instance() is None:      # QPrinter needs an application
        from PySide6.QtWidgets import QApplication
        app = QApplication.instance() or QApplication(sys.argv or ["gen_gui_manual"])
    data = _load_params()
    dest = Path(dest_dir)
    dest.mkdir(parents=True, exist_ok=True)
    written = {}
    for lang in langs:
        blocks = _build_blocks(lang, gui_ver, engine_ver, data)
        pdf = dest / (("NGenomeSyn_GUI_manual_Chinese.pdf" if lang == "zh"
                       else "NGenomeSyn_GUI_manual_English.pdf"))
        doc = QTextDocument()
        doc.setHtml(_blocks_to_html(blocks))
        printer = QPrinter(QPrinter.HighResolution)
        printer.setOutputFormat(QPrinter.PdfFormat)
        printer.setOutputFileName(str(pdf))
        doc.print_(printer)
        written[lang] = pdf
        try:
            _blocks_to_docx(blocks, str(pdf).replace(".pdf", ".docx"))
        except ImportError:
            pass
    return written


def main():
    dest = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "gui" / "doc"
    engine_ver = "1.50"
    try:
        m = re.search(r"Version\s*:\s*(\d+\.\d+)",
                      (ROOT / "bin" / "NGenomeSyn").read_text(errors="replace"))
        if m:
            engine_ver = m.group(1)
    except OSError:
        pass
    from gui import GUI_VERSION
    written = generate(dest, gui_ver=GUI_VERSION, engine_ver=engine_ver)
    for lang, p in written.items():
        print(lang, "->", p)
    return 0


if __name__ == "__main__":
    sys.path.insert(0, str(ROOT))
    sys.exit(main())
