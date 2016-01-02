bindkey -e
export EDITOR=vim

#タブの名前
echo -ne "\033]0;${HOST}\007"

RPROMPT='%F{yellow}[%~]%f'
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

#rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"

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

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors

#共通エイリアス設定
alias ll="ls -lh"
alias rm="rm -i"

#固有設定
case ${OSTYPE} in
  #Mac
  darwin*)
    PROMPT='%F{white}%n@%f%F{yellow}%m%f %F{white}%c%# %f'
    alias ls='ls -GF'
    alias ctags="/usr/local/bin/ctags"
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    export PATH=$HOME/work/bin:$PATH
    ;;
  linux*)
    PROMPT='%F{green}[%n@%f%F{blue}%m%f %F{green}%c]%# %f'
    alias ls='ls -F --color=always'
    ;;
esac

#iTerm2,tmuxのタブ名をホスト名:実行コマンドに変更する
preexec() {
    mycmd=(${(s: :)${1}})
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$mycmd[1]\e\\"
}

precmd() {
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):idle\e\\"
}
