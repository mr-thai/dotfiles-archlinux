export ZDOTDIR="$HOME/.config/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

# Pager
export PAGER="bat"

# Better man page with syntax highlighting
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# PATH (zsh-native)
typeset -U path PATH
path=(
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "$HOME/bin"
  "/usr/local/bin"
  $path
)
export PATH