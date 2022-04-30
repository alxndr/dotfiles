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
  'folke/trouble.nvim'; -- lists of stuff...

  -- behavior tweaks
  'svban/YankAssassin.vim'; -- control cursor behavior while yanking
  'echasnovski/mini.nvim'; -- ...?

  -- files / navigation
  'junegunn/fzf'; -- fuzzy file finder core?
  'junegunn/fzf.vim'; -- fuzzy file finder functions?
  'gaborvecsei/memento.nvim'; -- recent file navigator
  'airblade/vim-rooter'; -- keep vim working directory set to project root
  'chrisbra/Recover.vim'; -- add Compare to swapfile actions
  'camspiers/snap'; -- file / buffer finder
  'kyazdani42/nvim-tree.lua'; -- file browser

  -- git stuff
  'APZelos/blamer.nvim'; -- show contributor info in virtualtext
  'whiteinge/diffconflicts'; -- merge conflict helper: `:DiffConflicts`
  'tpope/vim-fugitive'; -- general functions
  'ruanyl/vim-gh-line'; -- GitHub-specific functions (namely: copy link to current line of code)
  'lewis6991/gitsigns.nvim'; -- status sigils in the sign column

  -- text manipulation
  'nicwest/vim-camelsnek'; -- camelcase / snake_case conversion functions
  'numToStr/Comment.nvim'; -- commenting shortcuts
  {url='https://gitlab.com/gi1242/vim-emoji-ab'}; -- helpers for inserting emoji characters 😜
  'cohama/lexima.vim'; -- matched-pair character closing
  'tpope/vim-surround'; -- matched-pair character conversion shortcuts

  -- javascript / nodejs
  'vuki656/package-info.nvim'; -- version info for contents of `package.json` files

  -- lisp/scheme/racket
  'guns/vim-sexp';
  'tpope/vim-sexp-mappings-for-regular-people'; -- different mappings

  -- eye candy
  {'catppuccin/nvim', name='catppuccin'}; -- colorscheme
  'norcalli/nvim-colorizer.lua'; -- color eye-candy
  'voldikss/vim-floaterm'; -- terminal eyecandy
  'nvim-lualine/lualine.nvim'; -- status line
  'anuvyklack/pretty-fold.nvim'; -- eye candy for folds

  -- treesitter etc
  {'nvim-treesitter/nvim-treesitter', branch='0.5-compat'}; -- file content parser
  'windwp/nvim-ts-autotag'; -- auto-close HTML tags (treesitter plugin)
  'danymat/neogen'; -- code annotation helper
  'ziontee113/syntax-tree-surfer'; -- syntax-aware selection helpers
  'p00f/nvim-ts-rainbow'; -- color matching parens (treesitter plugin
  'nvim-treesitter/nvim-treesitter-refactor'; -- refactor modules

  -- meta / dependencies
  'Iron-E/nvim-cartographer'; -- simpler API for mappings
  'hrsh7th/cmp-buffer'; -- something for nvim-cmp
  'hrsh7th/cmp-nvim-lsp'; -- "LSP source for nvim-cmp"
  'ryanoasis/vim-devicons'; -- icon characters; optionally (?) used by lualine; required by alpha
  'neovim/nvim-lspconfig'; -- LSP config
  'williamboman/nvim-lsp-installer'; -- LSP server installation helpers
  'MunifTanjim/nui.nvim'; -- UI toolkit used by `package-info.nvim`
  'nvim-lua/plenary.nvim'; -- prereq for gitsigns & memento
  'tpope/vim-repeat'; -- dependency of tpope's vim-sexp-mappings-for-regular-people
  'tpope/vim-surround'; -- dependency of tpope's vim-sexp-mappings-for-regular-people
  'kyazdani42/nvim-web-devicons'; -- icon characters; required by nvim-tree
}


-- alpha config
local alpha = require'alpha'
local startify = require'alpha.themes.startify'
startify.section.header.val = {
  [[______________________________________________________________________________________]],
  [[ ____________________________________________________________/\\\______________________]],
  [[  ___/\\/\\\\\\_______/\\\\\\\\______/\\\\\_____/\\\____/\\\_\///_____/\\\\\__/\\\\\____]],
  [[   __\/\\\////\\\____/\\\/////\\\___/\\\///\\\__\//\\\__/\\\___/\\\__/\\\///\\\\\///\\\__]],
  [[    __\/\\\__\//\\\__/\\\\\\\\\\\___/\\\__\//\\\__\//\\\/\\\___\/\\\_\/\\\_\//\\\__\/\\\__]],
  [[     __\/\\\___\/\\\_\//\\///////___\//\\\__/\\\____\//\\\\\____\/\\\_\/\\\__\/\\\__\/\\\__]],
  [[      __\/\\\___\/\\\__\//\\\\\\\\\\__\///\\\\\/______\//\\\_____\/\\\_\/\\\__\/\\\__\/\\\__]],
  [[       __\///____\///____\//////////_____\/////_________\///______\///__\///___\///___\///___]],
}
alpha.setup(startify.opts)


-- blamer config
cmd [[
  let g:blamer_prefix = '    '
  let g:blamer_show_in_insert_modes = 0
]]


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
  enabled = function()
  -- h/t `u/Miserable-Ad-7341` https://www.reddit.com/r/neovim/comments/skkp1r/comment/hvocxmj/
    local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
    if in_prompt then  -- this will disable cmp in the Telescope window (taken from the default config)
      return false
    end
    local context = require('cmp.config.context')
    return not(context.in_treesitter_capture('comment') == true or context.in_syntax_group('Comment'))
  end,
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
    globalstatus = true, -- global status line
  },
  extensions = {
    'nvim-tree'
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


-- mini config
require('mini.bufremove').setup({})
require('mini.indentscope').setup({
  draw = {
    delay = 1,
    animation = require('mini.indentscope').gen_animation('none'),
  },
  symbol = '･',
})


-- neogen config
require('neogen').setup {
  enabled = true
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
    producer = snap.get'consumer.fzf'(
      snap.get'consumer.try'(
        snap.get'producer.git.file',
        snap.get'producer.ripgrep.file'
      )
    ),
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
    producer = snap.get'consumer.limit'(999, snap.get'producer.ripgrep.vimgrep'),
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
g.nvim_tree_add_trailing = 1
require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = 1,
    },
  },
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
    'commonlisp',
    'css',
    'dockerfile',
    'elixir',
    'graphql',
    'html',
    'javascript',
    'json',
    -- 'lua', -- this causes trouble...
    'ruby',
    'rust',
    'scss',
    'yaml',
  },
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large buffers
      return vim.api.nvim_buf_line_count(bufnr) > 999999
    end,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 9999, -- Do not enable for files with more than n lines, int
  }
}


-- trouble config
require('trouble').setup {}


-- ts-autotag config
require('nvim-ts-autotag').setup()
