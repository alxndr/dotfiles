vim.opt.cursorcolumn = false
vim.opt.cmdheight = 0 -- neovim 0.8.x
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.fillchars = 'fold: '
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.laststatus = 3 -- global status line
vim.opt.list = true
vim.opt.listchars = "tab:␉\\ ,trail:␠,nbsp:⎵,extends:⋯"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = 'aF'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 333
vim.opt.wrap = false

vim.wo.cursorline = false
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'


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

-- don't need python integration...?
vim.cmd [[
  let g:loaded_node_provider = 0
  let g:loaded_perl_provider = 0
  let g:loaded_python3_provider = 0
  let g:loaded_ruby_provider = 0
]]
