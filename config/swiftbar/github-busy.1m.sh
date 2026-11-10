#!/bin/bash
# <xbar.title>GitHub Busy</xbar.title>
# <xbar.desc>Toggle the busy flag of your GitHub status from the menu bar</xbar.desc>
# <xbar.dependencies>gh</xbar.dependencies>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>

set -u

# SwiftBarはログインシェルを経由せずにプラグインを起動するため、PATHにHomebrewのパスが入っていない
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# GitHubのWeb UIがbusy設定時に入れる既定文言。解除時に、このプラグインが入れた文言かどうかの判定にも使う
DEFAULT_MESSAGE="I may be slow to respond."

# GitHubマーク（Octiconsのmark-github）の36px・144dpiのPNG。templateImageとして渡すと、SwiftBarがメニューバーの明暗に合わせた色で描画する
ICON="iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAHhlWElmTU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAABAAIAAIdpAAQAAAABAAAATgAAAAAAAACQAAAAAQAAAJAAAAABAAOgAQADAAAAAQABAACgAgAEAAAAAQAAACSgAwAEAAAAAQAAACQAAAAA+INbXQAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAA1VJREFUWAm1l1uIjVEUx8+4XxrXoVyGaNJMipKixi0xFCJJopRSQnkXXrx48I6QPMgjJckljcsgMxG5i6akPLgmD2hcfv+Tfdqz7fV95zvnO//6t9dea+211rfPvp26QnY0MWQZbIXNcDKsh8JX+AY+hx3wEnwNc0c/Im6Ct+GfjLyF/0bYF+aC5UR5CbMWEvpr1tqqqWgIg4/nUEhY2FFiDs5a2FgG3KtBMa64LmIrR1mQo6bXDa5Vqxxj0irSz1TLmQk/TjM1yC8qXPmHMa7wHZC1dU/APnDSv5ambPzGUzvtGPwIp0OH8QiapfNO4bfaTeEXqL/Kc5qGfM7ze4t8F16EF+Ad2A1dnKvIM6DDXARn89slzsG1OmesrT3BOXntTORxXj8UG1DMDpX0B0K/ECc/Q9/r19Kh54xhm7rwGFsu9LP/gmEO9Tf4QZJO4Dm+Y5XyVMbHipGuw8VuSnD6gW2Wc8yhVUG672JFafFPUY4dhoMG7ZdDzthJvFhB0m1TrtOGw3f0I+SQMwYQ7wOMFXVKi6zFSKgt/MWwVaP+yWAdBzG0qKDGmAVdt6HPQ23FblRB9UaGHkOfh9qKPUwFWUYdbrWCddP3qCDdLzHo3qoVrGWixV64D2MrXjM3Wg45Q9fHNxjL2akZemgk1N2y3rBVo9ZlPdQIUKxlC8ZYtdK9g8ONwZWo9faxLnHl26ygOq51bFtFtWPL/AZmTAi9KM5CK49qKK1bHVSWo/RP4DxYKfQU6YJJOS77wdd5zu+RJ8IF8IGnVzAF3QcXQ2vrYipuhkW0u6Fei0mFONsa/ErQdD6CzihZRekt9MrTO7vapAW/EHvSMvDjSNaH93qg0S/Mh36Qm/TroF6H4ZNBRabhOg5h4lhfOVutYEeCIPophWZ4Emr6z8CVMA0HcYgVEOoOJQXS0+CGF+gFsv4aVYI9DAqTh/1r+ChnIhqw6tHtBnciL4Xu/1N/ZOtCxlRCWkHauWXfBKNwjq2BT+h74AGYhr04uI8KW8UeGQugqyMGJW6Dbk05HwXRbtBiT0PMR4UppmJ/jgWwCpKvHvjboXbfY+gjaZzzC32eYtDZppiKXRU0K6vhFahtugumYSsOmpF2uBb+d86gywXlLGiXKItvccxfg5DGxIaH/e0AAAAASUVORK5CYII="

message="" emoji="" busy=false expires="" status_error=""

load_status() {
  status_error=""
  local out
  out=$(gh api graphql \
    -f query='{viewer{status{message emoji indicatesLimitedAvailability expiresAt}}}' \
    --jq '.data.viewer.status // {} | @sh "message=\(.message // "") emoji=\(.emoji // "") busy=\(.indicatesLimitedAvailability // false) expires=\(.expiresAt // "")"' 2>&1) || {
    status_error=$out
    return 1
  }
  eval "$out"
}

# 引数はmessage、emoji、busy、expiresAtの順。空文字の項目はGraphQL変数ごと省略し、nullとして送る
save_status() {
  local args=(-F "busy=$3")
  [ -n "$1" ] && args+=(-f "message=$1")
  [ -n "$2" ] && args+=(-f "emoji=$2")
  [ -n "$4" ] && args+=(-f "expiresAt=$4")
  gh api graphql --silent "${args[@]}" -f query='
    mutation($message: String, $emoji: String, $busy: Boolean, $expiresAt: DateTime) {
      changeUserStatus(input: {message: $message, emoji: $emoji, limitedAvailability: $busy, expiresAt: $expiresAt}) {
        clientMutationId
      }
    }' 2>&1
}

expires_at() {
  case "$1" in
    30m) date -u -v+30M +%Y-%m-%dT%H:%M:%SZ ;;
    1h) date -u -v+1H +%Y-%m-%dT%H:%M:%SZ ;;
    4h) date -u -v+4H +%Y-%m-%dT%H:%M:%SZ ;;
    1w) date -u -v+7d +%Y-%m-%dT%H:%M:%SZ ;;
    today)date -u -r "$(date -v23H -v59M -v59S +%s)" +%Y-%m-%dT%H:%M:%SZ ;;
    *) echo "" ;;
  esac
}

notify_failure() {
  local text=${1//\"/\'}
  osascript -e "display notification \"${text:0:200}\" with title \"GitHub Busy\"" >/dev/null 2>&1
}

case "${1:-}" in
  on)
    load_status || { notify_failure "$status_error"; exit 1; }
    err=$(save_status "${message:-$DEFAULT_MESSAGE}" "$emoji" true "$(expires_at "${2:-}")") || { notify_failure "$err"; exit 1; }
    exit 0
    ;;
  off)
    load_status || { notify_failure "$status_error"; exit 1; }
    if [ "$message" = "$DEFAULT_MESSAGE" ]; then
      err=$(save_status "" "" false "") || { notify_failure "$err"; exit 1; }
    else
      err=$(save_status "$message" "$emoji" false "$expires") || { notify_failure "$err"; exit 1; }
    fi
    exit 0
    ;;
esac

if ! load_status; then
  echo "| sfimage=exclamationmark.triangle"
  echo "---"
  echo "Failed to load GitHub status"
  echo "${status_error//|/¦}" | head -5
  echo "---"
  echo "Refresh | refresh=true"
  exit 0
fi

if [ "$busy" = "true" ]; then
  echo "Busy | templateImage=$ICON"
else
  echo "| templateImage=$ICON"
fi
echo "---"

if [ -n "$message$emoji" ]; then
  line="$emoji $message"
  echo "${line//|/¦}"
fi
if [ -n "$expires" ]; then
  epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$expires" +%s 2>/dev/null) &&
    echo "Until $(date -r "$epoch" "+%m/%d %H:%M")"
fi
[ -n "$message$emoji$expires" ] && echo "---"

if [ "$busy" = "true" ]; then
  echo "Clear busy | bash=\"$0\" param1=off terminal=false refresh=true"
else
  echo "Set busy | bash=\"$0\" param1=on terminal=false refresh=true"
  echo "Set busy for 30 minutes | bash=\"$0\" param1=on param2=30m terminal=false refresh=true"
  echo "Set busy for 1 hour | bash=\"$0\" param1=on param2=1h terminal=false refresh=true"
  echo "Set busy for 4 hours | bash=\"$0\" param1=on param2=4h terminal=false refresh=true"
  echo "Set busy until end of day | bash=\"$0\" param1=on param2=today terminal=false refresh=true"
  echo "Set busy for 1 week | bash=\"$0\" param1=on param2=1w terminal=false refresh=true"
fi
echo "---"
echo "Refresh | refresh=true"
