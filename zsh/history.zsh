# 履歴を保存するファイル
HISTFILE=$HOME/.zsh-history
# メモリ上に保存する履歴のサイズ
HISTSIZE=100000
# 上述のファイルに保存する履歴のサイズ
SAVEHIST=1000000

# share .zshhistory
# 実行時に履歴をファイルにに追加していく
setopt inc_append_history
# 履歴を他のシェルとリアルタイム共有する
setopt share_history
# 補完時にヒストリを自動的に展開
setopt hist_expand

setopt extended_history
