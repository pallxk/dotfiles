" .vimrc
" vim:et:ts=2:sw=2:

" vimrc files are searched in order and only the first one found is read.
" Unix:       $HOME/.vimrc, $HOME/.vim/vimrc
" MS-Windows: $HOME/_vimrc, $HOME/.vimrc, $HOME/vimfiles/vimrc, $VIM/_vimrc

" Set vim internal character encoding
set encoding=utf-8
" Specify the character encoding used in this vimrc
scriptencoding utf-8

source ~/.vim/common.vimrc


" Ctrl+Shift+U to toggle case of word
if has("gui_running")
  nnoremap <C-S-u>          g~iwe
  inoremap <C-S-u>     <Esc>g~iwea
else
  nnoremap <Char-0x95>      g~iwe
  inoremap <Char-0x95> <Esc>g~iwea
endif
