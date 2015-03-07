set   background=dark
set   expandtab
set   laststatus=2
set   list listchars=tab:»\ ,trail:·,nbsp:⎵,extends:…
set   scrolloff=2
set   shiftwidth=2
set   splitbelow
set   splitright
set   tabstop=2

filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin("~/.nvim/bundle/Vundle.vim")
Plugin       'bling/vim-airline'
Plugin        'moll/vim-bbye'
Plugin 'altercation/vim-colors-solarized'
Plugin        'kien/ctrlp.vim'
Plugin       'tpope/vim-fugitive'
Plugin    'airblade/vim-gitgutter'
Plugin    'Yggdroot/indentLine'
Plugin  'benekastah/neomake'
Plugin  'scrooloose/syntastic'
Plugin      'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

syntax on
let g:solarized_termcolors = 256
colorscheme solarized

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 12

let g:ctrlp_show_hidden=1

let g:indentLine_color_gui='#00FF00'
let g:indentLine_char='┊'

"autocmd BufWrite * :Neomake

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

"
" mappings
"

inoremap jk <Esc>
inoremap kj <Esc>

" make Y behave like other capitals
map Y y$

" opposite of J: inserts line after next char
nnoremap K a<CR><Esc>k$

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" make splits bigger
map ,w <C-w>10>
map ,W <C-w>5+

" create tags file
map <Leader>ct :!/usr/local/bin/ctags --recurse -f .git/tags --exclude=pkg --exclude=.git --exclude=coverage --exclude=jscoverage .<CR>

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>
