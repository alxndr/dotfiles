execute pathogen#infect()

set nocompatible
set backspace=indent,eol,start
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set bg=dark
set history=500
set ruler
set showcmd
set incsearch
set list listchars=tab:»·,trail:·

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on
autocmd FileType text setlocal textwidth=78
