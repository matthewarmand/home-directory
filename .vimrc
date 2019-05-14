
" Use vim settings rather than vi
" Must be first because it changes other settings
set nocompatible

" Plugin Management (vim-plug)
call plug#begin('~/.vim/plugged')

Plug 'nvie/vim-flake8'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dermusikman/sonicpi.vim'

call plug#end()

" SonicPi.vim configuration
let g:sonicpi_command = 'sonic-pi-tool'
let g:sonicpi_send = 'eval-stdin'
let g:sonicpi_stop = 'stop'
let g:vim_redraw = 1

" Settings
syntax on
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete

set shell=bash

set showmode
set nowrap

set backspace=indent,eol,start " allow backspacing over everything in insert
set autoindent                 " always autoindent on
set copyindent                 " copy previous indentation on autoindent
set number relativenumber      " show line numbers
set showmatch                  " show matching parens
set ignorecase                 " ignore case when searching
set smartcase                  " ignore case if search is all lowercase
set scrolloff=4                " keep 4 lines of edges of screen
set hlsearch                   " highlight search terms
set incsearch                  " show search matches as you type
set gdefault                   " search/replace globally by default
set nolist                     " show whitespace by default
set mouse=a                    " enable mouse if terminal supports
set paste

set fileformats="unix,dos,mac"

set autoread                   " automatically reload files changed

set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50

" Editor layout
set termencoding=utf-8
set encoding=utf-8
set lazyredraw              " don't update display while macro executing
set laststatus=2            " always put a status line in
set cmdheight=2             " use status bar 2 rows high

" Vim behavior
set hidden             " hide buffers instead of closing them
                       "    current buffer can go bg without being
                       "    written, and undo history preserved
set switchbuf=useopen  " reveal already opened files from quickfix
set history=1000
set undolevels=1000

set nobackup
set noswapfile

set wildmenu
set wildmode=list:full

set noerrorbells
set showcmd

set nomodeline

" tabstop settings... might want to make this filetype-specific
set expandtab                  " tab key inserts spaces instead of tabs
set tabstop=2                  " tab is 2 spaces
set softtabstop=2              " when hitting <BS> pretend a tab is removed
set shiftwidth=2               " number of spaces to use for autoindent
set smarttab                   " tab to next indent
set ruler                      " show cursor position

colorscheme obsidian

" On-Event scripts

" trim trailing whitespace on write
autocmd BufWritePre * %s/\s\+$//e
" lint Python files on write
autocmd BufWritePre *.py call Flake8()

