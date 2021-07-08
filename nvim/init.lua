local cmd = vim.cmd  -- execute Vim commands
local g = vim.g      -- access global variables

g.mapleader = '\\'

require 'plugins'
require 'options'
require 'mappings'

cmd 'syntax enable'
cmd 'colorscheme tender' -- installed via plugins
cmd 'highlight FloatermNC guibg=gray'
