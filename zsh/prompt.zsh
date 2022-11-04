if command -v starship 1>/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
