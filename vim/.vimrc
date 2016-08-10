" .vimrc
" vim:et:ts=2:sw=2:

" vimrc files are searched in order and only the first one found is read.
" Unix:       $HOME/.vimrc, $HOME/.vim/vimrc
" MS-Windows: $HOME/_vimrc, $HOME/.vimrc, $HOME/vimfiles/vimrc, $VIM/_vimrc

" Set vim internal character encoding
set encoding=utf-8
" Specify the character encoding used in this vimrc
scriptencoding utf-8

" Set fonts
if has("win32") || has("win64")
  set guifont=Consolas:h12
  set guifontwide=SimHei:h12
endif

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
set number		" print the line number
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" Do not spell check Asian words
set spelllang+=cjk
" Use 2 as 'A page is the number of lines in the window minus two.'
set scrolloff=2

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Swap functions of "," & "\"
let mapleader = ","
noremap \ ,

" Make editing $MYVIMRC easier
" Vimrc Editing
nnoremap <Leader>ve :split  $MYVIMRC<CR>
" Vimrc Sourcing
nnoremap <Leader>vs :source $MYVIMRC<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Yank the characters under the cursor until the end of the line.
" This behavior is more logical, and consistent with *C*, *D*,
" but not Vi-compatible.
map Y y$

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Make Ctrl-Space the same as Space in insert mode
" http://shallowsky.com/blog/linux/editors/vim-ctrl-space.html
imap <Nul> <Space>

" Jump to the first start of a change
" (Not working when changes are made at the first line)
nmap [C gg]c
" Jump to the last start of a change
" (Not working when changes are made at the last line)
nmap ]C G[c

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
  " No modeline in gitrebase as in gitcommit.
  autocmd FileType gitrebase setlocal nomodeline

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

" Show tabs and other listchars
set list
" Useful unicode characters for listchars:
"   ¦: U+00A6 BROKEN BAR
"   «: U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
"   ¬: U+00AC NOT SIGN
"   »: U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
"   ·: U+00B7 MIDDLE DOT
"   ↲: U+21B2 DOWNWARDS ARROW WITH TIP LEFTWARDS
"   ␣: U+2423 OPEN BOX
"   │: U+2502 BOX DRAWINGS LIGHT VERTICAL
"   ┆: U+2506 BOX DRAWINGS LIGHT TRIPLE DASH VERTICAL
"   █: U+2588 FULL BLOCK
"   ▸: U+25B8 BLACK RIGHT-POINTING SMALL TRIANGLE
let support_unicode = &encoding == "utf-8" && &term != "linux"
if support_unicode
  " listchars using unicode
  set listchars=tab:│\ ,extends:»,precedes:«
  "set listchars+=trail:·
  "let g:indentLine_char = '│'
  "let g:indentLine_first_char = '│'
else
  " listchars using ascii
  set listchars=tab:\|\ ,extends:>,precedes:<
  "set listchars+=trail:-
  "let g:indentLine_char = '|'
  "let g:indentLine_first_char = '|'
endif
" Trailing blanks are highlighted with plugin 'vim-better-whitespace'

" Support for "space" item in "listchars" is added in patch 7.4.710
if v:version > 704 || v:version == 704 && has("patch710")
  if support_unicode
    "set listchars+=space:·
  endif
endif

" Alt+u to toggle search highlighting (`less`-style)
" "v:hlsearch" variable is added in patch 7.4.079
if v:version > 704 || v:version == 704 && has("patch79")
  if has("gui_running")
    nnoremap <expr> <M-u>
      \           (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\n"
    inoremap <expr> <M-u>
      \ '<Esc>' . (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\na"
  else
    nnoremap <expr> <Esc>u
      \           (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\n"
    inoremap <expr> <Esc>u
      \ '<Esc>' . (&hls && v:hlsearch ? ':nohls' : ':set hls') . "\na"
  endif
else
  if has("gui_running")
    nnoremap <M-u>       :set hlsearch! <CR>
    inoremap <M-u>  <Esc>:set hlsearch! <CR>a
  else
    nnoremap <Esc>u      :set hlsearch! <CR>
    inoremap <Esc>u <Esc>:set hlsearch! <CR>a
  endif
endif

" Ctrl+Shift+U to toggle case of word
if has("gui_running")
  nnoremap <C-S-u>          g~iwe
  inoremap <C-S-u>     <Esc>g~iwea
else
  nnoremap <Char-0x95>      g~iwe
  inoremap <Char-0x95> <Esc>g~iwea
endif

" Disable certain pathogen bundles
let g:pathogen_disabled = []

" Preserve eol situation
" or ':set bin noeol' to keep the last line free of eol
if v:version > 704 || v:version == 704 && has("patch785")
  let g:pathogen_disabled += ['PreserveNoEOL']
  set nofixeol
else
  " PreserveNoEOL settings
  let g:PreserveNoEOL = 1
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

" vim-airline settings
set laststatus=2

" vim-gitgutter settings
" The delay before diff markers are computed (in ms)
set updatetime=500

" emmet-vim settings
let g:user_emmet_leader_key = '<C-j>'
let g:user_emmet_settings = webapi#json#decode(
\  join( readfile( expand( '~/.vim/emmet-snippets.json' ) ), "\n" ) )

" indentLine settings
" See :help concealcursor
"let g:indentLine_concealcursor = 'nc'

" vim-indent-guides settings
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1

" vim-json settings
let g:vim_json_syntax_concealcursor = 'nc'

" vim-markdown settings
" Disable Vim Markdown specific folding (currently buggy)
let g:vim_markdown_folding_disabled = 1
" Highlight YAML frontmatter as used by Jekyll
let g:vim_markdown_frontmatter = 1
