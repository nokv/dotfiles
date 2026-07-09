#!/bin/sh
# keys.command (type="pane" ポップアップ) から呼ばれ、呼び出し元ペインの cwd で
# デフォルトブランチ (origin/HEAD、未設定なら develop) との差分を hunk で表示する。
# HERDR_ACTIVE_PANE_CWD はシェルの cwd 固定なので、Claude Code が worktree に
# cd している場合にも追従する foreground_cwd を Socket API から取得する
cwd=$(herdr pane get "$HERDR_ACTIVE_PANE_ID" 2>/dev/null | sed -En 's/.*"foreground_cwd":"([^"]+)".*/\1/p')
cd "${cwd:-${HERDR_ACTIVE_PANE_CWD:-.}}" || exit 1
b=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
b=${b#origin/}
exec hunk diff "${b:-develop}"
