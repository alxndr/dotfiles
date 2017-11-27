set noautochdir
set   background=dark
set   showcmd
set   diffopt+=vertical
set   expandtab
set   foldmethod=indent
set   foldlevelstart=99
set   hlsearch
set   ignorecase
set   incsearch
set   iskeyword-=.
set   laststatus=2
set   lazyredraw
set   list listchars=tab:⋮\ ,trail:·,nbsp:⎵,extends:⋯
set   mouse=
set   number
set   scrolloff=2
set   shell=zsh
set   shiftwidth=2
set   showcmd
set   smartcase
set   splitbelow
set   splitright
set   tabstop=2
set   wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.sass-cache/*
set nowrap

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin("~/.config/nvim/plugged")
Plug        'bling/vim-airline'             " status line
Plug  'vim-airline/vim-airline-themes'      " themes
Plug        'townk/vim-autoclose'           " insert closer of matched pair
Plug         'moll/vim-bbye'                " smart buffer deleter
Plug       'kchmck/vim-coffee-script'       " syntax hl: coffeescript
Plug  'altercation/vim-colors-solarized'    " color scheme
Plug     'ctrlpvim/ctrlp.vim'               " file finder; ctags navigator
Plug  'elixir-lang/vim-elixir'              " syntax hl: elixir
Plug     'junegunn/vim-emoji'               " 🌚
Plug        'tpope/vim-endwise'             " insert `end` in Ruby
Plug      'terryma/vim-expand-region'       " grow visual selections
Plug        'tpope/vim-fugitive'            " git wrapper
Plug     'airblade/vim-gitgutter'           " mark diff status in gutter
Plug        'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug     'pangloss/vim-javascript'          " syntax hl: javascript (& more)
Plug   'plasticboy/vim-markdown'            " syntax hl: markdown
Plug     'mustache/vim-mustache-handlebars' " syntax hl: handlebars
Plug   'benekastah/neomake'                 " job runner
Plug      'myusuf3/numbers.vim'             " smart line numbers
Plug        'mhinz/vim-startify'            " show recent files on start
Plug        'tpope/vim-surround'            " modify enclosing matched pairs
Plug       'tomtom/tcomment_vim'            " smart comment-related shortcuts
Plug         'kana/vim-textobj-user'        " custom text objs
Plug  'whatyouhide/vim-textobj-xmlattr'     " text objs for xml element attrs
Plug 'jszakmeister/vim-togglecursor'        " change cursor in insert mode
Plug        'tpope/vim-vinegar'             " netrw enhancer
Plug     'noprompt/vim-yardoc'              " syntax hl: yard (in ruby)
call plug#end()

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

" vim-grepper config...
" gs is a verb to open Grepper for the selection (e.g. gsi"):
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

augroup neomake
  autocmd BufRead,BufWrite *.coffee,*.js :Neomake
  autocmd BufRead,BufWrite *.erb,*.rb    :Neomake
  autocmd BufRead,BufWrite *.ex,*.exs    :Neomake
  autocmd BufRead,BufWrite *.css,*.scss  :Neomake
augroup END

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

" jbuilder files use ruby highlighting
autocmd BufNewFile,BufRead *.jbuilder set ft=ruby

let g:deoplete#enable_at_startup=1

" netrw: tree display
let g:netrw_liststyle=3

let g:airline_theme='distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0 " hide git change summary
let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
let g:airline_section_y = 0 " hide fileencoding, fileformat section

let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](coverage|docs|node_modules|lib|vendor|\.git)$'
      \ }

"
" mappings
"

" don't go all the way to the Escape key
inoremap jk <Esc>
inoremap kj <Esc>

" shortcut for removing search highlight
"nnoremap <Esc> :nohl<Cr>

" make Y behave like C and D
map Y y$

" opposite of J: inserts newline below current line
nnoremap K m`"="\n"<CR>p``

" insert newline below with Enter
"nnoremap <CR> :<C-U>call append('.',         repeat([''],v:count1))<CR>
"nnoremap <S-CR> :<C-U>call append(line('.')-1, repeat([''],v:count1))<CR>
"nnoremap  :<C-U>call append(line('.')-1, repeat([''],v:count1))<CR>

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
nnoremap <C-h> <C-w>h " TODO this is broken https://github.com/neovim/neovim/issues/2048
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

" comment stuff
nnoremap <C-\> :TComment<CR>

" create tags file
map <Leader>ct :!/usr/local/bin/ctags --recurse -f .git/tags --exclude=pkg --exclude=.git --exclude=coverage --exclude=jscoverage .<CR>

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

" Esc-Esc in terminal buffer to exit insert mode
tnoremap <Esc><Esc> <C-\><C-n>

" reformat, keeping cursor position
map <F7> m`gg=G``

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

" Enter inserts newline below cursor
" http://vi.stackexchange.com/a/9720/67
nnoremap <buffer> <cr> :<C-U>call append('.', repeat([''],v:count1))<cr>
