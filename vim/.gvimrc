" .gvimrc
" vim:et:ts=2:sw=2:

" Set window size
set lines=30
set columns=120

" Set fonts
if has("win32") || has("win64")
  set guifont=Consolas:h12
  set guifontwide=SimHei:h12,Yahei\ Mono:h12
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
