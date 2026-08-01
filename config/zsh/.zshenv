# herdr の pane split 用フック: 重い初期化 (~1s) の前に exec してシェル起動を
# 高速化する (hunk-diff.sh 参照)
if [[ -n "$HERDR_PANE_EXEC" ]]; then
  _herdr_pane_exec=$HERDR_PANE_EXEC
  unset HERDR_PANE_EXEC  # 子プロセスでの再発火防止
  eval "exec $_herdr_pane_exec"
fi
