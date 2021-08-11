local cmd = vim.cmd  -- execute Vim commands

require 'options'

require 'plugins'

require 'mappings'

cmd 'syntax enable'
cmd 'colorscheme tokyonight' -- installed via plugins
cmd 'highlight FloatermNC guibg=gray'
