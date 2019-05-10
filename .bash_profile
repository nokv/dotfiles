export PATH=/usr/local/var/nodebrew/current/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/na-takahashi/google-cloud-sdk/path.bash.inc' ]; then . '/Users/na-takahashi/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/na-takahashi/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/na-takahashi/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"


export LANG=ja_JP.UTF-8

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND} - ${PWD##*/}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
#PROMPT_COMMAND='add_line'

# プロンプトの変更
export PS1='▲ \W/  ' 

