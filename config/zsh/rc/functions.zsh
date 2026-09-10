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

# 自分が作成した PR を org 配下の全リポジトリ横断で一覧する
# Usage: prs [YYYY-MM-DD] [org]   # 日付省略時は今日（JST）以降、org 省略時は GH_PR_OWNER
prs() {
  local since=${1:-$(TZ=Asia/Tokyo date +%Y-%m-%d)}
  local owner=${2:-$GH_PR_OWNER}
  if [[ -z "$owner" ]]; then
    echo "prs: org is not given (pass as 2nd arg or export GH_PR_OWNER=<org>)" >&2
    return 1
  fi
  # gh search prs は --template で JST 変換ができず、--json に総件数も含まれないため、
  # 同じ検索 API を gh api で呼び、jq で gh 既定の表（TTY: 幅に合わせて切り詰めた色付き表 / 非TTY: TSV）を再現する
  local filter='
    def cw: if (. >= 4352 and . <= 4447) or (. >= 11904 and . <= 42191) or (. >= 44032 and . <= 55203)
              or (. >= 63744 and . <= 64255) or (. >= 65072 and . <= 65103) or (. >= 65280 and . <= 65376)
              or (. >= 65504 and . <= 65510) or (. >= 127744 and . <= 129791) or . >= 131072 then 2 else 1 end;
    def dw: explode | map(cw) | add // 0;
    def pad(w): . + (" " * (w - dw) // "");
    def trunc(w): if dw <= w then . else
      (explode | reduce .[] as $c ({s: [], w: 0};
        if .w + ($c | cw) <= w - 3 then {s: (.s + [$c]), w: (.w + ($c | cw))} else . end) | .s | implode) + "..." end;
    def color(s): {open: "0;32", closed: "0;31", merged: "0;35"}[s] // "0";
    def header: "\u001b[0;2;4;37m\(.)\u001b[0m";
    def jst: fromdate | strflocaltime("%Y-%m-%d %H:%M");
    def repo: .repository_url | split("/") | last;
    def state: if .pull_request.merged_at then "merged" else .state end;
    if $ENV.PR_LIST_TTY != "1" then
      .items[] | [repo, .number, state, .title, (.created_at | jst)] | @tsv
    elif .total_count == 0 then "no pull requests matched your search"
    else
      (.items | map({repo: repo, num: "#\(.number)", state: state, title: (.title | gsub("\\s+"; " ")), created: (.created_at | jst)})) as $rows
      | ($rows | map(.repo | dw) | max) as $rw
      | ($rows | map(.num | dw) | max) as $nw
      | ([($ENV.PR_LIST_COLS | tonumber) - $rw - $nw - 16 - 6, 8] | max) as $tw
      | "\nShowing \($rows | length) of \(.total_count) pull requests\n",
        ([("REPO" | pad($rw)), ("ID" | pad($nw)), ("TITLE" | pad($tw)), "CREATED"] | map(header) | join("  ")),
        ($rows[] | [(.repo | pad($rw)), "\u001b[\(color(.state))m\(.num | pad($nw))\u001b[0m",
          (.title | trunc($tw) | pad($tw)), "\u001b[38;5;242m\(.created)\u001b[0m"] | join("  "))
    end'
  local tty=0
  [[ -t 1 ]] && tty=1
  PR_LIST_TTY=$tty PR_LIST_COLS=${COLUMNS:-$(tput cols 2>/dev/null || echo 80)} TZ=Asia/Tokyo \
    gh api -X GET search/issues -F per_page=100 -f sort=created -f order=asc \
      -f q="author:@me user:${owner} is:pr created:>=${since}T00:00:00+09:00" \
      --jq "$filter"
}
