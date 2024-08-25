# lang
export LANGUAGE="ja_JP.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Editor
export EDITOR=vim
export GIT_EDITOR="${EDITOR}"

# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

# ビープ音の停止
setopt no_beep
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ^Dでログアウトしない
setopt ignore_eof
