set   background=dark
set   expandtab
set   foldmethod=indent
set   foldlevelstart=99
set   hlsearch
set   incsearch
set   laststatus=2
set   list listchars=tab:┉\ ,trail:·,nbsp:⎵,extends:…
set   scrolloff=2
set   shiftwidth=2
set   smartcase
set   splitbelow
set   splitright
set   tabstop=2
set nowrap

" TODO use plug
filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin("~/.nvim/bundle/Vundle.vim") " TODO should be just bundle/
Plugin       'bling/vim-airline'          " status line
Plugin       'townk/vim-autoclose'        " insert closer of matched pair
Plugin        'moll/vim-bbye'             " smart buffer deleter
Plugin      'kchmck/vim-coffee-script'    " syntax hl: coffeescript
Plugin 'altercation/vim-colors-solarized' " color scheme
Plugin        'kien/ctrlp.vim'            " file finder; ctags navigator
Plugin 'elixir-lang/vim-elixir'           " syntax hl: elixir
Plugin       'tpope/vim-endwise'          " insert `end` in Ruby
Plugin       'tpope/vim-fugitive'         " git wrapper
Plugin    'airblade/vim-gitgutter'        " mark diff status in gutter
"lugin    'Yggdroot/indentLine'           " show indent levels
Plugin    'pangloss/vim-javascript'       " syntax hl: javascript (& more)
Plugin  'plasticboy/vim-markdown'         " syntax hl
Plugin  'scrooloose/nerdcommenter'        " language-agnostic comments
Plugin     'myusuf3/numbers.vim'          " smart line numbers
"lugin  'benekastah/neomake'              " job runner
Plugin       'mhinz/vim-startify'         " show recent files on start
Plugin       'tpope/vim-surround'         " modify enclosing matched pairs
Plugin  'scrooloose/syntastic'            " syntax checker
Plugin        'kana/vim-textobj-user'     " custom text objs
Plugin 'whatyouhide/vim-textobj-xmlattr'  " text objs for xml element attrs
Plugin       'tpope/vim-vinegar'          " netrw enhancer
Plugin      'gmarik/Vundle.vim'           " manage plugins
Plugin    'noprompt/vim-yardoc'           " syntax hl: yard (in ruby)
"lugin    'Valloric/YouCompleteMe'        " smart autocompleter
call vundle#end()
filetype plugin indent on

syntax on
let g:solarized_termcolors = 256
colorscheme solarized

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0 " hide git change summary
let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
let g:airline_section_y = 0 " hide fileencoding, fileformat section

let g:ctrlp_show_hidden=1

"let g:indentLine_color_gui='#00FF00'
"let g:indentLine_char='┊'

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

" opposite of J: inserts newline below current line
nnoremap K m`"="\n"<CR>p``

" gj, gk: vertical movement through whitespace
" thanks, WChargin! http://vi.stackexchange.com/a/156/67
function FloatUp()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm k
  endwhile
endfunction
function FloatDown()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm j
  endwhile
endfunction
nnoremap gk :call FloatUp()<CR>
nnoremap gj :call FloatDown()<CR>

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" space to toggle fold
" shift-space to close fold
nnoremap <Space> za
nnoremap <S-Space> zc

" make splits bigger
nnoremap ,w <C-w>10>
nnoremap ,W <C-w>5+

" buffer list
nnoremap <Leader><Leader> :buffers<CR>:b

" create tags file
map <Leader>ct :!/usr/local/bin/ctags --recurse -f .git/tags --exclude=pkg --exclude=.git --exclude=coverage --exclude=jscoverage .<CR>

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

" Git
" view last diff
command GitLastDiff !git log -1 -u
map gld :GitLastDiff<CR>

" read last commit message
command GitLastMessage :r !git log -1u
map glm :GitLastMessage<CR>
