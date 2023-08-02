local cmd = vim.cmd  -- execute Vim commands

-- Paq: package manager
-- installation instructions:
-- https://github.com/savq/paq-nvim/blob/cdde12dfbe/README.md#installation
require 'paq' {
  'savq/paq-nvim'; -- paq-nvim manages itself

  -- features
  'protex/better-digraphs.nvim';      -- character picker
  'jdhao/better-escape.vim';          -- sidestep `timeoutlen` when using insert-mode shortcuts to exit insert-mode
  'princejoogie/chafa.nvim';          -- functions for viewing images within neovim
  'gpanders/editorconfig.nvim';       -- integrate with `.editorconfig` files
  'hrsh7th/nvim-cmp';                 -- completion
  'startup-nvim/startup.nvim';        -- startup screen
  'godlygeek/tabular';                -- align columns of text
  'folke/trouble.nvim';               -- lists of stuff...

  -- behavior tweaks
  'jeffkreeftmeijer/vim-numbertoggle'; -- tweak line numbers in non-active windows
  'svban/YankAssassin.vim';            -- control cursor behavior while yanking

  -- files / buffers / navigation
  'famiu/bufdelete.nvim';     -- delete buffer but don't modify window splits
  'ghillb/cybu.nvim';         -- buffers navigation
  'axkirillov/easypick.nvim'; -- helper for creating custom Telescope pickers
  'ibhagwan/fzf-lua';         -- fuzzy file finder functions
  'ggandor/leap.nvim';        -- fancy cursor navigation
  'gaborvecsei/memento.nvim'; -- recent file navigator
  'airblade/vim-rooter';      -- keep vim working directory set to project root
  'chrisbra/Recover.vim';     -- add Compare to swapfile actions
  'kyazdani42/nvim-tree.lua'; -- file browser

  -- git stuff
  'APZelos/blamer.nvim';       -- show contributor info in virtualtext
  'rhysd/conflict-marker.vim'; -- merge conflict eye candy
  'tpope/vim-fugitive';        -- general functions
  'ruifm/gitlinker.nvim';      -- copy link to current line of code
  'lewis6991/gitsigns.nvim';   -- status sigils in the sign column, and next/prev hunk nav functions

  -- eyecandy
  'WilsonOh/emoji_picker-nvim';      -- emoji UX
  'hiphish/rainbow-delimiters.nvim'; -- rainbow parens

  -- text manipulation
  'nicwest/vim-camelsnek';                        -- camelcase / snake_case conversion functions
  'numToStr/Comment.nvim';                        -- commenting shortcuts
  {url='https://gitlab.com/gi1242/vim-emoji-ab'}; -- helpers for inserting emoji characters 😜
  'cohama/lexima.vim';                            -- matched-pair character closing
  'tpope/vim-surround';                           -- matched-pair character conversion shortcuts

  -- html
  'windwp/nvim-ts-autotag';  -- auto-close HTML tags (treesitter)

  -- javascript / nodejs
  'vuki656/package-info.nvim';   -- version info for contents of `package.json` files
  'MunifTanjim/prettier.nvim';   -- integration with Prettier (code formatter)
  'axelvc/template-string.nvim'; -- autoconvert quotes to backticks if you type ${} in the string (treesitter)

  -- elixir
  'mhanberg/elixir.nvim'; -- install elixirls and more

  -- lisp/scheme/racket
  'guns/vim-sexp';                              -- paren-navigation fundamentals
  'tpope/vim-sexp-mappings-for-regular-people'; -- different mappings

  -- eye candy
  'ribru17/bamboo.nvim';                  -- colorscheme
  'norcalli/nvim-colorizer.lua';          -- color eye-candy
  'sindrets/diffview.nvim';               -- make diffs prettier
  'voldikss/vim-floaterm';                -- terminal eyecandy
  'nvim-lualine/lualine.nvim';            -- status line
  'anuvyklack/pretty-fold.nvim';          -- eye candy for folds

  -- meta / dependencies
  'm00qek/baleia.nvim';              -- dependency for chafa
  'Iron-E/nvim-cartographer';        -- simpler API for mappings
  'hrsh7th/cmp-buffer';              -- something for nvim-cmp
  'hrsh7th/cmp-nvim-lsp';            -- "LSP source for nvim-cmp"
  'ryanoasis/vim-devicons';          -- icon characters; prereq for: diffview, lualine
  'junegunn/fzf';                    -- fuzzy file finder core
  'neovim/nvim-lspconfig';           -- LSP config
  'MunifTanjim/nui.nvim';            -- UI toolkit; prereq for: package-info
  'nvim-lua/plenary.nvim';           -- helper functions; prereq for: diffview, gitsigns, memento, chafa, startup
  'tpope/vim-repeat';                -- prereq for: vim-sexp-mappings-for-regular-people
  'tpope/vim-surround';              -- prereq for: vim-sexp-mappings-for-regular-people
  'nvim-telescope/telescope.nvim';   -- list searcher; prereq for: startup…
  {'nvim-treesitter/nvim-treesitter',-- file content parser
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end};
  'nvim-treesitter/nvim-treesitter-refactor';  -- refactor modules
  'kyazdani42/nvim-web-devicons';    -- icon characters; prereq for: nvim-tree
}


-- bamboo config
require('bamboo').setup({
  transparent = 'true',
  code_style = {
    comments = 'italic',
    keywords = 'bold',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },
})
require('bamboo').load()


-- better-escape config
vim.g.better_escape_interval = 100
vim.g.better_escape_shortcut = { 'jk'; 'kj' }


-- blamer config
cmd [[
  let g:blamer_prefix = '    '
  let g:blamer_show_in_insert_modes = 0
]]


-- chafa
require('chafa').setup({
  render = {
    min_padding = 5,
    show_label = true,
  },
  events = {
    update_on_nvim_resize = true,
  },
})


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


-- easypick config
local easypick = require 'easypick'
easypick.setup({
  pickers = {
    {
      name = 'conflicts',
      command = 'git conflicting',
      previewer = easypick.previewers.file_diff(),
      -- previewer = easypick.previewers.default(),
    },
    {
      name = 'deprank',
      command = 'deprank ./src | grep src | awk \'{print $2}\'',
      previewer = easypick.previewers.file_diff(),
      -- previewer = easypick.previewers.default(),
    },
  }
})


-- vim-emoji-ab config
cmd [[
  au FileType html,php,markdown,mmd,text,mail,gitcommit runtime macros/emoji-ab.vim
]]


-- emoji setup
require("emoji_picker").setup()


-- floaterm config
cmd 'au VimEnter * highlight FloatermNC guibg=gray'


-- gitlinker config
require('gitlinker').setup {
  mappings = nil,
}


-- gitsigns config
require('gitsigns').setup {}


-- leap config
require('leap').set_default_keymaps()


-- lexima config
cmd([[
  call lexima#add_rule({ 'char': '=', 'at': ')\%#', 'input': ' => ', 'filetype': ['javascript', 'javascriptreact', 'typescriptreact'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#', 'input': ' => {', 'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'typescriptreact'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#', 'input': '<BS><BS>global.console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'typescriptreact'] })
  call lexima#add_rule({ 'char': '%', 'at': '{\%#}', 'input': '%',    'input_after': '%', 'filetype': 'html' })
  call lexima#add_rule({ 'char': '-', 'at': '{%\%#%}', 'input': '-',    'input_after': ' -', 'filetype': 'html' })
]])


-- lsp config
local lspc = require'lspconfig'
local lsp_defaults = lspc.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
lspc.bashls.setup{}
lspc.cssls.setup{}
-- lspc.eslint.setup{}
lspc.graphql.setup{}
lspc.html.setup{}
-- lspc.jsonls.setup{}
lspc.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
lspc.tsserver.setup{}


-- lualine config
require'lualine'.setup{
  options = {
    component_separators = {'…', '…'},
    globalstatus = true, -- global status line
    icons_enabled = true,
    section_separators = '',
    theme = 'bamboo',
  },
  extensions = {
    'nvim-tree'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'searchcount', 'diagnostics'},
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


-- prettier.nvim config
require('prettier').setup {
  bin = 'prettier', -- or `prettierd`
}


-- pretty-fold config
require('pretty-fold').setup {
  default_keybindings = false,
  fill_char = '․',
  sections = {
    left = { 'content' },
    right = { ' ', 'number_of_folded_lines', ' ' },
  },
}


-- startup config
require('startup').setup({
  theme = 'startify',
  mappings = {
    open_file = '<CR>',
  },
  section_1 = {
    type = 'oldfiles',
    oldfiles_directory = true,
  },
  section_2 = {
    type = 'oldfiles',
    oldfiles_directory = false,
  },
})


-- -- template-string config
-- require('template-string').setup()



-- tree config
require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  renderer = {
    add_trailing = true,
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
  },
}


-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'awk',
    'bash',
    'comment',
    'commonlisp',
    'css',
    'dockerfile',
    'elixir',
    -- 'eslint',
    'graphql',
    'html',
    'javascript',
    -- 'json',
    'lua',
    'ruby',
    'rust',
    'scss',
    'typescript',
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


-- -- ts-autotag config
-- require('nvim-ts-autotag').setup()
