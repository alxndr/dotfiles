set   laststatus=2
set   list listchars=tab:»\ ,trail:·,nbsp:⎵,extends:…
set   scrolloff=2
set   splitbelow
set   splitright

filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin()
"lugin        'kien/ctrlp.vim' " TODO not working
Plugin    'Yggdroot/indentLine'
"lugin  'benekastah/neomake' " TODO not working
"lugin  'scrooloose/syntastic' " TODO not working
Plugin 'altercation/vim-colors-solarized'
Plugin       'bling/vim-airline'
Plugin    'airblade/vim-gitgutter'
Plugin      'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

syntax on

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 12

let g:ctrlp_show_hidden=1

"autocmd BufWrite * :Neomake

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

"
" mappings
"

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap K a<CR><Esc>k$ " opposite of J: inserts line after next char
" TODO why causing bell

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

