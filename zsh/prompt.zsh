# Starship
if command -v starship 1>/dev/null 2>&1; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml
fi
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
