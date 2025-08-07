vim.opt.cmdheight = 0 -- neovim 0.8.x
vim.opt.cursorcolumn = false
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.fillchars = 'fold: '
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.laststatus = 3 -- global status line
vim.opt.list = true
vim.opt.listchars = "tab:⎸\\ ,trail:␠,nbsp:⎵,extends:⋯"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = 'aF'
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 333
vim.opt.wrap = false

vim.wo.cursorline = false
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldmethod = 'expr'

vim.diagnostic.config({
  -- virtual_text = false, -- don't show in-line, require user interaction to show
  underline = true,
})

-- cursor
-- ...blink for insert isn't working?
vim.cmd [[
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor
]]

-- cursorline/column follows focused window split
vim.api.nvim_create_autocmd(
  { 'WinEnter', },
  { command = 'setlocal cursorline', }
)
vim.api.nvim_create_autocmd(
  { 'WinEnter', },
  { command = 'setlocal cursorcolumn', }
)
vim.api.nvim_create_autocmd(
  { 'WinLeave', },
  { command = 'setlocal nocursorline', }
)
vim.api.nvim_create_autocmd(
  { 'WinLeave', },
  { command = 'setlocal nocursorcolumn', }
)


-- foldtext
-- h/t https://vi.stackexchange.com/a/31741/67
vim.cmd [[
  function! MyFoldText()
      let nucolwidth = &fdc + &number*&numberwidth
      let winwd = winwidth(0) - nucolwidth
      let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
      let foldcharcount = -1
      let lineCounter = 1
      let rhs = " … ".foldlinecount."Ⱡ"
      let line = trim(strpart(getline(v:foldstart), 0, winwd - len(rhs)))
      let fillcharcount = winwd - indent(v:foldstart) - len(line) - len(rhs)
      return repeat("…", indent(v:foldstart)) . line . repeat(" ",fillcharcount) . rhs
  endfunction
  set foldtext=MyFoldText()
]]


-- colorscheme tweaks
vim.api.nvim_create_autocmd(
  { 'BufEnter', },
  { command = 'highlight Folded guibg=NONE', }
)
vim.api.nvim_create_autocmd(
  { 'TextYankPost', },
  {
    callback = function()
      vim.highlight.on_yank({higroup="Underlined", timeout=500})
    end
  }
)
vim.cmd [[
  highlight Search    guibg='NONE' guifg='NONE' gui=underline
  highlight IncSearch guibg='NONE' guifg='NONE' gui=underline
]]


-- markdown tweaks
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  { pattern = { '*.md' },
    command = 'setlocal wrap spell nonumber',
  }
)

-- gitcommit tweaks
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
    vim.opt_local.makeprg = 'npx commitlint --edit'
  end,
})

-- large file tweaks
-- * no plugins
-- * turn off syntax highlighting, expr-folding, undo, etc
-- h/t `/u/Narizocracia` https://www.reddit.com/r/neovim/comments/pz3wyc/comment/heyy4qf
vim.cmd [[
  function! DisableSyntaxTreesitter()
    if exists(':TSBufDisable')
      exec 'TSBufDisable autotag'
      exec 'TSBufDisable highlight'
    endif
    syntax off
    filetype off
    set   foldmethod=manual
    set noloadplugins
    set noswapfile
    set noundofile
  endfunction
]]
vim.api.nvim_create_autocmd(
  { 'BufReadPre', 'FileReadPre', },
  { command = 'if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | let b:minicursorword_disable=v:true | endif' }
)


-- disable some integrations
vim.cmd [[
  let g:loaded_perl_provider = 0
  let g:loaded_ruby_provider = 0
]]


-- Set indentation based on directory
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*',
  callback = function()
    if vim.fn.system('git remote get-url origin', true):match('planted%-solar/power_plants%.git.-$') then
      vim.opt.expandtab = false
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end
  end
})
