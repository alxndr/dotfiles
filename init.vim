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
set   scrolloff=2
set   shell=zsh
set   shiftwidth=2
set   showcmd
set   smartcase
set   splitbelow
set   splitright
set   tabstop=2
set   wildignore+=*/tmp/*,*.dump,*.pyc,*.so,*.swp,*.zip,*/data.*@*/*,*/log.*@*/*,*/.sass-cache/*
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
Plug       'hail2u/vim-css3-syntax'         " syntax hl: css
Plug         'kien/ctrlp.vim'               " file finder; ctags navigator
Plug  'elixir-lang/vim-elixir'              " syntax hl: elixir
Plug     'junegunn/vim-emoji'               " 🌚
Plug        'tpope/vim-endwise'             " insert `end` in Ruby
Plug      'terryma/vim-expand-region'       " grow visual selections
Plug        'tpope/vim-fugitive'            " git wrapper
Plug     'airblade/vim-gitgutter'           " mark diff status in gutter
Plug        'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] } " file contents searcher
Plug     'pangloss/vim-javascript'          " syntax hl: javascript (& more)
Plug          'mxw/vim-jsx'                 " syntax hl: JSX
Plug   'plasticboy/vim-markdown'            " syntax hl: markdown
Plug     'mustache/vim-mustache-handlebars' " syntax hl: handlebars
Plug   'benekastah/neomake'                 " job runner
Plug      'ipod825/vim-netranger', { 'do': ':UpdateRemotePlugins' } " file navigator
Plug        'mhinz/vim-startify'            " show recent files on start
Plug        'tpope/vim-surround'            " modify enclosing matched pairs
Plug       'tomtom/tcomment_vim'            " smart comment-related shortcuts
Plug         'kana/vim-textobj-user'        " custom text objs
Plug       'reedes/vim-textobj-quote'       " text objs for quotation marks, plus transformations
Plug  'whatyouhide/vim-textobj-xmlattr'     " text objs for xml element attrs
Plug 'jszakmeister/vim-togglecursor'        " change cursor in insert mode
Plug        'tpope/vim-vinegar'             " netrw enhancer
Plug     'noprompt/vim-yardoc'              " syntax hl: yard (in ruby)
call plug#end()

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized
"highlight Folded ctermbg=black ctermfg=white " this only works on bigmac

" tweak how folds look
set fillchars=fold:\ 

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

augroup textobj_quote
  autocmd FileType * call textobj#quote#init({'educate': 0})
augroup END
vmap <silent> <leader>qc <Plug>ReplaceWithCurly
vmap <silent> <leader>qs <Plug>ReplaceWithStraight


" hide line numbers in Terminal mode...
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" css files need hyphen to be a word char
" h/t hail2u/vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
autocmd BufNewFile,BufRead *.scss set ft=css

" json files use js highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript

" tweak how JS template literals are highlighted (...?)
" h/t @jeromecovington https://github.com/pangloss/vim-javascript/issues/242#issuecomment-343561923
let g:jsx_ext_required = 0


" jbuilder files use ruby highlighting
autocmd BufNewFile,BufRead *.jbuilder set ft=ruby

let g:deoplete#enable_at_startup=1

" netrw: tree display
let g:netrw_liststyle=3

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0 " hide git change summary
let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
let g:airline_section_y = 0 " hide fileencoding, fileformat section

let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/](\.git|\.hg|\.svn|coverage|bower_components|dist|docs|log|node_modules|project_files|vendor)$',
\ 'file': '\v[\/](\.exe\|\.so\|\.dll\|\.pyc)$'
\ }

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  " use Git to list files, so that the .gitignore is used to filter out things
  let g:ctrlp_user_command = {
  \ 'types': {
  \   1: ['.git', 'cd %s && git ls-files . -co --exclude-standard']
  \   },
  \ 'fallback': 'find %s -type f'
  \ }
  let g:ctrlp_clear_cache_on_exit = 0
endif

set wildignore+=*/.git/*,*/tmp/*,*.swp


"
" mappings
"

" don't go all the way to the Escape key
inoremap jk <Esc>
inoremap kj <Esc>

" shortcut for removing search highlight
nnoremap <Leader>n :nohl<CR>

" make Y behave like C and D
map Y y$

" opposite of J: inserts newline below current line
nnoremap K m`"="\n"<CR>p``

" Enter inserts newline below current line
nnoremap <CR> :<C-U>call append('.',         repeat([''],v:count1))<CR>
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
nnoremap <Leader>b :CtrlPBuffer<CR>

" comment stuff
nnoremap <C-\> :TComment<CR>


" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" revert current hunk to git HEAD
map <Leader>u :GitGutterRevertHunk

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

" \t to split open a terminal buffer
nnoremap <Leader>t :sp term://zsh<CR>A

" Esc-Esc in terminal buffer to exit insert mode
tnoremap <Esc><Esc> <C-\><C-n>

" reformat, keeping cursor position
map <F7> m`gg=G``

" save a protected file.
" h/t mattikus https://news.ycombinator.com/item?id=9397891
cmap w!! w !sudo tee % >/dev/null

" \e to convert :smiley_cat: to 😸
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>

" highlight git merge conflict markers as TODOs
" h/t https://vimrcfu.com/snippet/177
match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'

" jump to next/previous merge conflict marker
" h/t https://vimrcfu.com/snippet/177
"nnoremap <silent> ]c /\v^(\<\|\\\|\|\=\|\>){7}([^=].+)?$<CR>
"nnoremap <silent> [c ?\v^(\<\|\\|\|\=\|\>){7}([^=].+)\?$<CR>

" highlight pending tests as TODOs
match Todo '\<xdescribe\>\|\<xit\>'


"
" per-directory settings...
"

function! SetupEnvironment()
  let l:path = expand('%:p')
  " nr: set noexpandtab shiftwidth=2 tabstop=2; unset softtabstop
  if l:path =~ '/Users/alexanderquine/workspace/br/nodereport'
    setlocal noexpandtab shiftwidth=2 tabstop=2
    if findfile('.eslintrc', '.;') ==# ''
      let g:neomake_javascript_enabled_makers = ['eslint']
      let g:neomake_jsx_enabled_makers = ['eslint']
    endif
    " ...and set .js files to be React mode, & linted by ESLint
  "else
  "  setlocal expandtab smarttab textwidth=0
  endif
  " highlight git merge conflict markers as TODOs
  " h/t https://vimrcfu.com/snippet/177
  match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
