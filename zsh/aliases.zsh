alias cd:dev="cd ~/Desktop/develop"
alias l="ls -lah"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# browserslist
alias browserslist='npx browserslist'

# git
alias g='git'

# cd -> auto ls
cd() {
    builtin cd "$@" && ls
}
