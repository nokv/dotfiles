# GCP
export CLOUDSDK_PYTHON=python
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# Java
# export JAVA_HOME=$(/usr/libexec/java_home)

# gpg
export GPG_TTY=$(tty)

# 1password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
eval "$(op completion zsh)"
compdef _op op
[ -f $HOME/.config/op/plugins.sh ] && source $HOME/.config/op/plugins.sh

# AWS
export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"
export PATH="/usr/local/bin/aws_completer:$PATH"

# MySQL
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

eval "$(mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
