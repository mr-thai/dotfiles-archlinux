[[ -o interactive ]] || return


#----------- HISTORY ----------
HISTFILE=$HOME/.config/zsh/.zsh_history
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
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
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

#----------- Load Plugins -----------
# zsh-completions
if [[ -d $HOME/.config/zsh/plugins/zsh-completions/src ]]; then
  fpath=($HOME/.config/zsh/plugins/zsh-completions/src $fpath)
fi

autoload -Uz compinit
zmodload zsh/complist

COMPDUMP="$ZDOTDIR/.zcompdump"

# Fast + safe
if [[ ! -f $COMPDUMP || $COMPDUMP -ot /usr/share/zsh/functions ]]; then
  compinit -d "$COMPDUMP"
else
  compinit -C -d "$COMPDUMP"
fi

# Menu
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'

# Case-insensitive + fuzzy
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'

# smart cd
zstyle ':completion:*:cd:*' tag-order \
  local-directories \
  directory-stack \
  path-directories

# Cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"

# Colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# sudo completion
zstyle ':completion:*:sudo:*' command-path \
  /usr/local/sbin \
  /usr/local/bin \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin

# fzf-tab
if [[ -f $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
fi


# autosuggestion (dimmed)

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  # Suggestion color (subtle, doesn't overpower prompt)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

  # Suggestion source: prefer history
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)

  # Accept suggestion with Ctrl+F (doesn't conflict with TAB)
  ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char)

  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# fzf
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
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt='❯ '
  --pointer='❯'
  --marker='✓'
  --info=inline
  --preview 'bat --style=numbers --color=always --line-range :300 {}'
  --preview-window=right:60%:wrap
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5c2e7,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window=up:3:wrap"


# zsh-you-should-use
if [[ -f /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
fi


# syntax highlighting 
if [ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
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
  source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
elif [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
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
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-history-substring-search
if [[ -f $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  # Keybinds for substring search (Up/Down and j/k in Vi mode)
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# ---------- Starship prompt ----------
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
  eval "$(starship init zsh)"
fi

# zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# mise-bin (Version Manager)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi


# zsh-vi-mode
if [[ -f $HOME/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
  source $HOME/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# Fix Ctrl+R fzf keybinding being overwritten by vi-mode
function zvm_after_init() {
  if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
  # Ép buộc vi-mode trả lại phím Ctrl+R cho FZF
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey vicmd '^R' fzf-history-widget
}
# Compile AUR packages directly in RAM-disk (tmpfs) to protect and extend SSD life
alias paru='paru --builddir /tmp/paru'

# --- TRASH MANAGEMENT (Trash-cli + FZF) ---
trash() {
    local selected=$(trash-list | fzf --reverse --prompt="Select file Restore (Enter) / Delete entirely (Del): " --bind 'delete:execute(trash-empty)+abort')
    if [[ -n "$selected" ]]; then
        local file_path=$(echo "$selected" | awk '{$1=""; $2=""; print substr($0,3)}')
        trash-restore "$file_path"
    fi
}

# Auto launch Zellij
if [[ -z "$ZELLIJ" ]] && [[ "$TERM" != "linux" ]]; then
    zellij attach -c main
fi

# Dễ dàng đưa 1 app mới vào dotfiles
function stow-app() {
    if [[ -z "$1" ]]; then
        echo "Cách dùng: stow-app ~/.config/ten_app"
        return 1
    fi
    local src=$(realpath "$1")
    local pkg=$(basename "$src")
    local dest="$HOME/dotfiles/$pkg/.config/$pkg"
    
    if [[ ! -e "$src" ]]; then
        echo "Lỗi: Không tìm thấy $src"
        return 1
    fi
    if [[ -L "$src" ]]; then
        echo "Lỗi: $src đã là một symlink!"
        return 1
    fi

    echo "Đang dọn nhà cho $pkg vào ~/dotfiles..."
    mkdir -p "$(dirname "$dest")"
    mv "$src" "$dest"
    
    cd ~/dotfiles
    stow "$pkg"
    cd - > /dev/null
    echo "✅ Thành công! Bạn hãy cd ~/dotfiles và git commit nhé."
}
