-- helpful aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

g.mapleader = '\\'

require 'options'

require 'mappings'

-- package manager
require 'paq-nvim' {

  {'savq/paq-nvim', opt = true}; -- paq-nvim manages itself

  'joshdick/onedark.vim'; -- color scheme

  'nvim-treesitter/nvim-treesitter';

  'neovim/nvim-lspconfig';

  'camspiers/snap'; -- file / buffer finder

  'bling/vim-airline'; -- status line

  'winston0410/commented.nvim';

  'tpope/vim-surround'; -- matched-pair character shortcuts
}

cmd 'colorscheme onedark'
require('commented').setup()

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

-- TODO
-- * fugitive
-- * git gutter
-- * floating terminal
-- * lexima
-- * jump to prev/next git hunk
