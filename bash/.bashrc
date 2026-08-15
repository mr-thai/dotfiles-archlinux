# ~/.bashrc - Clean Fallback Shell

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# XDG Standard PATH
export PATH="$HOME/.local/bin:$PATH"

# Default Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Essential Safety Aliases (Synced with Zsh)
alias rm='trash-put'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Modern Coreutils Alternatives
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=always --color=always'
    alias ll='eza -lh --icons=always --color=always'
    alias la='eza -lha --icons=always --color=always'
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --style=plain --paging=never'
fi

# Basic prompt
PS1='[\u@\h \W]\$ '
