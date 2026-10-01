"""Preflight validation mirroring every guard inside bin/NGenomeSyn.

The engine checks most of these only mid-run and then exits with a terse
message (or crashes, e.g. division by zero for an unknown palette name).
Running the same checks here turns minutes of confused debugging into an
immediate, localised dialog.

Each check cites the engine line it mirrors.
"""
import gzip
from pathlib import Path

from .schema import Schema

ROW_CAP = 500000


def _open_text(path):
    p = Path(path)
    if p.suffix.lower() == ".gz":
        return gzip.open(p, "rt", encoding="utf-8", errors="replace")
    return open(p, "r", encoding="utf-8", errors="replace")


def _num(v):
    try:
        return float(v)
    except (TypeError, ValueError):
        return 0.0


def _genome_lengths(files):
    """{chr: (start, end)} of the first occurrence per .len file set."""
    lengths = {}
    for f in files:
        if not f:
            continue
        try:
            with _open_text(f) as fh:
                for line in fh:
                    parts = line.split()
                    if len(parts) >= 3 and not line.startswith("#"):
                        lengths.setdefault(parts[0],
                                           (parts[1], parts[2]))
        except OSError:
            continue
    return lengths


def validate(model):
    """Returns (errors, warnings): errors block the run, warnings do not."""
    errors, warnings = [], []
    tr = lambda k, **kw: _tr(k, **kw)                     # noqa: E731

    files = [f for f in model.genome_files if f]
    n_genomes = len(model.genome_files)

    # --- genome count (engine :1609 exits when < 2) ----------------------
    if n_genomes < 2 or not files:
        errors.append(tr("no_genome1"))
        return errors, warnings

    # --- contiguity: engine indexes GenomeInfoFileN directly -------------
    for i, f in enumerate(model.genome_files, 1):
        if not f:
            errors.append(tr("genome_gap", n=i))
    if len(files) > 20:                                   # engine :1615 warn
        warnings.append("more than 20 genomes (engine recommends <= 20)")

    # --- files exist (engine :1516 / :1578 exit) -------------------------
    for i, f in enumerate(model.genome_files, 1):
        if f and not Path(f).is_file():
            errors.append(tr("file_missing", f=f))

    # --- .len format (engine :1529 header probe, :1560 start/end rule) ---
    header_bad, row_bad = set(), []
    for i, f in enumerate(model.genome_files, 1):
        if not f or not Path(f).is_file():
            continue
        try:
            with _open_text(f) as fh:
                first = fh.readline()
                if len(first.split()) < 3:
                    header_bad.add(tr("len_header_bad", f=f))
                for n, line in enumerate(fh, 2):
                    if n > ROW_CAP:
                        break
                    parts = line.split()
                    if len(parts) < 3 or line.startswith("#"):
                        continue
                    if _num(parts[1]) > 1 and _num(parts[2]) > 1:
                        row_bad.append(tr("row_startend_bad", f=Path(f).name, n=n))
        except OSError:
            continue
    errors.extend(sorted(header_bad))
    errors.extend(row_bad[:20])
    if len(row_bad) > 20:
        errors.append("... +%d more" % (len(row_bad) - 20))

    # --- .link format (engine :1592 header probe needs >= 6 fields) ------
    for n, lf in enumerate(model.link_files, 1):
        if not Path(lf["path"]).is_file():
            errors.append(tr("file_missing", f=lf["path"]))
            continue
        if not (1 <= lf["a"] <= n_genomes and 1 <= lf["b"] <= n_genomes):
            errors.append(tr("link_range", n=n, g=max(lf["a"], lf["b"])))
        if lf["a"] == lf["b"]:
            warnings.append(tr("link_self", n=n))
        try:
            with _open_text(lf["path"]) as fh:
                if len(fh.readline().split()) < 6:
                    errors.append(tr("link_header_bad", f=lf["path"]))
        except OSError:
            continue

    # --- TotalGenomeNumber (engine :1628 exits when tt > NumGG) ----------
    tgn = model.global_params.get("TotalGenomeNumber")
    try:
        if tgn and int(tgn) > n_genomes:
            errors.append(tr("totalgenome_bad", v=tgn, g=n_genomes))
    except (TypeError, ValueError):
        pass

    # --- per-genome section checks ---------------------------------------
    chr_lengths = None
    palettes = set(Schema.palettes().get("builtin", {}))
    for idx in sorted(model.genomes):
        sec = model.genomes[idx]
        if not sec:
            continue
        for key in ("ZoomChr",):
            try:
                if key in sec and _num(sec[key]) == 0:
                    errors.append(tr("zoom_chr_zero", n=idx))
            except (TypeError, ValueError):
                pass
        ecr = sec.get("EndCurveRadian")
        try:
            if ecr is not None and _num(ecr) < 2:          # engine :2958 clamps
                warnings.append(tr("endcurve_low", v=ecr, n=idx))
        except (TypeError, ValueError):
            pass
        zr = sec.get("ZoomRegion") or ""
        if zr:
            parts = zr.split(":")
            if len(parts) != 3:
                errors.append(tr("zoomregion_bad", n=idx))
            else:
                if chr_lengths is None:
                    chr_lengths = _genome_lengths(model.genome_files)
                cname, s, e = parts[0], _num(parts[1]), _num(parts[2])
                if cname in chr_lengths:
                    lo, hi = sorted((_num(chr_lengths[cname][0]),
                                     _num(chr_lengths[cname][1])))
                    if not (lo <= s <= hi and lo <= e <= hi):
                        errors.append(tr("zoom_region_out", n=idx, v=zr))
                else:
                    errors.append(tr("zoom_chr_missing", c=cname,
                                     f=model.genome_files[idx - 1] if idx <= len(model.genome_files) else "?"))
        srf = sec.get("SpeRegionFile")
        if srf and not Path(srf).is_file():
            # engine :2989 only warns, then skips the file
            warnings.append(tr("file_missing", f=srf))
    for sec in (model.genome_all,):
        srf = sec.get("SpeRegionFile")
        if srf and not Path(srf).is_file():
            warnings.append(tr("file_missing", f=srf))

    # --- canvas sanity -----------------------------------------------------
    for key in ("CanvasHeightRitao", "CanvasWidthRitao"):
        v = model.global_params.get(key)
        try:
            if v is not None and _num(v) <= 0.1:           # engine :1830/:1835
                warnings.append(tr("ritao_low", key=key, v=v))
        except (TypeError, ValueError):
            pass

    # --- palettes: unknown names CRASH the engine (Illegal modulus zero) --
    for key in ("GenomeColorBrewer", "ChrColorBrewer", "SpeRegionColorBrewer"):
        v = model.global_params.get(key)
        if v and v not in palettes:
            errors.append(tr("palette_unknown", key=key, v=v, n=len(palettes)))

    # --- StyleUpDown: case-sensitive enum, bad values fall to the default -
    style_ok = set(Schema.data().get("style_choices") or [])
    for idx in sorted(model.links):
        sec = model.links[idx]
        v = sec.get("StyleUpDown")
        if v and style_ok and v not in style_ok:
            warnings.append(tr("style_bad", n=idx))
    v = model.link_all.get("StyleUpDown")
    if v and style_ok and v not in style_ok:
        warnings.append(tr("style_bad", n="ALL"))

    return errors, warnings


def _tr(key, **kw):
    from ..i18n import I18N
    return I18N.tr(key, **kw)
