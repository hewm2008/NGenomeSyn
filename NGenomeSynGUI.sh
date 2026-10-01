#!/bin/sh
# NGenomeSyn GUI launcher (Linux/macOS)
DIR=$(cd "$(dirname "$0")" && pwd)

# packaged app first
for d in "$DIR/dist/NGenomeSynGUI" "$DIR/NGenomeSynGUI"; do
    if [ -x "$d/NGenomeSynGUI" ]; then exec "$d/NGenomeSynGUI"; fi
done

# dev mode: needs python3 (>=3.9)
if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 not found. Please install Python 3.9+ first." >&2
    echo "未找到 python3，请先安装 Python 3.9+。" >&2
    exit 1
fi

# PySide6 present?
if ! python3 -c "import PySide6" >/dev/null 2>&1; then
    echo "============================================================" >&2
    echo " 首次启动需要安装 PySide6（约 1-2 分钟），请稍候..." >&2
    echo " First launch: installing PySide6 (about 1-2 minutes)..." >&2
    echo "============================================================" >&2
    ok=0
    python3 -m pip install PySide6 >/dev/null 2>&1 && ok=1
    if [ "$ok" -eq 0 ]; then
        echo "  默认源失败，尝试 --user 安装 / trying --user install..." >&2
        python3 -m pip install --user PySide6 >/dev/null 2>&1 && ok=1
    fi
    if [ "$ok" -eq 0 ]; then
        echo "  失败，尝试清华镜像源 / trying Tsinghua mirror..." >&2
        python3 -m pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple PySide6 >/dev/null 2>&1 && ok=1
    fi
    if [ "$ok" -eq 0 ]; then
        python3 -m ensurepip >/dev/null 2>&1
        python3 -m pip install --user PySide6 >/dev/null 2>&1 && ok=1
    fi
    if [ "$ok" -eq 0 ]; then
        echo "PySide6 自动安装失败 / automatic install failed." >&2
        echo "请手动安装 / Please install manually:  python3 -m pip install PySide6" >&2
        echo "（可能缺少权限或网络受限 / permission or network issue）" >&2
        exit 1
    fi
    if ! python3 -c "import PySide6" >/dev/null 2>&1; then
        echo "PySide6 安装后仍无法导入 / still not importable after install." >&2
        exit 1
    fi
    echo "PySide6 安装完成 / PySide6 installed." >&2
fi

# self-test first: surfaces a broken install / missing engine BEFORE the
# window is created (failures are visible, not a silent flash)
if ! python3 "$DIR/gui/main.py" --selftest; then
    echo "" >&2
    echo "[ERROR] 自检未通过 / self-test failed - see the messages above." >&2
    echo "       引擎需要 Perl；Windows 请将便携版 Perl 解压到 gui_runtime/perl/" >&2
    exit 1
fi

exec python3 "$DIR/gui/main.py" "$@"
