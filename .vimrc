call pathogen#infect()

set autoindent
set backspace=indent,eol,start
set bg=dark
set expandtab
set foldmethod=syntax
set foldlevelstart=1
set guioptions+=a " autoselect
set history=500
set ignorecase
set incsearch
set laststatus=2 " always show status line
set list listchars=tab:»·,trail:·
set nocompatible
set nowrap
set number
set ruler
set shiftwidth=2
set scroll=15
set scrolloff=3 " scroll 3 lines before end
set showcmd
set smartcase
set softtabstop=2
set tabstop=4
set textwidth=0 wrapmargin=0
set whichwrap+=<,>,h,l,[,]
" make Y behave like other capitals
map Y y$

" jump to next/prev edited area
map gk :GitGutterPrevHunk<CR>
map gj :GitGutterNextHunk<CR>
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" modify scroll value: ^d / ^u move by 1/3 of buffer height instead of 1/2
execute "set scroll=" . &lines / 3
au VimResized * execute "set scroll=" . &lines / 3

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch

  let g:airline_powerline_fonts = 1

  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  colorscheme solarized

  highlight clear SignColumn
  autocmd ColorScheme * highlight clear SignColumn
endif

let g:ctrlp_show_hidden = 1

filetype plugin indent on

" no more arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" very-magic regexes by default
nnoremap / /\v
vnoremap / /\v

" shift-k: opposite of shift-j, h/t http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap K a<CR><Esc>k$

" fix numpad mappings, http://swannie.net/index.php?title=Numeric+keypad+in+iTerm+with+vi&function=viewpage&pageid=24
if &term=~"xterm" || &term=="xterm-color"
  imap <Esc>Oq 1
  imap <Esc>Or 2
  imap <Esc>Os 3
  imap <Esc>Ot 4
  imap <Esc>Ou 5
  imap <Esc>Ov 6
  imap <Esc>Ow 7
  imap <Esc>Ox 8
  imap <Esc>Oy 9
  imap <Esc>Op 0
  imap <Esc>On .
  imap <Esc>OQ /
  imap <Esc>OR *
  imap <Esc>Ol +
  imap <Esc>OS -
  "imap ?????? =
endif

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '∼'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '⋍'

