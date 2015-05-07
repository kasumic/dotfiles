bindkey -e
export EDITOR=vim

#$B%?%V$NL>A0(B
echo -ne "\033]0;${HOST}\007"

RPROMPT='%F{yellow}[%~]%f'
setopt transient_rprompt

autoload -U compinit;compinit
zstyle ':completion:*:default' menu select

#$B%G%#%l%/%H%jL>$N$_$G$N0\F0(B
setopt auto_cd

#$B%S!<%W2;$rLD$i$5$J$$(B
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

#tmux$B$G<+F0%j%M!<%`$rL58z$K(B
DISABLE_AUTO_TITLE=true

# ------------------------------
### Ls Color ###
# $B?'$N@_Dj(B
export LSCOLORS=Exfxcxdxbxegedabagacad
# $BJd40;~$N?'$N@_Dj(B
export LS_COLORS='di=01;34:ln=01;36:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORS$B$H$O!)(B
export ZLS_COLORS=$LS_COLORS
# ls$B%3%^%s%I;~!"<+F0$G?'$,$D$/(B(ls -G$B$N$h$&$J$b$N!)(B)
export CLICOLOR=true
# $BJd408uJd$K?'$rIU$1$k(B
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# $B%W%m%s%W%H$K?'$rIU$1$k(B
autoload -U colors; colors

#$B6&DL%(%$%j%"%9@_Dj(B
alias ll="ls -lh"
alias rm="rm -i"

#$B8GM-@_Dj(B
case ${OSTYPE} in
  #Mac
  darwin*)
    PROMPT='%F{white}[%n@%f%F{yellow}%m%f %F{white}%c]%# %f'
    alias ls="ls -GF"
    alias ctags="/usr/local/bin/ctags"
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    ;;
  linux*)
    PROMPT='%F{green}[%n@%f%F{blue}%m%f %F{green}%c]%# %f'
    alias ls="ls -GF --color"
    ;;
esac
