"""Minimal bilingual (zh/en) UI strings for the NGenomeSyn GUI."""

LANGS = ("zh", "en")

STRINGS = {
    "cite": {"zh": "引用", "en": "Cite"},
    "cite_intro": {"zh": "如果NGenomeSyn对你有帮助，欢迎在分享使用体验或相关成果时附上本项目的 GitHub 链接与下面的论文引文，方便更多人找到它。感谢你的支持",
                   "en": "If NGenomeSyn is helpful to you, please consider including this project's GitHub link and the paper citation below when sharing your experience or related results so that more people can find it. Thank you for your support!"},
    "copy_citation": {"zh": "复制引用", "en": "Copy citation"},
    "citation_copied": {"zh": "引用已复制", "en": "Citation copied"},
    "open_github": {"zh": "打开 GitHub", "en": "Open GitHub"},
    "paper_label": {"zh": "论文", "en": "Paper"},
    "paper_doi": {"zh": "打开 DOI", "en": "Open DOI"},
    "app_title":        {"zh": "NGenomeSyn 图形界面",     "en": "NGenomeSyn GUI"},
    "run":              {"zh": "运行绘图",                "en": "Run"},
    "open_conf":        {"zh": "打开配置…",               "en": "Open conf…"},
    "save_conf":        {"zh": "保存配置…",               "en": "Save conf…"},
    "export_png":       {"zh": "导出 PNG…",              "en": "Export PNG…"},
    "export_svg":       {"zh": "导出SVG",                "en": "Export SVG"},
    "export_svg_tip":   {"zh": "将当前预览的 SVG 原样另存（与预览字节一致）", "en": "Save the exact SVG shown in the preview"},
    "export_pdf":       {"zh": "导出 PDF…",              "en": "Export PDF…"},
    "language":         {"zh": "语言",                    "en": "Language"},
    "help":             {"zh": "帮助",                    "en": "Help"},
    "help_tip":         {"zh": "打开使用手册 PDF（F1）",   "en": "Open the manual PDF (F1)"},
    "about":            {"zh": "关于",                    "en": "About"},
    "about_tip":        {"zh": "版本与联系方式",           "en": "Version & contact"},
    "about_title":      {"zh": "关于 NGenomeSyn GUI",     "en": "About NGenomeSyn GUI"},
    "about_body":       {"zh": "<h3>NGenomeSyn GUI {gui_ver}</h3>"
                               "<p>引擎 / Engine: NGenomeSyn {engine_ver} (hewm2008)</p>"
                               "<p>多基因组共线性可视化工具（多基因组比对展示）</p><hr>"
                               "<p>📧 邮箱：<a href=\"mailto:hewm2008@gmail.com\">hewm2008@gmail.com</a> / "
                               "<a href=\"mailto:hewm2008@qq.com\">hewm2008@qq.com</a></p>"
                               "<p>🏠 主页：<a href=\"https://github.com/hewm2008/NGenomeSyn\">github.com/hewm2008/NGenomeSyn</a></p>"
                               "<p>💬 QQ 交流群：<b>125293663</b></p>",
                           "en": "<h3>NGenomeSyn GUI {gui_ver}</h3>"
                                 "<p>Engine: NGenomeSyn {engine_ver} (hewm2008)</p>"
                                 "<p>Visualization of multiple genome synteny (multi-genome alignment)</p><hr>"
                                 "<p>📧 Email: <a href=\"mailto:hewm2008@gmail.com\">hewm2008@gmail.com</a> / "
                                 "<a href=\"mailto:hewm2008@qq.com\">hewm2008@qq.com</a></p>"
                                 "<p>🏠 Home: <a href=\"https://github.com/hewm2008/NGenomeSyn\">github.com/hewm2008/NGenomeSyn</a></p>"
                                 "<p>💬 QQ Group: <b>125293663</b></p>"},
    "help_pick_title":  {"zh": "选择用法手册",           "en": "Choose a manual"},
    "help_pick_intro":  {"zh": "请选择要打开的用法手册：", "en": "Choose the manual to open:"},
    "help_pick_footer": {"zh": "PDF 将用系统默认阅读器打开；GUI 手册缺失时可一键生成", "en": "PDFs open in your system viewer; missing GUI manuals can be generated on the fly"},
    "help_engine_zh":   {"zh": "引擎手册 · 中文（命令行用法）", "en": "Engine manual · Chinese (CLI usage)"},
    "help_engine_en":   {"zh": "引擎手册 · English（命令行用法）", "en": "Engine manual · English (CLI usage)"},
    "help_gui_zh":      {"zh": "GUI 手册 · 中文（图形界面用法）", "en": "GUI manual · Chinese (GUI usage)"},
    "help_gui_en":      {"zh": "GUI 手册 · English（图形界面用法）", "en": "GUI manual · English (GUI usage)"},
    "help_bundled":     {"zh": "已附带",                  "en": "bundled"},
    "help_missing_tag": {"zh": "未附带",                  "en": "not bundled"},
    "help_generate":    {"zh": "生成并打开",              "en": "Generate & open"},
    "help_generated":   {"zh": "已生成：{f}",             "en": "Generated: {f}"},
    "help_word":        {"zh": "Word",                   "en": "Word"},
    "help_word_tip":    {"zh": "打开 Word（.docx）版手册，便于编辑/打印", "en": "Open the editable Word (.docx) manual"},
    "data_files":       {"zh": "数据分组",                "en": "Data grouping"},
    "group_genome":     {"zh": "基因组 GenomeInfoFileN",  "en": "Genome files (GenomeInfoFileN)"},
    "group_link":       {"zh": "链接 LinkFileRefA VsRefB", "en": "Link files (LinkFileRefA VsRefB)"},
    "link_files":       {"zh": "链接文件",                "en": "Link files"},
    "add_file":         {"zh": "添加文件",                "en": "Add file"},
    "remove_file":      {"zh": "移除所选",                "en": "Remove selected"},
    "genome_file_hint": {"zh": "格式: Chr Start End 属性…（顺序=图中顺序，支持 .gz）", "en": "Format: Chr Start End attrs… (row order = figure order, .gz ok)"},
    "link_file_hint":   {"zh": "格式: chrA StartA EndA chrB StartB EndB 属性…（支持 .gz）", "en": "Format: chrA StartA EndA chrB StartB EndB attrs… (.gz ok)"},
    "data_preview":     {"zh": "数据预览（前 8 行）",     "en": "Data preview (first 8 rows)"},
    "preview_select":   {"zh": "预览文件",                "en": "Preview file"},
    "ref_a":            {"zh": "基因组A",                 "en": "Genome A"},
    "ref_b":            {"zh": "基因组B",                 "en": "Genome B"},
    "link_n":           {"zh": "Link {n}",               "en": "Link {n}"},
    "link_too_few":     {"zh": "至少需要 2 个基因组才能建立链接", "en": "At least 2 genomes are required for links"},
    "global_tab":       {"zh": "全局参数",                "en": "Global"},
    "genome_all_tab":   {"zh": "GenomeALL",              "en": "GenomeALL"},
    "genome_tab":       {"zh": "Genome {n}",             "en": "Genome {n}"},
    "link_all_tab":     {"zh": "LinkALL",                "en": "LinkALL"},
    "add_genome":       {"zh": "＋ 添加/转到基因组",       "en": "＋ Add/goto genome"},
    "remove_genome":    {"zh": "－ 移除该基因组",          "en": "－ Remove genome"},
    "add_genome_tip":   {"zh": "添加该编号的基因组配置段（已存在则直接跳到该页）；同时需在左侧添加对应 GenomeInfoFile", "en": "Create this genome section (or jump to it); also add its GenomeInfoFile on the left"},
    "genome_add_which": {"zh": "添加编号",                "en": "Add #"},
    "genome_remove_which": {"zh": "移除编号",             "en": "Remove #"},
    "genomes_count":    {"zh": "基因组：{g} · 链接：{l}",  "en": "Genomes: {g} · Links: {l}"},
    "remove_last_genome": {"zh": "将移除最后一个基因组配置段。继续？", "en": "This removes the last genome section. Continue?"},
    "palette_none":       {"zh": "（未使用）",           "en": "(not used)"},
    "palette_pick":       {"zh": "选择调色板",           "en": "Choose a palette"},
    "palette_clear":      {"zh": "清除（不使用调色板）",  "en": "Clear (no palette)"},
    "palette_builtin_qual": {"zh": "RColorBrewer · 定性/分类", "en": "RColorBrewer · qualitative"},
    "palette_builtin_seq":  {"zh": "RColorBrewer · 连续/渐变", "en": "RColorBrewer · sequential/diverging"},
    "palette_files":      {"zh": "扩展目录",              "en": "Extension folder"},
    "view_menu":        {"zh": "视图",                    "en": "View"},
    "menu_file":        {"zh": "文件",                    "en": "File"},
    "reset_layout":     {"zh": "重置布局",                "en": "Reset layout"},
    "right_dock_title": {"zh": "参数",                    "en": "Parameters"},
    "log_dock_title":   {"zh": "运行日志",                "en": "Run log"},
    "genome_manage":    {"zh": "基因组 / 链接管理",        "en": "Genome / link manager"},
    "add_link":         {"zh": "＋ 添加链接",              "en": "＋ Add link"},
    "remove_link":      {"zh": "－ 移除该链接",            "en": "－ Remove link"},
    "auto_refresh":     {"zh": "自动刷新",                "en": "Auto refresh"},
    "auto_refresh_tip": {"zh": "参数修改后自动重跑引擎并刷新预览", "en": "Re-run the engine automatically after parameter edits"},
    "show_params":      {"zh": "参数总览",                "en": "Parameters"},
    "params_none":      {"zh": "（尚未设置任何参数）",     "en": "(no parameters set)"},
    "summary_nav_note": {"zh": "点击左侧段名可快速定位",   "en": "Click a section to jump to it"},
    "refresh_preview":  {"zh": "🔄 刷新预览",             "en": "🔄 Refresh preview"},
    "refresh_tip":      {"zh": "用当前参数重新运行并刷新预览图（F5）", "en": "Re-run with current parameters and refresh the preview (F5)"},
    "stale_running":    {"zh": "参数已修改，正在重新渲染…", "en": "Parameters changed — re-rendering…"},
    "stale_manual":     {"zh": "参数已修改，点击刷新预览",   "en": "Parameters changed — click Refresh preview"},
    "stale_fail_hint":  {"zh": "自动刷新失败，详见运行日志", "en": "Auto refresh failed — see the run log"},
    "show_all_params":  {"zh": "显示全部参数",           "en": "Show all params"},
    "enabled":          {"zh": "启用",                    "en": "On"},
    "running":          {"zh": "正在运行 NGenomeSyn …",   "en": "Running NGenomeSyn …"},
    "already_running":  {"zh": "上一次运行还在进行中，请等待完成", "en": "A run is still in progress, please wait"},
    "run_fail_title":   {"zh": "运行失败",                "en": "Run failed"},
    "run_fail_msg":     {"zh": "NGenomeSyn 引擎未成功出图（原因：{reason}）。详细输出见下方/运行日志页：", "en": "The engine did not produce a figure (reason: {reason}). See the run log below:"},
    "done_ok":          {"zh": "完成：{f}",               "en": "Done: {f}"},
    "done_fail":        {"zh": "运行失败，请查看运行日志", "en": "Run failed, see the log tab"},
    "no_genome1":       {"zh": "请先添加 GenomeInfoFile1（至少 2 个基因组）", "en": "Please add GenomeInfoFile1 first (at least 2 genomes)"},
    "file_missing":     {"zh": "文件不存在：{f}",         "en": "File not found: {f}"},
    "perl_missing":     {"zh": "未找到 Perl。Windows 请将便携版 Perl 放到 gui_runtime/perl/，Linux 请安装 perl。", "en": "Perl not found. On Windows put portable Perl under gui_runtime/perl/, on Linux install perl."},
    "conf_written":     {"zh": "配置已写入 {f}",          "en": "Conf written to {f}"},
    "conf_loaded":      {"zh": "已载入配置 {f}",          "en": "Conf loaded from {f}"},
    "conf_aliases":     {"zh": "已自动改写 {n} 处历史拼写：{keys}", "en": "Auto-corrected {n} legacy spellings: {keys}"},
    "export_done":      {"zh": "已导出 {f}",              "en": "Exported {f}"},
    "no_preview":       {"zh": "尚无预览。请先运行绘图。", "en": "No preview yet. Run first."},
    "filter":           {"zh": "筛选参数…",              "en": "Filter params…"},
    "filter_tip":       {"zh": "跨全部分类搜索参数",       "en": "Search across all groups"},
    "show_all_tip":     {"zh": "同时显示低频参数",         "en": "Also show low-frequency parameters"},
    "filter_nomatch":   {"zh": "没有匹配的参数",           "en": "No matching parameters"},
    "cat_all_lowfreq":  {"zh": "该分类参数均为低频参数，请勾选“显示全部参数”",
                         "en": 'All parameters here are low-frequency; tick "Show all params" to display them'},
    "presence_only_tip": {"zh": "该项只要存在就生效，写 0 也会生效；留空 = 不生效",
                          "en": "The engine acts on this key merely existing — writing 0 "
                                "also triggers it; leave empty to disable"},
    "open_failed":      {"zh": "无法打开该文件（系统未注册打开方式）",
                         "en": "Could not open the file (no handler registered)"},
    "files_folded_hint": {"zh": "已配置 {n} 个文件，此处仅显示列表；请用左侧面板编辑",
                          "en": "Configured {n} files — listed here for reference; "
                                "edit them in the left panel"},
    "loading_genomes":  {"zh": "正在载入 {n} 个配置段…", "en": "Loading {n} sections…"},
    "new_project":      {"zh": "新建",                    "en": "New"},
    "choose":           {"zh": "选择…",                   "en": "Browse…"},
    "save_conf_title":  {"zh": "保存 NGenomeSyn 配置",    "en": "Save NGenomeSyn conf"},
    "open_conf_title":  {"zh": "打开 NGenomeSyn 配置",    "en": "Open NGenomeSyn conf"},
    "animated_hint":    {"zh": "动态 SVG 请用浏览器打开：{f}", "en": "Animated SVG: open in a browser: {f}"},
    "err_title":        {"zh": "错误",                    "en": "Error"},
    "warn_title":       {"zh": "提示",                    "en": "Notice"},
    "validate_title":   {"zh": "配置检查未通过",           "en": "Configuration check failed"},
    "validate_intro":   {"zh": "以下问题会导致引擎中途报错或画图异常，请先修正：", "en": "These problems would make the engine abort mid-run or misrender:"},
    "validate_warn":    {"zh": "警告（可继续运行）：",      "en": "Warnings (you can still run):"},
    "zoomregion_bad":   {"zh": "ZoomRegion 格式应为 chr:start:end（Genome {n}）", "en": "ZoomRegion format is chr:start:end (Genome {n})"},
    "palette_unknown":  {"zh": "未知调色板名 {key}={v}（可选：{n} 个内置名）", "en": "Unknown palette name {key}={v} ({n} built-in names)"},
    "style_bad":        {"zh": "StyleUpDown 取值应为 UpDown/DownUp/UpUp/DownDown/line（Link {n}）", "en": "StyleUpDown must be UpDown/DownUp/UpUp/DownDown/line (Link {n})"},
    "zoom_chr_zero":    {"zh": "ZoomChr 不能为 0（Genome {n}）", "en": "ZoomChr must not be 0 (Genome {n})"},
    "endcurve_low":     {"zh": "EndCurveRadian 至少为 2（已填 {v}，Genome {n}）", "en": "EndCurveRadian must be >= 2 (got {v}, Genome {n})"},
    "ritao_low":        {"zh": "{key} 至少为 0.1（已填 {v}）", "en": "{key} must be > 0.1 (got {v})"},
    "genome_gap":       {"zh": "GenomeInfoFile 编号必须连续从 1 开始（缺少第 {n} 个）", "en": "GenomeInfoFile numbers must be contiguous from 1 (missing #{n})"},
    "link_self":        {"zh": "Link 的两个基因组编号相同（Link {n}）", "en": "Link endpoints reference the same genome (Link {n})"},
    "link_range":       {"zh": "Link {n} 引用了不存在的基因组编号 {g}", "en": "Link {n} references a non-existing genome #{g}"},
    "len_header_bad":   {"zh": ".len 首行至少需要 3 列（引擎会直接退出）：{f}", "en": "First line of a genome file needs >= 3 columns (engine exits): {f}"},
    "link_header_bad":  {"zh": ".link 首行至少需要 6 列（引擎会直接退出）：{f}", "en": "First line of a link file needs >= 6 columns (engine exits): {f}"},
    "row_startend_bad": {"zh": "{f} 第 {n} 行的 Start 和 End 不能同时 > 1（引擎会直接退出）", "en": "{f} line {n}: Start and End must not both be > 1 (engine exits)"},
    "zoom_chr_missing": {"zh": "ZoomRegion 的染色体 {c} 不在 {f} 中（Genome {n}）", "en": "ZoomRegion chromosome {c} is not in {f} (Genome {n})"},
    "zoom_region_out":  {"zh": "ZoomRegion 区间超出染色体范围（Genome {n}）：{v}", "en": "ZoomRegion outside the chromosome range (Genome {n}): {v}"},
    "totalgenome_bad":  {"zh": "TotalGenomeNumber ({v}) 大于实际基因组数 ({g})（引擎会直接退出）", "en": "TotalGenomeNumber ({v}) exceeds the genome count ({g}) (engine exits)"},
    "canvas_title":     {"zh": "画布预览",                "en": "Canvas preview"},
}


class I18N:
    _lang = "zh"

    @classmethod
    def lang(cls):
        return cls._lang

    @classmethod
    def set_lang(cls, lang):
        if lang in LANGS:
            cls._lang = lang

    @classmethod
    def tr(cls, key, **kw):
        s = STRINGS.get(key, {})
        text = s.get(cls._lang) or s.get("zh") or key
        if kw:
            try:
                text = text.format(**kw)
            except (KeyError, IndexError):
                pass
        return text
