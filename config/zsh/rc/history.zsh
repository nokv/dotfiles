HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000

# 履歴ファイルに追記する（上書きしない）
setopt APPEND_HISTORY
# 複数のzshセッション間で履歴を共有（コマンド実行時の即時追記も含む）
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

# 履歴ファイルをクラウド同期フォルダへ退避する (config/zsh-history-sync/sync.sh)。
# launchd から起動すると ~/Library/CloudStorage への書き込みが TCC で拒否されるため、
# ターミナルの権限を引き継ぐ対話シェルから PERIOD 秒おきにバックグラウンドで起動する
PERIOD=300
_zsh_history_sync() {
  local sync="${XDG_CONFIG_HOME:-$HOME/.config}/zsh-history-sync/sync.sh"
  [[ -x $sync ]] && "$sync" &>/dev/null &!
}
autoload -Uz add-zsh-hook
add-zsh-hook periodic _zsh_history_sync
