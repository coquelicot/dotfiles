" Author: fcrh
" Email: coquelicot1117@gmail.com
" Last Modified: 2016/10/28

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

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set copyindent
set smartindent

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

" For Unix and Win32, if a directory ends in two path separators "//" or "\\", 
" the swap file name will be built from the complete path to the file with all
" path separators substituted to percent '%' signs. This will ensure file name
" uniqueness in the preserve directory.
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//


" Mapping ------------------------------------------------------------

nmap \s :shell<CR>
nmap \p :!python<CR>

" reselect
vmap > >gv
vmap < <gv

nmap ; :

" move to next/previous row instead of line
nmap j gj
nmap k gk


" https://github.com/peter50216/dotfiles/blob/master/config/vimrc
imap jk <ESC>
nmap ^ 0
nmap 0 ^
vmap ^ 0
vmap 0 ^


" Specialization -----------------------------------------------------

" c,cpp
autocmd FileType c,cpp nmap \r :!./%<<CR>
autocmd Filetype c,cpp set cin
autocmd Filetype c,cpp set makeprg=g++\ -O2\ -std=c++11\ %\ -o\ %<

" script
autocmd Filetype python,ruby,sh nmap \r :!./%<CR>

" makefile
autocmd Filetype make set noexpandtab

" html,css,js
autocmd Filetype html,css,javascript set shiftwidth=2
autocmd Filetype html,css,javascript set tabstop=2
autocmd Filetype html,css,javascript set softtabstop=2


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
