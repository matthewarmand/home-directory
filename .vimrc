let python_highlight_all=1
syntax on
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete

set shell=/usr/bin/zsh

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

colorscheme iceberg            " from https://github.com/cocopon/iceberg.vim
" transparent background
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" Search for highlighted text with //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Plugin Management (vim-plug)
call plug#begin('/home/matt/.vim/plugged')

Plug 'itspriddle/vim-shellcheck', { 'for': ['sh', 'bash'] }
Plug 'mhinz/vim-signify'
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'prettier/vim-prettier', { 'do': 'npm install --production', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'z0mbix/vim-shfmt', { 'for': ['sh', 'bash', 'zsh'] }

call plug#end()
" vim-plug to update plugins: :PlugUpdate

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set foldlevel=99          " Max so we have granularity when folding

let g:vim_redraw = 1

let g:shfmt_extra_args = '-i 2 -ci'

" Filetype-specific settings
augroup filetype_tab_settings
  au BufNewFile,BufRead *.py,*.js setlocal
      \ tabstop=4
      \ softtabstop=4
      \ shiftwidth=4
      \ textwidth=79
      \ expandtab
      \ autoindent
      \ fileformat=unix
augroup END

augroup swayconfig
  autocmd!
  au BufNewFile,BufRead $HOME/.config/sway/* set syntax=i3config
augroup END

" On-Event scripts

" trim trailing whitespace on write
augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END
" format and lint shell scripts on write
augroup filetype_shell
  autocmd!
  autocmd FileType sh,bash autocmd BufWritePre <buffer> Shfmt
  autocmd FileType sh,bash autocmd BufWritePre <buffer> execute ':ShellCheck!'
augroup END
" format and lint Python files on write
augroup filetype_python
  autocmd!
  autocmd FileType python autocmd BufWritePre <buffer> execute ':Black'
  autocmd FileType python autocmd BufWritePre <buffer> call Flake8()
augroup END
