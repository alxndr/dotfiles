" based on https://github.com/hrsh7th/nvim-cmp/blob/614e00d/utils/vimrc.vim

if has('vim_starting')
  set encoding=utf-8
endif
scriptencoding utf-8

if &compatible
  set nocompatible
endif

" set up Plug
let s:plug_dir = expand('/tmp/plugged/vim-plug')
if !filereadable(s:plug_dir .. '/plug.vim')
  execute printf('!curl -fLo %s/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', s:plug_dir)
end
execute 'set runtimepath+=' . s:plug_dir
" specify plugins
call plug#begin(s:plug_dir)
	Plug 'vuki656/package-info.nvim'
	Plug 'MunifTanjim/nui.nvim'
call plug#end()
PlugInstall | quit
