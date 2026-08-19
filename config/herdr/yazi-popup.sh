#!/bin/sh
# yazi を popup で開く (type="popup" から呼ぶ)
# popup の起動 cwd はシェル起動時のまま固定されるため、worktree に cd 中でも
# 追従するよう hunk-diff.sh と同じく foreground_cwd を解決してから exec する
cwd=$(herdr pane get "$HERDR_ACTIVE_PANE_ID" 2>/dev/null | sed -En 's/.*"foreground_cwd":"([^"]+)".*/\1/p')
cwd=${cwd:-${HERDR_ACTIVE_PANE_CWD:-.}}
cd "$cwd" || exit 1
exec yazi
