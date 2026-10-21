#!/bin/sh
# zsh の履歴ファイルをクラウド同期フォルダへ一方向コピーする。history.zsh の periodic フックから
# バックグラウンドで定期的に起動される。
# 履歴ファイルを同期フォルダに直接置くと、File Provider の応答待ちでシェル起動が
# 数秒止まることがあるため、履歴はローカルに置き、ここで退避だけを行う
set -u

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh-history-sync"
LOG="$HOME/Library/Logs/zsh-history-sync.log"

log() {
  printf '%s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$*" >> "$LOG"
}

if [ ! -r "$CONFIG_DIR/env" ]; then
  log "skip: $CONFIG_DIR/env not found"
  exit 0
fi
# shellcheck source=/dev/null
. "$CONFIG_DIR/env"

SRC="${ZSH_HISTORY_SYNC_SRC:-$HOME/.zsh_history}"
DEST_DIR="${ZSH_HISTORY_SYNC_DIR:-}"

if [ -z "$DEST_DIR" ]; then
  log "skip: ZSH_HISTORY_SYNC_DIR is empty"
  exit 0
fi
if [ ! -r "$SRC" ]; then
  log "skip: $SRC not found"
  exit 0
fi
# 同期フォルダがマウントされていない（Drive 未起動など）ときは何もしない
if [ ! -d "$DEST_DIR" ]; then
  log "skip: $DEST_DIR not mounted"
  exit 0
fi

HOST=$(scutil --get LocalHostName 2>/dev/null || hostname -s)
DEST="$DEST_DIR/.zsh_history-$HOST"

# 内容が同じならコピーしない（Drive 側の不要な再アップロードを避ける）
if err=$(/usr/bin/rsync -a "$SRC" "$DEST" 2>&1); then
  log "ok: $SRC -> $DEST"
else
  log "error: rsync exit $? ($SRC -> $DEST): $err"
  exit 1
fi
