[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function set_win_title() {
  echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)
