# ──────────────────────────────
# 基本初期化
autoload -Uz compinit colors && compinit
setopt prompt_subst

export EDITOR=vim
bindkey -e

#タブの名前
echo -ne "\033]0;${HOST}\007"

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

#共通エイリアス設定
alias ll="ls -lh"
alias rm="rm -i"


# ──────────────────────────────
# 補完スクリプト格納先と初期化
fpath=(~/.zsh/completion $fpath)

# docker 補完スクリプトを生成（初回のみ）
if command -v docker >/dev/null 2>&1; then
  if [[ ! -f ~/.zsh/completion/_docker ]]; then
    docker completion zsh > ~/.zsh/completion/_docker
  fi
fi

# --- AWS CLI completion ---
# 必要: aws-cli v2 が入っていること（aws_completer が提供されます）
if command -v aws >/dev/null 2>&1; then
  # aws コマンドに completer を関連付け
  # ※ nospace は候補確定時にスペースを自動で付けないオプション（好みで外してOK）
  if command -v aws_completer >/dev/null 2>&1; then
    complete -o nospace -C "$(command -v aws_completer)" aws
  fi
fi


# ──────────────────────────────

# zsh-autosuggestions（履歴補完）
if [[ -d ~/.zsh/zsh-autosuggestions ]]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting（構文色付け）※必ず最後に
if [[ -d ~/.zsh/zsh-syntax-highlighting ]]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ──────────────────────────────
# プロンプト表示用関数群
function os_icon {
  case "$OSTYPE" in
    darwin*) echo "🍎" ;;
    linux*)
      if grep -q Microsoft /proc/version 2>/dev/null; then
        echo "🫯"
      else
        echo "🐧"
      fi ;;
    msys*|cygwin*|win32) echo "🫯" ;;
    *) echo "💻" ;;
  esac
}

function current_dir_name {
  echo "${PWD##*/}"
}

function shorten_path {
  local path=$PWD
  local maxlen=30
  if (( ${#path} > maxlen )); then
    echo "...${path[-$maxlen,-1]}"
  else
    echo "$path"
  fi
}

# ──────────────────────────────
# 🎯 左プロンプト
PROMPT='%F{white}%n%f@%F{cyan}%m%f$(os_icon): %~%f %# '

# 📁 右プロンプト
RPROMPT='%B%F{green}$(shorten_path)%f%b'

# ──────────────────────────────
# ls エイリアス設定（exa優先, なければOS別にlsを使う）

# exa 用カラー設定（見やすさ重視）
export EXA_COLORS="di=1;92:ln=1;96:ex=1;93:da=1;97"
export LS_COLORS="di=1;92:ln=1;96:ex=1;93:fi=0"

if command -v exa >/dev/null 2>&1; then
  # exa がインストールされていれば優先使用
  alias ls='exa --icons --group-directories-first --color=always'
else
  case "$OSTYPE" in
    darwin*)  # macOS
      alias ls='ls -GF'
      ;;
    linux*)
      if grep -q Microsoft /proc/version 2>/dev/null; then
        # WSL
        alias ls='ls -F --color=auto'
      else
        # Linux ネイティブ
        alias ls='ls -F --color=auto'
      fi
      ;;
    msys*|cygwin*|win32)
      # Windows Git Bash など
      alias ls='ls -F'
      ;;
    *)
      # その他未対応環境
      alias ls='ls -F'
      ;;
  esac
fi
