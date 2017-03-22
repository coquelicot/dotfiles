" Author: fcrh
" Email: coquelicot1117@gmail.com
" Last Modified: 2017/03/22

" Vundle -------------------------------------------------------------

" Start
filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'majutsushi/tagbar'

" End
call vundle#end()
filetype plugin indent on


" Basic setting ------------------------------------------------------

syntax on
colorscheme elflord

set exrc
set modeline

set number
set ruler
set showcmd
set cursorline

set backspace=2

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set scrolloff=5

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set copyindent

set foldmarker={{{,}}}
set foldmethod=marker

set mouse=a

set wildmenu
set wildignore=*.swp,*un~,*.o,*.pyc,*.class

set title

set hidden
set confirm

set backup
set undofile
set backupcopy=yes

set lazyredraw

" For Unix and Win32, if a directory ends in two path separators "//" or "\\", 
" the swap file name will be built from the complete path to the file with all
" path separators substituted to percent '%' signs. This will ensure file name
" uniqueness in the preserve directory.
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//


" Mapping ------------------------------------------------------------

nnoremap \s :shell<CR>
nnoremap \p :!python<CR>

" NERDTree required
nnoremap \f :NERDTreeFocus<CR>

" Tagbar required
nnoremap \t :TagbarToggle<CR>

" get rid of highlight search
nnoremap \\ :nohlsearch<CR>

" reselect
vnoremap > >gv
vnoremap < <gv

nnoremap ; :

" move to next/previous row instead of line
nnoremap j gj
nnoremap k gk

" tab helper
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>

" clear screen
nnoremap \l :redraw!<CR>


" https://github.com/peter50216/dotfiles/blob/master/config/vimrc
inoremap jk <ESC>
nnoremap ^ 0
nnoremap 0 ^
vnoremap ^ 0
vnoremap 0 ^


" Specialization -----------------------------------------------------

" c,cpp
autocmd FileType c,cpp nnoremap \r :!./%<<CR>
autocmd Filetype c,cpp set cin
autocmd Filetype c,cpp set makeprg=g++\ -O2\ -std=c++11\ %\ -o\ %<

" script
autocmd Filetype python,ruby,sh nnoremap \r :!./%<CR>

" makefile
autocmd Filetype make set noexpandtab

" html,css,js
autocmd Filetype htmldjango,html,css,javascript set shiftwidth=2
autocmd Filetype htmldjango,html,css,javascript set tabstop=2
autocmd Filetype htmldjango,html,css,javascript set softtabstop=2


" Setup backup/undo dir ----------------------------------------------

function CreateDirs(dirs)
    for dir in split(a:dirs, ',')
        if isdirectory(dir) == 0
            echo "Creating dir: " . dir
            call mkdir(dir, 'p')
        endif
    endfor
endfunction

call CreateDirs(&backupdir)
call CreateDirs(&undodir)


" Syntastic required -------------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" eslint required
let g:syntastic_javascript_checkers = ['eslint']


" Load local config --------------------------------------------------

function ReadRCOnPath(target_path)
    let current_path = ''
    for dir in split(a:target_path, '/')
        let current_path = current_path . '/' . dir
        let file = current_path . '/' . '.vimrc.local'
        if filereadable(file) && empty(matchstr(getfperm(file), '^r.-.--.--$')) == 0
            execute 'source ' . file
        endif
    endfor
endfunction
call ReadRCOnPath(getcwd())
