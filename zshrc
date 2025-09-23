bindkey -e
export EDITOR=vim

#タブの名前
echo -ne "\033]0;${HOST}\007"

RPROMPT='[%F{green}%~%f]'
setopt transient_rprompt

autoload -U compinit;compinit
zstyle ':completion:*:default' menu select

#ディレクトリ名のみでの移動
setopt auto_cd

#ビープ音を鳴らさない
setopt nolistbeep

#History
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#tmuxで自動リネームを無効に
DISABLE_AUTO_TITLE=true

# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;36:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#共通エイリアス設定
alias ll="ls -lh"
alias rm="rm -i"

# 色と関数の有効化
autoload -Uz colors && colors
setopt prompt_subst

# ✅ OSアイコン関数（左プロンプト用）
function os_icon {
  case "$OSTYPE" in
    darwin*) echo "🍎" ;;               # macOS
    linux*)
      if grep -q Microsoft /proc/version 2>/dev/null; then
        echo "🪟"                       # WSL
      else
        echo "🐧"                       # Linux (native)
      fi ;;
    msys*|cygwin*|win32) echo "🪟" ;;   # Windows Git Bash etc
    *) echo "💻" ;;                     # fallback
  esac
}

# 絶対パスの短縮（30文字以上なら末尾表示）
function shorten_path {
  local path=$PWD
  local maxlen=30
  if (( ${#path} > maxlen )); then
    echo "...${path[-$maxlen,-1]}"
  else
    echo "$path"
  fi
}

# 🎯 左プロンプト（OSアイコン＋ディレクトリ名のみ）
PROMPT='%F{white}%n%f@%F{cyan}%m%f$(os_icon):%~%f %# '

# 📁 右プロンプト（絶対パス・黄緑色）
RPROMPT='%B%F{green}$(shorten_path)%f%b'

# --- kubectl 補完を設定 ---
if type kubectl >/dev/null 2>&1; then
  mkdir -p ${ZDOTDIR:-$HOME}/.zsh/completion
  if [ ! -f ${ZDOTDIR:-$HOME}/.zsh/completion/_kubectl ]; then
    kubectl completion zsh > ${ZDOTDIR:-$HOME}/.zsh/completion/_kubectl
  fi
  fpath=(${ZDOTDIR:-$HOME}/.zsh/completion $fpath)

  autoload -Uz compinit
  # 補完キャッシュなどをクリアするなら以下
  # compinit -u
  compinit
fi

# 補完スクリプト読み込み先に docker 補完を追加
fpath=(~/.zsh/completion $fpath)

# zsh-autosuggestions（入力中にグレーで履歴提案）
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting（コマンド構文に色付け）
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
