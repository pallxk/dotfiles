" .vimrc

" vimrc files are searched in order and only the first one found is read.
" Unix:       $HOME/.vimrc, $HOME/.vim/vimrc
" MS-Windows: $HOME/_vimrc, $HOME/.vimrc, $HOME/vimfiles/vimrc, $VIM/_vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Show tabs, trailing spaces and so on
set list
" Useful unicode characters for listchars:
"   «: U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
"   ¬: U+00AC NOT SIGN
"   »: U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
"   ·: U+00B7 MIDDLE DOT
"   ↲: U+21B2 DOWNWARDS ARROW WITH TIP LEFTWARDS
"   ␣: U+2423 OPEN BOX
"   █: U+2588 FULL BLOCK
"   ▸: U+25B8 BLACK RIGHT-POINTING SMALL TRIANGLE
let support_unicode = &encoding == "utf-8" && &term != "linux"
if support_unicode
  " listchars using unicode
  set listchars=tab:▸\ ,trail:·,extends:»,precedes:«
else
  " listchars using ascii
  set listchars=tab:\|\ ,trail:-,extends:>,precedes:<
endif
" Support for "space" item in "listchars" is added in patch 7.4.710
if v:version > 704 || v:version == 704 && has("patch710")
  if support_unicode
    "set listchars+=space:·
  endif
endif

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Load pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Load color scheme
colorscheme desert
