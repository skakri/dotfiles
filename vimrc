" Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
" Bundle 'davidhalter/jedi-vim'
Bundle 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on
colorscheme slate

set gdefault
set ignorecase
set smartcase

syntax on

set cursorline
set cursorcolumn

hi CursorLine   cterm=NONE ctermbg=19
hi CursorColumn ctermbg=18


" Ignores files that match these patterns.
set wildignore+=*.png
set wildignore+=*.gif
set wildignore+=*.jpeg
set wildignore+=*.jpg
set wildignore+=*.ico
set wildignore+=*.pyc
set wildignore+=*.pyo
set wildignore+=*.db


" Show some special chars like tab and trailing spaces differently.
set list
set listchars=tab:→\ ,trail:·,nbsp:·

set et
set ts=4
set sw=4
set sts=4

set splitbelow
set splitright

set undodir=/tmp
set noswapfile
set complete+=k

map <F2> :NERDTreeToggle<CR>
map <F3> :tabp<CR>
map <F4> :tabn<CR>

nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation is handled via Jedi
" let g:pymode_doc = 1
" let g:pymode_doc_key = 'K'

" Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Jedi
" Don't automatically select first suggestion from Jedi
let g:jedi#popup_select_first = 0

let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"

let g:jedi#documentation_command = "K"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#show_call_signatures = "1"

" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END

