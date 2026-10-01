"""NGenomeSyn conf model, reader and writer (engine-format compatible).

Model sections mirror the engine's %HashConfi layout:
  global_params  <- SetParaFor=global    (files + figure/canvas settings)
  genome_all     <- SetParaFor=GenomeALL (inheritance template)
  genomes[n]     <- SetParaFor=GenomeN   (sparse, n >= 1)
  link_all       <- SetParaFor=LinkALL
  links[m]       <- SetParaFor=LinkM     (m = ordinal of the LinkFileRef line)

UI scopes: "global", "genome_all", ("genome", n), "link_all", ("link", m).
"""
import re
from pathlib import Path

from .schema import Schema

# conf keys whose values are file paths resolved against the conf directory
PATH_KEYS = ("SpeRegionFile",)

_RE_GENOME_FILE = re.compile(r"^GenomeInfoFile(\d+)$")
_RE_LINK_FILE = re.compile(r"^LinkFileRef(\d+)VsRef(\d+)$")
_RE_SECTION_GENOME = re.compile(r"^Genome(\d+)$", re.IGNORECASE)
_RE_SECTION_LINK = re.compile(r"^Link(\d+)$", re.IGNORECASE)


def abspath_for(value, base_dir):
    """Resolve a conf path: ~ expanded, relative -> against base_dir."""
    value = str(value).strip()
    if not value:
        return value
    p = Path(value).expanduser()
    if p.is_absolute():
        return str(p)
    return str((Path(base_dir) / p).resolve())


def quote_value(value, param=None):
    """Quote a value that would otherwise be mangled by the engine parser.

    The engine strips comments at the first '#' and then removes ALL '"', so
    quoting only protects a '#' at the start of a value (the '"#' sequence).
    Bare hex colors (fill=#F8F8F8) parse to an EMPTY string in the engine —
    colors must always be written quoted."""
    value = str(value)
    if value == "":
        return value
    p = Schema.param(param) if param else None
    if value.startswith("#") or "#" in value or (p and p.get("type") == "color"):
        return '"%s"' % value
    return value


def _engine_split(line):
    """Replicate the engine's comment/quote handling for one conf line
    (bin/NGenomeSyn:1475-1494), including the value-truncation at the
    second '=' of Perl's split(/\\s*=\\s*/)."""
    line = line.strip().strip("\r")
    if not line or line.startswith("#"):
        return None
    line = line.replace('"#', "\x00")
    line = line.split("##")[0].split("#")[0]
    line = line.replace("\x00", '"#').replace('"', "").strip()
    if "=" not in line:
        return None
    parts = re.split(r"\s*=\s*", line, maxsplit=2)
    key = parts[0].strip()
    value = parts[1].strip() if len(parts) > 1 else ""
    return (key, value) if key else None


class ConfModel:
    """In-memory representation of an NGenomeSyn configuration."""

    def __init__(self):
        self.genome_files = ["", ""]      # GenomeInfoFile1..N (N = index+1)
        # ordered; {"a": int, "b": int, "path": str}; ordinal = LinkN
        self.link_files = []
        self.global_params = {}
        self.genome_all = {}
        self.genomes = {}                 # {int: {key: value}}
        self.link_all = {}
        self.links = {}                   # {int: {key: value}}
        # [(line_no, old_key, new_key)] produced by load(): historical
        # misspellings that were silently ignored by the engine
        self.alias_log = []

    # ------------------------------------------------------------ sections
    def section_for(self, scope):
        if isinstance(scope, tuple):
            kind, idx = scope
            if kind == "genome":
                return self.genomes.setdefault(idx, {}) if idx else None
            if kind == "link":
                return self.links.setdefault(idx, {}) if idx else None
            return None
        return {"global": self.global_params,
                "genome_all": self.genome_all,
                "link_all": self.link_all}.get(scope)

    def set_param(self, scope, name, value):
        target = self.section_for(scope)
        if target is None:
            return
        if value is None or value == "":
            target.pop(name, None)
        else:
            target[name] = str(value)

    def get_param(self, scope, name):
        target = self.section_for(scope)
        return (target or {}).get(name, "")

    def all_scopes(self):
        """Every scope that currently holds at least one parameter."""
        out = ["global"]
        if self.genome_all:
            out.append("genome_all")
        out += [("genome", n) for n in sorted(self.genomes)]
        if self.link_all:
            out.append("link_all")
        out += [("link", n) for n in sorted(self.links)]
        return out

    def genome_count(self):
        return len([f for f in self.genome_files if f])

    def link_count(self):
        return len(self.link_files)

    # ------------------------------------------------------------ paths
    def absolutize_paths(self, base_dir):
        """Resolve user-typed relative paths before saving/running so the
        engine never depends on its CWD (it resolves against CWD)."""
        self.genome_files = [abspath_for(f, base_dir) if f else f
                             for f in self.genome_files]
        for lf in self.link_files:
            lf["path"] = abspath_for(lf["path"], base_dir)
        for sec in (self.global_params, self.genome_all, self.link_all,
                    *self.genomes.values(), *self.links.values()):
            for key in PATH_KEYS:
                if sec.get(key):
                    sec[key] = abspath_for(sec[key], base_dir)

    # ------------------------------------------------------------ writing
    def to_conf_text(self, map_path=None):
        """Engine-format conf text. `map_path` rewrites file paths (used at
        run time to swap .gz inputs for pre-decompressed cache copies); the
        default keeps the user's own paths so saved confs stay portable."""
        mp = map_path or (lambda p: p)
        lines = ["# Generated by NGenomeSyn GUI", "", "SetParaFor=global"]
        for i, f in enumerate(self.genome_files):
            if f:
                lines.append("GenomeInfoFile%d=%s" % (i + 1, mp(f)))
        for n, lf in enumerate(self.link_files, 1):
            # the ordinal position of this line IS the LinkN index
            lines.append("LinkFileRef%dVsRef%d=%s"
                         % (lf["a"], lf["b"], mp(lf["path"])))
        for k in sorted(self.global_params):
            if _RE_GENOME_FILE.match(k) or _RE_LINK_FILE.match(k) or k == "SetParaFor":
                continue
            lines.append("%s=%s" % (k, quote_value(self.global_params[k], k)))

        for title, sec in (("GenomeALL", self.genome_all),):
            if sec:
                lines.append("")
                lines.append("SetParaFor=%s" % title)
                lines += ["%s=%s" % (k, quote_value(sec[k], k))
                          for k in sorted(sec)]
        for idx in sorted(self.genomes):
            sec = self.genomes[idx]
            if not sec:
                continue
            lines.append("")
            lines.append("SetParaFor=Genome%d" % idx)
            lines += ["%s=%s" % (k, quote_value(sec[k], k)) for k in sorted(sec)]
        if self.link_all:
            lines.append("")
            lines.append("SetParaFor=LinkALL")
            lines += ["%s=%s" % (k, quote_value(self.link_all[k], k))
                      for k in sorted(self.link_all)]
        for idx in sorted(self.links):
            sec = self.links[idx]
            if not sec:
                continue
            lines.append("")
            lines.append("SetParaFor=Link%d" % idx)
            lines += ["%s=%s" % (k, quote_value(sec[k], k)) for k in sorted(sec)]
        lines.append("")
        return "\n".join(lines)

    def save(self, path):
        Path(path).write_text(self.to_conf_text(), encoding="utf-8")

    # ------------------------------------------------------------ reading
    def load(self, path):
        self.__init__()
        p = Path(path)
        if p.suffix == ".gz":
            import gzip
            with gzip.open(p, "rt", encoding="utf-8", errors="replace") as fh:
                raw_lines = fh.read().splitlines()
        else:
            raw_lines = p.read_text(encoding="utf-8",
                                    errors="replace").splitlines()
        conf_dir = p.resolve().parent
        section = None                    # engine starts at -1: keys before
        aliases = Schema.aliases()        # the first SetParaFor are LOST
        value_aliases = Schema.data().get("value_aliases") or {}
        for lineno, raw in enumerate(raw_lines, 1):
            kv = _engine_split(raw)
            if kv is None:
                continue
            key, value = kv
            if key == "SetParaFor":
                name = value.strip()
                if name == "global":
                    section = "global"
                elif name == "GenomeALL":
                    section = "genome_all"
                elif name == "LinkALL":
                    section = "link_all"
                else:
                    m = _RE_SECTION_GENOME.match(name)
                    if m:
                        section = ("genome", int(m.group(1)))
                    else:
                        m = _RE_SECTION_LINK.match(name)
                        section = ("link", int(m.group(1))) if m else None
                continue
            if section is None:
                # the engine drops these silently ($SetParaFor == -1);
                # mirror that but tell the user
                self.alias_log.append((lineno, key, "(dropped: before SetParaFor)"))
                continue
            m = _RE_GENOME_FILE.match(key)
            if m:
                idx = int(m.group(1))
                while len(self.genome_files) < idx:
                    self.genome_files.append("")
                self.genome_files[idx - 1] = abspath_for(value, conf_dir)
                continue
            m = _RE_LINK_FILE.match(key)
            if m:
                self.link_files.append({"a": int(m.group(1)),
                                        "b": int(m.group(2)),
                                        "path": abspath_for(value, conf_dir)})
                continue
            new_key = Schema.resolve_alias(key)
            if new_key != key:
                self.alias_log.append((lineno, key, new_key))
                key = new_key
            vals = value_aliases.get(key)
            if vals and value in vals:
                self.alias_log.append((lineno, "%s=%s" % (key, value),
                                       "%s=%s" % (key, vals[value])))
                value = vals[value]
            if key in PATH_KEYS:
                value = abspath_for(value, conf_dir)
            target = self.section_for(section)
            if target is not None:
                target[key] = value
        return self
