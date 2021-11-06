local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

require 'plugin/vertical_space_jumper'

-- Paq: package manager
-- installation instructions:
-- https://github.com/savq/paq-nvim/blob/cdde12dfbe/README.md#installation
require 'paq-nvim' {
  'savq/paq-nvim'; -- paq-nvim manages itself

  'goolord/alpha-nvim'; -- startup screen
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'Iron-E/nvim-cartographer'; -- simpler API for mappings
  'hrsh7th/nvim-cmp'; -- completion
  'hrsh7th/cmp-buffer'; -- something for nvim-cmp
  'hrsh7th/cmp-nvim-lsp'; -- "LSP source for nvim-cmp"
  'norcalli/nvim-colorizer.lua'; -- color eye-candy
  'numToStr/Comment.nvim'; -- commenting shortcuts
  'ryanoasis/vim-devicons'; -- icon characters; optionally (?) used by lualine; required by alpha
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'beauwilliams/focus.nvim'; -- split window sizer
  'tpope/vim-fugitive'; -- Git helpers
  'junegunn/fzf'; -- fuzzy file finder
  'junegunn/fzf.vim'; -- fuzzy file finder
  'lewis6991/gitsigns.nvim'; -- git change sigils
  'cohama/lexima.vim'; -- matched-pair character closing
  'ggandor/lightspeed.nvim'; -- cursor navigation shortcuts
  'neovim/nvim-lspconfig';
  'williamboman/nvim-lsp-installer';
  'nvim-lualine/lualine.nvim'; -- status line
  'MunifTanjim/nui.nvim'; -- UI toolkit used by `package-info.nvim`
  'vuki656/package-info.nvim'; -- version info for contents of `package.json` files
  'nvim-lua/plenary.nvim'; -- prereq for gitsigns
  'airblade/vim-rooter'; -- keep vim working directory set to project root
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'tpope/vim-surround'; -- matched-pair character shortcuts
  'folke/tokyonight.nvim'; -- color scheme
  'kyazdani42/nvim-tree.lua'; -- file browser
  'nvim-treesitter/nvim-treesitter';
  'windwp/nvim-ts-autotag'; -- auto-close HTML tags
  'p00f/nvim-ts-rainbow'; -- color matching parens
  'kyazdani42/nvim-web-devicons'; -- icon characters; required by nvim-tree
}


-- alpha config
require('alpha').setup(require('alpha.themes.startify').opts)


-- colorizer config
require 'colorizer'.setup({
  'css';
  'javascript';
  'html';
}, {
  RRGGBBAA = true;
  rgb_fn   = true;
})


-- Comment config
require('Comment').setup()

-- cmp config
local cmp = require'cmp'
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.documentationFormat = {'markdown', 'plaintext'}
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
-- capabilities.textDocument.completion.completionItem.resolveSupport = {properties = {
  -- 'documentation', 'detail', 'additionalTextEdits',
-- }}
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    {name = 'buffer'},
  },
}
-- TODO these are not working yet... conflict with Lexima?
-- g.lexima_no_default_rules = true
-- cmd [[
  -- call lexima#set_default_rules()
  -- inoremap <silent><expr> <C-Space> compe#complete()
  -- inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
  -- inoremap <silent><expr> <C-e>     compe#close('<C-e>')
  -- inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
  -- inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
-- ]]


-- floaterm config
cmd 'highlight FloatermNC guibg=gray'


-- focus config
require('focus').setup()


-- gitsigns config
require('gitsigns').setup {}


-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#', 'input': '<BS><BS>global.console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
]])


-- lsp config
local lspc = require'lspconfig'
lspc.eslint.setup{}
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
    theme = 'seoul256',
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
  theme = 'tokyonight',
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


-- snap config
-- mappings are in `mappings.lua`
local snap = require('snap')
snapFindFile = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    -- producer = snap.get'consumer.fzf'(
      -- snap.get'consumer.try'(
        -- snap.get'producer.git.file',
        -- snap.get'producer.ripgrep.file'
      -- ),
    -- ),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end
snapFindBuffer = function ()
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end
snapSearchWithGrep = function ()
  snap.run {
    producer = snap.get'consumer.limit'(100000, snap.get'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get'preview.vimgrep'}
  }
end



-- tokyonight config
vim.g.tokyonight_italic_keywords = false


-- tree config
g.nvim_tree_quit_on_open = 1
g.nvim_tree_add_trailing = 1
require'nvim-tree'.setup {}
-- g.nvim_tree_bindings = {
--   { key = '<Tab>', mode = 'n', cb = '<C-w><C-w>'}
-- }


-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {'bash', 'comment', 'css', 'dockerfile', 'elixir', 'graphql', 'html', 'javascript', 'json', 'lua', 'ruby', 'scss', 'yaml'},
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}


-- ts-autotag config
require('nvim-ts-autotag').setup()
