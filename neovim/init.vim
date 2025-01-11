" --- Plugin Management (using vim-plug) ---
call plug#begin('~/.vim/plugged')
" GitHub Management
Plug 'tpope/vim-fugitive'
" Go Development
" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Language Server Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Navigation
Plug 'preservim/nerdtree'

" Colorscheme (Let's say we chose gruvbox)
Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }

call plug#end()

" --- Plugin Configurations ---

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


" coc.nvim
" Use <tab> for completion, but also cycle through snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
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

" custom mapping
map <c-s> :w<CR>
map <c-q> :q<CR>
map <\> <leader>
map <leader>g :Git<CR>
map <leader>q :qa!<CR>

" In your init.vim

" Install the markdown parser
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "markdown" }, 
  auto_install = true,
  highlight = { enable = true },
}
EOF

" Alternative (if you have nvim-treesitter installed):
"TSInstall markdown

" Enable syntax highlighting (if not enabled globally)
syntax on
