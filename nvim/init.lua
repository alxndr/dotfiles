-- helpful aliases
local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

g.mapleader = '\\'

-- package manager
require 'paq-nvim' {
  'savq/paq-nvim'; -- paq-nvim manages itself
  'vim-airline/vim-airline'; -- status line
  'vim-airline/vim-airline-themes'; -- status line eyecandy
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'winston0410/commented.nvim'; -- commenting shortcuts
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'tpope/vim-fugitive'; -- Git helpers
  'airblade/vim-gitgutter'; -- for GitGutterUndoHunk
  'cohama/lexima.vim'; -- matched-pair character closing
  'ggandor/lightspeed.nvim'; -- cursor navigation shortcuts
  'neovim/nvim-lspconfig';
  'airblade/vim-rooter'; -- keep vim working directory set to project root
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'mhinz/vim-startify'; -- startup screen
  'tpope/vim-surround'; -- matched-pair character shortcuts
  'jacoborus/tender.vim'; -- color scheme
  'kyazdani42/nvim-tree.lua'; -- file browser
  'nvim-treesitter/nvim-treesitter';
  'kyazdani42/nvim-web-devicons'; -- required by nvim-tree ... but doesn't seem to work
}

require 'options'
require 'mappings'

cmd 'syntax enable'
cmd 'colorscheme tender'

cmd 'hi FloatermNC guibg=gray'

-- airline config
g.airline_theme = 'ouo'
g.airline_powerline_fonts = 1
g.airline_section_x = 0 -- hide tagbar, filetype, virtualenv section
g.airline_section_y = 0 -- hide fileencoding, fileformat section
g['airline#extensions#hunks#enabled'] = 0 -- hide git change summary
g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
g['airline#extensions#whitespace#enabled'] = 0 -- hide [88]trailing

-- commented config
require('commented').setup {
	keybindings = {n = 'gc', v = 'gc', nl = 'gcc'},
}

-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'jasmine.javascript'] })
]])

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
--{ type=fn['GitFilesModified'](),  header={' ➤ git modified'}            },
--{ type=fn['GitFilesUntracked'](), header={' ➤ git untracked'}           },
  { type='commands',                header={' ➤ Commands'}                },
}

-- tree config
g.nvim_tree_quit_on_open = 1
g.nvim_tree_add_trailing = 1

-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {'bash', 'comment', 'css', 'dockerfile', 'elixir', 'graphql', 'html', 'javascript', 'json', 'lua', 'ruby', 'scss', 'yaml'},
}

-- web-devicons config
-- require('nvim-web-devicons').setup()
