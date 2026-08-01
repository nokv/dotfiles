#!/bin/sh
# デフォルトブランチとの差分を hunk で表示する
#   引数なし: アクティブペインの右隣に split して表示 (type="shell" から呼ぶ)
#   full:     全画面の一時ペインで表示 (type="pane" から呼ぶ)
# split はシェル経由でしか起動できないため、HERDR_PANE_EXEC を .zshenv で exec させて
# zsh 初期化をスキップする
# worktree に cd 中でも追従するよう、シェル cwd 固定の HERDR_ACTIVE_PANE_CWD ではなく
# foreground_cwd を使う
cwd=$(herdr pane get "$HERDR_ACTIVE_PANE_ID" 2>/dev/null | sed -En 's/.*"foreground_cwd":"([^"]+)".*/\1/p')
cwd=${cwd:-${HERDR_ACTIVE_PANE_CWD:-.}}
cd "$cwd" || exit 1
b=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
b=${b#origin/}
b=${b:-develop}
# ローカルブランチの位置ずれ対策で origin との merge-base を比較対象にする
base=$(git merge-base "origin/$b" HEAD 2>/dev/null) || base=$b
[ "$1" = "full" ] && exec hunk diff "$base"
# .zshenv 時点では PATH 未設定のため絶対パスで渡す
hunk_bin=$(command -v hunk) || exit 1
exec herdr pane split "$HERDR_ACTIVE_PANE_ID" --direction right --cwd "$cwd" --focus \
  --env "HERDR_PANE_EXEC=$hunk_bin diff $base"
