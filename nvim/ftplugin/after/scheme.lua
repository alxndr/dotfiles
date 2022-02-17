vim.opt.foldmethod = 'indent'

vim.cmd [[
  call lexima#add_rule({ 'char': "'", 'input': '', 'filetype': ['scheme'] })
]]
