call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
" NeoBundle 'jceb/vim-orgmode'
" NeoBundle 'tpope/vim-speeddating'
" Plug 'majutsushi/tagbar'
Plug 'icblnk/vim-wombat-scheme'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'
Plug 'preservim/nerdcommenter'
" Plug 'arakashic/chromatica.nvim'
" NeoBundle 'scrooloose/syntastic'

call plug#end()

" Required:
filetype plugin indent on

syntax on
set number relativenumber
let mapleader = ","
set shiftwidth=4

" theme
set t_Co=256
colorscheme wombat

" Airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" NerdTree
nmap <leader>t :NERDTreeToggle<cr>

" Nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Clipboard
" set clipboard=unnamedplus
set clipboard+=unnamedplus

" FuzzyFinder
nmap <silent> <C-n> :Buffers<CR>
nmap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>

" Silver searcher
let g:ag_working_path_mode="r"

" Tag list
nmap <F8> :TagbarToggle<CR>

" Configure buffers
" This allows buffers to be hidden.
set hidden

"----------------------------------------------------------

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"----------------------------------------------------------
"



" To open a new empty buffer
nmap <C-T> :enew<cr>
" Move to the next buffer
nmap <C-L> :bn<CR>
" Move to the previous buffer
nmap <C-H> :bp<CR>
" Close the current buffer and move to the previous one
nmap <C-Q> :bp <BAR> bd #<CR>

" To open a new tab
nmap <C-A-t> :tabnew<cr>
" Move to the next tab
nmap <C-A-l> :tabn<CR>
" Move to the previous tab
nmap <C-A-h> :tabp<CR>
" Close the current tab
nmap <C-A-q> :tabclose<CR>

" Remap Alt+[hjkl] to jump between windows
if has('nvim')
  :tnoremap <A-h> <C-\><C-n><C-w>h
  :tnoremap <A-j> <C-\><C-n><C-w>j
  :tnoremap <A-k> <C-\><C-n><C-w>k
  :tnoremap <A-l> <C-\><C-n><C-w>l
endif
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
:tnoremap <Esc> <C-\><C-n>
