# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
export PATH="/Applications/Postgres.app/Contents/Versions/18/bin:$PATH"
export PATH="/Users/mitanshpanchal/.cargo/bin:$PATH"

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias pd="cd ~/Developer/"
eval "$(starship init zsh)"

# Added by Antigravity
export PATH="/Users/mitanshpanchal/.antigravity/antigravity/bin:$PATH"

# (HF_TOKEN intentionally not backed up - keep it in ~/.zshrc only)

# opencode
export PATH=/Users/mitanshpanchal/.opencode/bin:$PATH


# fin
export PATH=$PATH:/Users/mitanshpanchal/.fin/bin

# fin
export FIN_DATABASE_URL="sqlite:////Users/mitanshpanchal/.fin/finances.db"

# Added by Antigravity IDE
export PATH="/Users/mitanshpanchal/.antigravity-ide/antigravity-ide/bin:$PATH"

# Containerized dev shell.
# Usage: devbox [project-dir]  -> starts the project's dev container and attaches
# a per-project tmux session inside it. Closing the terminal keeps it running.
# The existing `dev` command still opens a host tmux session.
devbox() {
  local dir="${1:-$PWD}"
  dir="${dir:A}"
  while [[ "$dir" != "/" && ! -f "$dir/.devcontainer/compose.yaml" ]]; do
    dir="${dir:h}"
  done
  local compose="$dir/.devcontainer/compose.yaml"
  [[ -f "$compose" ]] || { echo "devbox: no .devcontainer/compose.yaml found" >&2; return 1; }

  docker compose -f "$compose" up -d --wait app >/dev/null || return 1

  # First run: mirror devcontainer.json's postCreateCommand.
  if ! docker compose -f "$compose" exec -T app bash -lc 'test -d node_modules || test -d .venv' >/dev/null 2>&1; then
    local post
    post=$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1])).get("postCreateCommand",""))' \
      "$dir/.devcontainer/devcontainer.json" 2>/dev/null)
    [[ -n "$post" ]] && { echo "devbox: installing dependencies (first run)..."; docker compose -f "$compose" exec -T app bash -lc "$post" || return 1; }
  fi

  local proj="${dir:t}" run="docker compose -f ${(q)compose}"
  local hasdev
  hasdev=$(python3 -c 'import json,sys;d=json.load(open(sys.argv[1]));print("1" if (d.get("scripts") or {}).get("dev") else "")' "$dir/package.json" 2>/dev/null)

  # postStartCommand (if any) runs on every start, not just the first.
  local post_start
  post_start=$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1])).get("postStartCommand",""))' \
    "$dir/.devcontainer/devcontainer.json" 2>/dev/null)
  [[ -n "$post_start" ]] && docker compose -f "$compose" exec -T app bash -lc "$post_start" >/dev/null 2>&1

  if ! tmux has-session -t "=${proj}" 2>/dev/null; then
    tmux new-session -d -s "$proj" -c "$dir" -n edit "nvim ."
    tmux new-window  -t "=${proj}:" -c "$dir" -n shell "$run exec app zsh"
    [[ -n "$hasdev" ]] && tmux new-window -t "=${proj}:" -c "$dir" -n serve "$run exec app zsh -lc 'npm run dev'"
    tmux new-window  -t "=${proj}:" -c "$dir" -n logs  "$run logs -f --tail=200 app"
    tmux new-window  -t "=${proj}:" -c "$dir" -n test
    tmux select-window -t "=${proj}:edit"
    # session-scoped marker: the status bar shows "⬢ <project>"
    tmux set-option -t "=${proj}:" @dev_container "$proj"
    tmux set-window-option -t "=${proj}:shell" automatic-rename off
    tmux set-window-option -t "=${proj}:logs"  automatic-rename off
  else
    # Heal panes killed by a container recreate/restart.
    local w dead
    for w in shell serve logs; do
      dead=$(tmux display-message -p -t "=${proj}:$w" '#{pane_dead}' 2>/dev/null)
      [[ "$dead" = "1" ]] && tmux respawn-pane -k -t "=${proj}:$w" >/dev/null 2>&1
    done
  fi

  if [[ -n "${TMUX:-}" ]]; then tmux switch-client -t "=${proj}"; else tmux attach -t "=${proj}"; fi
}

devstop() {
  local dir="${1:-$PWD}"
  dir="${dir:A}"
  local compose="$dir/.devcontainer/compose.yaml"
  [[ -f "$compose" ]] || { echo "devstop: no .devcontainer/compose.yaml in $dir" >&2; return 1; }
  docker compose -f "$compose" down
}
