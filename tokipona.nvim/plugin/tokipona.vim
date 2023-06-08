" Title:        Toki Pona Sitelen Pilin Converter
" Description:  ...
" Last Change:  ...
" Maintainer:   jan Lesate <alxndr+tokipona.nvim@gmail.com>

if exists("g:loaded_tokipona") " do not load multiple times
 finish
endif
let g:loaded_tokipona = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/tokipona/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 ConvertTP lua require("tokipona").convert()
" command! -nargs=0 ConvertTokiPonaLasinaToEmosi lua require("tokipona").convert()
