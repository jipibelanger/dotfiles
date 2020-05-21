" Plugin manager settings  -------------------------------------------------{{{
set nocompatible
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Plugins
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('mhinz/vim-signify')
  call dein#add('Vigemus/iron.nvim')
  call dein#add('w0rp/ale')
  call dein#add('scrooloose/nerdtree')
  call dein#add('ncm2/ncm2')
  call dein#add('roxma/nvim-yarp')
  call dein#add('ncm2/ncm2-tmux')
  call dein#add('ncm2/ncm2-path')
  call dein#add('ncm2/ncm2-jedi', {'on_ft': ['python']})
  call dein#add('ncm2/ncm2-pyclang', {'on_ft': ['c', 'cpp']})
  call dein#add('ncm2/ncm2-racer', {'on_ft': ['rust']})
  call dein#add('vimscript/toml', {'on_ft': ['toml']})

  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on    " required

" }}}

" Basic settings  ----------------------------------------------------------{{{
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype
set number                " Display line numbers
set relativenumber        " Display relative line numbers
set background=dark       " We are using dark background in vim
set title                 " show title in console title bar
set wildmenu              " Menu completion in command mode on <Tab>
set wildmode=full         " <Tab> cycles between all matching choices.
set t_Co=256              " Force terminal colors to 256
set enc=utf-8             " utf-8 encoding
set hlsearch              " highlight search results
set foldnestmax=1         " fold only one level by default

""" Moving Around/Editing
set pastetoggle=<F3>      " paste mode to preserve indentation
set cursorline            " have a line indicate the cursor location
set ruler                 " show the cursor position all the time
set nostartofline         " Avoid moving cursor to BOL when jumping around
set virtualedit=block     " Let cursor move past the last char in <C-v> mode
set scrolloff=3           " Keep 3 context lines above and below the cursor
set backspace=2           " Allow backspacing over autoindent, EOL, and BOL
set showmatch             " Briefly jump to a paren once it's balanced
set wrap                  " Wrap text
set linebreak             " don't wrap textin the middle of a word
set autoindent            " always set autoindenting on
set cindent               " use smart indent if there is no indent file
set tabstop=2             " <tab> inserts 2 spaces
set shiftwidth=2          " but an indent level is 2 spaces wide.
set softtabstop=2         " <BS> over an autoindent deletes spaces.
set expandtab             " Use spaces, not tabs, for autoindent/tab key.
set shiftround            " rounds indent to a multiple of shiftwidth
set formatoptions=tcroql  " Setting text and comment formatting to auto
set colorcolumn=80        " Show colored column at 80 characters
set splitbelow            " Vertical splits open below current editor
set splitright            " Horizontal splits open to the right of the current editor

""" Messages, Info, Status
set laststatus=2          " always show status line
set showcmd               " Show incomplete normal mode commands as I type.
set report=0              " : commands always print changed line count.
set shortmess+=a          " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                 " Show some info, even without statuslines.
set laststatus=2          " Always show statusline, even if only 1 window.

""" Do not create swapfile/backup files
set nowritebackup
set nobackup
set noswapfile

" }}}

" Custom key maps  ---------------------------------------------------------{{{
let mapleader=","
let maplocalleader=",,"

" Paste from clipboard
noremap <leader>p "+p
noremap <leader>y "+y

" ctrl-hjkl navigates the splits
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" ctrl-hjkl navigates the splits in terminal mode
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <Esc> <C-\><C-n>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" Disable ex mode
nnoremap Q <nop>

" jk to escape insert mode
inoremap jk <esc>
inoremap <esc> <nop>

" keymap edit/source vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" folds keymaps
nnoremap <silent> <F6> :set foldmethod=indent<CR>
nnoremap <silent> <F8> :setlocal foldnestmax=2<CR>

" tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" toggle background dark/light
call togglebg#map("<F7>")

" }}}

" Color scheme -------------------------------------------------------------{{{

" match the git-gutter line to the color of the number line background
function! MatchSignColumnToNbrLine() abort
  if &background == "dark"
    highlight SignColumn ctermbg=Black
  else
    highlight SignColumn ctermbg=LightGray
  endif
endfunction

augroup MyColors autocmd!
    autocmd ColorScheme * call MatchSignColumnToNbrLine()
augroup END

colorscheme solarized

" }}}

" Autocommands  ------------------------------------------------------------{{{
" Close the documentation window when completion is done
autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Enter terminal buffer in insert mode
augroup terminal_commands
  au!
  au BufEnter * if &buftype == 'terminal' | startinsert | endif
augroup END

" No line numbers in terminal buffer
au TermOpen * setlocal nonumber norelativenumber

" Fold vimrc on markers
augroup vimrc_comment_folding
  au!
  au FileType vim
    \   setlocal foldmethod=marker " vimrc folds
    \ | setlocal foldlevel=0
augroup END

" }}}

" Plugin configurations  ---------------------------------------------------{{{
" pyenv configs
let g:python3_host_prog = expand("~/.pyenv/versions/base/bin/python")

" vim-markdown
let g:vim_markdown_frontmatter = 1

" iron.nvim
noremap <leader>! :IronPromptRepl<CR>
noremap <leader>$ :IronRepl<CR>
luafile $HOME/.config/nvim/ironconfig.lua

" airline
let g:airline_powerline_fonts = 1

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}
let g:ale_completion_enabled = 0

" NERDTree
nnoremap <silent> <F2> :NERDTree<CR>

" merlin
augroup opam_merlin_setup
  au!
  au FileType ocaml
    \ let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
    \ | execute "set rtp+=" . g:opamshare . "/merlin/vim"
augroup END

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

"ncm2-pyclang
let g:ncm2_pyclang#library_path = '/home/linuxbrew/.linuxbrew/opt/llvm/lib/libclang.so.9'
autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>

" }}}
