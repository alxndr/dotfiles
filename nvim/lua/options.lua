vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.fillchars = 'fold: '
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.listchars = "tab:␉\\ ,trail:␠,nbsp:⎵,extends:⋯"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 333
vim.opt.wrap = false

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- line number tweaks
--  * "hybrid" style: normal mode shows absolute & insert mode shows absolute
--    for current line, relative for others
--    h/t https://jeffkreeftmeijer.com/vim-number/
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' },
  { command = 'if &nu && mode() != "i" | set rnu | endif' }
)
vim.api.nvim_create_autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },
  { command = 'if &nu && mode() != "i" | set rnu | endif' }
)

-- colorscheme tweaks
vim.api.nvim_create_autocmd(
  { 'BufEnter', },
  { command = 'highlight Folded guibg=NONE', }
)
vim.api.nvim_create_autocmd(
  { 'BufEnter', },
  { command = 'highlight Whitespace guibg=red', }
)
vim.api.nvim_create_autocmd(
  { 'TextYankPost', },
  {
    callback = function(_args)
      -- silent! lua vim.highlight.on_yank({higroup="Underlined", timeout=500})
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
vim.cmd [[
  autocmd filetype gitcommit setlocal spell
]]

-- disable large files: syntax highlighting, context scope visualization, etc
-- h/t `/u/Narizocracia` https://www.reddit.com/r/neovim/comments/pz3wyc/comment/heyy4qf
-- function definition in `functions.lua`
vim.api.nvim_create_autocmd(
  { 'BufReadPre', 'FileReadPre', },
  { command = 'if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | let b:minicursorword_disable=v:true | endif' }
)
