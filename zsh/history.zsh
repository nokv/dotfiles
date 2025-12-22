HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000

# 履歴ファイルに追記する（上書きしない）
setopt APPEND_HISTORY
# コマンド実行時に即座に履歴に追加
setopt INC_APPEND_HISTORY
# 複数のzshセッション間で履歴を共有
setopt SHARE_HISTORY
# 直前と同じコマンドは履歴に追加しない
setopt HIST_IGNORE_DUPS
# 履歴展開時に直接実行せず確認する
setopt HIST_VERIFY
# 重複するコマンドは古い方を削除
setopt HIST_IGNORE_ALL_DUPS
# 履歴検索時に重複を表示しない
setopt HIST_FIND_NO_DUPS
# 履歴展開時に補完候補を表示
setopt HIST_EXPAND
# 履歴にタイムスタンプを記録
setopt EXTENDED_HISTORY
# 余分な空白を削除して履歴に保存
setopt HIST_REDUCE_BLANKS
