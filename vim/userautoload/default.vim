"----------------------------------------------------------------------------
"基本設定
"----------------------------------------------------------------------------
"vi互換モードをオフ
set nocompatible

"マウスサポート
set mouse=a

"構文ハイライトを有効にする
syntax on

"文字コード
scriptencoding utf-8
set encoding=utf-8

"ファイル書き込み時の文字コード
set fileencoding=utf-8

"ファイル文字コード自動認識(記載されている順番にオープンしていく)
set fileencodings=iso-2022-jp,utf-8,ucs2le,ucs-2,cp932,euc-jp

"改行コードの自動判別
set fileformats=unix,dos,mac

"全角文字の幅縮小をやめる
set ambiwidth=double

"全角を表示する
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white

"全角スペースを表示する
match ZenkakuSpace /　/

"クリップボード設定
"unnamed:ヤンクしたテキストそのままクリップボードにコピー
"autoselect:ヴィジュアルモードで選択したテキストをクリップボードへコピー
set clipboard=unnamed,autoselect

"ターミナル上からの張り付けを許可
set paste

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"----------------------------------------------------------------------------
"カラー設定
"----------------------------------------------------------------------------
"256色対応
set t_Co=256

"カラースキーマ
"Unix用設定
if has('unix') 
  colorscheme pablo
endif

"Mac用設定
if has('mac')
  colorscheme desert
endif

"----------------------------------------------------------------------------
"編集設定
"----------------------------------------------------------------------------
"バックアップの作成をしない
set nobackup

"スワップを編集中に作らない
set noswapfile

"編集中のファイルが変更されたら自動で読み直す
set autoread

"バックスペースキーで行頭を削除する
set backspace=indent,eol,start

"入力補完
set wildmenu


"----------------------------------------------------------------------------
"インデント設定
"----------------------------------------------------------------------------
"自動インデント
"新しい行を現在の行と同じインデントにする
set autoindent

"<Tab>の代わりに空白文字を挿入する
set expandtab

"タブ入力時に対応する空白の数
set softtabstop=2

"ファイル内の<Tab>が対応する空白の数
set tabstop=2

"行頭の余白内で<Tab>を入れるとshiftwidth分だけインデントする
set smarttab

"シフト移動幅
set shiftwidth=2

"----------------------------------------------------------------------------
"ステータスライン設定
"----------------------------------------------------------------------------
"ステータスラインを常に表示
set laststatus=2

"入力中のコマンドをステータスに表示する
set showcmd

"ファイル名表示
set statusline+=%<%F

"変更のチェック表示
set statusline+=%m

"読み込み専用かどうか表示
set statusline+=%r

"ファイルフォーマット表示
set statusline+=[%{&fileformat}]

"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]

"ファイルタイプ表示
set statusline+=%y


"----------------------------------------------------------------------------
"表示設定
"----------------------------------------------------------------------------
"行番号を表示
set number

"ルーラを表示
set ruler

"カーソル行を下線表示
set cursorline

"カーソル行をハイライト
hi CursorLine term=reverse cterm=none ctermbg=236

"スクロール余白
set scrolloff=5

"括弧入力時の対応する括弧を表示
set showmatch

"ビープ音を可視化
set visualbell

"タブ文字、行末など不可視文字を表示する
set list
"Unix用設定
if has('unix') 
  set listchars=tab:▸-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
endif

"Mac用設定
if has('mac')
  "listで表示される文字のフォーマットを指定する
  set listchars=tab:▸-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
endif


"----------------------------------------------------------------------------
"検索設定
"----------------------------------------------------------------------------
"インクリメンタルサーチ
set incsearch

"検索時に最後まで行ったら最初に戻る
set wrapscan

"検索結果のハイライト
set hlsearch

"大文字でも小文字でも検索ヒット
set ignorecase

"ただし、大文字の場合は大文字のみ
set smartcase

"ESC連続入力でハイライトを消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
