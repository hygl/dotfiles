" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype plugin on

"Powerline
" " set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
" set laststatus=2
set t_Co=256 
" let g:Powerline_symbols = 'unicode'

" allow backspacing over everything in insert mode
"show statusbar always
:set laststatus=2
:set nu
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set paste
"indent as in the emacs
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
" Auto expand tabs to spaces
set expandtab

set ruler
set hlsearch
" keep a copy of last edit
" if this throws errors, make sure the backup dir exists
set backup
set backupdir=~/.vim/backup/
set wildmode=longest,list


" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif
hi Normal ctermbg=none
highlight NonText ctermbg=none
set t_ut=


if has("autocmd")
  filetype plugin indent on
  autocmd FileType text setlocal textwidth=78

" always jump to last edit position when opening a file
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal g`\"" |
       \ endif
endif
" set number
call pathogen#infect()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" syntax enable
"if has('gui_running')
"    set background=dark
"    set guifont=Source\ Code\ Pro\ for\ Powerline:h14
"endif
"let g:onedark_termcolors=256
"colorscheme onedark
colorscheme tomorrow
