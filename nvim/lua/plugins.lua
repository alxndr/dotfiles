-- Paq: package manager
-- installation instructions:
-- https://github.com/savq/paq-nvim/blob/cdde12dfbe/README.md#installation
require 'paq' {

  'savq/paq-nvim'; -- paq-nvim manages itself


  -- features
  'goolord/alpha-nvim';                 -- startup screen
  'gpanders/editorconfig.nvim';         -- integrate with `.editorconfig` files
  'mhartington/formatter.nvim';         -- reformat code
  'Robitx/gp.nvim';                     -- new robot overlords 🤖
  'godlygeek/tabular';                  -- align columns of text
  'olacin/telescope-cc.nvim';           -- Conventional Commit integration
 {'piersolenski/telescope-import.nvim', -- autocomplete import statements (depends on ripgrep?)
    build = function() require('telescope').load_extension('import') end};
  -- 'folke/trouble.nvim';                 -- diagnostics stuff
  'folke/which-key.nvim';               -- manage keyboard shortcuts...
  'rachartier/tiny-inline-diagnostic.nvim'; -- diagnostic message tweaks


  -- behavior tweaks
  'jdhao/better-escape.vim';           -- sidestep `timeoutlen` when using insert-mode shortcuts to exit insert-mode
  'RRethy/vim-illuminate';             -- highlight/underline all occurrences of word under cursor
  'echasnovski/mini.nvim';             -- more text objects
  'jeffkreeftmeijer/vim-numbertoggle'; -- tweak line numbers in non-active windows
  'stevearc/quicker.nvim';             -- quickfix window workflow improvements + eye candy
  'svban/YankAssassin.vim';            -- control cursor behavior while yanking


  -- files / buffers / navigation
  'famiu/bufdelete.nvim';     -- delete buffer but don't modify window splits
  'ghillb/cybu.nvim';         -- buffers navigation
  'axkirillov/easypick.nvim'; -- helper for creating custom Telescope pickers
  'ibhagwan/fzf-lua';         -- fuzzy file finder functions -- \\ -- \g -- <C-p> -- <C-s>
  'airblade/vim-rooter';      -- keep vim working directory set to project root (nextreport confuses this...)
  'chrisbra/Recover.vim';     -- add Compare to swapfile actions
  'kyazdani42/nvim-tree.lua'; -- file browser            -- \<Tab>


  -- git stuff
  'APZelos/blamer.nvim';       -- show contributor info in virtualtext
  'rhysd/conflict-marker.vim'; -- merge conflict eye candy
  'tpope/vim-fugitive';        -- general functions
  'ruifm/gitlinker.nvim';      -- copy link to current line of code
  'lewis6991/gitsigns.nvim';   -- status sigils in the sign column, and next/prev hunk nav functions


  -- text manipulation
  'nicwest/vim-camelsnek';                        -- camelcase / snake_case conversion functions
  'numToStr/Comment.nvim';                        -- commenting shortcuts
  {url='https://gitlab.com/gi1242/vim-emoji-ab'}; -- helpers for inserting emoji characters 😜
  'cohama/lexima.vim';                            -- matched-pair character closing
  'tpope/vim-surround';                           -- mappings for converting matched-pair characters


  -- language-specific features...
  ---- CSV
  'VidocqH/data-viewer.nvim';        -- table view
  -- 'emmanueltouzery/decisive.nvim';   -- align columns

  ---- Elixir
  'mhanberg/elixir.nvim';            -- install elixirls and more

  ---- HTML
  'windwp/nvim-ts-autotag';          -- auto-close tags (treesitter)

  ---- JavaScript
  'vuki656/package-info.nvim';       -- version info for contents of `package.json` files
  'axelvc/template-string.nvim';     -- autoconvert quotes to backticks if you type ${} in the string (treesitter)

  ---- Liquid (templating)
  'tpope/vim-liquid';                -- Jekyll posts (templating language within markdown)

  ---- LISP / Scheme / Racket / etc
  'julienvincent/nvim-paredit';      -- s-expression editing facilitation

  ---- Markdown
  'rhysd/vim-gfm-syntax';            -- syntax highlighting for Git-Flavored Markdown

  ---- query languages
  'neo4j-contrib/cypher-vim-syntax'; -- cypher (Neo4j)

  ---- Raku (aka Perl 6)
  'Raku/vim-raku';


  -- eye candy
  'ribru17/bamboo.nvim';             -- colorscheme
  'norcalli/nvim-colorizer.lua';     -- color eye-candy
  'sindrets/diffview.nvim';          -- make diffs prettier
  'WilsonOh/emoji_picker-nvim';      -- emoji UX
  'voldikss/vim-floaterm';           -- terminal eyecandy
  'nvim-lualine/lualine.nvim';       -- status line
  'hiphish/rainbow-delimiters.nvim'; -- rainbow parens


  -- LSP server / linter / formatter / etc
  'hrsh7th/nvim-cmp';                -- completion
  'hrsh7th/cmp-buffer';              -- something for nvim-cmp
  'hrsh7th/cmp-nvim-lsp';            -- "LSP source for nvim-cmp"
  'mfussenegger/nvim-lint';          -- linter
  'neovim/nvim-lspconfig';           -- LSP config
  'arkav/lualine-lsp-progress';      -- show LSP server status in lualine
  'williamboman/mason.nvim';         -- LSP plugins manager
  'nvimtools/none-ls.nvim';          -- customizable language server for LSP … require'null-ls'


  -- meta / dependencies
  'junegunn/fzf';                              -- fuzzy file finder core
  'MunifTanjim/nui.nvim';                      -- UI toolkit; prereq for: package-info
  'nvim-lua/plenary.nvim';                     -- helper functions; prereq for: diffview, gitsigns, memento, startup, data-viewer…
  'nvim-telescope/telescope.nvim';             -- list searcher; prereq for: startup, telescope-import, …
  {'nvim-treesitter/nvim-treesitter',          -- file content parser
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end};
  'nvim-treesitter/nvim-treesitter-refactor';  -- refactor modules
  'nvim-tree/nvim-web-devicons';               -- icon characters; prereq for: alpha-nvim, lualine, nvim-tree
}


-- requring which-key here will allow registration of mappings alongside each plugin's config…
local mappings = require'which-key'


-- alpha config
require'alpha'.setup(require'alpha.themes.startify'.config)


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
vim.cmd [[
  let g:blamer_prefix = '    '
  let g:blamer_show_in_insert_modes = 0
]]
mappings.add({
  {',gb', '<CMD>BlamerToggle<CR>'},
})




-- colorizer config
require 'colorizer'.setup({
  'css';
  'html';
  'javascript';
  'rust';
  'typescript';
}, {
  css    = true;
  css_fn = true;
})


-- Comment config
require('Comment.ft').racket = { '#;%s', '#| %s |#' }
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


-- data-viewer config
require('data-viewer').setup({
  view = {
    float = false,
  },
})


-- easypick config
local easypick = require 'easypick'
easypick.setup({
  pickers = {
    {
      name = 'conflicts',
      command = 'git conflicting',
      previewer = easypick.previewers.file_diff(),
    },
  }
})
mappings.add({
  {',cc', '<CMD>Easypick conflicts<CR>', desc='git merge conflict resolver UX'},
})


-- vim-emoji-ab config
vim.cmd [[
  au FileType html,php,markdown,mmd,text,mail,gitcommit runtime macros/emoji-ab.vim
]]


-- emoji_picker setup
require('emoji_picker').setup()
mappings.add{
  {'<LEADER>e', [[<CMD>s/:\([^:]\+\):/\=gh_emoji#for(submatch(1), submatch(0))/g<CR>]], desc='replace comma-delimited emoji names in current line with the eponymous emoji character', mode='n'},
  {'<LEADER>e', '<CMD>EmojiPicker<CR>', desc='open Emoji picker', mode='i'},
}


-- floaterm config
vim.api.nvim_create_autocmd(
  { 'VimEnter', },
  { command = 'highlight FloatermNC guibg=gray', }
)
mappings.add{
  {'<LEADER>t', '<CMD>FloatermToggle<CR>', desc='open/close floating terminal window'},
  { mode='t',
    {'<LEADER>t', '<CMD>FloatermToggle<CR>',           desc='open/close floating terminal window'},
    {'<C-Space>', [[<C-\><C-n>]],                      desc='exit terminal-insert mode' },
    {'<C-t>',     [[<C-\><C-n><CMD>FloatermNew<CR>]],  desc='new terminal' },
    {'<C-[>',     [[<C-\><C-n><CMD>FloatermPrev<CR>]], desc='previous terminal' },
    {'<C-]>',     [[<C-\><C-n><CMD>FloatermNext<CR>]], desc='next terminal' },
  }
}


-- formatter config
local formatter_util = require 'formatter.util' -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
local linter_biome = function()
  return {
    exe = 'biome',
    stdin = true,
    args = {
      'check',
      '--fix',
      '--config-path',
      './biome.json',
      '--stdin-file-path',
      formatter_util.escape_path(formatter_util.get_current_buffer_file_path()),
    },
    -- TODO show error when biome can't parse the input...
  }
end
local linter_black = function()
  return {
    exe = 'black',
    stdin = true,
    args = {
      '-', -- explicitly tell it to read from stdin
      '--stdin-filename',
      formatter_util.escape_path(formatter_util.get_current_buffer_file_path()),
    },
  }
end
require('formatter').setup {
  logging = true, -- Enable or disable logging
  log_level = vim.log.levels.WARN, -- Set the log level
  filetype = { -- All formatter configurations are opt-in
    javascript = { linter_biome },
    javascriptreact = { linter_biome },
    python = { linter_black },
    typescript = { linter_biome },
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  }
}
mappings.add{
  -- TODO would be nice if this also ran diagnostics???
  {',f', 'mm<CMD>Format<CR>`m', desc='reformat current buffer (using formatter.nvim)'},
}


-- fugitive (Git) config
mappings.add{
  {',g', group='git'},
  {',ga', ':Git commit --amend', desc='amend git commit',  prefix=',g', silent=false},
  {',gc', '<CMD>Git commit<CR>', desc='git commit',        prefix=',g'},
  {',gg', '<CMD>silent Git<CR>', desc='show status window',prefix=',g'},
  {',gl', '<CMD>Git lg<CR>',     desc='show git log',      prefix=',g'},
  {',gp', ':Git push',           desc='git push',          prefix=',g', silent=false},
  {',gP', ':Git push --force',   desc='git force push',    prefix=',g', silent=false},
}


-- illuminate config
require('illuminate').configure{
  delay = 1313,
  disable_keymaps = true,
  large_file_overrides = true,
  min_count_to_highlight = 1,
  under_cursor = false,
} -- still doesn't highlight table key(??)s in Lua...
mappings.add{
  {',h', function() require'illuminate'.toggle() end, desc='toggle the Highlighting of all instances (or pair) of hovered word'}
}


-- fzf-lua config
require('fzf-lua').setup{
  defaults = {
    formatter = 'path.filename_first', -- doesn't work for live_grep_native 😞
    2, -- https://github.com/ibhagwan/fzf-lua/issues/1585#issuecomment-2550882405 ??
  },
  live_grep_native = {
    formatter = 'path.dirname_first', -- https://github.com/ibhagwan/fzf-lua/issues/1362#issuecomment-2256360989
  },
}
mappings.add{
  {'<LEADER>\\',      function() require'fzf-lua'.buffers() end,          desc='fuzzy-find filepath, of all open buffers'},
  {',r',              function() require'fzf-lua'.live_grep_native() end, desc='fuzzy-find string (i.e. gRep), within files in project'},
  {',R',              function() require'fzf-lua'.resume() end,           desc='Resume the last fuzzy-find'},
  {'<C-p>',           function() require'fzf-lua'.files() end,            desc='fuzzy-find all Paths-with-filenames, within files in project'},
  {'<C-s>',           function() require'fzf-lua'.grep_cword() end,       desc='fuzzy-find word under curSor, within files in project'}, -- h/t https://robots.thoughtbot.com/faster-grepping-in-vim
  {'<C-s>', mode='v', function() require'fzf-lua'.grep_visual() end,      desc='fuzzy-find visual Selection, within files in project'},  -- h/t https://robots.thoughtbot.com/faster-grepping-in-vim
  {'<C-x><C-f>', mode={'n','i','v'}, function() require'fzf-lua'.complete_path() end, desc='fuzzy complete-path to file in project'}, -- TODO this is always relative to project root, can it be relative to current buffer's file??
}


-- gitlinker config
require('gitlinker').setup {
  mappings = nil,
}
mappings.add{
  {',gu',           function () require'gitlinker'.get_buf_range_url('n') end, desc='Github permalink Url to current line'},
  {',gu', mode='v', function () require'gitlinker'.get_buf_range_url('v') end, desc='Github permalink Url to selection'},
}


-- gitsigns config
require('gitsigns').setup{
  word_diff = true,
}
mappings.add({
  {'<LEADER>i', function() require"gitsigns".toggle_word_diff() end,  desc='toggle git Diff to show in-line edits'},
  {'gj',        function() require"gitsigns.actions".next_hunk() end, desc='jump to modified hunk below cursor position'},
  {'gk',        function() require"gitsigns.actions".prev_hunk() end, desc='jump to modified hunk above cursor position'},
  {'gu',        function() require"gitsigns".reset_hunk() end,        desc='undo hunk modification at cursor position'},
})


-- gp config
require('gp').setup {
  openai_api_key = os.getenv('OPENAI_API_KEY'), -- TODO error if not found...
}


-- lexima config
vim.cmd [[
  " javascript
  call lexima#add_rule({ 'char': '=', 'at': ')\%#'   , 'input': ' => ',                                     'filetype': ['javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact'] })
  call lexima#add_rule({ 'char': '{', 'at': ')\%#'   , 'input': ' => {',                'input_after': '}', 'filetype': ['javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact'] })
  call lexima#add_rule({ 'char': '(', 'at': 'cl\%#'  , 'input': '<BS><BS>console.log(', 'input_after': ')', 'filetype': ['javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact'] })
  " lisps
  call lexima#add_rule({ 'char': "'", 'filetype': ['lisp', 'scheme', 'racket']})
  call lexima#add_rule({ 'char': '`', 'filetype': ['lisp', 'scheme', 'racket']})
]]


-- mini.ai setup
require('mini.ai').setup()


-- lint config
require('lint').linters_by_ft = {
  javascript = {'biomejs'},
  javascriptreact = {'biomejs'},
}
mappings.add({
  {',l', function () require('lint').try_lint() end, desc='run Linter'},
})


-- lsp config
local lspc = require'lspconfig'
local lsp_defaults = lspc.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())
lspc.bashls.setup{}
lspc.cssls.setup{}
lspc.cucumber_language_server.setup{}
lspc.eslint.setup{} -- ni -g vscode-langservers-extracted
lspc.graphql.setup{}
lspc.html.setup{}
lspc.jsonls.setup{}
lspc.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
-- lspc.raku_navigator.setup{}
lspc.superhtml.setup {
  filetypes = { 'html' }
}
lspc.ts_ls.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "svelte" },
  cmd = { "typescript-language-server", "--stdio" }
}
-- Svelte tweaks, h/t @TGlide https://github.com/TGlide/nvim-config/blob/39eaf5706c8d/lua/thomasgen/lazy/lsp.lua#L105-L110
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.workspace.didChangeWatchedFiles = false
lspc.svelte.setup {
  capabilities = lsp_capabilities
}


local null_ls = require("null-ls")
local markdownlint = { -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/db09b6c691def00/README.md#parsing-cli-program-output
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "markdown" },
  -- null_ls.generator creates an async source that spawns the command with the given arguments and options
  generator = null_ls.generator({
    command = "markdownlint",
    args = { "--stdin" },
    to_stdin = true,
    from_stderr = true,
    -- choose an output format (raw, json, or line)
    format = "line",
    check_exit_code = function(code, stderr)
      local success = code <= 1
      if not success then
        -- can be noisy for things that run often (e.g. diagnostics), but can be useful for things that run on demand (e.g. formatting)
        print(stderr)
      end
      return success
    end,
    -- use helpers to parse the output from string matchers, or parse it manually with a function
    on_output = require("null-ls.helpers").diagnostics.from_patterns({
      {
        pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
        groups = { "row", "col", "message" },
      },
      {
        pattern = [[:(%d+) [%w-/]+ (.*)]],
        groups = { "row", "message" },
      },
    }),
  }),
}
null_ls.register(markdownlint)


-- lualine config
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return " 🔴  Recording @" .. recording_register
  end
end
require'lualine'.setup{
  options = {
    component_separators = {'…', '…'},
    globalstatus = true, -- one-line "global status line"
    icons_enabled = true,
    -- section_separators = '',
    theme = 'bamboo',
  },
  extensions = {
    'nvim-tree'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename', {'macro-recording', fmt=show_macro_recording}, 'lsp_progress'},
    lualine_c = {'searchcount'},
    lualine_x = {'diagnostics'},
    lualine_y = {'branch', 'filetype'},
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


-- mason config
require('mason').setup()


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


-- quicker config
local q = require'quicker'
local expand_opts = { before = 2, after = 2, add_to_existing = true }
q.setup{
  keys = {
    { '>', function() q.expand(expand_opts) end, desc = 'expand quickfix context', },
    { '<', function() q.collapse() end,          desc = 'collapse quickfix context', },
  },
}


-- rooter config
vim.cmd [[
  let g:rooter_patterns = ['.git', '.editorconfig']
]]


-- telescope-import
require("telescope").setup({
  extensions = {
    import = {
      -- Add imports to the top of the file keeping the cursor in place
      insert_at_top = true,
    },
  },
})
local git_hunks = function() -- h/t Peter Gundel https://www.petergundel.de/git/neovim/telescope/2023/03/22/git-jump-in-neovim-with-telescope.html
  require("telescope.pickers").new({
    finder = require("telescope.finders").new_oneshot_job({ "git", "jump", "--stdout", "diff" }, {
      entry_maker = function(line)
        local filename, lnum_string = line:match("([^:]+):(%d+).*")
        if filename:match("^/dev/null") then -- I couldn't find a way to use grep in new_oneshot_job so we have to filter here.
          return nil                         -- return nil if filename is /dev/null because this means the file was deleted.
        end
        return {
          value = filename,
          display = line,
          ordinal = line,
          filename = filename,
          lnum = tonumber(lnum_string),
        }
      end,
    }),
    sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
    previewer = require("telescope.config").values.grep_previewer({}),
    results_title = "Git hunks",
    prompt_title = "Git hunks",
    layout_strategy = "flex",
  }, {}):find()
end
-- TODO add one for git conflicts...
mappings.add{
  {'<LEADER>gh', git_hunks, {}}
}


-- template-string config
require('template-string').setup {
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'python',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  },
}


-- tiny-inline-diagnostic config
require('tiny-inline-diagnostic').setup {
  blend = {
    factor = 0.4,
  },
}



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
mappings.add({
  {'<LEADER><TAB>', '<CMD>NvimTreeToggle<CR>', desc='toggle NvimTree' },
})


-- treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'awk',
    'bash',
    'clojure',
    'comment',
    'commonlisp',
    'css',
    'csv',
    'dockerfile',
    'elixir',
    'erlang',
    'go',
    'graphql',
    'html',
    'java',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown_inline',
    'perl',
    'php',
    'python',
    'ruby',
    'rust',
    'scheme',
    'scss',
    'svelte',
    'tsx',
    'typescript',
    'vim',
    'xml',
    'yaml',
    'zig',
  },
  highlight = {
    enable = true,
    disable = function(_lang, bufnr) -- Disable in large buffers
      return vim.api.nvim_buf_line_count(bufnr) > 999999
    end,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 999, -- Do not enable for files with more than n lines, int
  }
}


-- ts-autotag config
require('nvim-ts-autotag').setup()
