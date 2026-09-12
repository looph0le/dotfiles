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

- **Style:** Professional dark — Tokyo Night (`#1a1b26` bg, `#c0caf5` fg)
- **ANSI approach:** Standard Tokyo Night palette (coral red, green, gold, indigo blue, violet, cyan)
- **Selection:** `#33467c` bg with `#c0caf5` fg
- The current palette is in `auto/theme.ghostty` — user wants a basic professional dark theme

## Edit cycle

Edit `config`, then reload with `ctrl+space>[` or `shift+cmd+,` (Ghostty default).
