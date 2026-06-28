# Ghostty Config (`~/.config/ghostty`)

## Structure

- `config` — main config file (Ghostty key=value format, one per line)
- `auto/theme.ghostty` — auto-generated theme file, sourced from `config` via `config-file = ?auto/theme.ghostty` (the `?` prefix means "include if exists")

## Keybind convention

- Leader prefix: `ctrl+space>` (similar to tmux prefix)
- `super` = cmd key
- `>` separates leader from action in `keybind` values
- Config is reloaded with `ctrl+space>[` (bound to `reload_config`)

## Notable settings

- Font: `MesloLGS Nerd Font Mono`, 14pt, medium weight
- Ligatures disabled: `font-feature = -liga,-calt,-dlig`
- Opacity: 1 (no transparency), blur radius 0
- Shell integration cursor disabled: `shell-integration-features = no-cursor`
- Copy on select copies to clipboard
- Window decoration is `auto` (not hidden)

## Color palette preference

- **Style:** Dark & Rich — warm deep background (`#0c0c0a`), red shades throughout
- **ANSI approach:** All slots lean into the red/warm family (crimson, terracotta, amber, burgundy, berry rose, copper, coral, rust, gold, dusty rose, warm copper)
- **Foreground:** Warm cream/ivory (`#d6cebd`)
- **Selection:** Slightly lighter than bg (`#1f1c18`)
- The current palette is in `auto/theme.ghostty` — user considers this their "nice colorscheme" and wants future color work to follow this same warm-red-dominant direction

## Edit cycle

Edit `config`, then reload with `ctrl+space>[` or `shift+cmd+,` (Ghostty default).
