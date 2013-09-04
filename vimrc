""""""""""""""""""""""""""
" MY FUNCTIONS
""""""""""""""""""""""""""
" Creation files
so $HOME/vimfiles/vimScripts/python

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" unmap home row keys to force motion use
noremap h <NOP>
noremap j <NOP>
noremap k <NOP>
noremap l <NOP>
""""""""""""""""""""""""""
" VUNDLE
""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/vimfiles/bundle/vundle/
call vundle#rc('$HOME/vimfiles/bundle')

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/pep8'

" Powerline setup
set guifont=DejaVu+Sans+Mono+for+Powerline

filetype off
syntax on
filetype plugin indent on
""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""
set autoread
let mapleader=","
let g:mapleader=","

" always show statusbar, even if no buffer loaded
set laststatus=2

""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""
set ruler
set incsearch
set hlsearch
set mat=2
set showmatch

" Show line numbers
set nu

" remember info about buffers on close
set viminfo^=%

" smart indent
set si
" auto indent
set ai
" wrap lines
set wrap
""""""""""""""""""""""""""
" GUI
""""""""""""""""""""""""""
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

""""""""""""""""""""""""""
" COLOURS
""""""""""""""""""""""""""
" enable syntax highlighting
syntax enable

" dark background
colors koehler

set encoding=utf8

set ffs=unix,dos,mac

""""""""""""""""""""""""""
" BINDS: INTERFACE
""""""""""""""""""""""""""

" maps space to search
map <space> /

" Maps ctrl-space to backwards-search
map <c-space> ?

" Maps go-to-line-beginning to go to the first non-whitespace character
" good for Python usage
map 0 ^

" bundle maps
map <F2> :NERDTreeToggler
" binds f11 to fullscreen dll mode
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)r

""""""""""""""""""""""""""
" BINDS: FILE
""""""""""""""""""""""""""

map <c-s> <ESC>:w!

""""""""""""""""""""""""""
" PYTHON
""""""""""""""""""""""""""

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
""""""""""""""""""""""""""
" DEFAULT
""""""""""""""""""""""""""

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END
