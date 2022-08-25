vim.g.mapleader = '\\' -- 💪

local keymap = vim.api.nvim_set_keymap
local map = require 'cartographer'
local snap = require 'snap'

-- normal mode
snap.register.map({'n'}, {'<Leader><Leader>'}, snapFindBuffer)
map.n.nore['<Leader><Tab>'] = ':NvimTreeToggle<CR>'
snap.register.map({'n'}, {'<Leader>g'}, snapSearchWithGrep) -- TODO why does this pause before launching??
map.n.nore['<Leader>j'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'
map.n.nore['<Leader>k'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'
map.n.nore['<Leader>t'] = ':FloatermToggle<CR>'
map.n.nore['<Leader>u'] = ':lua require"gitsigns".reset_hunk()<CR>'
map.n.nore['<Leader>v'] = ':edit $MYVIMRC<CR>' -- h/t roryokane https://lobste.rs/s/6qp0vo#c_fu9psh
map.n.nore['<Leader>vf'] = ':edit ~/workspace/dotfiles/nvim/lua/functions.lua<CR>'
map.n.nore['<Leader>vm'] = ':edit ~/workspace/dotfiles/nvim/lua/mappings.lua<CR>'
map.n.nore['<Leader>vo'] = ':edit ~/workspace/dotfiles/nvim/lua/options.lua<CR>'
map.n.nore['<Leader>vp'] = ':edit ~/workspace/dotfiles/nvim/lua/plugins.lua<CR>'
map.n.nore['<Leader>w'] = ':set list!<CR>'
map.n.nore['<Leader>y'] = ':only<CR>'
map.n.nore['<Leader>2'] = '/TODO<CR>:nohl<CR>'
map.n.nore['<Space>'] = ':' -- 🙌
map.n.nore['<CR>'] = 'm`o<Esc>``'
map.n.nore['<Tab>'] = '<C-w><C-w>'
map.n.nore[',,'] = 'm`A,<Esc>``j' -- append comma to line and move down
map.n.nore[',;'] = 'm`A;<Esc>``j' -- append semicolon to line and move down
map.n.nore[',b'] = '<CMD>lua require("memento").toggle()<CR>'
map.n.nore[',d'] = '<CMD>lua vim.diagnostic.open_float()<CR>'
map.n.nore[',f'] = 'zcj0/{\\n<CR>:nohl<CR>zz'
map.n.nore[',F'] = ':set foldlevel=0<CR>zozz'
map.n.nore[',ga'] = ':Git commit --amend'
map.n.nore[',gb'] = ':BlamerToggle<CR>'
map.n.nore[',gc'] = ':Git commit<CR>'
--          ,gl   = gh-line's gh_line_map (defined in plugins file)
map.n.nore[',gp'] = ':Git push'
map.n.nore[',gP'] = ':Git push --force'
map.n.nore[',gs'] = ':Git<CR>'
keymap('n', ',l', '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', {silent = true})
map.n.nore[',m'] = '/\\v^(\\<|\\||\\=|\\>){7}(.+)?$<CR>:nohl<CR>zz'
map.n.nore[',n'] = ':nohl<CR>'
map.n.nore[',r'] = '<CMD>lua vim.diagnostic.goto_next()<CR>'
map.n.nore[',R'] = '<CMD>lua vim.diagnostic.goto_prev()<CR>'
map.n.nore[',t'] = 'za'
map.n.nore[',vv'] = '<CMD>lua require("package-info").show()<CR>'
map.n.nore[',vu'] = '<CMD>lua require("package-info").change_version()<CR>'
map.n.nore[',w'] = '10<C-w>>'
map.n.nore[',W'] = '5<C-w>+'
map.n.nore['-'] = '<C-x>'
map.n.nore['+'] = '<C-a>'
map.n.nore['=('] = '0=a('
map.n.nore['=)'] = '$=a('
--          gb   = numToStr/Comment.nvim blockwise comment action/toggle
--          gc   = numToStr/Comment.nvim linewise comment action/toggle
map.n.nore['gj'] = ":call search('\\%' . virtcol('.') . 'v\\S', 'W')<CR>" -- h/t kenorb https://vi.stackexchange.com/a/693/67
map.n.nore['gk'] = ":call search('\\%' . virtcol('.') . 'v\\S', 'bW')<CR>" -- h/t kenorb https://vi.stackexchange.com/a/693/67
map.n.nore['H'] = 'zh'
map.n.nore['L'] = 'zl'
map.n.nore['Q'] = ':bd<CR>'
map.n.nore['<S-Down>'] = 'ddp' -- shift current line down
map.n.nore['<S-Up>'] = 'ddkP' -- shift current line up
map.n.nore.expr['<C-d>'] = "(winheight(0)/3).'<C-d>'"
map.n.nore['<C-h>'] = '<C-w>h'
map.n.nore['<C-j>'] = '<C-w>j'
map.n.nore['<C-k>'] = '<C-w>k'
map.n.nore['<C-l>'] = '<C-w>l'
map.n.nore['<C-n>'] = ':cn<CR>' -- next quickfix entry
map.n.nore['<C-w>/'] = '<C-w>|<C-w>_'
snap.register.map({'n'}, {'<C-p>'}, snapFindFile)
map.n['<C-s>'] = 'viw<C-s>' -- grep for word under cursor; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map.n.nore.expr['<C-u>'] = "(winheight(0)/3).'<C-u>'"

-- insert mode
keymap('i', '<Leader>e', '<CMD>EmojiPicker<CR>', {silent=true})
map.i.nore[',,'] = '<Esc>m`A,<Esc>``a' -- append comma to line and return to position
map.i.nore[',;'] = '<Esc>m`A;<Esc>``a' -- append semicolon to line and return to position
map.i.nore['jk'] = '<Esc>'
map.i.nore['kj'] = '<Esc>'
map.i.nore['qq'] = '<Esc>m`gqq``a' -- wrap current line and return to position
map.i.nore['<C-a>'] = [[<Esc>A]] -- append (e.g. to hop over autocompleted characters)
map.i.nore['<C-e>'] = '<Esc><C-e>a' -- preserve `<C-e>` scroll behavior in insert mode
map.i.nore['<C-y>'] = '<Esc><C-y>a' -- preserve `<C-y>` scroll behavior in insert mode
map.i.nore['<S-Down>'] = '<Esc>m`ddp``a' -- shift current line down and return to position
map.i.nore['<S-Up>'] = '<Esc>m`ddkP``a' -- shift current line up and return to position

-- terminal mode
map.t.nore['<Leader>n'] = '<C-\\><C-n>:FloatermNew<CR>'
map.t.nore['<Leader>t'] = '<C-\\><C-n>:FloatermToggle<CR>'
map.t.nore['<Leader>['] = '<C-\\><C-n>:FloatermPrev<CR>'
map.t.nore['<Leader>]'] = '<C-\\><C-n>:FloatermNext<CR>'
map.t.nore['<C-Space>'] = '<C-\\><C-n>'
map.t.nore['<C-t>'] = '<C-\\><C-n>:FloatermToggle<CR>'
map.t.nore['<C-[>'] = '<C-\\><C-n>:FloatermPrev<CR>'
map.t.nore['<C-]>'] = '<C-\\><C-n>:FloatermNext<CR>'

-- visual mode
map.v.nore['<Space>'] = ':' -- 🙌
map.v.nore['<Tab>'] = 'd:vnew<CR>PGddgg' -- extract selection from current file & paste into new buffer
keymap('v', ',l', '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>', {})
--          gb  = numToStr/Comment blockwise comment toggle
--          gc  = numToStr/Comment linewise comment toggle
map.v.nore['L'] = '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>'
map.v.nore['H'] = '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>'
map.v.nore['Y'] = '"+y' -- copy selection to system clipboard
map.v['<C-s>'] = 'y\\g<C-r>"' -- grep for selection using Snap; h/t https://robots.thoughtbot.com/faster-grepping-in-vim
map.v.nore['<S-Down>'] = ":m '>+1<CR>gv=gv" -- shift current line down, h/t https://superuser.com/a/1611268/112856
map.v.nore['<S-Up>']   = ":m '<-2<CR>gv=gv" -- shift current line up, h/t https://superuser.com/a/1611268/112856
