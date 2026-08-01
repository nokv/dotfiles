# herdr の pane split 用フック
# 初期化の前にexecしてシェル起動を高速化するref: hunk-diff.sh
if [[ -n "$HERDR_PANE_EXEC" ]]; then
  _herdr_pane_exec=$HERDR_PANE_EXEC
  unset HERDR_PANE_EXEC  # 子プロセスでの再発火防止
  eval "exec $_herdr_pane_exec"
fi
