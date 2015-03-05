set   laststatus=2
set   list listchars=tab:»\ ,trail:·,nbsp:⎵,extends:…
set   scrolloff=2

filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin()
"lugin       'kien/ctrlp.vim' " TODO not working
Plugin   'Yggdroot/indentLine'
"lugin 'benekastah/neomake' " TODO not working
"lugin 'scrooloose/syntastic' " TODO not working
Plugin      'bling/vim-airline'
Plugin     'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 12

"autocmd BufWrite * :Neomake

let g:ctrlp_show_hidden=1

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap K a<CR><Esc>k$ " opposite of J: inserts line after next char
" TODO why causing bell

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

