set noautochdir
set   background=dark
set   diffopt+=vertical
set   expandtab
set   foldmethod=indent
set   foldlevelstart=99
set   hlsearch
set   ignorecase
set   incsearch
set   laststatus=2
set   list listchars=tab:┉\ ,trail:·,nbsp:⎵,extends:…
set   scrolloff=2
set   shell=/bin/sh " otherwise wants to use ruby 1.8.7
set   shiftwidth=2
set   smartcase
set   splitbelow
set   splitright
set   tabstop=2
set   wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.sass-cache/*
set nowrap

call plug#begin("~/.nvim/plugged")
Plug        'bling/vim-airline'             " status line
Plug        'townk/vim-autoclose'           " insert closer of matched pair
Plug         'moll/vim-bbye'                " smart buffer deleter
Plug       'kchmck/vim-coffee-script'       " syntax hl: coffeescript
Plug  'altercation/vim-colors-solarized'    " color scheme
Plug         'kien/ctrlp.vim'               " file finder; ctags navigator
Plug  'elixir-lang/vim-elixir'              " syntax hl: elixir
Plug     'junegunn/vim-emoji'               " 🌚
Plug        'tpope/vim-endwise'             " insert `end` in Ruby
Plug      'terryma/vim-expand-region'       " grow visual selections
Plug        'tpope/vim-fugitive'            " git wrapper
Plug     'airblade/vim-gitgutter'           " mark diff status in gutter
Plug     'pangloss/vim-javascript'          " syntax hl: javascript (& more)
Plug   'plasticboy/vim-markdown'            " syntax hl: markdown
Plug     'mustache/vim-mustache-handlebars' " syntax hl: handlebars
Plug   'benekastah/neomake'                 " job runner
Plug   'scrooloose/nerdcommenter'           " language-agnostic comments
Plug      'myusuf3/numbers.vim'             " smart line numbers
Plug        'mhinz/vim-startify'            " show recent files on start
Plug        'tpope/vim-surround'            " modify enclosing matched pairs
Plug   'scrooloose/syntastic'               " syntax checker
Plug         'kana/vim-textobj-user'        " custom text objs
Plug  'whatyouhide/vim-textobj-xmlattr'     " text objs for xml element attrs
Plug 'jszakmeister/vim-togglecursor'        " change cursor in insert mode
Plug        'tpope/vim-vinegar'             " netrw enhancer
Plug     'noprompt/vim-yardoc'              " syntax hl: yard (in ruby)
call plug#end()

let g:solarized_termcolors = 256
colorscheme solarized

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

autocmd BufWrite * :Neomake

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0 " hide git change summary
let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
let g:airline_section_y = 0 " hide fileencoding, fileformat section

let g:ctrlp_show_hidden=1

"
" mappings
"

" don't go all the way to the Escape key
inoremap jk <Esc>
inoremap kj <Esc>

" shortcut for removing search highlight
nnoremap <Esc> :nohl<Cr>

" make Y behave like C and D
map Y y$

" opposite of J: inserts newline below current line
nnoremap K m`"="\n"<CR>p``

" shift lines vertically
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

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
nnoremap <C-h> <C-w>h " TODO not working?
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

" save a protected file. thanks to mattikus https://news.ycombinator.com/item?id=9397891
cmap w!! w !sudo tee % >/dev/null


" Git
" view last diff
command GitLastDiff !git log -1 -u
map gld :GitLastDiff<CR>

" read last commit message
command GitLastMessage :read !git log -1
map glm :GitLastMessage<CR>

" \e to convert :smiley_cat: to 😸
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>
