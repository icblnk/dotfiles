call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
" NeoBundle 'jceb/vim-orgmode'
" NeoBundle 'tpope/vim-speeddating'
" Plug 'majutsushi/tagbar'
Plug 'icblnk/vim-wombat-scheme'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'
Plug 'preservim/nerdcommenter'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'mhinz/vim-startify'
" Plug 'mfukar/robotframework-vim'

call plug#end()

" Required:
filetype plugin indent on

syntax on
set number relativenumber
"set cursorline
let mapleader = ","
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set mouse=a

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

" Show trailing spaces, etc.
set list

"----------------------------------------------------------

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

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
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" map to <Leader>cf in C++ code
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
" autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" map to <Leader>cf in Python code
nmap <Leader>cf <Plug>(coc-format)
vmap <Leader>cf <Plug>(coc-format-selected)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

"----------------------------------------------------------
"

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

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
