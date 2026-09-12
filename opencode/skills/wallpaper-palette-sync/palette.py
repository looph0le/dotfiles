#!/usr/bin/env python3
"""Extract color palette from a wallpaper using colorz, then write Ghostty config."""

import sys
from pathlib import Path

import numpy as np
from colorz import colorz, brighten
from PIL import Image


GHOSTTY_DIR = Path.home() / ".config" / "ghostty" / "auto"


def hex_rgb(r, g, b):
    return f"#{r:02x}{g:02x}{b:02x}"


def luminance(r, g, b):
    return 0.299 * r + 0.587 * g + 0.114 * b


def saturation(r, g, b):
    return max(r, g, b) - min(r, g, b)


def top_colors(thumb, n):
    px = np.array(thumb.convert("RGB"), dtype=np.int16).reshape(-1, 3)
    q = (px // 16) * 16
    unique, counts = np.unique(q, axis=0, return_counts=True)
    order = np.argsort(-counts)
    return [tuple(map(int, unique[i])) for i in order[:n]]


def extract(image_path):
    img = Image.open(image_path).convert("RGB")
    thumb = img.copy()
    thumb.thumbnail((160, 160))

    px = np.array(thumb, dtype=np.uint8).reshape(-1, 3).astype(np.int16)

    lum = 0.299 * px[:, 0] + 0.587 * px[:, 1] + 0.114 * px[:, 2]
    dark_idx = np.argmin(lum)
    light_idx = np.argmax(lum)
    dark_px = tuple(map(int, px[dark_idx]))
    light_px = tuple(map(int, px[light_idx]))

    colors = colorz(image_path, n=6)
    cols = [tuple(map(int, c)) for c, _ in colors]
    brights = [tuple(map(int, b)) for _, b in colors]

    if len(cols) < 6:
        for c in top_colors(thumb, 12):
            if len(cols) >= 6:
                break
            if all(max(abs(a - b) for a, b in zip(c, e)) > 16 for e in cols):
                cols.append(c)
                brights.append(tuple(map(int, brighten(c, 50))))

    vibrant = max(cols + brights, key=lambda c: saturation(*c))

    # colorz hue order: red, yellow, green, cyan, blue, magenta
    # ANSI slots: 1=red, 2=green, 3=yellow, 4=blue, 5=magenta, 6=cyan
    colorz_to_ansi = [(0, 1), (1, 3), (2, 2), (3, 6), (4, 4), (5, 5)]

    ansi = {
        0: dark_px,
        7: light_px,
        8: tuple(map(int, np.clip(np.array(dark_px) + 40, 0, 255))),
        15: tuple(map(int, np.clip(np.array(light_px) + 40, 0, 255))),
    }

    for colorz_idx, ansi_slot in colorz_to_ansi:
        ansi[ansi_slot] = cols[colorz_idx]
        ansi[ansi_slot + 8] = brights[colorz_idx]

    return {
        "bg": dark_px,
        "fg": light_px,
        "cursor": vibrant,
        "ansi": ansi,
    }


def write_ghostty(palette, path):
    path.parent.mkdir(parents=True, exist_ok=True)
    a = {k: hex_rgb(*v) for k, v in palette["ansi"].items()}
    bg = hex_rgb(*palette["bg"])
    fg = hex_rgb(*palette["fg"])
    cursor = hex_rgb(*palette["cursor"])

    lines = [
        f"background = {bg}",
        f"foreground = {fg}",
        f"cursor-color = {cursor}",
        f"cursor-text = {bg}",
        f"selection-background = {a[0]}",
        f"selection-foreground = {fg}",
        "",
    ]
    for i in range(16):
        lines.append(f"palette = {i}={a[i]}")

    path.write_text("\n".join(lines) + "\n")
    print(f"Wrote {path}")


def main():
    if len(sys.argv) < 2:
        print("Usage: palette.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]
    palette = extract(image_path)

    write_ghostty(palette, GHOSTTY_DIR / "theme.ghostty")


if __name__ == "__main__":
    main()
