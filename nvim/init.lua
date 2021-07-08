local cmd = vim.cmd  -- execute Vim commands

require 'plugins'
require 'options'
require 'mappings'

cmd 'syntax enable'
cmd 'colorscheme tender' -- installed via plugins
cmd 'highlight FloatermNC guibg=gray'
