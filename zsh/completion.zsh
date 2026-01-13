if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# npm
eval "$(npm completion)"

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-insert true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"

# fzf cdr
function fzf-cdr() {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr

#
# Completion module options
#

# 補完後、カーソルを単語の末尾に移動
setopt ALWAYS_TO_END
# 単語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD

# Enable caching
zstyle ':completion::complete:*' use-cache on

# Group matches and describe.
zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
# case-insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+r:|[._-]=* r:|=*' '+l:|=*'

# ファイル補完時に色付け（ls --colorと同じ色を使用）
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ssh/scpなどでホスト名を補完
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${(f)"$(cat {/etc/ssh/ssh_known_hosts,~/.ssh/known_hosts}(N) 2>/dev/null)"}%%[#| ]*}//,/ }
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# manページをセクションごとにグループ表示
zstyle ':completion:*:manuals' separate-sections yes
zstyle ':completion:*:manuals.(^1*)' insert-sections yes

# kill/rmで同じ候補を重複表示しない
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other

# プロセス補完を改善（killコマンド用）
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'

zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' squeeze-slashes true
