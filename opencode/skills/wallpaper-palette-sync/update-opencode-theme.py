#!/usr/bin/env python3
"""Read Ghostty theme and regenerate opencode system-transparent theme."""

import json
import re
import sys
from pathlib import Path

GHOSTTY_FILE = Path.home() / ".config" / "ghostty" / "auto" / "theme.ghostty"
OPENCODE_THEME_FILE = Path.home() / ".config" / "opencode" / "themes" / "system-transparent.json"

HEX_RE = re.compile(r"^#[0-9a-fA-F]{6}$")


def parse_ghostty(path):
    colors = {}
    ansi = {}
    if not path.exists():
        print(f"Error: Ghostty theme not found at {path}", file=sys.stderr)
        sys.exit(1)
    for line in path.read_text().strip().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        m = re.match(r"(\w[\w-]*)\s*=\s*(.+)", line)
        if not m:
            continue
        key, raw = m.group(1), m.group(2).strip()
        if key == "palette":
            slot, _, hexval = raw.partition("=")
            ansi[int(slot)] = hexval.strip()
        elif key in ("background", "foreground", "cursor-color"):
            colors[key] = raw
    return colors, ansi


def validate_hex(value, name):
    if not value:
        print(f"Error: empty value for '{name}' — cannot write invalid theme", file=sys.stderr)
        sys.exit(1)
    if not HEX_RE.match(value):
        print(f"Error: '{name}' has invalid hex '{value}' — must be #RRGGBB", file=sys.stderr)
        sys.exit(1)
    return value


def build_theme(ghostty_colors, ansi):
    bg = ghostty_colors.get("background", "#070b0a")
    fg = ghostty_colors.get("foreground", "#8aadbf")
    accent = ghostty_colors.get("cursor-color", "#0998dc")

    def ansi_get(slot, default):
        return ansi.get(slot, default)

    validate_hex(bg, "background")
    validate_hex(fg, "foreground")
    validate_hex(accent, "cursor-color")

    defs = {
        "bg": bg,
        "fg": fg,
        "accent": accent,
        "blue_dark": validate_hex(ansi_get(1, "#1a81aa"), "blue_dark"),
        "blue_mid": validate_hex(ansi_get(3, "#2d86aa"), "blue_mid"),
        "blue_med": validate_hex(ansi_get(4, "#3f8baa"), "blue_med"),
        "blue_muted": validate_hex(ansi_get(6, "#5190aa"), "blue_muted"),
        "blue_bright1": validate_hex(ansi_get(9, "#21a6dc"), "blue_bright1"),
        "blue_bright2": validate_hex(ansi_get(11, "#3aaddc"), "blue_bright2"),
        "blue_bright3": validate_hex(ansi_get(12, "#51b3dc"), "blue_bright3"),
        "blue_bright4": validate_hex(ansi_get(14, "#68badc"), "blue_bright4"),
        "blue_light": validate_hex(ansi_get(10, "#83c5df"), "blue_light"),
        "blue_ice": validate_hex(ansi_get(15, "#b2d5e7"), "blue_ice"),
        "grey_dark": validate_hex(ansi_get(8, "#2f3332"), "grey_dark"),
        "teal_muted": validate_hex(ansi_get(2, "#6699ad"), "teal_muted"),
    }

    return {
        "$schema": "https://opencode.ai/theme.json",
        "defs": defs,
        "theme": {
            "primary": {"dark": "accent", "light": "accent"},
            "secondary": {"dark": "blue_bright3", "light": "blue_bright3"},
            "accent": {"dark": "accent", "light": "accent"},
            "error": {"dark": "blue_dark", "light": "blue_dark"},
            "warning": {"dark": "blue_mid", "light": "blue_mid"},
            "success": {"dark": "blue_light", "light": "blue_light"},
            "info": {"dark": "blue_bright4", "light": "blue_bright4"},
            "text": {"dark": "fg", "light": "bg"},
            "textMuted": {"dark": "blue_muted", "light": "blue_med"},
            "selectedListItemText": {"dark": "bg", "light": "bg"},
            "background": "none",
            "backgroundPanel": "none",
            "backgroundElement": "none",
            "backgroundMenu": "none",
            "backgroundSidebar": "none",
            "border": {"dark": "grey_dark", "light": "grey_dark"},
            "borderActive": {"dark": "accent", "light": "accent"},
            "borderSubtle": {"dark": "grey_dark", "light": "grey_dark"},
            "diffAdded": {"dark": "blue_light", "light": "blue_light"},
            "diffRemoved": {"dark": "blue_dark", "light": "blue_dark"},
            "diffContext": {"dark": "blue_muted", "light": "blue_muted"},
            "diffHunkHeader": {"dark": "blue_muted", "light": "blue_muted"},
            "diffHighlightAdded": {"dark": "blue_light", "light": "blue_light"},
            "diffHighlightRemoved": {"dark": "blue_dark", "light": "blue_dark"},
            "diffAddedBg": "none",
            "diffRemovedBg": "none",
            "diffContextBg": "none",
            "diffLineNumber": {"dark": "blue_med", "light": "blue_muted"},
            "diffAddedLineNumberBg": "none",
            "diffRemovedLineNumberBg": "none",
            "markdownText": {"dark": "fg", "light": "bg"},
            "markdownHeading": {"dark": "accent", "light": "accent"},
            "markdownLink": {"dark": "blue_bright3", "light": "blue_bright3"},
            "markdownLinkText": {"dark": "blue_bright4", "light": "blue_bright4"},
            "markdownCode": {"dark": "blue_light", "light": "blue_light"},
            "markdownBlockQuote": {"dark": "blue_muted", "light": "blue_muted"},
            "markdownEmph": {"dark": "blue_bright1", "light": "blue_bright1"},
            "markdownStrong": {"dark": "accent", "light": "accent"},
            "markdownHorizontalRule": {"dark": "grey_dark", "light": "grey_dark"},
            "markdownListItem": {"dark": "accent", "light": "accent"},
            "markdownListEnumeration": {"dark": "blue_bright2", "light": "blue_bright2"},
            "markdownImage": {"dark": "blue_bright3", "light": "blue_bright3"},
            "markdownImageText": {"dark": "blue_bright4", "light": "blue_bright4"},
            "markdownCodeBlock": {"dark": "fg", "light": "bg"},
            "syntaxComment": {"dark": "blue_muted", "light": "blue_muted"},
            "syntaxKeyword": {"dark": "accent", "light": "accent"},
            "syntaxFunction": {"dark": "blue_bright4", "light": "blue_bright4"},
            "syntaxVariable": {"dark": "fg", "light": "bg"},
            "syntaxString": {"dark": "blue_light", "light": "blue_light"},
            "syntaxNumber": {"dark": "blue_bright1", "light": "blue_bright1"},
            "syntaxType": {"dark": "blue_bright2", "light": "blue_bright2"},
            "syntaxOperator": {"dark": "fg", "light": "bg"},
            "syntaxPunctuation": {"dark": "fg", "light": "bg"},
        },
    }


def validate_theme(theme):
    errors = []
    defs = theme.get("defs", {})
    for name, value in defs.items():
        if not value:
            errors.append(f"def '{name}' is empty")
        elif not HEX_RE.match(value):
            errors.append(f"def '{name}' has invalid hex '{value}'")
    if errors:
        print("Theme validation failed:", file=sys.stderr)
        for e in errors:
            print(f"  {e}", file=sys.stderr)
        sys.exit(1)


def main():
    colors, ansi = parse_ghostty(GHOSTTY_FILE)
    theme = build_theme(colors, ansi)
    validate_theme(theme)
    OPENCODE_THEME_FILE.parent.mkdir(parents=True, exist_ok=True)
    OPENCODE_THEME_FILE.write_text(json.dumps(theme, indent=2) + "\n")
    print(f"Wrote {OPENCODE_THEME_FILE}")


if __name__ == "__main__":
    main()
