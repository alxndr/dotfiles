set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin()

Plugin       'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin      'bling/vim-airline'
Plugin     'gmarik/Vundle.vim'

set   laststatus=2

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 12

let g:ctrlp_show_hidden=1

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap K a<CR><Esc>k$ " opposite of J: inserts line after next char
