local opt = vim.opt  -- to set options

opt.expandtab = true
opt.foldlevelstart = 99
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = false
opt.wrap = false

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
