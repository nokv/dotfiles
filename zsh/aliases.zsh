alias mac_version="sw_vers && uname -r && uname -m && sysctl -a machdep.cpu"
alias cd:dev="cd ~/Desktop/develop"
alias cd:code="cd ~/Documents/vscode"
alias ll='eza -l -a --git --classify -h'
alias ls="eza -a"
alias cat='bat'
alias v='vim'
alias vi='vim'
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"
alias updateBrewfile='brew bundle dump --force --no-vscode'
alias gc='gcloud'
alias reload="exec ${SHELL} -l"
alias path='echo -e ${PATH//:/\\n}'

# search files and zip them
searchAndZip() {
  find . -path '*/node_modules' -prune -false -o -name "$1" -print | zip -r $1.$(date "+%Y%m%d").zip -@
}

# History
alias history='history -i -t "%F %T"'

# git
alias g='git'
alias gitArchiveDiff="sh ~/dotfiles/git/utils/gitArchiveDiff.sh $@"

function cd() {
  if [[ $# -eq 0 ]]; then
    local dir=$(cdr -l | sed 's/^[0-9]*[[:space:]]*//' | fzf --height 40% --reverse)
    if [[ -n "$dir" ]]; then
      builtin cd "$dir" && ls
    fi
  else
    builtin cd "$@" && ls
  fi
}

function u() {
  cd ./"$(git rev-parse --show-cdup)"
  if [ $# = 1 ]; then
    cd "$1"
  fi
}
_u() {
  _values $(fd --type d --base-directory $(git rev-parse --show-cdup))
}
compdef _u u

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
