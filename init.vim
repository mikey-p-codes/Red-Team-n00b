" --- General Settings ---

set nocompatible              " Use Vim settings, rather than Vi
filetype plugin indent on       " Enable file type detection and plugins
syntax on                     " Enable syntax highlighting
set encoding=utf-8            " Set default encoding to UTF-8

set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight the current line
set showmatch               " Highlight matching brackets

set tabstop=4               " Number of spaces a tab counts for
set shiftwidth=4            " Number of spaces for indent
set expandtab               " Use spaces instead of tabs
set smartindent             " Enable smart indenting

set hlsearch                " Highlight search results
set incsearch               " Show matches as you type
set ignorecase              " Case-insensitive search by default
set smartcase               " Case-sensitive if search contains uppercase

set hidden                  " Allow switching buffers without saving
set nobackup                " No backup files
set nowritebackup           " No backup files while writing
set noswapfile             " No swap files

set updatetime=300          " Time in ms to trigger various events (e.g., CursorHold)

set termguicolors          " Enable 24-bit color support
set background=dark         " Assume a dark background

" --- Plugin Management (using vim-plug) ---

call plug#begin('~/.vim/plugged')
" GitHub Management
Plug 'tpope/vim-fugitive'
" Go Development
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Language Server Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colorscheme (Let's say we chose gruvbox)
Plug 'morhetz/gruvbox'

call plug#end()

" --- Plugin Configurations ---

" Colorscheme
colorscheme gruvbox

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" FZF
map <C-p> :Files<CR>

" vim-go
let g:go_fmt_command = "goimports"  " Use goimports for formatting
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go :silent call go#fmt#Format(0)
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Key mappings for vim-go (examples)
nmap <leader>b :GoBuild<CR>
nmap <leader>r :GoRun<CR>
nmap <leader>t :GoTest<CR>

" coc.nvim
" Use <tab> for completion, but also cycle through snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for triggering completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Go-to definition
nmap <silent> gd <Plug>(coc-definition)
" Go-to type definition
nmap <silent> gD <Plug>(coc-type-definition)
" Go-to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Go-to references
nmap <silent> gr <Plug>(coc-references)