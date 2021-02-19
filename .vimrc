"really neads refactoring but gets my job done 
set number
syntax on
set tabstop=2
set autoindent
set softtabstop=2
set cursorline
set mouse=a

nnoremap <c-o> :w<cr>

execute pathogen#infect()
filetype plugin indent on
let g:solarized_termcolors=256
packadd! dracula
syntax enable
colorscheme dracula

call pathogen#infect()
filetype plugin indent on

call plug#begin()

Plug 'morhetz/gruvbox' "intellij color scheme
Plug 'othree/yajs.vim' "JS syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim' "search
Plug 'frazrepo/vim-rainbow'
Plug 'moll/vim-node'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }


call plug#end()

"NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

"Fit Gutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
set signcolumn=yes
nmap ]h <Plug>(GitGutterNextHunk) "same as default
nmap [h <Plug>(GitGutterPrevHunk) "same as default
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

"vim-airline
let g:airline_powerline_fonts = 1

"rainbow
let g:rainbow_active = 1

colorscheme gruvbox
