-- helpful aliases
local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

g.mapleader = '\\'

require 'options'
require 'mappings'

-- package manager
require 'paq-nvim' {
  {'savq/paq-nvim', opt = true}; -- paq-nvim manages itself
  'bling/vim-airline'; -- status line
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'winston0410/commented.nvim'; -- commenting shortcuts
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'tpope/vim-fugitive'; -- Git helpers
  'lewis6991/gitsigns.nvim'; -- line markers for added/removed code
  'cohama/lexima.vim'; -- matched-pair character closing
  'neovim/nvim-lspconfig';
  'joshdick/onedark.vim'; -- color scheme
  'nvim-lua/plenary.nvim'; -- required by gitsigns
  'unblevable/quick-scope'; -- highlight letter targets when using f/t to move within a line
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'mhinz/vim-startify'; -- startup screen
  'tpope/vim-surround'; -- matched-pair character shortcuts
  'nvim-treesitter/nvim-treesitter';
}

cmd 'colorscheme onedark'

require('commented').setup {
	keybindings = {n = 'gc', v = 'gc', nl = 'gcc'},
}

require('gitsigns').setup()

-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'jasmine.javascript'] })
]])

-- quickscope config
g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- snap config
local snap = require 'snap'
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

-- startify config
-- h/t https://github.com/mhinz/vim-startify/wiki/Example-configurations#show-modified-and-untracked-git-files
-- TODO fix these functions...
--[[
  function! GitFilesModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
  function! GitFilesUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
]]
g.startify_custom_header = ''
g.startify_lists = {
  { type='files',                   header={' ➤ recent global'}           },
  { type='dir',                     header={' ➤ recent in '..fn.getcwd()} },
  { type='sessions',                header={' ➤ Sessions'}                },
  { type='bookmarks',               header={' ➤ Bookmarks'}               },
  -- { type=fn['GitFilesModified'](),  header={' ➤ git modified'}            },
  -- { type=fn['GitFilesUntracked'](), header={' ➤ git untracked'}           },
  { type='commands',                header={' ➤ Commands'}                },
}
