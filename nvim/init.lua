-- helpful aliases
local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

g.mapleader = '\\'

-- package manager
require 'paq-nvim' {
  'savq/paq-nvim'; -- paq-nvim manages itself
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'winston0410/commented.nvim'; -- commenting shortcuts
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'tpope/vim-fugitive'; -- Git helpers
  'airblade/vim-gitgutter'; -- for GitGutterUndoHunk
  'cohama/lexima.vim'; -- matched-pair character closing
  'ggandor/lightspeed.nvim'; -- cursor navigation shortcuts
  'neovim/nvim-lspconfig';
  'hoob3rt/lualine.nvim'; -- status line
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

-- commented config
require('commented').setup {
  keybindings = {n = 'gc', v = 'gc', nl = 'gcc'},
}

-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#', 'input': '<BS><BS>global.console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
]])


-- lualine config
require'lualine'.setup{
  options = {
    icons_enabled = true,
    component_separators = {'', ''},
    section_separators = {'', ''},
    theme = 'seoul256',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'filetype'},
    lualine_z = {'progress', 'location'}
  },
}


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
