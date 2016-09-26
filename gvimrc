"source ~/.vimrc

"---------------------------------------------------------------------------
"カラー設定
colorscheme newspaper
"カーソル行をハイライト無効
set nocursorline

hi Pmenu                    guibg=#ffffff
hi PmenuSel                 guifg=#000000 guibg=#ffff66

" フォント設定:
if has('win32')
  " Windows用
  set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('gui_macvim')
"  set guifont=Osaka-Mono:h14
  set guifont=Ricty:h16
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif
