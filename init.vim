set noautochdir
set   background=dark
set   diffopt+=vertical
set   expandtab
set   foldlevelstart=99
set   foldmethod=syntax
set   hlsearch
set   ignorecase
set   inccommand=nosplit
set   incsearch
set   iskeyword-=.
set   laststatus=2
set   lazyredraw
set   list listchars=tab:␉\ ,trail:␠,nbsp:⎵,extends:⋯
set   mouse=
set   number
set   relativenumber
set   scrolloff=2
set   shell=zsh
set   shiftwidth=0
set   showcmd
set   smartcase
set   splitbelow splitright
set   tabstop=2
set notermguicolors
set   wildcharm=<C-z> " need this before we can remap <Tab>
set   wildignore+=*/tmp/*,*.dump,*.pyc,*.so,*.swp,*.zip,*/data.*@*/*,*/log.*@*/*,*/.sass-cache/*,*/.git/*,*/.idea/*,*/node_modules/*
set nowrap

if executable('rg')
  set grepprg=rg\ --vimgrep
elseif isdirectory('.git') && executable('git')
  set grepprg=git\ grep\ -nI
endif

"""""""""""
" Plugins "
"""""""""""

" set up vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source '~/.config/nvim/init.vim'
endif

call plug#begin("~/.config/nvim/plugged")

  " Abolish: assorted helpers by @tpope
  Plug 'tpope/vim-abolish'
    nnoremap <Leader>cc crc " coerce to camelCase
    nnoremap <Leader>cs crs " coerce to snake_case
    nnoremap <Leader>cu cru " coerce to UPPER_SNAKE

  " Airline: fancy status line
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'ouo'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#hunks#enabled = 0 " hide git change summary
    let g:airline_section_x = 0 " hide tagbar, filetype, virtualenv section
    let g:airline_section_y = 0 " hide fileencoding, fileformat section
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

  " ALE: linting engine
  Plug 'w0rp/ale'
    let g:ale_fixers = {
    \  '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['eslint'],
    \}
    let g:ale_linters = {
    \  'javascript': ['eslint'],
    \  'json': ['jsonlint'],
    \  'sass': ['sass-lint', 'scss-lint'],
    \}
    let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \} " Do not lint or fix minified files.
    let g:ale_sign_error = '🚨'
    let g:ale_sign_warning = '⚠️'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_save = 1
    let g:ale_sign_column_always = 1
    let g:ale_lint_delay = 600

  " BBye: smart buffer deleter
  Plug 'moll/vim-bbye'

  " COC: code completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Colorizer.lua: color the backgrounds of CSS colors
  " ...requires termguicolors to be on 😞
  Plug 'norcalli/nvim-colorizer.lua', {'branch': 'sass-variable-matcher'}
    " additional settings are outside plug#end()

  " ColorsSolarized: color scheme
  Plug 'altercation/vim-colors-solarized'
    let g:solarized_termcolors = 256

  " EditorConfig: coding style documentor
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    let g:EditorConfig_indent_style = 'space'

  " Emoji: 🌚
  Plug 'junegunn/vim-emoji'

  " FZF: 'fuzzy' text finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " to install via plug
  Plug 'junegunn/fzf.vim' " helpers to use FZF as file finder
  " Customize fzf colors to match your color scheme … https://github.com/junegunn/fzf/blob/ab11b74/README-VIM.md#examples
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

  " GitGutter: mark diff status in gutter
  Plug 'airblade/vim-gitgutter'
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = 'δ'
    let g:gitgutter_sign_removed = '✂︎'
    let g:gitgutter_sign_removed_first_line = '✃'
    let g:gitgutter_sign_modified_removed = '✁'
    let g:gitgutter_diff_args = '-w'

  " GitLink: generate URL for the current file / line / SHA / GitHub repo
  Plug 'iautom8things/gitlink-vim'
    function! CopyGitLink(...) range
      redir @+
      silent echo gitlink#GitLink(get(a:, 1, 0))
      redir END
    endfunction
    " Leader gl : GitLink
    nmap <leader>gl :call CopyGitLink()<CR>
    vmap <leader>gl :call CopyGitLink(1)<CR>

  " Vim-JSDoc: shortcuts for JSDoc
  Plug 'heavenshell/vim-jsdoc'
    let g:jsdoc_allow_input_prompt = 1
    let g:jsdoc_input_description = 1
    let g:jsdoc_enable_es6 = 1
    nnoremap <Leader>d :JsDoc<CR>

  " Lexima: auto-close parentheses/brackets/quotes/oh my
  Plug 'cohama/lexima.vim'

  " LF: file browser UI
  Plug 'ptzz/lf.vim'
  Plug 'rbgrouleff/bclose.vim' " dependency of lf.vim
    let g:lf_replace_netrw = 1 " use lf when opening a directory
    let g:lf_map_keys = 0 " turn off default lf mapping

  " ViMagit: git helper
  Plug 'jreybert/vimagit'

  " Markdown Preview: opens a browser tab with hot-preview of .md files
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    let g:mkdp_page_title = '𝐌𝐃： ${name}'

  " GitMessenger: git commit browser
  Plug 'rhysd/git-messenger.vim'
    let g:git_messenger_no_default_mappings=v:true " need this to create our own mapping

  " NeoFormat: code formatting
  Plug 'sbdchd/neoformat'

  " Polyglot: syntax highlighting for a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " QuickScope: navigation helpers
  Plug 'unblevable/quick-scope'

  " RainbowParentheses: just like it sounds
  Plug 'junegunn/rainbow_parentheses.vim'

  " Recover: add Compare to Swapfile actions
  Plug 'chrisbra/Recover.vim'

  " Rooter: change vim working dir
  Plug 'airblade/vim-rooter'
    let g:rooter_patterns = ['.git', '.git/']

  " Startify: show recent files on start
  Plug 'mhinz/vim-startify'

  " TComment: smart comment-related shortcuts
  Plug 'tomtom/tcomment_vim'

  " TextObjUser: custom text objs
  Plug 'kana/vim-textobj-user'

  " TextObjQuote: text objs for quotation marks, plus transformations
  Plug 'reedes/vim-textobj-quote'

  " TextObjXMLAttr: text objs for xml element attrs
  Plug 'whatyouhide/vim-textobj-xmlattr'

  " ToggleCursor: change cursor in insert mode
  Plug 'jszakmeister/vim-togglecursor'

call plug#end()

colorscheme solarized

highlight Folded cterm=NONE "guibg=NONE

highlight clear SignColumn " make gutter background transparent
autocmd ColorScheme * highlight clear SignColumn

call lexima#add_rule({'char': '>', 'at': ')\%#', 'input': ' => ', 'filetype': 'javascript'})

" fix saving crontab on OS X
" h/t https://superuser.com/a/907889/112856
autocmd filetype crontab setlocal nobackup nowritebackup

" line numbers: relative & absolute; hidden in terminals ...h/t https://jeffkreeftmeijer.com/vim-number/
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

" vertical movement through whitespace ...h/t WChargin http://vi.stackexchange.com/a/156/67
" TODO move to plugin
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

""""""""""""
" Mappings "
"„„„„„„„„„„"

" jj kk : Escape
inoremap jj <Esc>
inoremap kk <Esc>

" gk/gj : vertical movement through whitespace
nnoremap gk :call FloatUp()<CR>
nnoremap gj :call FloatDown()<CR>

" j/k: respect wrapped lines when unprefixed by a count ...h/t https://www.hillelwayne.com/post/intermediate-vim/
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" h/t embedded.kyle https://superuser.com/a/540488/112856
" opens a new buffer with selection and deletes from original buffer
vnoremap ,<Tab> :'<,'>d<Space>\|<Space>new<Space>\|<Space>0put<Space>\"

" Q : close buffer but preserve split, using vim-bbye
nnoremap Q :Bdelete<CR>

" w!! : save a protected file ...h/t mattikus https://news.ycombinator.com/item?id=9397891
cmap w!! w !sudo tee % >/dev/null

" make Y behave like C and D
nnoremap Y y$

" ,c ,o ,t : Close or Open or Toggle fold
nnoremap ,c zc
nnoremap ,o zo
nnoremap ,t za

" ,f : reformat with npm
nnoremap ,f :!npx prettier --write %<CR>

" ,md : preview markdown file in browser with MarkdownPreview
nnoremap ,md :MarkdownPreview<CR>

" ,n : remove search highlight
nnoremap ,n :nohl<CR>

" ,r : jump to next erorr
nnoremap ,r :ALENext<CR>
nnoremap ,R :ALEPrevious<CR>

" ,s : in NPM package.json, highlight related scripts (i.e. any pre/post hooks
"      of the script name under the cursor). TODO highlight the other way around
nnoremap ,s yi"/"\(pre\\|post\)\?<C-R>""<CR>

" ,w/,W : make horizontal/vertical splits bigger
nnoremap ,w <C-w>10>
nnoremap ,W <C-w>5+

" +/- : increment/decrement numbers ...h/t myfreeweb https://lobste.rs/s/6qp0vo#c_0emhe5
nnoremap - <C-x>
nnoremap + <C-a>

" Enter : insert newline below current line
" buftype check h/t Rich https://vi.stackexchange.com/a/3129/67
" TODO extract to plugin??
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":<C-U>call append('.', repeat([''],v:count1))<CR>"

" Space : enter command-line mode
nnoremap <Space> :
vnoremap <Space> :

" Shift-↑/↓ : move lines vertically
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" Ctrl-h/j/k/l : move focus to split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ctrl-p : fuzzy-find files (within the current Git repository; with FZF)
nnoremap <C-p> :GFiles<CR>

" Ctrl-s : search for word under cursor ...h/t https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap <C-s> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ctrl-Space : toggle folds
nnoremap <C-Space> za

" Ctrl-\ : comment or uncomment line/selection
nnoremap <C-\> :TComment<CR>

" Leader Leader : list buffers (with FZF)
nnoremap <Leader><Leader> :Buffers<CR>

" Leader Tab : open lf file browser
nnoremap <Leader><Tab> :Lf<CR>

" Leader 2 : jump to next ToDo
nnoremap <leader>2 /TODO<CR>:nohl<CR>

" Leader e : convert colon-delimited emoji name to emoji character
nmap <Leader>e :s/:\([^: ]\+\):/\=emoji#for(submatch(1), submatch(0), 0)/g<CR>:nohl<CR>

" Leader gg : Vimagit
nnoremap <Leader>gg :Magit<CR>

" Leader j/k : jump to next/prev edited area
map <Leader>j :GitGutterNextHunk<CR>
map <Leader>k :GitGutterPrevHunk<CR>

" Leader m : view most recent git message for current line
nmap <Leader>m <Plug>(git-messenger)

" Leader o : shortcut for :only
nnoremap <Leader>o :only<CR>

" Leader t : open terminal in floating window with vim-floaterm
" nnoremap <Leader>t :FloatermToggle<CR>i

" Leader u : revert current hunk to git HEAD
nnoremap <Leader>u :GitGutterUndoHunk<CR>

" Leader v : edit vimrc ...h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
nnoremap <Leader>v :edit $MYVIMRC<CR>

" Leader w : reveal/hide whitespace markers
nnoremap <Leader>w :set list!<CR>

" Leader x : trim trailing whitespace
nnoremap <Leader>x :s/\s\+$//<CR>:nohl<CR>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" ...there's a bug in this somewhere?
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Floating Term
" h/t @huytd https://github.com/huytd/vim-config/blob/0a6cc59aee/init.vim#L132-L171
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm()
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let s:float_term_border_win = nvim_open_win(border_buf, v:true, border_opts)
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatTermNormal term=None guibg=#2d3d45
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatTermNormal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:FloatTermNormal')
  terminal
  startinsert
  " Close border window when terminal window close
  autocmd CursorMoved * ++once call nvim_win_close(s:float_term_border_win, v:true)
endfunction
nnoremap <Leader>t :call FloatTerm()<CR>
