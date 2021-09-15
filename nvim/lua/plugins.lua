local cmd = vim.cmd  -- execute Vim commands
local fn = vim.fn    -- call Vim functions
local g = vim.g      -- access global variables

-- Paq: package manager
-- installation instructions:
-- https://github.com/savq/paq-nvim/blob/cdde12dfbe/README.md#installation
require 'paq-nvim' {
  'savq/paq-nvim'; -- paq-nvim manages itself

  'goolord/alpha-nvim'; -- startup screen
  'ojroques/nvim-bufdel'; -- buffer deletion made saner
  'Iron-E/nvim-cartographer'; -- simpler API for mappings
  'winston0410/commented.nvim'; -- commenting shortcuts
  'nvim-lua/completion-nvim';
  'ryanoasis/vim-devicons'; -- icon characters; optionally (?) used by lualine; required by alpha
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'tpope/vim-fugitive'; -- Git helpers
  'junegunn/fzf'; -- fuzzy file finder
  'junegunn/fzf.vim'; -- fuzzy file finder
  'lewis6991/gitsigns.nvim'; -- git change sigils
  'cohama/lexima.vim'; -- matched-pair character closing
  'ggandor/lightspeed.nvim'; -- cursor navigation shortcuts
  'neovim/nvim-lspconfig';
  'hoob3rt/lualine.nvim'; -- status line
  'nvim-lua/plenary.nvim'; -- prereq for gitsigns
  'airblade/vim-rooter'; -- keep vim working directory set to project root
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'tpope/vim-surround'; -- matched-pair character shortcuts
  'jacoborus/tender.vim'; -- color scheme
  'kyazdani42/nvim-tree.lua'; -- file browser
  'nvim-treesitter/nvim-treesitter';
  'kyazdani42/nvim-web-devicons'; -- icon characters; required by nvim-tree ... but doesn't seem to work
}


-- alpha config
require('alpha').setup(require('alpha.themes.startify').opts)


-- commented config
require('commented').setup {
  keybindings = {
    n = 'gc',
    v = 'gc',
    nl = 'gcc',
  },
}

-- gitsigns config
require('gitsigns').setup{
}

-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#', 'input': '<BS><BS>global.console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'jasmine.javascript'] })
]])

-- lsp config
local lspc = require'lspconfig'
local completion = require'completion'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local function eslint_config_exists()
  local eslintrc = fn.glob('.eslintrc*', 0, 1)
  if not vim.tbl_isempty(eslintrc) then
    return true
  end
  if fn.glob('package.json') and fn.filereadable('package.json') then
    if fn.json_decode(fn.readfile('package.json'))['eslintConfig'] then
      return true
    end
  end
  return false
end
local eslint = {
  lintCommand = 'eslint_d --format visualstudio --stdin --stdin-filename ${INPUT}',
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m'},
  lintIgnoreExitCode = true,
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspc.cssls.setup{
  capabilities = capabilities,
  on_attach = completion.on_attach,
}
-- TODO: `eslint_d` seems to chew up CPU after running for a few minutes 😞
--[[
lspc.efm.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    -- set_lsp_config(client)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return fn.getcwd()
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'json',
  },
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ['javascript.jsx'] = {eslint},
      json = {eslint},
    },
  },
}
]]
lspc.html.setup{
  capabilities = capabilities,
  on_attach = completion.on_attach,
}

-- lualine config
require'lualine'.setup{
  options = {
    icons_enabled = true,
    component_separators = {'⧹', '⧸'},
    section_separators = {'▋', '▐'},
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
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'progress', 'location'}
  },
}


-- tree config
g.nvim_tree_quit_on_open = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_bindings = {
  { key = '<Tab>', mode = 'n', cb = '<C-w><C-w>'}
}


-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {'bash', 'comment', 'css', 'dockerfile', 'elixir', 'graphql', 'html', 'javascript', 'json', 'lua', 'ruby', 'scss', 'yaml'},
}
