#
# Utility functions
#

# キャッシュ付きでコマンド出力をsourceする
# Usage: cache_eval <cache_name> <command>
# Example: cache_eval "npm_completion" "npm completion"
cache_eval() {
  local name=$1
  local cmd=$2
  local cache_dir="$HOME/.cache/shell"
  local cache_file="${cache_dir}/${name}.zsh"
  local cmd_name=${cmd%% *}  # コマンド名を取得（最初の単語）
  local cmd_path=$(whence -p "$cmd_name" 2>/dev/null)

  # キャッシュが存在しない、またはコマンドが更新された場合に再生成
  if [[ ! -f "$cache_file" ]] || [[ -n "$cmd_path" && "$cmd_path" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    eval "$cmd" > "$cache_file" 2>/dev/null
  fi

  [[ -f "$cache_file" ]] && source "$cache_file"
}

# キャッシュを強制的に再生成
# Usage: cache_clear [name]  # 名前省略で全削除
cache_clear() {
  local cache_dir="$HOME/.cache/shell"
  if [[ -n "$1" ]]; then
    rm -f "${cache_dir}/${1}.zsh"
    echo "Cleared cache: $1"
  else
    rm -f "${cache_dir}"/*.zsh
    echo "Cleared all completion caches"
  fi
}
