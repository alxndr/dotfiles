-- helpful aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

g.mapleader = '\\'

require('lua/options')

-- package manager
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true} -- paq-nvim manages itself

-- color scheme
paq {'joshdick/onedark.vim'}
cmd 'colorscheme onedark'

paq {'nvim-treesitter/nvim-treesitter'}

paq {'neovim/nvim-lspconfig'}

paq {'camspiers/snap'}
local snap = require'snap'
snap.register.map({'n'}, {'<C-p>'}, function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end)
snap.register.map({'n'}, {'<Leader><Leader>'}, function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end)
snap.register.map({'n'}, {'<Leader>g'}, function()
  snap.run {
    producer = snap.get'consumer.limit'(100000, snap.get'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'}
  }
end)

paq {'winston0410/commented.nvim'}
require('commented').setup()

require('lua/mappings')

-- TODO
-- * status line
-- * fugitive
-- * git gutter
-- * floating terminal
-- * lexima
-- * vim-surround
-- * jump to prev/next git hunk
