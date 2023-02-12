# GCP
export CLOUDSDK_PYTHON=python3
# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then . $HOME/google-cloud-sdk/path.zsh.inc; fi
# The next line enables shell command completion for gcloud.
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/google-cloud-sdk/completion.zsh.inc; fi

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Ruby
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

# gpg
export GPG_TTY=$(tty)

# 1password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
eval "$(op completion zsh)"; compdef _op op
source $HOME/.config/op/plugins.sh

# PHP
export PATH="/usr/local/opt/php@8.0/bin:$PATH"
export PATH="/usr/local/opt/php@8.0/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/.composer/vendor/bin:$PATH"

# Python
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  if which pyenv-virtualenv-init >/dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# AWS
export PATH="$HOME/.ebcli-virtual-env/executables:$PATH"
export PATH="/usr/local/bin/aws_completer:$PATH"
complete -C '/usr/local/bin/aws_completer' aws

# Node.js version manager
. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH compinit
autoload -Uz compinit && compinit
