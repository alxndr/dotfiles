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
set   wildcharm=<C-z> " need this before we can remap <Tab>
set   wildignore+=*/tmp/*,*.dump,*.pyc,*.so,*.swp,*.zip,*/data.*@*/*,*/log.*@*/*,*/.sass-cache/*,*/.git/*,*/.idea/*,*/node_modules/*
set nowrap

" set up vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source '~/.config/nvim/init.vim'
endif

call plug#begin("~/.config/nvim/plugged")

  " Airline : status line
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " linting engine
  Plug 'w0rp/ale'

  " insert closer of matched pair
  Plug 'townk/vim-autoclose'

  " smart buffer deleter
  Plug 'moll/vim-bbye'

  " dependency of ptzz/lf.vim
  Plug 'rbgrouleff/bclose.vim'

  " code completion
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

  " color scheme
  Plug 'altercation/vim-colors-solarized'

  " file finder; ctags navigator
  Plug 'kien/ctrlp.vim'

  " coding style documentor
  Plug 'editorconfig/editorconfig-vim'

  " emoji 🌚
  Plug 'junegunn/vim-emoji'

  " insert `end` in Ruby
  Plug 'tpope/vim-endwise'

  " git wrapper
  Plug 'tpope/vim-fugitive'

  " 'fuzzy' text finder
  "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } " to install via plug
  "Plug '/usr/local/opt/fzf' " if installed via Homebrew
  "Plug 'junegunn/fzf.vim' " helpers

  " mark diff status in gutter
  Plug 'airblade/vim-gitgutter'

  " file browser UI
  Plug 'ptzz/lf.vim'

  " git commit browser
  Plug 'rhysd/git-messenger.vim'

  " syntax highlighting for a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " show recent files on start
  Plug 'mhinz/vim-startify'

  " modify enclosing matched pairs
  Plug 'tpope/vim-surround'

  " smart comment-related shortcuts
  Plug 'tomtom/tcomment_vim'

  " custom text objs
  Plug 'kana/vim-textobj-user'

  " text objs for quotation marks, plus transformations
  Plug 'reedes/vim-textobj-quote'

  " text objs for xml element attrs
  Plug 'whatyouhide/vim-textobj-xmlattr'

  " change cursor in insert mode
  Plug 'jszakmeister/vim-togglecursor'

call plug#end()

let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

let g:ctrlp_show_hidden = 1

" tweak how folds look
set fillchars=fold:\ 

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

" fix saving crontab on OS X
" h/t https://superuser.com/a/907889/112856
autocmd filetype crontab setlocal nobackup nowritebackup


" linting config
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'json': ['jsonlint'],
\}
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\} " Do not lint or fix minified files.
" let g:ale_pattern_options_enabled = 1 " If you configure g:ale_pattern_options outside of vimrc, you need this.
" let g:ale_linters_explicit = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠️'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 600

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

" GitGutter config
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = 'δ'
let g:gitgutter_sign_removed = '✂︎'
" let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = '✁'
let g:gitgutter_diff_args = '-w'

let g:lf_replace_netrw = 1 " use lf when opening a directory
let g:lf_map_keys = 0 " turn off default lf mapping

autocmd StdinReadPre * let s:std_in=1
" ...what was that for?




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
  set grepprg=rg\ --vimgrep
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

" vertical movement through whitespace
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

" highlight git merge conflict markers as TODOs ...h/t https://vimrcfu.com/snippet/177
match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'



"
" mappings
"

" gk/gj : vertical movement through whitespace
nnoremap gk :call FloatUp()<CR>
nnoremap gj :call FloatDown()<CR>

" j/k: respect wrapped lines when unprefixed by a count ...h/t https://www.hillelwayne.com/post/intermediate-vim/
" doesn't interfere with above jk/kj remapping
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" jk/kj : Escape
inoremap jk <Esc>
inoremap kj <Esc>

" Q : close buffer but preserve split
nnoremap Q :Bdelete<CR>

" w!! : save a protected file ...h/t mattikus https://news.ycombinator.com/item?id=9397891
cmap w!! w !sudo tee % >/dev/null

" make Y behave like C and D
nnoremap Y y$

" ,w/,W : make horizontal/vertical splits bigger
nnoremap ,w <C-w>10>
nnoremap ,W <C-w>5+

" +/- : increment/decrement numbers ...h/t myfreeweb https://lobste.rs/s/6qp0vo#c_0emhe5
nnoremap - <C-x>
nnoremap + <C-a>

" Enter : insert newline below current line
nnoremap <CR> :<C-U>call append('.', repeat([''],v:count1))<CR>

" Space : toggle/close fold
nnoremap <Space> za

" Shift-Space : enter command-line  mode
nnoremap <S-Space> :

" shift lines vertically
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ctrl-s : search for word under cursor ...h/t https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap <C-s> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" comment stuff
nnoremap <C-\> :TComment<CR>

" Leader Leader : list buffers
nnoremap <Leader><Leader> :CtrlPBuffer<CR>

" Leader Tab : open file browser
nnoremap <Leader><Tab> :Lf<CR>

" Leader e : convert colon-delimited emoji name to emoji character
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>

" Leader j/k : jump to next/prev edited area
map <Leader>j :GitGutterNextHunk<CR>
map <Leader>k :GitGutterPrevHunk<CR>

" Leader m : view most recent git message for current line
let g:git_messenger_no_default_mappings=v:true
nmap <Leader>m <Plug>(git-messenger)

" Leader n : remove search highlight
nnoremap <Leader>n :nohl<CR>

" Leader o : open file with system opener
nnoremap <Leader>o :!open %<CR><CR>

" Leader s : change spaces to tabs
nnoremap <Leader>s :s/  /\t/g<CR>:noh<CR>

" Leader t : split open a terminal buffer
nnoremap <Leader>t :sp term://zsh<CR>A

" Leader u : revert current hunk to git HEAD
nnoremap <Leader>u :GitGutterUndoHunk<CR>

" edit vimrc ...h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
nnoremap <Leader>v :edit $MYVIMRC<CR>

" Esc-Esc : exit insert mode from terminal buffer
tnoremap <Esc><Esc> <C-\><C-n>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"
" per-directory settings...
"

function! SetupEnvironment()
  " highlight git merge conflict markers as TODOs
  " h/t https://vimrcfu.com/snippet/177
  match Todo '\v^(\<|\||\=|\>){7}([^=].+)?$'
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
