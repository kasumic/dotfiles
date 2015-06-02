"-------------------------------------
"Basic
"-------------------------------------
"文字コード関連
scriptencoding utf-8
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
"バックアップ無効
set nobackup
"スワップを編集中に作らない
set noswapfile
"マウスサポート有効化
set mouse=a
""ビープ音を鳴らさない
set vb t_vb=
set visualbell
"OSのクリップボードを使用
set clipboard=unnamed
"コマンド履歴の保存数
set history=1000
"-------------------------
"Syntax and Color
"-------------------------
syntax on
set t_Co=256
"colorscheme molokai
colorscheme pablo
"--------------------------------------------
"Editer 
"--------------------------------------------
"行番号表示
set number
"ルーラ表示
set ruler
"対応する括弧表示
set showmatch
"対応する括弧の表示時間
set showmatch matchtime=3
"インデントの設定
set cindent
"カーソル行に下線表示
"set cursorline
"大文字でも小文字でも検索にヒットするように
set ignorecase
"ただし大文字を検索は大文字のみ
set smartcase
"インクリメンタルサーチ
set incsearch
"検索結果のハイライト
set hlsearch
"スクロール余白
set scrolloff=5
"タブ文字、行末など不可視文字を表示する
"set list
"listで表示される文字のフォーマットを指定する
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"-----------------
"タブの設定
"-----------------
set wildmenu
"ファイル内の <Tab> が対応する空白の数
set tabstop=2
"シフト移動幅
set shiftwidth=2
"タブの代わりに空白文字を挿入する
set expandtab
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"
set nowrap

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
"-----------------
"Japanese
"-----------------
set ambiwidth=double
"全角表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
"-------------------------------------
"Window
"-------------------------------------
"タイトル
set notitle
"タイプ中のコマンドを画面最下行に表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l/%L%V%8P
"ステータスライン時刻表示用
function! g:Date()
    return strftime("%x %H:%M")
endfunction
set statusline+=\ \%{g:Date()}
"xterm/screen対応
set ttymouse=xterm2
highlight statusline   term=NONE cterm=NONE guifg=white guibg=black ctermfg=white ctermbg=black
"---------------------------------------------
"Keymap
"---------------------------------------------
"-------------------------------------------------------------------------------
" Mapping <jump-tag>
"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------
"esc連続入力でハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
"タブ移動
nmap <Tab> gt
nmap <S-Tab> gT

if exists('$TMUX')
  set term=screen-256color
endif
