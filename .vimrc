" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'roblillack/vim-bufferlist'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Valloric/YouCompleteMe', { 'do': './install --clang-completer' }
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax on
set number
let mapleader = ","
let g:deoplete#enable_at_startup = 1

" Solarized theme
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NerdTree
nmap <leader>t :NERDTreeToggle<cr>

" Clipboard
set clipboard=unnamedplus

" Neovim-qt Guifont command, to change the font
command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>")
" Set font on start
let g:Guifont="DejaVu Sans Mono for Powerline:h13"

" Buffer list
map <silent> <F3> :call BufferList()<CR>

" Tag list
nmap <F8> :TagbarToggle<CR>

" You complete me
let g:ycm_global_ycm_extra_conf = '/home/iglinchuk/.vim/.ycm_extra_conf.py'
