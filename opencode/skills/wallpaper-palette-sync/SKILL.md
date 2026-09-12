---
name: wallpaper-palette-sync
description: >-
  Use when the user wants to download a wallhaven wallpaper, extract its color
  palette, and sync the colors to Ghostty terminal config.
  Trigger keywords: wallpaper, wallhaven, extract palette, sync colors, ghostty,
  theme from wallpaper, rice terminal, desktop rice.
---

# Wallpaper Palette Sync

Downloads a wallhaven wallpaper, extracts its dominant color palette, and
applies matching colors to Ghostty (`~/.config/ghostty/auto/theme.ghostty`).

## Wallhaven Download

Given a wallhaven wallpaper ID (e.g., `xepyo3`):

1. **Determine file extension** — fetch the page and check for "PNG" in the size info:
   ```bash
   curl -s "https://wallhaven.cc/w/xepyo3" | grep -o 'Size[^<]*'
   ```

2. **Construct direct URL** — the first 2 chars of the ID form the subdirectory:
   ```
   https://w.wallhaven.cc/full/{first_2_chars}/wallhaven-{id}.{ext}
   ```

3. **Download with Referer** (wallhaven blocks hotlinking):
   ```bash
   curl -L -o ~/Downloads/wallhaven-{id}.{ext} \
     -e "https://wallhaven.cc/w/{id}" \
     "https://w.wallhaven.cc/full/{first_2_chars}/wallhaven-{id}.{ext}"
   ```

4. **Verify**:
   ```bash
   file ~/Downloads/wallhaven-{id}.{ext}
   ```

5. **Set as desktop** (macOS):
   ```bash
   osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'$HOME'/Downloads/wallhaven-{id}.{ext}"'
   ```

## Color Extraction

Use the `palette.py` script (in this skill directory) which uses the
[`colorz`](https://github.com/obskyr/colorz) library — purpose-built for
extracting terminal color palettes from images. It uses k-means clustering
to find the 6 most dominant hue-ordered colors, generates bold variants,
and maps them to ANSI terminal slots.

First-time setup (one-time):
```bash
python3 -m venv ~/.config/opencode/skills/wallpaper-palette-sync/.venv
~/.config/opencode/skills/wallpaper-palette-sync/.venv/bin/pip install colorz
```

Extract palette and write Ghostty config:
```bash
~/.config/opencode/skills/wallpaper-palette-sync/.venv/bin/python3 \
  ~/.config/opencode/skills/wallpaper-palette-sync/palette.py \
  ~/Downloads/wallhaven-{id}.{ext}
```

This writes:
- `~/.config/ghostty/auto/theme.ghostty` — 16-color ANSI palette + bg/fg/cursor

Then sync to opencode:
```bash
python3 ~/.config/opencode/skills/wallpaper-palette-sync/update-opencode-theme.py
```

This writes:
- `~/.config/opencode/themes/system-transparent.json` — opencode theme using transparent backgrounds

## Palette Design Guidelines

### Ghostty ANSI 16-color (in `auto/theme.ghostty`)

| Slot   | Role                          | Source from wallpaper              |
| ------ | ----------------------------- | ---------------------------------- |
| 0,8    | Black/Bright Black            | deepest shadow / dark midtone      |
| 1      | Red                           | warm rusty / saturated red accent  |
| 2      | Green                         | teal-green midtone                 |
| 3      | Yellow                        | warm muted gold                    |
| 4      | Blue                          | deep navy                          |
| 5      | Magenta                       | dark muted purple                  |
| 6      | Cyan                          | dark teal-cyan                     |
| 7,15   | White/Bright White            | muted light blue / icy white       |
| 9      | Bright Red                    | saturated red (glow/highlight)     |
| 10     | Bright Green                  | teal green glow                    |
| 11     | Bright Yellow                 | warm golden light                  |
| 12     | Bright Blue                   | bright cyan-blue (main glow!)      |
| 13     | Bright Magenta                | muted purple                       |
| 14     | Bright Cyan                   | bright teal-cyan glow              |

Additional fields:
- `background` = deepest shadow color
- `foreground` = light icy blue (readable on dark bg)
- `cursor-color` = main accent glow color
- `cursor-text` = background color
- `selection-background` = dark midtone
- `selection-foreground` = light variant

## Config File Path

| App     | Config file                            |
| ------- | -------------------------------------- |
| Ghostty | `~/.config/ghostty/auto/theme.ghostty` |
| opencode | `~/.config/opencode/themes/system-transparent.json` |

The theme files are auto-generated; safe to overwrite entirely.

## Troubleshooting

### Empty-string defs error in opencode

If opencode fails to start with `system-transparent.json`, check that no `defs`
values are empty strings (`""`). The opencode theme schema requires valid hex
colors (`#RRGGBB`) for all def entries.

The `update-opencode-theme.py` script now validates every hex value before
writing. If it finds an empty or malformed color, it exits with an error
message rather than writing an invalid file. This prevents the issue at
source.

To manually fix: replace any `""` in `defs` with actual hex colors matching
your palette (see `system-transparent.json` in this skill directory for a
correct reference).

## Reload After Editing

```bash
# Ghostty — send reload keybinding (ctrl+space>[)
# Or the user can press shift+cmd+, (Ghostty default)
# If ghostty isn't running, the new theme applies on next launch
```

## Full Workflow Example

### Cyberpunk Wallhaven ID: `3llmey`

Given a cyberpunk street scene (6000×3028, `3llmey`):

1. **Check extension** — inspect the wallpaper page source for the direct image URL:
   ```bash
   curl -s "https://wallhaven.cc/w/3llmey" | grep -oP 'src="https://w\.wallhaven\.cc/full/[^"]+\.\w+'
   ```
   This returns: `src="https://w.wallhaven.cc/full/3l/wallhaven-3llmey.jpg"` (JPG)

2. **Download with Referer**:
   ```bash
   curl -L -o ~/Downloads/wallhaven-3llmey.jpg \
     -e "https://wallhaven.cc/w/3llmey" \
     "https://w.wallhaven.cc/full/3l/wallhaven-3llmey.jpg"
   ```

3. **Verify**:
   ```bash
   file ~/Downloads/wallhaven-3llmey.jpg
   ```

4. **Set as desktop** (macOS):
   ```bash
   osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'$HOME'/Downloads/wallhaven-3llmey.jpg"'
   ```

5. **Extract palette and write Ghostty config**:
   ```bash
   ~/.config/opencode/skills/wallpaper-palette-sync/.venv/bin/python3 \
     ~/.config/opencode/skills/wallpaper-palette-sync/palette.py \
     ~/Downloads/wallhaven-3llmey.jpg
   ```

6. **Reload**:
   Ghostty: press `ctrl+space>[` or `shift+cmd+,`

7. **Sync opencode theme**:
   ```bash
   python3 ~/.config/opencode/skills/wallpaper-palette-sync/update-opencode-theme.py
   ```
   This reads the Ghostty palette and rewrites `~/.config/opencode/themes/system-transparent.json`. Reload opencode to pick up the change.
