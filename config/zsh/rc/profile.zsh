eval "$(/opt/homebrew/bin/brew shellenv)"
export XDG_CONFIG_HOME="$HOME/.config"
# ~/.npmrcは外部ツールが書き込むため管理対象から外し、共通設定はnpmのグローバル設定として読ませる
export NPM_CONFIG_GLOBALCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PATH="$HOME/.local/bin:$PATH"
