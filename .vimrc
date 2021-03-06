" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------

" Vundle setup: (https://github.com/VundleVim/Vundle.vim)
set nocompatible " required
filetype off " required
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle
call vundle#begin() " initialize Vundle

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-fireplace'
Plugin 'nixprime/cpsm'

" Ultisnips configuration. Must remain before vundle#end
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

call vundle#end() " required
filetype plugin indent on

" Command-T configuration
let g:CommandTTraverseSCM = 'pwd' " set file directory to present working
" directory (default setting looks for a git directory, which causes issues
" when working in large, shared repos

" Gitgutter. Reduce updatetime so that git-gutter moves faster
set updatetime=250

" CtrlP configuration
set runtimepath^=~/.vim/bundle/ctrlp.vim
" use custom matcher ("cpsm")
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" set no max limit on the number of files to search in
let g:ctrlp_max_files=0
" let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer=0
" ignore files in .gitignore https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" ------------------------------------------------------------------------------
" Colors
" ------------------------------------------------------------------------------

set background=dark
highlight FoldColumn guifg='#282828' guibg='#282828'
" add light gray color column from line 81 on
hi ColorColumn ctermbg='234'
let &colorcolumn=join(range(81,999),",")
" invert the statusline for non-focused buffers
hi StatusLineNC ctermfg=240 ctermbg=0
" tone down the TablineFill background, match with StatusLineNC
hi TablineFill ctermfg=240
" match VertSplit to TablineFill, unfocused split
hi VertSplit ctermfg=240
" for Command-T, make the highlighted text gruvbox green
hi PmenuSel ctermfg=14

" ------------------------------------------------------------------------------
" CursorLine
" ------------------------------------------------------------------------------

set cursorline
hi Cursor ctermbg=214 guibg=#ffaf00
hi CursorColumn ctermbg=236 guibg=#2c2c2c
hi CursorLine ctermbg=239 guibg=#2c2c2c cterm=none gui=none

" only show cursorline in active buffer
augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" ------------------------------------------------------------------------------
" Appearance
" ------------------------------------------------------------------------------

syntax enable " enable syntax highlighting
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar
set laststatus=2 " always show statusline
set list " show trailing whitespace
set listchars=tab:▸\ ,trail:▫ " characters for showing trailing whitespace
set number " show line numbers
set ruler " show where you are
set scrolloff=3 " show context above/below cursorline
set showtabline=2
set fillchars+=vert:\ " remove char from split bar (note significant whitespace)
" don't remember what this does:
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
" display the last invoked command in the bottom right corner
set showcmd

" ------------------------------------------------------------------------------
" Bells/Alerts
" ------------------------------------------------------------------------------

" disable noises
" http://stackoverflow.com/questions/16047146/disable-bell-in-macvim
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" ------------------------------------------------------------------------------
" Editing Options
" ------------------------------------------------------------------------------

set autoindent
set backspace=2 " Fix broken backspace in some setups
set clipboard=unnamed " yank and paste with the system clipboard
set expandtab " always uses spaces instead of tab characters
set mouse=a " Enable basic mouse behavior such as resizing buffers.
set shiftwidth=2 " size of an "indent"
set softtabstop=2 " insert mode tab and backspace use 2 spaces
set tabstop=2 " size of a hard tabstop
" don't comment out new lines automatically when leaving a commented-out line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"-------------------------------------------------------------------------------
" File Options
"-------------------------------------------------------------------------------

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

"-------------------------------------------------------------------------------
" Custom Key Mappings
" ------------------------------------------------------------------------------

let mapleader = ',' " use ',' as <leader> key
" ,, to go to last file
map <leader><leader> <c-^>
" run flow on current file
map <leader>f :w\|:!clear; yarn run flow %<cr>
" run eslint on current file
map <leader>l :w\|:!clear; yarn run eslint %<cr>
" run prettier on current file
map <leader>p :w\|:!clear; yarn run prettier -- % --write<cr>
" print flow type of object under cursor
map <leader>g :exec "!yarn run flow type-at-pos " . expand("%") . " " . line(".") . " " . col(".")<cr>

map <leader>t :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>

" ------------------------------------------------------------------------------
" Custom Functions
" ------------------------------------------------------------------------------

" trim trailing whitespace
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
" call TrimWhiteSpace on file write
autocmd BufWritePre * :call TrimWhitespace()

" borrowed from gary bernhardt
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

" map ,r to run `yarn test` on the file that was focused when BindR was called
fun! BindR()
  let current_path = expand('%')
  :exe ":map ,r :w\\|:!clear; yarn test " . current_path . "<cr>"
endfun
command! BindR :call BindR()
