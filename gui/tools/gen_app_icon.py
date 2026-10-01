import argparse
import struct
from pathlib import Path

from PySide6.QtCore import QBuffer, QIODevice
from PySide6.QtWidgets import QApplication


def generate(destination):
    from gui.ui.logo import logo_pixmap

    app = QApplication.instance() or QApplication([])
    chunks = []
    for kind, size in ((b"icp4", 16), (b"icp5", 32), (b"icp6", 64),
                       (b"ic07", 128), (b"ic08", 256), (b"ic09", 512),
                       (b"ic10", 1024)):
        buffer = QBuffer()
        buffer.open(QIODevice.WriteOnly)
        if not logo_pixmap(square=True, size=size).save(buffer, "PNG"):
            raise RuntimeError("Failed to render application icon")
        data = bytes(buffer.data())
        chunks.append(kind + struct.pack(">I", len(data) + 8) + data)
    payload = b"".join(chunks)
    Path(destination).write_bytes(b"icns" + struct.pack(">I", len(payload) + 8) + payload)


if __name__ == "__main__":
    import sys
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
    parser = argparse.ArgumentParser()
    parser.add_argument("destination", type=Path)
    generate(parser.parse_args().destination)
