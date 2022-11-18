# Starship
if command -v starship 1>/dev/null 2>&1; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml
fi
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function set_win_title() {
  echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)
