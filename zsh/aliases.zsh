alias cd:dev="cd ~/Desktop/develop"
alias cd:code="cd ~/Documents/vscode"
alias ls='exa --classify --icons -h'
alias cat='bat'
alias v='vim'
alias vi='vim'
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"
alias updateBrewfile='brew bundle dump --force'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# browserslist
alias browserslist='npx browserslist'

# google cloud platform
alias gc='gcloud'

# npm
alias npm-global-list='npm ls --location=global --depth=0'

# search files and zip them
searchAndZip() {
  find . -path '*/node_modules' -prune -false -o -name "$1" -print | zip -r $1.$(date "+%Y%m%d").zip -@
}

# History
alias history='history -i -t "%F %T"'

# https://firebase.google.com/docs/cli#update-cli
alias firebase-upgrade='curl -sL firebase.tools | upgrade=true bash'

# git
alias g='git'
alias gitSHA="sh ~/dotfiles/git/utils/getSHA.sh $@"
alias gitArchiveDiffHead="sh ~/dotfiles/git/utils/gitArchiveDiffHead.sh $@"
alias gitArchiveDiffBetween="sh ~/dotfiles/git/utils/gitArchiveDiffBetween.sh $@"
alias gitLogFromSHA="git log -n 1 $@" # git log from sha

# cd -> auto ls
cd() {
  builtin cd "$@" && ls
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
