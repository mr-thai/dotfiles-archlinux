[[ -o interactive ]] || return


# XDG Base Directory setup: Save history and cache to ~/.local/state/zsh
[[ -d "$HOME/.local/state/zsh" ]] || mkdir -p "$HOME/.local/state/zsh"
[[ -d "$HOME/.cache/zsh" ]] || mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.local/state/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt inc_append_history
setopt append_history
setopt share_history

setopt hist_ignore_space
setopt hist_ignore_dups
unsetopt hist_ignore_all_dups

setopt hist_reduce_blanks
setopt hist_verify
setopt extended_history

# ---------- Options ----------

# Navigation
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

# Experience
setopt interactive_comments
setopt extended_glob
setopt no_beep
setopt prompt_subst

# Error correction (commands only, not paths)
setopt correct
unsetopt correct_all

# Job control
setopt long_list_jobs
setopt notify

#----------- alias ----------- 

alias en="fcitx5-remote -s keyboard-us"
alias tiengviet="fcitx5-remote -s bamboo"


# ls (unified, colored, icons with eza)
alias ls='eza --icons=always --color=always --git --group-directories-first --hyperlink'
alias ll='eza -la --icons=always --color=always --group-directories-first --git --header --no-user --hyperlink'
alias lt='eza --tree --level=2 --icons=always --group-directories-first --hyperlink'


# grep
alias grep='grep --color=auto'

# editors
export BAT_THEME="Catppuccin Mocha"
alias cat='bat --style=plain'


# session
alias q='exit'

# safety (more flexible)
alias rm='trash-put'       # rm = trash (safe)
alias cp='cp -iv'
alias mv='mv -iv'

# fzf
ff() {
    local selected

    selected=("${(@f)$(
        fd --type f --hidden --follow --exclude .git |
        fzf --multi \
            --height=80% \
            --layout=reverse \
            --border \
            --preview '
                if [ -d {} ]; then
                    eza --tree --level=2 {}
                else
                    bat --style=numbers,changes --color=always --line-range=:500 {}
                fi
            ' \
            --preview-window=right:60%:wrap:border-rounded \
            --bind "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
    )}") || return

    (( ${#selected[@]} == 0 )) && return

    local files=()
    local f

    for f in "${selected[@]}"; do
        files+=("$(realpath "$f")")
    done

    local common="${files[1]:h}"

    for f in "${files[@]}"; do
        local dir="${f:h}"

        while [[ $dir != ${common}* ]]; do
            common="${common:h}"
        done
    done

    [[ -z "$common" ]] && common="$PWD"

    cd "$common" || return

    local rel=()

    for f in "${files[@]}"; do
        rel+=("${f#$common/}")
    done

    nvim "${rel[@]}"
}


# system
alias top='btop'
alias cleanup='paru -Scc --noconfirm && paru -c --noconfirm && trash-empty 30 && sudo journalctl --vacuum-time=2weeks'

if command -v duf >/dev/null 2>&1; then
  alias df='duf'
else
  alias df='df -hT'
fi

if command -v dust >/dev/null 2>&1; then
  alias du='dust'
else
  alias du='du -h --max-depth=1'
fi


alias free='free -h'


# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	trap 'command rm -f -- "$tmp"' EXIT INT TERM
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	command rm -f -- "$tmp"
	trap - EXIT INT TERM
}

# zellij
alias z='zellij'

#nvim
alias v='nvim'
# aria2
alias a='aria2p'

# git & dev TUI tools
alias g='git'
alias lg='lazygit'
alias ldk='lazydocker'


# utilities
alias myip='curl -s ifconfig.me'
alias path='echo $PATH | tr ":" "\n" | nl'
alias reload='source ~/.config/zsh/.zshrc'
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias sudo='sudo '
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias mkd='mkdir -p'
md() {
    mkdir -p "$1" && cd "$1"
}
alias tree='eza --tree --level=3 --icons=always --group-directories-first --ignore-glob=".git" --hyperlink'

# paru package management
alias psi='paru -S'
alias psr='paru -Rns'
alias psu='paru -Syu'
alias pss='paru -Ss'

#----------- Unified Fast Plugin Loader -----------
zsh_load_plugin() {
    if [[ -f "/usr/share/zsh/plugins/$1/$2" ]]; then
        source "/usr/share/zsh/plugins/$1/$2"
    elif [[ -f "$HOME/.config/zsh/plugins/$1/$2" ]]; then
        source "$HOME/.config/zsh/plugins/$1/$2"
    fi
}

# 1. zsh-completions (Must be added to fpath before compinit)
if [[ -d /usr/share/zsh/plugins/zsh-completions/src ]]; then
  fpath=(/usr/share/zsh/plugins/zsh-completions/src $fpath)
elif [[ -d $HOME/.config/zsh/plugins/zsh-completions/src ]]; then
  fpath=($HOME/.config/zsh/plugins/zsh-completions/src $fpath)
fi

autoload -Uz compinit
zmodload zsh/complist

COMPDUMP="$HOME/.cache/zsh/zcompdump"
if [[ ! -f "$COMPDUMP" || "$COMPDUMP" -ot /usr/share/zsh/functions ]]; then
  compinit -d "$COMPDUMP"
else
  compinit -C -d "$COMPDUMP"
fi

# Completion Styles
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 2. fzf-tab (Must be loaded AFTER compinit, but BEFORE syntax-highlighting)
zsh_load_plugin "fzf-tab" "fzf-tab.plugin.zsh"

# 3. zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char)
zsh_load_plugin "zsh-autosuggestions" "zsh-autosuggestions.zsh"

# fzf native completion & commands
if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
fi
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
else
  export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git/*"'
fi
export FZF_DEFAULT_OPTS="
  --height=60% --layout=reverse --border=rounded
  --prompt='❯ ' --pointer='❯' --marker='✓' --info=inline
  --preview 'bat --style=numbers --color=always --line-range :300 {}'
  --preview-window=right:60%:wrap
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5c2e7,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window=up:3:wrap"

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"
  bindkey '^R' atuin-search
fi

if [[ -o vi ]]; then
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
  bindkey -M vicmd 'H' beginning-of-line
  bindkey -M vicmd 'L' end-of-line
fi

# zsh-you-should-use
zsh_load_plugin "zsh-you-should-use" "you-should-use.plugin.zsh"

# 4. fast-syntax-highlighting (Must be loaded AFTER compinit and autosuggestions)
typeset -gA ZSH_HIGHLIGHT_STYLES
typeset -ga ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[comment]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[command]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#9ece6a,italic'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[path]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#f7768e'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#e0af68'
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=#f7768e,bold')
zsh_load_plugin "fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh" || zsh_load_plugin "zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"

# 5. zsh-history-substring-search (Must be loaded AFTER syntax-highlighting)
zsh_load_plugin "zsh-history-substring-search" "zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# 6. zsh-vi-mode (Must be loaded BEFORE Starship)
zsh_load_plugin "zsh-vi-mode" "zsh-vi-mode.plugin.zsh"

# Extras (Starship, Zoxide, Mise) - MUST BE LOADED ABSOLUTELY LAST
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
  eval "$(starship init zsh)"
fi
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

export CATPPUCCIN_FLAVOR="mocha"
export BAT_THEME="Catppuccin Mocha"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#cdd6f4,bg:#1e1e2e,hl:#f38ba8,fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8,pointer:#f5c2e7,marker:#f5e0dc,spinner:#f5c2e7,header:#f38ba8"

# Fix Ctrl+R history search being overwritten by vi-mode
function zvm_after_init() {
  if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
  if command -v atuin >/dev/null 2>&1; then
    zvm_bindkey viins '^R' atuin-search
    zvm_bindkey vicmd '^R' atuin-search
  fi
  zvm_bindkey vicmd 'k' history-substring-search-up
  zvm_bindkey vicmd 'j' history-substring-search-down
  zvm_bindkey vicmd 'H' beginning-of-line
  zvm_bindkey vicmd 'L' end-of-line
}
# Compile AUR packages directly in RAM-disk (tmpfs) to protect and extend SSD life
alias paru='paru --builddir /tmp/paru'

# --- TRASH MANAGEMENT (Trash-cli + FZF) ---
trash() {
    local selected=$(trash-list | fzf --reverse \
        --prompt="   Restore [Enter] | Delete [Alt+D] | Exit [Esc] > " \
        --header=" Trash Bin (trash-cli) " \
        --preview="echo '📁 Original Path : ' \$(echo {} | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} //'); echo '🕒 Deleted At    : ' \$(echo {} | awk '{print \$1, \$2}')" \
        --preview-window="up:2:wrap" \
        --color="prompt:#f38ba8,header:#f9e2af,info:#cba6f7" \
        --bind 'alt-d:execute(trash-rm {3..})+reload(trash-list)')
    if [[ -n "$selected" ]]; then
        # Safely extract the file path starting from the 3rd column
        local file_path=$(echo "$selected" | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} //')
        if [[ -n "$file_path" ]]; then
            trash-restore "$file_path"
        fi
    fi
}

# Auto launch Zellij (Multi-layer anti-trapping guard for Neovim & IDEs)
if [[ -z "$ZELLIJ" ]] && \
   [[ -z "$NVIM" ]] && \
   [[ -z "$VSCODE_PID" ]] && \
   [[ "$TERM_PROGRAM" != "vscode" ]] && \
   [[ "$TERM" != "linux" ]] && \
   [[ -z "$NO_ZELLIJ" ]] && \
   [[ -o interactive ]]; then
    zellij attach -c main
fi

# Easily stow a new app into dotfiles
function stow-app() {
    if [[ -z "$1" ]]; then
        echo "Usage: stow-app ~/.config/app_name"
        return 1
    fi
    local src=$(realpath "$1")
    local pkg=$(basename "$src")
    local dest="$HOME/dotfiles/$pkg/.config/$pkg"
    
    if [[ ! -e "$src" ]]; then
        echo "Error: $src not found"
        return 1
    fi
    if [[ -L "$src" ]]; then
        echo "Error: $src is already a symlink!"
        return 1
    fi

    echo "Moving $pkg to ~/dotfiles..."
    mkdir -p "$(dirname "$dest")"
    mv "$src" "$dest"
    
    cd ~/dotfiles
    stow "$pkg"
    cd - > /dev/null
    echo "✅ Success! Don't forget to cd ~/dotfiles and git commit."
}
