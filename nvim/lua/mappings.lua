vim.g.mapleader = '\\' -- 💪

-- use j/k to move down/up in a wrap-aware way if appropriate
-- ...using `g<Down|Up>` so as to not conflict with my remapping of `gj`/`gk`...
vim.cmd [[
  noremap <expr> j v:count ? 'j' : 'g<Down>'
  noremap <expr> k v:count ? 'k' : 'g<Up>'
]]

local keymap = vim.api.nvim_set_keymap

local map = require 'cartographer'

-- normal mode
keymap('n', '<Leader><Leader>', '<CMD>lua require"fzf-lua".buffers()<CR>', {})
map.n.nore['<Leader><Tab>'] = '<CMD>NvimTreeToggle<CR>'
map.n.nore['<Leader>;'] = 'm`A;<Esc>``j' -- append semicolon to line and move down
keymap('n','<Leader>a', '<CMD>Alpha<CR>', {})
keymap('n','<Leader>f', '<CMD>Easypick deprank<CR>', {})
keymap('n', '<Leader>g', '<CMD>lua require "fzf-lua".live_grep_native()<CR>', {noremap=true})
keymap('n','<Leader>j', "<CMD>call VerticalSpaceJumpDown()<CR>", {})
keymap('n','<Leader>k', "<CMD>call VerticalSpaceJumpUp()<CR>", {})
map.n.nore['<Leader>t'] = '<CMD>FloatermToggle<CR>'
map.n.nore['<Leader>u'] = '<CMD>lua require"gitsigns".reset_hunk()<CR>'
map.n.nore['<Leader>v'] = '<CMD>edit $MYVIMRC<CR>' -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map.n.nore['<Leader>vf'] = '<CMD>edit ~/workspace/dotfiles/nvim/lua/functions.lua<CR>'
map.n.nore['<Leader>vm'] = '<CMD>edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>'
map.n.nore['<Leader>vo'] = '<CMD>edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>'
map.n.nore['<Leader>vp'] = '<CMD>edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>'
map.n.nore['<Leader>w'] = '<CMD>set list!<CR>'
map.n.nore['<Leader>y'] = '<CMD>only<CR>'
map.n.nore['<Leader>2'] = '/TODO<CR><CMD>nohl<CR>'
map.n.nore['<Space>'] = ':' -- note that this means using <CMD> over : in other mappings, or using noremap
map.n.nore['<CR>'] = 'm`o<Esc>``'
map.n.nore['<Tab>'] = '<C-w><C-w>'
map.n.nore[',,'] = 'm`A,<Esc>``j' -- append comma to line and move down
map.n.nore[',b'] = '<CMD>lua require("memento").toggle()<CR>'
keymap('n', ',c', '<CMD>Easypick conflicts<CR>', {silent = true})
map.n.nore[',d'] = '<CMD>lua vim.diagnostic.open_float()<CR>'
map.n.nore[',f'] = 'zcj0/{\\n<CR><CMD>nohl<CR>zz'
map.n.nore[',F'] = '<CMD>set foldlevel=0<CR>zozz'
map.n.nore[',ga'] = ':Git commit --amend'
map.n.nore[',gb'] = '<CMD>BlamerToggle<CR>'
map.n.nore[',gc'] = '<CMD>Git commit<CR>'
keymap('n', ',gl', '<CMD>Git lg<CR>', {silent = true})
map.n.nore[',gp'] = ':Git push'
map.n.nore[',gP'] = ':Git push --force'
map.n.nore[',gs'] = '<CMD>Git<CR>'
keymap('n', ',l', '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', {silent = true})
map.n.nore[',m'] = '/\\v^(\\<|\\||\\=|\\>){7}(.+)?$<CR><CMD>nohl<CR>zz'
map.n.nore[',n'] = '<CMD>nohl<CR>'
map.n.nore[',r'] = '<CMD>lua vim.diagnostic.goto_next()<CR>'
map.n.nore[',R'] = '<CMD>lua vim.diagnostic.goto_prev()<CR>'
keymap('n', ',s', '<CMD>Git<CR>', {silent = true})
map.n.nore[',t'] = 'za'
map.n.nore[',vv'] = '<CMD>lua require("package-info").show()<CR>'
map.n.nore[',vu'] = '<CMD>lua require("package-info").change_version()<CR>'
map.n.nore[',w'] = '10<C-w>>'
map.n.nore[',W'] = '5<C-w>+'
keymap('n', ':',  '<CMD>set cursorline!<CR><CMD>set cursorcolumn!<CR>', {noremap = true, silent = true})
map.n.nore['-'] = '<C-x>'
map.n.nore['+'] = '<C-a>'
map.n.nore['=('] = '0=a('
map.n.nore['=)'] = '$=a('
--          gb   = numToStr/Comment.nvim blockwise comment action/toggle
--          gc   = numToStr/Comment.nvim linewise comment action/toggle
keymap('n', 'gj', "<CMD>lua vim.schedule(function() require('gitsigns.actions').next_hunk() end)<CR>", {noremap=true})
keymap('n', 'gk', "<CMD>lua vim.schedule(function() require('gitsigns.actions').prev_hunk() end)<CR>", {noremap=true})
map.n.nore['H'] = 'zh'
map.n.nore['L'] = 'zl'
map.n.nore['Q'] = '<CMD>Bdelete<CR>'
map.n.nore['<S-Down>'] = 'ddp' -- shift current line down
map.n.nore['<S-Up>'] = 'ddkP' -- shift current line up
map.n.nore.expr['<C-d>'] = "(winheight(0)/3).'<C-d>'"
map.n.nore['<C-h>'] = '<C-w>h'
map.n.nore['<C-j>'] = '<C-w>j'
map.n.nore['<C-k>'] = '<C-w>k'
map.n.nore['<C-l>'] = '<C-w>l'
map.n.nore['<C-n>'] = '<CMD>cn<CR>' -- next quickfix entry
map.n.nore['<C-w>/'] = '<C-w>|<C-w>_'
keymap('n', '<C-p>', '<CMD>lua require("fzf-lua").files()<CR>', {})
keymap('n', '<C-s>', '<CMD>lua require("fzf-lua").grep_cword()<CR>', {}) -- grep for word under cursor; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map.n.nore.expr['<C-u>'] = "(winheight(0)/3).'<C-u>'"

-- insert mode
keymap('i', '<Leader>e', '<CMD>EmojiPicker<CR>', {silent=true})
map.i.nore['<Leader>;'] = '<Esc>m`A;<Esc>``a' -- append semicolon to line and return to position
map.i.nore[',,'] = '<Esc>m`A,<Esc>``a' -- append comma to line and return to position
map.i.nore['qq'] = '<Esc>m`gqq``a' -- wrap current line and return to position
map.i.nore['<C-a>'] = [[<Esc>A]] -- append (e.g. to hop over autocompleted characters)
vim.api.nvim_set_keymap('i', '<C-d>', '', { callback = function() require'better-digraphs'.digraphs('i') end, desc = 'better-digraphs helper', noremap = true })
map.i.nore['<C-e>'] = '<Esc><C-e>a' -- preserve `<C-e>` scroll behavior in insert mode
map.i.nore['<C-y>'] = '<Esc><C-y>a' -- preserve `<C-y>` scroll behavior in insert mode
map.i.nore['<S-Down>'] = '<Esc>m`ddp``a' -- shift current line down and return to position
map.i.nore['<S-Up>'] = '<Esc>m`ddkP``a' -- shift current line up and return to position

-- terminal mode
map.t.nore['<Leader>n'] = '<C-\\><C-n><CMD>FloatermNew<CR>'
map.t.nore['<Leader>t'] = '<C-\\><C-n><CMD>FloatermToggle<CR>'
map.t.nore['<Leader>['] = '<C-\\><C-n><CMD>FloatermPrev<CR>'
map.t.nore['<Leader>]'] = '<C-\\><C-n><CMD>FloatermNext<CR>'
map.t.nore['<C-Space>'] = '<C-\\><C-n>'
map.t.nore['<C-t>'] = '<C-\\><C-n><CMD>FloatermToggle<CR>'
map.t.nore['<C-[>'] = '<C-\\><C-n><CMD>FloatermPrev<CR>'
map.t.nore['<C-]>'] = '<C-\\><C-n><CMD>FloatermNext<CR>'

-- visual mode
map.v.nore['<Space>'] = ':' -- 🙌
map.v.nore['<Tab>'] = 'd<CMD>vnew<CR>PGddgg' -- extract selection from current file & paste into new buffer
keymap('v', ',l', '', {callback = function() require'gitlinker'.get_buf_range_url('v') end})
keymap('v', ',s', '<CMD>Ray<CR>', {}) -- Share code via ray.so
--          gb  = numToStr/Comment blockwise comment toggle
--          gc  = numToStr/Comment linewise comment toggle
map.v.nore['L'] = '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>'
map.v.nore['H'] = '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>'
map.v.nore['Y'] = '"+y' -- copy selection to system clipboard
keymap('v', '<C-s>', '<CMD>lua require"fzf-lua".grep_visual()<CR>', {}) -- grep for selection; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map.v.nore['<S-Up>']   = "<CMD>move '<-2<CR>" -- shift current line up
map.v.nore['<S-Down>'] = "<CMD>move '>+1<CR>" -- shift current line down
keymap('v', '<Leader>a', ':Tab /', {noremap=true}) -- for *a*lign
