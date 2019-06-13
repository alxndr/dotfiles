" edit vimrc ...h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
nnoremap <Leader>ev :edit $MYVIMRC<CR>

set noautochdir
set   background=dark
set   diffopt+=vertical
set   expandtab
set   foldlevelstart=99
set   foldmethod=indent
set   hlsearch
set   ignorecase
set   inccommand=nosplit
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
set   wildignore+=*/tmp/*,*.dump,*.pyc,*.so,*.swp,*.zip,*/data.*@*/*,*/log.*@*/*,*/.sass-cache/*,*/.git/*,*/.idea/*,*/node_modules/*
set nowrap

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source '~/.config/nvim/init.vim'
endif
call plug#begin("~/.config/nvim/plugged")
Plug        'bling/vim-airline'             " status line
Plug  'vim-airline/vim-airline-themes'      " themes
Plug         'w0rp/ale'                     " linting engine
Plug        'townk/vim-autoclose'           " insert closer of matched pair
Plug         'moll/vim-bbye'                " smart buffer deleter
Plug     'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'} " code completion
Plug  'altercation/vim-colors-solarized'    " color scheme
Plug         'kien/ctrlp.vim'               " file finder; ctags navigator
Plug 'editorconfig/editorconfig-vim'        " coding style documentor
Plug     'junegunn/vim-emoji'               " 🌚
Plug        'tpope/vim-endwise'             " insert `end` in Ruby
Plug        'tpope/vim-fugitive'            " git wrapper
Plug     'airblade/vim-gitgutter'           " mark diff status in gutter
Plug        'rhysd/git-messenger.vim'       " git commit browser
Plug        'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] } " file contents searcher
Plug      'sheerun/vim-polyglot'            " syntax highlighting for a bunch of languages
Plug        'mhinz/vim-startify'            " show recent files on start
Plug        'tpope/vim-surround'            " modify enclosing matched pairs
Plug       'tomtom/tcomment_vim'            " smart comment-related shortcuts
Plug         'kana/vim-textobj-user'        " custom text objs
Plug       'reedes/vim-textobj-quote'       " text objs for quotation marks, plus transformations
Plug  'whatyouhide/vim-textobj-xmlattr'     " text objs for xml element attrs
Plug 'jszakmeister/vim-togglecursor'        " change cursor in insert mode
Plug        'tpope/vim-vinegar'             " netrw enhancer
call plug#end()

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

let g:ctrlp_show_hidden = 1

" tweak how folds look
set fillchars=fold:\ 

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

" linting config
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" let g:ale_linters = {
" \  'javascript': ['eslint'],
" \  'json': ['jsonlint'],
" \}
" let g:ale_pattern_options = {
" \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
" \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
" \} " Do not lint or fix minified files.
let g:ale_pattern_options_enabled = 1 " If you configure g:ale_pattern_options outside of vimrc, you need this.
let g:ale_linters_explicit = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✦'  " ➜
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1

" let g:javascript_plugin_jsdoc = 1

" line numbers: relative & absolute; hidden in terminals
set number relativenumber " https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  " autocmd TermOpen * setlocal norelativenumber
  " autocmd TermOpen * setlocal nonumber
augroup END
augroup TerminalStuff " https://github.com/onivim/oni/issues/962
  " autocmd! " Clear old autocommands
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" vim-grepper config...
" gs is a verb to open Grepper for the selection (e.g. gsi"):
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

autocmd StdinReadPre * let s:std_in=1
" ...what was that for?

" css files need hyphen to be a word char
" h/t hail2u/vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" tweak how JS template literals are highlighted (...?)
" h/t @jeromecovington https://github.com/pangloss/vim-javascript/issues/242#issuecomment-343561923
let g:jsx_ext_required = 0

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

" git-messenger at \m
let g:git_messenger_no_default_mappings=v:true
nmap <Leader>m <Plug>(git-messenger)


"
" mappings
"

" open file with system opener
nnoremap <Leader>o :!open %<CR><CR>

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
nnoremap <CR> :<C-U>call append('.', repeat([''],v:count1))<CR>

" use + and - to increment/decrement numbers
" h/t myfreeweb https://lobste.rs/s/6qp0vo#c_0emhe5
nnoremap + <C-x>
nnoremap - <C-a>

" shift lines vertically
nnoremap <S-Up> :m-2<CR> " doesn't work...
nnoremap <S-Down> :m+<CR>

" gj, gk: vertical movement through whitespace
" thanks, WChargin! http://vi.stackexchange.com/a/156/67
function! FloatUp()
  while line(".") > 1 && (strlen(getline(".")) < col(".") || getline(".")[col(".") - 1] =~ '\s')
    norm k
  endwhile
endfunction
function! FloatDown()
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
nnoremap <Leader><Leader> :CtrlPBuffer<CR>

" comment stuff
nnoremap <C-\> :TComment<CR>

" Ctrl-/ searches for word under cursor
" https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap <C-s> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" jump to next/prev edited area
map <Leader>k :GitGutterPrevHunk<CR>
map <Leader>j :GitGutterNextHunk<CR>

" revert current hunk to git HEAD
map <Leader>u :GitGutterUndoHunk

" \q for vim-bbye's :Bdelete
nnoremap <Leader>q :Bdelete<CR>

" \t to split open a terminal buffer
nnoremap <Leader>t :sp term://zsh<CR>A

" Esc-Esc in terminal buffer to exit insert mode
tnoremap <Esc><Esc> <C-\><C-n>

" reformat, keeping cursor position
" map <F7> m`gg=G``

" save a protected file.
" h/t mattikus https://news.ycombinator.com/item?id=9397891
cmap w!! w !sudo tee % >/dev/null

" \e to convert :smiley_cat: to 😸
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>

" highlight git merge conflict markers as TODOs
" h/t https://vimrcfu.com/snippet/177
match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" if unprefixed by a count, j/k will respect wrapped lines
" h/t https://www.hillelwayne.com/post/intermediate-vim/
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

"
" per-directory settings...
"

function! SetupEnvironment()
  " highlight git merge conflict markers as TODOs
  " h/t https://vimrcfu.com/snippet/177
  match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
