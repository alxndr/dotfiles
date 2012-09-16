set nocompatible
set backspace=indent,eol,start
set tabstop=4
set autoindent
set bg=dark
set history=500
set ruler
set showcmd
set incsearch

map Q gq

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on
autocmd FileType text setlocal textwidth=78

