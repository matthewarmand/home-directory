syntax on
filetype indent plugin on

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
set updatetime=100            " decrease async update time

" tabstop settings... might want to make this filetype-specific
set expandtab                  " tab key inserts spaces instead of tabs
set tabstop=2                  " tab is 2 spaces
set softtabstop=2              " when hitting <BS> pretend a tab is removed
set shiftwidth=2               " number of spaces to use for autoindent
set smarttab                   " tab to next indent
set ruler                      " show cursor position

set background=dark
colorscheme iceberg            " from https://github.com/cocopon/iceberg.vim
" transparent background
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" Search for highlighted text with //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'python': ['black'],
\  'sh': ['shfmt'],
\}
let g:ale_sh_shfmt_options = '-i 2 -ci'

let g:ale_linters = {
\  'python': ['flake8'],
\  'sh': ['shellcheck'],
\  'dockerfile': ['hadolint'],
\}
let g:ale_dockerfile_hadolint_options = '--ignore DL3006 --ignore DL3008' " this won't work until this gets released: https://github.com/dense-analysis/ale/pull/4353
let g:ale_python_flake8_options = '--append-config /home/matt/.flake8'

augroup filetype_env_settings
  autocmd!
  au BufNewFile,BufRead .env* let b:ale_sh_shellcheck_options = '--exclude SC2034'
  au BufNewFile,BufRead .env.tmpl setlocal syntax=sh
augroup END

let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_open_list = 1

" autocomplete
let g:ale_completion_enable = 1
set completeopt+=preview
set completeopt+=menuone
set completeopt+=noinsert

augroup alefixprewrite
  autocmd!
  au BufWritePre * ALEFix
augroup END

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

set foldlevel=99          " Max so we have granularity when folding

let g:vim_redraw = 1

" Filetype-specific settings
augroup filetype_tab_settings
  autocmd!
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
  au BufNewFile,BufRead $HOME/.config/sway/* setlocal syntax=i3config
augroup END
