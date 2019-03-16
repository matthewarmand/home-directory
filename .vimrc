
" Use vim settings rather than vi
" Must be first because it changes other settings
set nocompatible

syntax on
filetype indent plugin on

set shell=bash

set showmode
set nowrap

" tabstop settings... might want to make this filetype-specific
set expandtab                  " tab key inserts spaces instead of tabs
set tabstop=4                  " tab is 4 spaces
set softtabstop=4              " when hitting <BS> pretend a tab is removed
set shiftwidth=4               " number of spaces to use for autoindent
set smarttab                   " tab to next indent

set backspace=indent,eol,start " allow backspacing over everything in insert
set autoindent                 " always autoindent on
set copyindent                 " copy previous indentation on autoindent
set number relativenumber      " show line numbers
set ruler                      " show cursor position
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

colorscheme obsidian

" Plugin Management (vim-plug)
call plug#begin('~/.vim/plugged')

Plug 'nvie/vim-flake8'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

" On-Event scripts

" trim trailing whitespace on write
autocmd BufWritePre * %s/\s\+$//e
" lint Python files on write
autocmd BufWritePre *.py call Flake8()

