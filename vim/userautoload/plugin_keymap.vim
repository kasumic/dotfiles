"NERDTree
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <ESC> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""
" Unit.vim$B$N@_Dj(B
""""""""""""""""""""""""""""""
" $BF~NO%b!<%I$G3+;O$9$k(B
let g:unite_enable_start_insert=1
" $B%P%C%U%!0lMw(B
noremap <C-P> :Unite buffer<CR>
" $B%U%!%$%k0lMw(B
noremap <C-N> :Unite -buffer-name=file file<CR>
" $B:G6a;H$C$?%U%!%$%k$N0lMw(B
noremap <C-Z> :Unite file_mru<CR>
" sources$B$r!V:#3+$$$F$$$k%U%!%$%k$N%G%#%l%/%H%j!W$H$9$k(B
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" $B%&%#%s%I%&$rJ,3d$7$F3+$/(B
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" $B%&%#%s%I%&$r=D$KJ,3d$7$F3+$/(B
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESC$B%-!<$r(B2$B2s2!$9$H=*N;$9$k(B
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

noremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
