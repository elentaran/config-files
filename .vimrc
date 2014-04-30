""""""""""""""""""""""""""""""""""""""""""""
"	Config File VIM Arpad Rimmel	   "
""""""""""""""""""""""""""""""""""""""""""""

" Assign F keys to unable/disable the spellchecker
map <F5> <ESC>:setlocal spell spelllang=en_us<RETURN>
map <F6> <ESC>:setlocal spell spelllang=fr<RETURN>
map <F8> <ESC>:setlocal nospell<return>

" Assign keys to create and navigate through tab
map <C-T> <ESC>:tabedit<CR>
map <C-L> <ESC>:tabnext<CR>
map <C-H> <ESC>:tabprevious<CR>

nmap ,v :edit $MYVIMRC<CR>
nmap ,s :source $MYVIMRC<CR>


" Assign keys for the navigation
map <C-J> <C-D>
map <C-K> <C-U>

" Assign key to save the file
map S :w<CR>

" Assign ESC on more accesible keys
imap jk <ESC>
imap kj <ESC>
imap <C-X> <ESC>

" case sensitive search only when there is a capital letter
set ignorecase 
set smartcase

" incremental search
set incsearch
set magic                   " regexp when search

" scroll 3 lines before reaching the end of the screen
set scrolloff=3

" go back to the right colon with a mark
nnoremap ' `
nnoremap ` '

" autocomplete in a more useful way
set wildmode=longest,list

" Indentation
set autoindent
set smartindent
set tabstop=4
set softtabstop=4              " number of spaces while editing
set shiftwidth=4
set expandtab

" set cursor to last known position when opening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
       \| exe "normal! g'\"" | endif
endif

" option for Vundle (bundle manager)
" commands:
"   BundleList (list configured packages)
"   BundleInstall (install uninstalled packages from the list)
"   BundleUpdate (check for updates and install them)
"   BundleClean (remove unused packages)
set nocompatible
filetype off
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" list of bundles
Bundle 'gmarik/vundle'      
Bundle 'Valloric/YouCompleteMe'
Bundle 'screen.vim'
Bundle 'Vim-R-plugin'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" option vim for vim-r-plugin
syntax enable
" let vimrplugin_screenplugin = 0
let vimrplugin_tmux = 0
let maplocalleader = "!"


" Octave syntax 
augroup filetypedetect 
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave 
augroup END 

" option for YouCompleteMe
set completeopt-=preview
let ycm_confirm_extra_conf = 0
