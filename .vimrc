" -------------------------------------------------------------------------------------------------
" .vimrc configurations moved into .vim/vimrc to keep under version control
" .vimrc file runs .vim/vimrc at runtime:
" ~$ cat .vimrc -> runtime vimrc
"
" --------------------------------------------------------------------------------------------------

" --------------------------------------------------------------------------------------------------
" Plugins
" --------------------------------------------------------------------------------------------------

" Vundle setup: (https://github.com/VundleVim/Vundle.vim)
set nocompatible " required
filetype off " required
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle
call vundle#begin() " initialize Vundle

Plugin 'VundleVim/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'

" Ultisnips configuration. Must remain before vundle#end
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

call vundle#end() " required
filetype plugin indent on

" Command-T configuration
let g:CommandTTraverseSCM = 'pwd' " set file directory to present working directory (default setting
" looks for a git directory, which causes issues when working in large, shared repos (GO repo)

" Gitgutter. Reduce updatetime so that git-gutter moves faster
set updatetime=250

" --------------------------------------------------------------------------------------------------
" Colors
" --------------------------------------------------------------------------------------------------

" colorscheme gruvbox
set background=dark
highlight FoldColumn guifg='#282828' guibg='#282828'
hi ColorColumn ctermbg='235'
let &colorcolumn=join(range(101,999),",") " add light gray color column from line 101 on

" --------------------------------------------------------------------------------------------------
" Appearance
" --------------------------------------------------------------------------------------------------

syntax enable " enable syntax highlighting
let g:netrw_liststyle=3 " show editor in tree mode
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar
set laststatus=2 " always show statusline
set list " show trailing whitespace
set listchars=tab:▸\ ,trail:▫ " characters for showing trailing whitespace
set number " show line numbers
set ruler " show where you are
set scrolloff=3 " show context above/below cursorline
set showtabline=2

" --------------------------------------------------------------------------------------------------
" Bells/Alerts
" --------------------------------------------------------------------------------------------------

" disable noises
" http://stackoverflow.com/questions/16047146/disable-bell-in-macvim
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" --------------------------------------------------------------------------------------------------
" Editing Options
" --------------------------------------------------------------------------------------------------

set autoindent
set backspace=2 " Fix broken backspace in some setups
set clipboard=unnamed " yank and paste with the system clipboard
set expandtab " always uses spaces instead of tab characters
set mouse=a " Enable basic mouse behavior such as resizing buffers.
set shiftwidth=2 " size of an "indent"
set softtabstop=2 " insert mode tab and backspace use 2 spaces
set tabstop=2 " size of a hard tabstop
" don't comment out new lines automatically when leaving a commented-out line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r
" formatoptions-=o

"--------------------------------------------------------------------------------------------------
" File Options
"--------------------------------------------------------------------------------------------------

set encoding=utf-8
set autoread " reload files when changed on disk, i.e. via `git checkout`
set directory-=. " don't store swapfiles in the current directory
set ignorecase " case-insensitive search
set incsearch " search as you type
set wildignore+=log " ignore log files
set wildignore+=*.rbc " ignore rbc files
set wildignore+=**/tmp " ignore tmp folder
set wildignore+=**/bundle " ignores vim bundles
set wildignore+=**/node_modules " ignores node_modules
" wildmenu and wildmode show a navigable menu for tab completion
" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu/9511657#9511657
set wildmenu
set wildmode=longest,list,full

"--------------------------------------------------------------------------------------------------
" Custom Key Mappings
" --------------------------------------------------------------------------------------------------

let mapleader = ',' " use ',' as <leader> key
" ,, to go to last file
map <leader><leader> <c-^>
" toggle NERDTree
map ntc :NERDTreeToggle<cr>

" --------------------------------------------------------------------------------------------------
" Custom Functions
" --------------------------------------------------------------------------------------------------

" trim trailing whitespace
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
    %s/\s\+$//e
      call setpos('.', l:save_cursor)
      endfun
      " call TrimWhiteSpace on file write
      autocmd BufWritePre * :call TrimWhitespace()

" --------------------------------------------------------------------------------------------------
" Notes
" --------------------------------------------------------------------------------------------------

" to reset netrw working directory: :Ntree [directory name] to reset netrw directory
