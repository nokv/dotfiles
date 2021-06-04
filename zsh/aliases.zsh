alias cd:dev="cd ~/Desktop/develop"
alias cd:code="cd ~/Documents/vscode"
alias l="ls -lah"
alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# browserslist
alias browserslist='npx browserslist'

# npm
alias npm-global-list='npm ls -g --depth=0'

# search files and zip them
searchAndZip() {
    find . -path '*/node_modules' -prune -false -o -name "$1" -print | zip -r $1.`date "+%Y%m%d"`.zip -@
}

# https://firebase.google.com/docs/cli#update-cli
alias firebase-upgrade='curl -sL firebase.tools | upgrade=true bash'

# git
alias gitSHA="sh ~/dotfiles/git/utils/getSHA.sh $@"
alias gitArchiveDiffHead="sh ~/dotfiles/git/utils/gitArchiveDiffHead.sh $@"
alias gitArchiveDiffBetween="sh ~/dotfiles/git/utils/gitArchiveDiffBetween.sh $@"
alias gitLogFromSHA="git log -n 1 $@" # git log from sha

# cd -> auto ls
cd() {
    builtin cd "$@" && ls
}
