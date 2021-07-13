local opt = vim.opt  -- to set options

opt.expandtab = true
opt.fillchars = 'fold: '
opt.foldlevelstart = 99
opt.ignorecase = true
opt.list = true
opt.listchars = "tab:␉\\ ,trail:␠,nbsp:⎵,extends:⋯"
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 333
opt.wrap = false

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
