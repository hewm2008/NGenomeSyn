"""Pre-decompress .gz inputs for the engine.

bin/NGenomeSyn reads .gz inputs through shell pipes (`open FH, "gzip -cd $f |"`,
6 sites), which breaks on Windows and on paths with spaces. The GUI avoids the
engine's shell dependency entirely: any .gz input (genome .len, link .link,
special-region file) is decompressed once with Python's gzip into a cache dir,
and the runtime conf points at the plain copy.

Cache layout — the file KEEPS its real basename because the engine derives the
default genome label from it (split on '/', then '.', take [0], :1571-1572):

    <CacheLocation>/NGenomeSynGUI/gz/<sha1(abspath)[:16]>/<basename minus .gz>

so R64.len.gz -> <key>/R64.len -> label "R64", identical to the plain-file
case. The stamp file records mtime/size so changed sources re-decompress.
"""
import gzip
import hashlib
import shutil
from pathlib import Path


def cache_root():
    from PySide6.QtCore import QStandardPaths
    base = QStandardPaths.writableLocation(QStandardPaths.CacheLocation)
    return Path(base) / "NGenomeSynGUI" / "gz"


def materialize(path):
    """Return a plain (non-.gz) path for `path`; non-gz inputs pass through.

    Never raises: on any failure the original path is returned and the engine
    falls back to its own (shell) decompression."""
    p = str(path or "").strip()
    if not p or not p.lower().endswith(".gz"):
        return p
    src = Path(p).expanduser()
    if not src.is_file():
        return p
    try:
        key = hashlib.sha1(str(src.resolve()).encode("utf-8")).hexdigest()[:16]
        target_dir = cache_root() / key
        target_dir.mkdir(parents=True, exist_ok=True)
        target = target_dir / src.name[:-3]          # strip ".gz"
        stamp = target_dir / "source.stamp"
        st = src.stat()
        sig = "%d:%d" % (st.st_mtime_ns, st.st_size)
        if target.is_file() and target.stat().st_size > 0 \
                and stamp.is_file() and stamp.read_text(encoding="utf-8") == sig:
            return str(target)
        tmp = target_dir / (".tmp-" + target.name)
        with gzip.open(src, "rb") as fin, open(tmp, "wb") as fout:
            shutil.copyfileobj(fin, fout, 1 << 20)
        tmp.replace(target)
        stamp.write_text(sig, encoding="utf-8")
        return str(target)
    except OSError:
        return p


def map_all_paths(model):
    """Runtime path mapper: swap every .gz input of the model for its cached
    plain copy (genome files, link files, special-region files)."""
    cache = {}

    def mp(path):
        if not path or path in cache:
            return cache.get(path, path)
        out = materialize(path)
        cache[path] = out
        return out

    return mp
