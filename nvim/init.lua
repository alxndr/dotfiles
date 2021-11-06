local cmd = vim.cmd  -- execute Vim commands

require 'options'

require 'plugins'

require 'mappings'

cmd 'syntax enable'
cmd 'colorscheme moonfly' -- installed via plugins
