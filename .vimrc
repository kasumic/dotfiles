"-------------------------------------------------
" NeoBundle
"-------------------------------------------------
 
" Vi互換OFF 
set nocompatible
filetype off
 
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
        call neobundle#begin(expand('~/.vim/bundle/'))
        NeoBundleFetch 'Shougo/neobundle.vim'
endif
 
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'chase/vim-ansible-yaml'
call neobundle#end()
 
" ファイル形式別プラグインのロードを有効化
filetype plugin on
filetype indent on
 
" 分割した設定ファイルをすべて読み込む
set runtimepath+=~/.vim/
runtime! userautoload/*.vim
