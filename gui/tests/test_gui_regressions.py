#!/usr/bin/env python3
"""NGenomeSyn GUI regression tests (offscreen Qt).

Invariants covered:
  1. schema: param set matches the engine exactly (no dead keys), palettes
     parse to valid hex, enums match the engine's literal eq strings
  2. conf round-trip: load -> save -> load identity for every Example conf,
     and the saved text re-parses under the engine's own regex chain
  3. byte identity: the GUI-regenerated conf renders the SAME SVG bytes as
     the original conf (for confs without legacy-misspellings rewrites)
  4. gz equivalence: a .gz input routed through the cache renders the same
     SVG as the plain file
  5. UI: lazy tabs, genome/link add/remove semantics (link renumbering),
     i18n coverage, PNG/PDF export, quote_value behaviour

Run:  python3 gui/tests/test_gui_regressions.py      (or pytest)
"""
import gzip
import hashlib
import json
import os
import shutil
import re
import subprocess
import sys
import tempfile
from pathlib import Path

os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

_FAILED = []
_PASSED = [0]


def check(name, cond, extra=""):
    if cond:
        _PASSED[0] += 1
        print("PASS %s" % name)
    else:
        _FAILED.append(name)
        print("FAIL %s  %s" % (name, extra))


# ---------------------------------------------------------------------------
# 1. schema
# ---------------------------------------------------------------------------
def test_schema():
    from gui.core import schema as S
    data = S.Schema.data()
    check("schema.params", len(data["params"]) == 66, len(data["params"]))
    check("schema.categories", list(data["categories"])[0] == "files")
    check("schema.no_plot_types", data.get("plot_types") == [])
    dead = {"strokewidth", "crBG", "crStrokeBG", "ShiftXaxisY"}
    names = {p["name"] for p in data["params"]}
    check("schema.no_dead_keys", not (dead & names), dead & names)
    v = data["validation"]
    check("schema.validation_clean",
          not v["in_meta_not_in_code"] and not v["in_code_not_in_meta"], v)

    # palettes: valid hex, PiYG excluded (engine crashes on it), Dark2 exact
    pals = data["palettes"]["builtin"]
    check("palettes.count", len(pals) == 35, len(pals))
    check("palettes.piyg_excluded", "PiYG" not in pals)
    dark2 = pals["Dark2"]["colors"]
    check("palettes.dark2", dark2[:3] == ["#1B9E77", "#D95F02", "#7570B3"], dark2[:3])
    import re
    hexre = re.compile(r"^#[0-9A-F]{6}$")
    bad = [n for n, e in pals.items()
           if not e["colors"] or not all(hexre.match(c) for c in e["colors"])]
    check("palettes.hex_valid", not bad, bad)
    check("palettes.paired_max12", pals["Paired"]["max"] == 12)

    # enums match the engine's literal eq strings (bin/NGenomeSyn:2799-2900)
    style = next(p for p in data["params"] if p["name"] == "StyleUpDown")
    check("enum.style_choices",
          style["choices"] == ["UpDown", "DownUp", "UpUp", "DownDown", "line"],
          style["choices"])
    up = next(p for p in data["params"] if p["name"] == "ScaleUpDown")
    check("enum.scaleupdown", up["choices"] == ["Up"], up["choices"])

    # aliases
    check("aliases.set", data["aliases"] == {
        "MainCor": "MainColor", "MoveX": "MoveToX", "MoveY": "MoveToY",
        "GenomeNameRatio": "GenomeNameSizeRatio", "HightRation": "HeightRatio"},
        data["aliases"])
    check("aliases.resolve", S.Schema.resolve_alias("HightRation") == "HeightRatio")
    check("aliases.identity", S.Schema.resolve_alias("ZoomChr") == "ZoomChr")

    # scope coverage: fill/stroke render in both genome and link forms
    fill = next(p for p in data["params"] if p["name"] == "fill")
    check("scope.fill_shared", fill["scope"] == ["genome", "link"], fill["scope"])


# ---------------------------------------------------------------------------
# 2. conf round-trip
# ---------------------------------------------------------------------------
def _engine_split(line):
    """The engine's own comment/quote chain, used to re-parse saved confs."""
    import re as _re
    line = line.strip().strip("\r")
    if not line or line.startswith("#"):
        return None
    line = line.replace('"#', "\x00")
    line = line.split("##")[0].split("#")[0]
    line = line.replace("\x00", '"#').replace('"', "").strip()
    if "=" not in line:
        return None
    parts = _re.split(r"\s*=\s*", line, maxsplit=2)
    key = parts[0].strip()
    return (key, parts[1].strip() if len(parts) > 1 else "") if key else None


def _parse_engine_style(text):
    """{(section, key): value} exactly like the engine would see it."""
    out = {}
    section = "-1"
    for line in text.splitlines():
        kv = _engine_split(line)
        if kv is None:
            continue
        k, v = kv
        if k == "SetParaFor":
            section = v
            continue
        out[(section, k)] = v
    return out


def _confs():
    return sorted((ROOT / "Example").rglob("*.conf"))


def test_conf_roundtrip():
    from gui.core.conf_io import ConfModel
    for conf in _confs():
        m1 = ConfModel().load(conf)
        text = m1.to_conf_text()
        m2 = ConfModel()
        m2.alias_log = []
        # parse the written text through the model loader (in-memory file)
        tmp = Path(tempfile.mkdtemp(prefix="ngs_rt_")) / "r.conf"
        tmp.write_text(text, encoding="utf-8")
        m2 = ConfModel().load(tmp)
        same = (m1.genome_files == m2.genome_files
                and m1.link_files == m2.link_files
                and m1.global_params == m2.global_params
                and m1.genome_all == m2.genome_all
                and m1.genomes == m2.genomes
                and m1.link_all == m2.link_all
                and m1.links == m2.links)
        check("roundtrip.load_save_load %s" % conf.relative_to(ROOT), same)
        shutil.rmtree(tmp.parent, ignore_errors=True)


def test_engine_reparse():
    """Saved conf text must re-parse identically under the engine's chain."""
    from gui.core.conf_io import ConfModel
    for conf in _confs():
        m = ConfModel().load(conf)
        text = m.to_conf_text()
        got = _parse_engine_style(text)
        # every value the model holds must survive the engine's parser
        expect = {}
        for i, f in enumerate(m.genome_files, 1):
            if f:
                expect[("global", "GenomeInfoFile%d" % i)] = f
        for n, lf in enumerate(m.link_files, 1):
            expect[("global", "LinkFileRef%dVsRef%d" % (lf["a"], lf["b"]))] = lf["path"]
        for k, v in m.global_params.items():
            expect[("global", k)] = str(v)
        for k, v in m.genome_all.items():
            expect[("GenomeALL", k)] = str(v)
        for idx, sec in m.genomes.items():
            for k, v in sec.items():
                expect[("Genome%d" % idx, k)] = str(v)
        for k, v in m.link_all.items():
            expect[("LinkALL", k)] = str(v)
        for idx, sec in m.links.items():
            for k, v in sec.items():
                expect[("Link%d" % idx, k)] = str(v)
        bad = []
        for sk, v in expect.items():
            g = got.get(sk)
            if g is None:
                bad.append("%s missing" % (sk,))
            elif g != v and not (v.startswith("#") and g == v.strip("#")):
                bad.append("%s: %r != %r" % (sk, g, v))
        check("engine.reparse %s" % conf.relative_to(ROOT), not bad, bad[:4])


# ---------------------------------------------------------------------------
# 3. engine byte identity
# ---------------------------------------------------------------------------
ENGINE = ROOT / "bin" / "NGenomeSyn"


def _run_engine(conf, out_base, cwd):
    r = subprocess.run(["perl", str(ENGINE), "-InConf", str(conf),
                        "-OutPut", str(out_base), "-NoPng"],
                       cwd=str(cwd), capture_output=True, text=True, timeout=300)
    svg = Path(str(out_base) + ".svg")
    if svg.is_file() and svg.stat().st_size > 0:
        return hashlib.sha1(svg.read_bytes()).hexdigest()
    return None


def _gui_conf_hash(conf):
    from gui.core.conf_io import ConfModel
    m = ConfModel().load(conf)
    m.absolutize_paths(conf.parent)
    tmp = Path(tempfile.mkdtemp(prefix="ngs_byte_"))
    gui_conf = tmp / "gui.conf"
    gui_conf.write_text(m.to_conf_text(), encoding="utf-8")
    h = _run_engine(gui_conf, tmp / "gui", tmp)
    shutil.rmtree(tmp, ignore_errors=True)
    return h, len(m.alias_log)


def test_byte_identity():
    cases = {
        "Example/example1/in1.conf": "identical",
        "Example/example2/in1.conf": "identical",
        "Example/example2/in2.conf": "identical",
        "Example/example2/in3.conf": "identical",
        "Example/example3/in1.conf": "alias-rewritten",   # MainCor -> MainColor
        "Example/example3/in2.conf": "identical",
        "Example/example3/in3.conf": "identical",
        "Example/example5/in2.conf": "identical",
        "Example/example6/in1.conf": "identical",
    }
    for rel, expect in cases.items():
        conf = ROOT / rel
        tmp = Path(tempfile.mkdtemp(prefix="ngs_orig_"))
        h_orig = _run_engine(conf, tmp / "orig", conf.parent)
        shutil.rmtree(tmp, ignore_errors=True)
        h_gui, n_alias = _gui_conf_hash(conf)
        if expect == "identical":
            check("byte.identity %s" % rel,
                  h_orig is not None and h_orig == h_gui,
                  "orig=%s gui=%s" % (h_orig, h_gui))
        else:
            check("byte.alias-rewritten %s" % rel,
                  n_alias > 0 and h_orig is not None and h_gui is not None,
                  "alias=%d orig=%s gui=%s" % (n_alias, h_orig, h_gui))


def test_gz_equivalence():
    """A .gz input through the cache must render byte-identically."""
    work = Path(tempfile.mkdtemp(prefix="ngs_gz_"))
    rd = ROOT / "Example" / "RealData" / "Yeast"
    with open(rd / "R64.len", "rb") as fin, gzip.open(work / "R64.len.gz", "wb") as fout:
        shutil.copyfileobj(fin, fout)
    shutil.copy2(rd / "R64.len", work / "R64.len")
    (work / "YJM1447.len").write_bytes((rd / "YJM1447.len").read_bytes())
    shutil.copy2(rd / "R64_YJM1447.link", work / "R64_YJM1447.link")
    conf = work / "gz.conf"
    conf.write_text(
        "SetParaFor = global\n"
        "GenomeInfoFile1=R64.len\n"
        "GenomeInfoFile2=YJM1447.len\n"
        "LinkFileRef1VsRef2=R64_YJM1447.link\n", encoding="utf-8")
    conf_gz = work / "gz_used.conf"
    conf_gz.write_text(
        "SetParaFor = global\n"
        "GenomeInfoFile1=R64.len.gz\n"
        "GenomeInfoFile2=YJM1447.len\n"
        "LinkFileRef1VsRef2=R64_YJM1447.link\n", encoding="utf-8")
    h_plain = _run_engine(conf, work / "a", work)
    from gui.core.conf_io import ConfModel
    from gui.core.gzcache import map_all_paths, materialize
    m = ConfModel().load(conf_gz)
    check("gz.cache_label", Path(materialize(str(work / "R64.len.gz"))).name == "R64.len")
    # the GUI's runtime pipeline: map .gz -> cache, write runtime conf, run
    gui_conf = work / "gui_gz.conf"
    gui_conf.write_text(m.to_conf_text(map_path=map_all_paths(m)), encoding="utf-8")
    check("gz.runtime_conf_no_gz", "len.gz" not in gui_conf.read_text(encoding="utf-8"))
    h_gz = _run_engine(gui_conf, work / "b", work)
    check("gz.cache_run_ok", h_gz is not None)
    check("gz.same_output", h_plain == h_gz, "%s vs %s" % (h_plain, h_gz))
    shutil.rmtree(work, ignore_errors=True)


def test_quote_value():
    from gui.core.conf_io import ConfModel, _engine_split, quote_value
    # bare hex is DESTROYED by the engine parser (bin/NGenomeSyn:1482)
    kv = _engine_split("fill=#F8F8F8")
    check("quote.bare_hex_dies", kv == ("fill", ""), kv)
    # quoted hex survives
    kv = _engine_split('fill="%s"' % "#F8F8F8")
    check("quote.quoted_hex_ok", kv == ("fill", "#F8F8F8"), kv)
    # the writer always quotes colors
    check("quote.writer_quotes", quote_value("#F8F8F8", "fill") == '"#F8F8F8"')
    check("quote.named_color", quote_value("green", "fill") == '"green"')
    check("quote.plain", quote_value("1200", "body") == "1200")
    m = ConfModel()
    m.set_param(("link", 1), "fill", "#8DD3C7")
    check("quote.conf_line", 'fill="#8DD3C7"' in m.to_conf_text())


# ---------------------------------------------------------------------------
# 5. UI
# ---------------------------------------------------------------------------
def test_ui():
    import tempfile
    from PySide6.QtCore import QSettings, Qt
    from PySide6.QtWidgets import QApplication
    QSettings.setPath(QSettings.IniFormat, QSettings.UserScope,
                      tempfile.mkdtemp(prefix="ngs_settings_"))
    app = QApplication.instance() or QApplication([])

    # "+" button must add an empty row even when the guard would early-return
    from gui.ui.files_panel import GenomeFilesBar, _PreviewBox, PREVIEW_ROWS
    bar = GenomeFilesBar()
    bar.set_files(["/tmp/a.len"])
    bar._add_clicked()
    check("ui.bar_add_row", len(bar._rows) == 2, len(bar._rows))
    bar.set_files(bar.files())
    check("ui.bar_keeps_empty_row", len(bar._rows) == 2)
    check("ui.bar_files_compact", bar.files() == ["/tmp/a.len"])

    # preview: the FILE ROW is the selector (RectChr pattern); top 8 rows shown
    import shutil as _sh
    work = Path(tempfile.mkdtemp(prefix="ngs_prev_"))
    f1, f2 = work / "one.len", work / "two.len"
    f1.write_text("".join("Chr%d 1 %d\n" % (i, 1000 + i) for i in range(1, 21)),
                  encoding="utf-8")
    f2.write_text("".join("c%d 1 %d\n" % (i, 2000 + i) for i in range(1, 6)),
                  encoding="utf-8")
    prev = _PreviewBox()
    prev.set_items([("GenomeInfoFile1", str(f1)), ("GenomeInfoFile2", str(f2))])
    check("ui.preview_items", len(prev.items()) == 2, len(prev.items()))
    # the FIRST file is selected by default
    check("ui.preview_default_first", prev.current_index() == 0,
          prev.current_index())
    check("ui.preview_top8", prev.table.rowCount() == PREVIEW_ROWS,
          prev.table.rowCount())
    check("ui.preview_first_file", prev.table.item(0, 0).text() == "Chr1",
          prev.table.item(0, 0).text())
    prev.select(1)                              # click the 2nd file row
    check("ui.preview_switch", prev.table.item(0, 0).text() == "c1",
          prev.table.item(0, 0).text())
    check("ui.preview_switch_rows", prev.table.rowCount() == 5,
          prev.table.rowCount())
    check("ui.preview_title_shows_file", "GenomeInfoFile2" in prev.title.text(),
          prev.title.text())
    _sh.rmtree(work, ignore_errors=True)

    # A: a long genome list must not push the link section out of the dock -
    # the row area is height-capped and scrolls instead
    many = GenomeFilesBar()
    many.set_files(["/tmp/g%d.len" % i for i in range(12)])
    from gui.ui.files_panel import FOLD_MAX_HEIGHT, FOLD_MAX_HEIGHT_TIGHT
    check("ui.bar_height_capped",
          many._scroll.maximumHeight() <= FOLD_MAX_HEIGHT,
          many._scroll.maximumHeight())
    check("ui.bar_many_rows_kept", len(many.files()) == 12, len(many.files()))
    # tight by default (left dock), roomy on request (right dock cards)
    check("ui.bar_tight_default",
          many._scroll.maximumHeight() <= FOLD_MAX_HEIGHT_TIGHT,
          many._scroll.maximumHeight())
    roomy = GenomeFilesBar()
    roomy.set_roomy(True)
    roomy.set_files(["/tmp/g%d.len" % i for i in range(12)])
    check("ui.bar_roomy_deeper",
          roomy._scroll.maximumHeight() > FOLD_MAX_HEIGHT_TIGHT,
          roomy._scroll.maximumHeight())

    # clicking a file row selects it for previewing (RectChr pattern)
    from PySide6.QtCore import QEvent, QPoint, QPointF
    from PySide6.QtGui import QMouseEvent
    from PySide6.QtCore import Qt as _Qt2
    from PySide6.QtWidgets import QApplication as _QA
    hits = []
    pb = GenomeFilesBar()
    pb.set_files(["/tmp/a.len", "/tmp/b.len", "/tmp/c.len"])
    pb.row_selected.connect(hits.append)
    ev = QMouseEvent(QEvent.MouseButtonPress, QPointF(5, 5), QPointF(5, 5),
                     QPoint(5, 5), _Qt2.LeftButton, _Qt2.LeftButton,
                     _Qt2.NoModifier)
    _QA.sendEvent(pb._rows[2]["edit"], ev)      # goes through eventFilter
    check("ui.row_click_selects", hits == [2], hits)
    check("ui.row_click_highlights", pb.selected_index() == 2,
          pb.selected_index())

    # the LABEL ("GenomeInfoFile3" / "Link 2") is clickable too
    hits2 = []
    pb2 = GenomeFilesBar()
    pb2.set_files(["/tmp/a.len", "/tmp/b.len", "/tmp/c.len"])
    pb2.row_selected.connect(hits2.append)
    _QA.sendEvent(pb2._rows[1]["lab"], ev)
    check("ui.label_click_selects", hits2 == [1], hits2)

    # A:/B: spins must NOT clamp an already-loaded value when the genome count
    # grows afterwards (a 2<->3 link used to silently become 2<->2)
    from gui.ui.files_panel import LinkFilesBar
    lb = LinkFilesBar()
    lb.set_links([{"a": 2, "b": 3, "path": "x.link"}], force=True)
    lb.set_genome_count(2)
    lb.set_genome_count(3)
    check("ui.link_spin_no_clamp", lb.links()[0]["b"] == 3, lb.links()[0])

    from gui.i18n import I18N, STRINGS
    for key in STRINGS:
        zh = I18N.tr(key)
        I18N.set_lang("en")
        en = I18N.tr(key)
        I18N.set_lang("zh")
        if not zh or not en or zh == key or en == key:
            check("i18n.key %s" % key, False, "%r / %r" % (zh, en))
            break
    else:
        check("i18n.all_keys_bilingual", True)

    from gui.ui.main_window import MainWindow
    from gui.ui.genome_tab import LazyGenomePage, LazyLinkPage

    w = MainWindow()
    check("ui.window_builds", w.param_tabs.count() == 4, w.param_tabs.count())

    # the "数据分组" category must be FIRST in the global form's list
    gf = w.global_form
    first = gf.cat_list.item(0)
    from PySide6.QtCore import Qt as _Qt
    check("ui.files_cat_first", first.data(_Qt.UserRole) == "files",
          first.data(_Qt.UserRole))

    # C: the data-grouping page must show TWO cards (genome group + link group)
    gf.cat_list.setCurrentRow(0)
    from PySide6.QtWidgets import QLabel as _QLabel
    titles = [lb.text() for lb in gf.scroll.widget().findChildren(_QLabel)
              if lb.objectName() == "cardTitle"]
    check("ui.files_two_groups", len(titles) == 2, titles)
    check("ui.files_group_names",
          titles and "GenomeInfoFileN" in titles[0] and "LinkFileRef" in titles[1],
          titles)

    # citation dialog must carry the published paper (README §5)
    dlg = w._build_citation_dialog()
    from PySide6.QtWidgets import QPlainTextEdit as _PTE
    cite = dlg.findChild(_PTE)
    body = cite.toPlainText() if cite is not None else ""
    check("ui.citation_has_paper",
          "10.1093/bioinformatics/btad121" in body and "Bioinformatics" in body, body[:80])
    dlg.close()

    w.model.load(str(ROOT / "Example/example1/in1.conf"))
    w._rebuild_param_tabs()
    titles = [w.param_tabs.tabText(i) for i in range(w.param_tabs.count())]
    check("ui.tab_set", titles == ["全局参数", "GenomeALL", "Genome 1",
                                   "Genome 2", "LinkALL", "参数总览"], titles)

    # picking a row in EITHER dock selects it in both, and previews it
    from PySide6.QtCore import QPointF
    from PySide6.QtGui import QMouseEvent
    from PySide6.QtCore import QEvent as _QE
    from PySide6.QtCore import Qt as _Qt3
    w.files_panel.sync_genomes(w.model.genome_files)      # as _open_conf does
    w.files_panel.sync_links(w.model.link_files, force=True)
    check("ui.panel_got_files", len(w.files_panel.genome_panel.preview.items()) == 2,
          len(w.files_panel.genome_panel.preview.items()))
    w.files_panel.select_row("genome", 1)
    check("ui.select_syncs_docks",
          w.global_form.genome_bar.selected_index() == 1
          and w.files_panel.genome_panel.preview.current_index() == 1,
          (w.global_form.genome_bar.selected_index(),
           w.files_panel.genome_panel.preview.current_index()))
    # right dock row pick -> left dock preview
    w.files_panel.genome_panel.preview.select(0)
    w.global_form.genome_bar.row_selected.emit(1)   # bar carries the index
    app.processEvents()
    check("ui.right_pick_previews_left",
          w.files_panel.genome_panel.preview.current_index() == 1,
          w.files_panel.genome_panel.preview.current_index())
    click = QMouseEvent(_QE.MouseButtonPress, QPointF(3, 3), QPointF(3, 3),
                        QPointF(3, 3).toPoint(), _Qt3.LeftButton,
                        _Qt3.LeftButton, _Qt3.NoModifier)
    from PySide6.QtWidgets import QApplication as _QA2
    _QA2.sendEvent(w.global_form.genome_bar._rows[0]["lab"], click)
    check("ui.right_label_click",
          w.files_panel.genome_panel.preview.current_index() == 0,
          w.files_panel.genome_panel.preview.current_index())
    # laziness: section pages materialize only when shown
    lazies = [w.param_tabs.widget(i) for i in range(w.param_tabs.count())]
    check("ui.lazy_genome_pages",
          sum(isinstance(x, LazyGenomePage) and not x.materialized()
              for x in lazies) == 2)
    check("ui.summary_lazy", not w.summary_tab.materialized())

    # selecting a genome page materializes exactly that one
    w.param_tabs.setCurrentWidget(w.genome_pages[2])
    check("ui.materialize_on_show", w.genome_pages[2].materialized()
          and not w.genome_pages[1].materialized())

    # add genome section (sparse)
    w.g_add_spin.setValue(5)
    w._add_genome()
    check("ui.add_genome", 5 in w.model.genomes
          and len(w.model.genome_files) == 5)
    # remove renumbers nothing (sparse genome sections keep their index)
    w.g_rem_spin.setValue(2)
    w._remove_genome()
    check("ui.remove_genome_sparse", 2 not in w.model.genomes
          and 1 in w.model.genomes and 5 in w.model.genomes)

    # links: ordinal semantics — removing Link1 renumbers Link2 -> Link1
    w.model.links.clear()
    w.model.link_files = [
        {"a": 1, "b": 2, "path": "x1.link"},
        {"a": 1, "b": 3, "path": "x2.link"},
        {"a": 2, "b": 3, "path": "x3.link"}]
    w.model.links = {1: {"Reverse": "1"}, 3: {"Reverse": "1"}}
    w._remove_by_index(1, "link")
    check("ui.link_renumber_files",
          [lf["path"] for lf in w.model.link_files] == ["x2.link", "x3.link"])
    # old Link3 section moves to index 2 (Link2 section never existed)
    check("ui.link_renumber_sections", w.model.links == {2: {"Reverse": "1"}},
          w.model.links)
    check("ui.link_conf_ordinal",
          "LinkFileRef1VsRef3=x2.link" in w.model.to_conf_text()
          and "LinkFileRef2VsRef3=x3.link" in w.model.to_conf_text())

    # writer order: files first, then other global keys
    m = w.model
    m.global_params["body"] = "1500"
    txt = m.to_conf_text()
    lines = [l for l in txt.splitlines() if l.startswith(("GenomeInfoFile", "LinkFileRef", "body="))]
    check("writer.files_first", lines[0].startswith("GenomeInfoFile1")
          and lines[-1] == "body=1500", lines)

    # i18n switch keeps the window alive
    w.lang_combo.setCurrentIndex(1)
    check("ui.lang_switch", w.param_tabs.count() >= 6)
    w.lang_combo.setCurrentIndex(0)

    # export from a real run (engine must be available)
    from gui.core.runner import find_engine, find_perl
    if find_perl() and find_engine():
        w.model = type(w.model)()  # fresh
        w.model.load(str(ROOT / "Example/example1/in1.conf"))
        w.out_dir = Path(tempfile.mkdtemp(prefix="ngs_ui_run_"))
        w.out_name = "ui_test"
        w._rebuild_param_tabs()
        loop_ok = {"done": False}
        from PySide6.QtCore import QEventLoop, QTimer
        loop = QEventLoop()
        w.runner.finished_ok.connect(lambda _p: (loop_ok.update(done=True), loop.quit()))
        w.runner.failed.connect(lambda r: (loop_ok.update(done=False, r=r), loop.quit()))
        w._run_impl(auto=True)
        QTimer.singleShot(120000, loop.quit)
        loop.exec()
        check("ui.run_ok", loop_ok.get("done"), loop_ok.get("r", ""))
        svg = w.out_dir / "ui_test.svg"
        if svg.is_file():
            check("ui.preview_load", w.preview.load_svg(str(svg)))
            png = w.out_dir / "x.png"
            pdf = w.out_dir / "x.pdf"
            check("ui.export_png", w.preview.export_png(str(png)) and png.stat().st_size > 1000)
            check("ui.export_pdf", w.preview.export_pdf(str(pdf)) and pdf.stat().st_size > 1000)
        shutil.rmtree(w.out_dir, ignore_errors=True)

    w.close()


# ---------------------------------------------------------------------------
def test_param_toggle():
    """Ticking a parameter's enable box must never raise.

    Two bugs lived here: the genome/link tabs exposed `_index` while
    `_route_param_change` read `.index`, and the palette keys (schema enums
    rendered as a QLineEdit + swatch) fell into the QComboBox branch and
    called currentData() on a QLineEdit."""
    import tempfile as _tf
    from PySide6.QtCore import QSettings as _QS
    from PySide6.QtWidgets import QApplication as _QA
    _QS.setPath(_QS.IniFormat, _QS.UserScope, _tf.mkdtemp(prefix="ngs_tog_"))
    app = _QA.instance() or _QA([])
    from gui.ui.main_window import MainWindow
    w = MainWindow()
    w.model.load(str(ROOT / "Example/example2/in2.conf"))
    w.files_panel.sync_genomes(w.model.genome_files)
    w.files_panel.sync_links(w.model.link_files, force=True)
    w._rebuild_param_tabs()

    forms = [w.global_form, w.genome_all_form, w.link_all_form]
    for page in list(w.genome_pages.values()) + list(w.link_pages.values()):
        forms.append(page.materialize().form)

    n = 0
    errors = []
    for f in forms:
        for i in range(f.cat_list.count()):
            f.cat_list.setCurrentRow(i)
            app.processEvents()
            for key, row in list(f._rows.items()):
                n += 1
                for state in (True, False, True):
                    try:
                        row.enable.setChecked(state)
                        row._on_toggle(state)
                    except Exception as e:              # noqa: BLE001
                        errors.append("%s/%s: %s" % (f.scope, key, e))
                        break
    check("toggle.no_errors", not errors, errors[:3])
    check("toggle.rows_exercised", n > 80, n)

    # a palette key must land its real value in the model when ticked
    gf = w.global_form
    for i in range(gf.cat_list.count()):
        gf.cat_list.setCurrentRow(i)
    row = gf._rows.get("GenomeColorBrewer")
    if row is not None:
        row.enable.setChecked(True)
        row._on_toggle(True)
        check("toggle.palette_writes_model",
              w.model.global_params.get("GenomeColorBrewer") == "Dark2",
              w.model.global_params.get("GenomeColorBrewer"))
        row.enable.setChecked(False)
        row._on_toggle(False)
        check("toggle.untick_clears",
              "GenomeColorBrewer" not in w.model.global_params)
    w.close()


def test_version_consistency():
    """GUI, engine and the READMEs must all report the same version."""
    import re as _re
    from gui import GUI_VERSION
    check("version.gui", GUI_VERSION == "1.50", GUI_VERSION)
    engine = (ROOT / "bin" / "NGenomeSyn").read_text(encoding="utf-8",
                                                     errors="replace")
    found = set(_re.findall(r"Version\s*:\s*(\d+\.\d+)", engine))
    check("version.engine", found == {"1.50"}, found)
    usage = subprocess.run(["perl", str(ROOT / "bin" / "NGenomeSyn"), "-help"],
                           capture_output=True, text=True, timeout=120)
    check("version.engine_help", "Version:1.50" in (usage.stdout + usage.stderr),
          (usage.stdout + usage.stderr)[:80])
    readme = (ROOT / "README.md").read_text(encoding="utf-8", errors="replace")
    check("version.readme", "v1.50.tar.gz" in readme and "v1.43" not in readme)
    cn = (ROOT / "README_Chinese.md").read_bytes().decode("gbk", errors="replace")
    check("version.readme_cn", "v1.50" in cn and "v1.43" not in cn)

    # the Help dialog must NOT offer the WeChat/social-media article
    from gui.ui.main_window import MainWindow as _MW
    names = [n for _k, n, _i in _MW._MANUALS]
    check("help.no_article_entry",
          not any("WeChat" in n or "Article" in n for n in names), names)


def test_readme_gui_install_and_citation_last():
    """README install section must cover Linux/macOS/Windows, and Citation must be last."""
    en = (ROOT / "README.md").read_text(encoding="utf-8", errors="replace")
    cn = (ROOT / "README_Chinese.md").read_bytes().decode("gbk", errors="replace")

    for tag, txt in (("en", en), ("cn", cn)):
        # install section: three platforms + GUI launch for Linux/macOS and Windows
        check("readme.%s.download_3os" % tag, "Linux / macOS / Windows" in txt)
        check("readme.%s.gui_sh" % tag, "NGenomeSynGUI.sh" in txt)
        check("readme.%s.gui_bat" % tag, "NGenomeSynGUI.bat" in txt)
        # the social-media article must not be advertised in the README
        check("readme.%s.no_article_link" % tag,
              "WeChat_Article" not in txt and "\u63a8\u6587\u7a3f" not in txt)
        # the GUI manuals stay linked
        check("readme.%s.manual_links" % tag, "NGenomeSyn_GUI_manual_Chinese.pdf" in txt
              and "NGenomeSyn_GUI_manual_English.pdf" in txt)

    # English README: section order 5 Contact, 6 GUI, 7 Citation last
    heads = re.findall(r"^###\s+(\d+)\s+\S", en, re.M)
    check("readme.en.order", heads == ["1", "2", "3", "4", "5", "6", "7"], heads)
    check("readme.en.contact_is_5", "### 5 Contact" in en and "### 6 Contact" not in en)
    check("readme.en.gui_is_6", "### 6 Graphical User Interface (GUI)" in en)
    check("readme.en.citation_last", en.index("### 7 Citation") > en.index("### 6 Graphical")
          and en.index("### 7 Citation") < en.index("swimming in the sky"), en.index("### 7 Citation"))


def test_doc_images_fit_page():
    """Screenshots must fit the page box: fit both sides, never upscale."""
    import importlib.util
    import zipfile
    EMU = 914400.0
    PAGE_H = 9.0                      # A4/Letter minus 1in margins
    specs = []
    for script in ("gen_gui_manual.py", "gen_wechat_article.py"):
        f = ROOT / "gui" / "tools" / script
        spec = importlib.util.spec_from_file_location(script[:-3], f)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        specs.append((script, mod))

    # every screenshot in gui/doc must land inside the page box
    for png in sorted((ROOT / "gui" / "doc").glob("*.png")):
        for script, mod in specs:
            w, h = mod._fit_inches(str(png))
            check("imgfit.%s.%s.h" % (script, png.stem), h is not None and h <= PAGE_H,
                  "%.2f x %.2f in" % (w, h))
            check("imgfit.%s.%s.w" % (script, png.stem), w <= 6.4,
                  "%.2f in" % w)
            # never enlarge beyond the native pixel size
            nw, nh = mod._png_size(str(png))
            check("imgfit.%s.%s.native" % (script, png.stem),
                  nw and w <= nw / 96.0 + 0.01, "%.2f in" % w)

    # the generated DOCX must not contain an oversized picture
    for docx in sorted((ROOT / "gui" / "doc").glob("*.docx")):
        with zipfile.ZipFile(str(docx)) as z:
            xml = z.read("word/document.xml").decode("utf-8")
        ext = re.findall(r'<wp:extent cx="(\d+)" cy="(\d+)"/>', xml)
        check("imgfit.%s.present" % docx.stem, bool(ext), len(ext))
        for cx, cy in ext:
            check("imgfit.%s.fits" % docx.stem, int(cy) / EMU <= PAGE_H,
                  "%.2f in tall" % (int(cy) / EMU))


def test_manual_cites_article_and_points_to_readme():
    """The GUI manual must cite the article and point to the README for details."""
    import importlib.util
    f = ROOT / "gui" / "tools" / "gen_gui_manual.py"
    spec = importlib.util.spec_from_file_location("gen_gui_manual_c", f)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    blocks = mod._build_blocks("zh", "1.50", "1.50", mod._load_params())
    text = "\n".join(p for k, p in blocks if k in ("h2", "h3", "p", "note", "code"))
    check("manual.cites_article", "btad121" in text and "10.1093/bioinformatics" in text)
    check("manual.points_to_readme", "README" in text and "Citation" in text)
    check("manual.has_contact", "hewm2008@gmail.com" in text)
    # emoji would render as tofu boxes in the Qt-generated PDF
    def _is_emoji(c):
        o = ord(c)
        return (0x1F000 <= o <= 0x1FAFF or 0x2600 <= o <= 0x27BF
                or 0x2B00 <= o <= 0x2BFF or 0xFE00 <= o <= 0xFE0F)
    bad = [c for c in text if _is_emoji(c)]
    check("manual.no_emoji", not bad, bad[:5])


def test_shipped_docs_cite_article_and_have_valid_styles():
    """The shipped .docx files must cite the article and use styles that exist.

    WPS/Word rewrite styleIds (Heading3 -> 31). Transplanting blocks from a
    freshly generated file without remapping leaves pStyle ids that no longer
    resolve, and the headings silently degrade to Normal - check for orphans.
    """
    import zipfile
    for docx in sorted((ROOT / "gui" / "doc").glob("*.docx")):
        with zipfile.ZipFile(str(docx)) as z:
            xml = z.read("word/document.xml").decode("utf-8")
            styles = z.read("word/styles.xml").decode("utf-8")
        text = "".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", xml))
        check("shipped.%s.cites" % docx.stem, "btad121" in text)
        check("shipped.%s.readme" % docx.stem, "README" in text)
        defined = set(re.findall(r'w:styleId="([^"]+)"', styles))
        used = set(re.findall(r'<w:(?:p|r)Style w:val="([^"]+)"', xml))
        check("shipped.%s.no_orphan_style" % docx.stem, not (used - defined),
              sorted(used - defined)[:5])
        # the citation heading must still be a heading
        want = ("\u4e03\u3001\u5f15\u7528" if "WeChat" in docx.stem
                else "\u5f15\u7528\u6587\u7ae0")
        check("shipped.%s.cite_heading" % docx.stem,
              want in text or "Cite the article" in text, want)


def test_wechat_article_points_to_readme():
    """The article draft keeps the citation and points to the README."""
    md = (ROOT / "gui" / "doc" / "NGenomeSyn_GUI_WeChat_Article.md").read_text(
        encoding="utf-8")
    check("article.cites", "btad121" in md)
    check("article.readme_link", "#7-citation" in md and "README" in md)
    en = (ROOT / "README.md").read_text(encoding="utf-8", errors="replace")
    check("article.anchor_valid", "### 7 Citation" in en)


def test_doc_assets():
    """gui/doc must ship the manuals, screenshots and the article draft."""
    doc = ROOT / "gui" / "doc"
    manuals = ["NGenomeSyn_GUI_manual_Chinese.pdf",
               "NGenomeSyn_GUI_manual_English.pdf",
               "NGenomeSyn_GUI_manual_Chinese.docx",
               "NGenomeSyn_GUI_manual_English.docx"]
    for m in manuals:
        f = doc / m
        check("doc.%s" % m, f.is_file() and f.stat().st_size > 20000,
              f.stat().st_size if f.is_file() else "missing")

    # the manuals must actually embed the screenshots
    for m in manuals[2:]:
        import zipfile
        try:
            with zipfile.ZipFile(doc / m) as z:
                media = [n for n in z.namelist() if n.startswith("word/media/")]
        except Exception as e:                          # noqa: BLE001
            media = []
            check("doc.%s readable" % m, False, e)
        check("doc.%s has_images" % m, len(media) == 2, media)

    for shot in ("GUI_Home.png", "GUI_Data.png"):
        f = doc / shot
        ok = f.is_file() and f.read_bytes()[:8] == b"\x89PNG\r\n\x1a\n"
        check("doc.%s" % shot, ok, "not a PNG" if f.is_file() else "missing")
        if f.is_file():
            check("doc.%s size" % shot, f.stat().st_size > 20000,
                  f.stat().st_size)
            # must be a decodable image (python-docx refuses broken ones)
            try:
                from docx.image.image import Image as _DImage
                img = _DImage.from_file(str(f))
                check("doc.%s decodable" % shot, img.px_width > 200)
            except Exception as e:                      # noqa: BLE001
                check("doc.%s decodable" % shot, False, e)

    for art in ("NGenomeSyn_GUI_WeChat_Article.docx",
                "NGenomeSyn_GUI_WeChat_Article.md"):
        f = doc / art
        check("doc.%s" % art, f.is_file() and f.stat().st_size > 3000,
              f.stat().st_size if f.is_file() else "missing")

    # the READMEs must point at the shipped assets
    readme = (ROOT / "README.md").read_text(encoding="utf-8", errors="replace")
    check("readme.has_gui_section", "Graphical User Interface (GUI)" in readme)
    check("readme.links_manual", "NGenomeSyn_GUI_manual_Chinese.pdf" in readme)
    check("readme.has_shot", "gui/doc/GUI_Home.png" in readme)
    cn = (ROOT / "README_Chinese.md").read_bytes().decode("gbk", errors="replace")
    check("readme_cn.has_gui_section", "图形界面 GUI" in cn)
    check("readme_cn.links_manual", "NGenomeSyn_GUI_manual_Chinese.pdf" in cn)


def test_all():
    test_schema()
    test_quote_value()
    test_conf_roundtrip()
    test_engine_reparse()
    test_gz_equivalence()
    test_byte_identity()
    test_param_toggle()
    test_version_consistency()
    test_readme_gui_install_and_citation_last()
    test_doc_images_fit_page()
    test_manual_cites_article_and_points_to_readme()
    test_shipped_docs_cite_article_and_have_valid_styles()
    test_wechat_article_points_to_readme()
    test_doc_assets()
    test_ui()
    print("\n%d passed, %d failed" % (_PASSED[0], len(_FAILED)))
    if _FAILED:
        print("failed:", _FAILED)
    return len(_FAILED) == 0


if __name__ == "__main__":
    import faulthandler
    faulthandler.dump_traceback_later(900, exit=True)
    ok = test_all()
    sys.exit(0 if ok else 1)
