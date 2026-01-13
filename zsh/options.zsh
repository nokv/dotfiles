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

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
setopt auto_param_keys

# disable ctrl+s, ctrl+q
setopt no_flow_control

# ビープ音の停止
setopt no_beep
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ^Dでログアウトしない
setopt ignore_eof

# pushd時の重複を無視
setopt PUSHD_IGNORE_DUPS
# pushd/popdの出力を抑制
setopt PUSHD_SILENT
# dotfileも候補に含める
setopt globdots
