local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

-- Paq: package manager
-- installation instructions:
-- https://github.com/savq/paq-nvim/blob/cdde12dfbe/README.md#installation
require 'paq' {
  'savq/paq-nvim'; -- paq-nvim manages itself

  -- features
  'goolord/alpha-nvim'; -- startup screen
  'hrsh7th/nvim-cmp'; -- completion
  'tpope/vim-fugitive'; -- Git helpers
  'junegunn/fzf'; -- fuzzy file finder
  'junegunn/fzf.vim'; -- fuzzy file finder
  'ruanyl/vim-gh-line'; -- GitHub functions
  'lewis6991/gitsigns.nvim'; -- git change sigils
  'nvim-lualine/lualine.nvim'; -- status line
  'gaborvecsei/memento.nvim'; -- recent file navigator
  'vuki656/package-info.nvim'; -- version info for contents of `package.json` files
  'airblade/vim-rooter'; -- keep vim working directory set to project root
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'kyazdani42/nvim-tree.lua'; -- file browser

  -- behavior tweaks
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'svban/YankAssassin.vim'; -- control cursor behavior while yanking

  -- text manipulation
  'nicwest/vim-camelsnek'; -- camelcase / snake_case conversion functions
  'numToStr/Comment.nvim'; -- commenting shortcuts
  {url='https://gitlab.com/gi1242/vim-emoji-ab'}; -- helpers for inserting emoji characters 😜
  'cohama/lexima.vim'; -- matched-pair character closing
  'tpope/vim-surround'; -- matched-pair character conversion shortcuts

  -- eye candy
  {'catppuccin/nvim', name='catppuccin'}; -- colorscheme
  'norcalli/nvim-colorizer.lua'; -- color eye-candy
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'machakann/vim-highlightedyank'; -- highlight yanked region
  'anuvyklack/pretty-fold.nvim'; -- eye candy for folds

  -- treesitter etc
  'nvim-treesitter/nvim-treesitter'; -- file content parser
  'windwp/nvim-ts-autotag'; -- auto-close HTML tags (treesitter plugin)
  'p00f/nvim-ts-rainbow'; -- color matching parens (treesitter plugin

  -- meta / dependencies
  'Iron-E/nvim-cartographer'; -- simpler API for mappings
  'hrsh7th/cmp-buffer'; -- something for nvim-cmp
  'hrsh7th/cmp-nvim-lsp'; -- "LSP source for nvim-cmp"
  'ryanoasis/vim-devicons'; -- icon characters; optionally (?) used by lualine; required by alpha
  'neovim/nvim-lspconfig'; -- LSP config
  'williamboman/nvim-lsp-installer'; -- LSP server installation helpers
  'MunifTanjim/nui.nvim'; -- UI toolkit used by `package-info.nvim`
  'nvim-lua/plenary.nvim'; -- prereq for gitsigns & memento
  'kyazdani42/nvim-web-devicons'; -- icon characters; required by nvim-tree
}


-- alpha config
require('alpha').setup(require('alpha.themes.startify').opts)


-- catppuccin config
require('catppuccin').setup {
  styles = {
    functions = 'NONE',
    keywords = 'NONE',
    variables = 'NONE',
  },
  integrations = {
    gitsigns = true,
    ts_rainbow = true,
  },
}
cmd 'colorscheme catppuccin'


-- colorizer config
require 'colorizer'.setup({
  'css';
  'html';
  'javascript';
  'rust';
}, {
  RRGGBBAA = true;
  rgb_fn   = true;
})


-- Comment config
require('Comment').setup()


-- cmp config
local cmp = require'cmp'
cmp.setup {
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  },
}


-- vim-emoji-ab config
cmd [[
  au FileType html,php,markdown,mmd,text,mail,gitcommit runtime macros/emoji-ab.vim
]]


-- floaterm config
cmd 'au VimEnter * highlight FloatermNC guibg=gray'


-- gh-line config
cmd [[
  let g:gh_line_map_default = 0
  let g:gh_line_map = ',gl'
  let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '
  let g:gh_line_blame_map_default = 0
]]


-- gitsigns config
require('gitsigns').setup {}


-- highlightedyank config
cmd [[
  highlight HighlightedyankRegion guifg=magenta
]]


-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#', 'input': '<BS><BS>global.console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
]])


-- lsp config
local lspc = require'lspconfig'
lspc.bashls.setup{}
lspc.cssls.setup{}
-- lspc.eslint.setup{}
lspc.racket_langserver.setup{}

local lspi = require'nvim-lsp-installer'
lspi.on_server_ready(function(server)
  local opts = {}
  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end
  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)



-- lualine config
require'lualine'.setup{
  options = {
    icons_enabled = true,
    component_separators = {'…', '…'},
    section_separators = '',
    theme = 'catppuccin',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'diagnostics'},
    lualine_y = {'filetype'},
    lualine_z = {'location', 'progress'}
  },
  inactive_sections = {
    lualine_a = {'diff'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'progress', 'location'}
  },
}


-- package-info config
require('package-info').setup{
  colors = {
    outdated = '#11aaee',
    up_to_date = '#000000',
  },
  hide_unstable_versions = true,
  hide_up_to_date = true,
  icons = {
    style = {
      outdated = ' // new version: ',
    },
  },
}


-- pretty-fold config
require('pretty-fold').setup {
  fill_char = '⋅',
  sections = {
    left = { 'content' },
    right = { ' ', 'number_of_folded_lines', ' ' },
  },
}
require('pretty-fold.preview').setup {}


-- snap config
-- mappings are in `mappings.lua`
local snap = require('snap')
snapFindFile = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'},
    hidden = true,
  }
end
snapFindBuffer = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'},
    hidden = true,
  }
end
snapSearchWithGrep = function ()
  snap.run {
    producer = snap.get'consumer.limit'(100000, snap.get'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'},
    hidden = true,
  }
end
vim.cmd [[
  highlight! link SnapSelect Search
  highlight! link SnapMultiSelect Search
  highlight! link SnapNormal Fg1
  highlight! link SnapBorder SnapNormal
  highlight! link SnapPrompt MoreMsg
  highlight! link SnapPosition Yellow
  highlight! link WildMenu Yellow
]]



-- tree config
g.nvim_tree_quit_on_open = 1
g.nvim_tree_add_trailing = 1
require'nvim-tree'.setup {
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
  },
}


-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'elixir',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'ruby',
    'rust',
    'scss',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large buffers
      return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}


-- ts-autotag config
require('nvim-ts-autotag').setup()
