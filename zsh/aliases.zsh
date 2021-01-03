alias cd:dev="cd ~/Desktop/develop"
alias l="ls -lah"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# cd -> auto ls
cd() {
    builtin cd "$@" && ls
}
