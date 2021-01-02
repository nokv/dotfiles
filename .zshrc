export LANG=ja_JP.UTF-8

# プロンプトの変更
eval "$(starship init zsh)"

#################################  PATH  #################################
export CLOUDSDK_PYTHON=python3
# gcloud
# The next line updates PATH for the Google Cloud SDK.
source '/Users/na-takahashi/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
source '/Users/na-takahashi/google-cloud-sdk/completion.zsh.inc'

export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/.composer/vendor/bin:$PATH"

# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
# 参考: https://qiita.com/crankcube/items/15f06b32ec56736fc43a
export PYENV_ROOT=/usr/local/var/pyenv
# pyenv の自動補完機能を有効化
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="/Users/na-takahashi/.ebcli-virtual-env/executables:$PATH"
#export PATH=/Users/na-takahashi/.pyenv/versions/3.7.2/bin:$PATH

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# .nvmrc が存在している場合自動でバージョンを切り替える。
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

#################################  ALIAS  #################################
alias cd:dev="cd ~/Desktop/develop"
alias l="ls -lah"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

#################################  HISTORY  #################################
# history
# 履歴を保存するファイル
HISTFILE=$HOME/.zsh-history
# メモリ上に保存する履歴のサイズ
HISTSIZE=100000
# 上述のファイルに保存する履歴のサイズ
SAVEHIST=1000000

# share .zshhistory
# 実行時に履歴をファイルにに追加していく
setopt inc_append_history
# 履歴を他のシェルとリアルタイム共有する
setopt share_history

#################################  COMPLEMENT  #################################
# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''


### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

# ビープ音の停止
setopt no_beep

# ビープ音の停止(補完時)
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit
