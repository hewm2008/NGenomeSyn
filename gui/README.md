# NGenomeSyn GUI（跨平台桌面图形界面）

NGenomeSyn 的跨平台图形界面：**同一份代码运行于 Windows / Linux / macOS**，无需命令行即可完成
从数据导入、参数配置到预览、导出的完整流程。底层仍调用原版 Perl 引擎
`bin/NGenomeSyn`（**引擎保持零修改**）。

The cross-platform desktop GUI for NGenomeSyn. One codebase runs on
Windows/Linux/macOS; it drives the original, **unmodified** Perl engine.

## 功能 / Features

- 双数据列表管理：基因组文件 `GenomeInfoFile1..N`（.len，行序=图中顺序）与
  链接文件 `LinkFileRefA VsRefB`（.link，行序=LinkN 编号），左侧面板与
  "全局参数 → 数据文件"分类页双入口同步；自动按文件名推导默认基因组名
- 全量参数表单：66 个真实参数（由 `bin/NGenomeSyn` 源码交叉校验生成 schema），
  按分类浏览、中英双语说明、显示引擎真实默认值与取值范围；
  包含 17 个官方文档未提及但引擎真实读取的参数
- 35 个内置 RColorBrewer 调色板选择器（色条预览、搜索），分别作用于
  染色体条 / 链接带 / 特殊区域三个键
- 历史错拼自动改写：`HightRation→HeightRatio`、`MainCor→MainColor`、
  `UpUP→UpUp`、`GenomeNameRatio→GenomeNameSizeRatio`、`MoveX/MoveY→MoveToX/MoveToY`，
  日志明确列出改写清单，绝不静默
- **运行前配置检查**：.len/.link 列数、start/end 规则、ZoomRegion 越界、
  未知调色板名（会导致引擎除零崩溃）等，全部在运行前拦截
- SVG 实时预览 + 缩放，导出高分辨率 PNG / PDF（由 Qt 渲染，不依赖 ImageMagick）
- 中英双语界面，一键切换；布局与语言记忆

## 引擎改动：仅 1 处（Windows 必需）

`bin/NGenomeSyn` 只改了一段——**SVG 模块探测**，因为原来的写法在 Windows 上
根本无法执行：

```perl
# 改前：spawn shell，且重定向到 Unix 专用的 /dev/null
$SVGTest = ` perl -MSVG -e " print\\\"SVG\\\" "  2>  /dev/null  `;

# 改后：纯 Perl 探测，不 spawn 任何 shell
my $SVGTest = "";
if ( eval { require SVG; 1 } ) { $SVGTest = "SVG"; }
```

原因：`cmd.exe` 会把 `2> /dev/null` 解析成 `\dev\nul`，该目录不存在，于是报
“系统找不到指定的路径”并**直接跳过命令**，`perl` 根本没被启动；同时 `\"`
是给 `sh` 的转义，`cmd` 不认。GUI 侧无法绕过（无法让 `cmd` 成功创建
`\dev\nul`），因此这处必须改。改后语义完全等价（仍然"先试系统 SVG，再退回
内置 `bin/svg_kit/SVG.pm`"），且不再依赖 shell。

**零回归验证**：用原始引擎与改后引擎分别跑官方 9 个示例 conf，生成的 SVG
**字节完全一致**（`test_gui_regressions.py` 中的 `byte.identity` 覆盖）。

其余已知问题都在 GUI 侧化解，**引擎不再改动**：

| 引擎问题 | GUI 侧方案 |
|---|---|
| `open "\|gzip -cd $f \|"` 外部命令读 .gz（6 处，Windows/空格路径不可用） | `core/gzcache.py` 用 Python gzip 预解压到系统缓存目录，运行时 conf 指向纯文本副本；缓存文件**保留真实文件名**（引擎由文件名推导默认基因组名），按 `(绝对路径, mtime, size)` 失效 |
| 成功时 `exit(1)`（-NoPng 路径），部分错误 `exit(0)` | runner 以「SVG 存在且非空」判定成功，从不参考退出码 |
| ImageMagick `convert` 依赖 / Windows `convert.exe` 陷阱 | GUI 始终传 `-NoPng`，PNG/PDF 由 `QSvgRenderer` 渲染导出 |
| `use lib "/hwfssz4/..."` 硬编码路径 | 实测为无害 no-op（目录不存在时 `use lib` 静默跳过） |
| 强制升级 `checkUpdate`（wget） | 引擎中已被注释（`:48`），不会触发 |
| 提示 `Possible precedence problem ... line 2348` | `SpeRegion` 解析里的既有写法告警，不影响出图，可忽略 |

回归保障：`gui/tests/test_gui_regressions.py` 对官方 Example 全部 conf 做
**GUI 生成 conf vs 官方 conf 的 SVG 字节一致性**验证（含错拼写改写特例与
.gz 缓存等价性）。

## 快速开始 / Quick start

### 开发态运行（Linux / macOS）

```bash
pip install PySide6          # Python >= 3.9
./NGenomeSynGUI.sh           # 或 python3 gui/main.py
```

### 开发态运行（Windows）

```
pip install PySide6
NGenomeSynGUI.bat            (双击即可；或 python gui\main.py)
```

### 启动失败排查（双击闪退 / 闪一下就没）

启动器**全程落盘日志**，并在启动后 8 秒自动检查 GUI 是否真正进入事件循环；
若已崩溃，黑色窗口会**直接打印原因**并暂停。日志文件位置：

| 文件 | 内容 |
|---|---|
| `ngs_gui_launcher.log` | 启动器全过程（Python 路径、PySide6 安装、self-test 输出） |
| `ngs_gui_launch.log` | GUI 内部逐阶段日志：解释器 → 导入 → QApplication → 主题 → 图标 → MainWindow → **event loop**；Qt 自身警告也记在这里 |
| `ngs_gui_crash.log` | 未捕获异常与 Python 崩溃栈（faulthandler，含 C 级崩溃） |

崩溃时**最后一行 stage 就是断点位置**。也可手动执行自检：

```bat
python gui\main.py --selftest
```

自检逐项：PySide6 → Qt 平台插件 → 参数 schema → logo 资源 → 引擎文件 →
`bin\svg_kit` → Perl 解释器 → **引擎能否真正被 perl 执行**（`perl -c`）→
Qt 渲染 → 临时目录可写。

| 现象 | 原因与处理 |
|---|---|
| `[FATAL] Python 3.9 or newer was not found in PATH` | 未装 Python 或未加 PATH |
| `[FATAL] PySide6 install failed` | 网络受限；手动 `python -m pip install PySide6 -i https://pypi.tuna.tsinghua.edu.cn/simple` |
| `[FAIL] perl runtime` | 系统无 Perl。下载 portable Strawberry Perl，解压使 `gui_runtime\perl\perl\bin\perl.exe` 存在 |
| `[FAIL] bundled svg_kit` | `bin\svg_kit\SVG.pm` 缺失，拷贝时漏了目录 |
| `[FAIL] engine compiles` | 便携 Perl 不完整 |
| `[FATAL] did not reach the event loop` | 看 `ngs_gui_launch.log` 最后一行 stage，并检查是否是**旧版 gui 目录残留** |
| 窗口出现后一闪而过、无窗口 | 同样以 `ngs_gui_launch.log` 末尾 stage 为准 |

> 排错提示：启动器使用**与 self-test 同一个解释器**的 `pythonw`（而非系统里
> 任意一个 `pythonw`）——常见的"窗口根本不出现"就是 `pythonw` 指向了另一个
> 没装 PySide6 的 Python。
>
> 注：`NGenomeSynGUI.bat` 必须保持 **CRLF + ASCII**。UTF-8 中文注释或 LF 行尾会让
> `cmd.exe` 解析异常，表现为双击闪退。

### 打包发行版（Windows 双击即用）

```bat
pip install pyinstaller
pyinstaller gui\tools\NGenomeSynGUI.spec --distpath dist --noconfirm
python gui\tools\build_windows.py dist\NGenomeSynGUI
```

产物目录结构：

```
NGenomeSynGUI/
├── NGenomeSynGUI.exe         双击运行
├── bin/                      Perl 引擎（原样）+ svg_kit
├── gui_runtime/perl/         放入便携版 Strawberry Perl
│                             （解压为 gui_runtime/perl/perl/bin/perl.exe）
└── NGenomeSyn_manual_*.pdf   手册
```

放入便携 Perl 后用户**零安装、零配置**；不放入时也可用系统 PATH 中的 perl。

Linux 打包同理；macOS 用 `python3 gui/tools/gen_app_icon.py gui/resources/NGenomeSyn.icns`
生成图标后 `pyinstaller` 直接产出 `dist/NGenomeSyn.app`（spec 内含 BUNDLE），
打包必须在 macOS 本机完成。

### GUI 手册

帮助对话框可打开附带的手册；缺失时由 `gui/tools/gen_gui_manual.py`
按 schema **一键生成**（PDF + Word），参数参考章节永远与 schema 同步：

```bash
python3 gui/tools/gen_gui_manual.py     # 输出到 gui/doc/
```

## 目录 / Layout

```
gui/
├── main.py                  入口
├── i18n.py                  中英双语文案
├── theme.py                 亮/暗主题（跟随系统）
├── core/
│   ├── schema.py            参数 schema 加载
│   ├── conf_io.py           conf 模型 / 读写（含错拼改写清单）
│   ├── runner.py            QProcess 运行引擎（-NoPng，SVG 判定成功）
│   ├── gzcache.py           .gz 预解压缓存（保留文件名推导基因组名）
│   └── validate.py          运行前配置检查（镜像引擎全部中止点）
├── ui/
│   ├── main_window.py       主窗口（三栏工作台）
│   ├── files_panel.py       基因组/链接双文件面板（Bar+Panel+预览）
│   ├── param_form.py        参数表单（分类树 + 调色板选择器）
│   ├── genome_tab.py        Genome N / Link N 惰性页签
│   ├── params_summary.py    参数总览（全段可编辑）
│   ├── preview.py           SVG 预览 + PNG/PDF 导出
│   └── logo.py              应用图标 / 关于页 logo
├── doc/                     随发行版分发的文档
│   ├── GUI_Home.png                        主界面截图（README / 手册 / 推文）
│   ├── GUI_Data.png                        左栏数据列表与预览细节
│   ├── NGenomeSyn_GUI_manual_Chinese.pdf/.docx
│   ├── NGenomeSyn_GUI_manual_English.pdf/.docx
│   └── NGenomeSyn_GUI_WeChat_Article.docx/.md   公众号/社交媒体推文稿（发布素材，不在 Help 中列出）
├── resources/
│   ├── params_schema.json   由 gen_schema.py 从引擎源码生成
│   └── NGenomeSyn.icns      macOS 应用图标
├── tests/test_gui_regressions.py   回归测试（offscreen）
└── tools/
    ├── gen_schema.py        重新生成 schema：python3 gui/tools/gen_schema.py
    ├── gen_screenshots.py   离屏渲染 gui/doc/*.png 截图
    ├── gen_gui_manual.py    生成 GUI 手册（PDF/DOCX，内嵌截图）
    ├── gen_wechat_article.py 生成公众号推文稿（DOCX + Markdown）
    ├── gen_app_icon.py      生成 .icns
    ├── NGenomeSynGUI.spec   PyInstaller 打包配置
    └── build_windows.py     组装发行目录（含便携 Perl 说明）
```

## schema 与参数说明

schema 由 `gen_schema.py` 生成，两处来源交叉验证并把结果写入
`validation` 块（生成时必须全绿）：

1. **引擎源码**：正则提取全部 `$HashConfi{...}{...}` 读点、预置默认值、
   36 组 `$HashColData` 调色板数据（其中 PiYG 因缺失 `%MaxColNum` 条目会被
   引擎除零崩溃——已实测并**排除**，故只有 35 个可用）。
2. **手工 META 表**：每个参数的中英说明、类型、范围、默认值（对照引擎源码逐一核实）。

6 个引擎死键（global `strokewidth`/`fill`/`ShiftXaxisY`、`crBG`、`crStrokeBG`）
已被识别并在 GUI 中隐藏。

## 已知限制 / Notes

- 引擎 `.len` 头行探针不跳过 `#` 注释行（`:1526`），故基因组文件首行必须是数据行
  （GUI 检查与之保持一致）。
- 引擎由「conf 中该行的出现顺序」决定 LinkN 编号；GUI 的链接面板与 conf 写出
  均严格保持顺序，删除中间链接会自动重排编号。
- `ScaleUpDown` 引擎只识别 `Up` 一个值（区分大小写）；不设置时基因组 1 在上、
  其余在下。
- schema 更新（引擎升级后）：运行 `python3 gui/tools/gen_schema.py` 重新生成，
  交叉验证不过则生成器会以非零码退出。
