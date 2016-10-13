" Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mattn/emmet-vim'
Bundle 'sjl/splice.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'derekwyatt/vim-scala'

call vundle#end()

filetype plugin indent on
colorscheme slate

set mouse=a
set gdefault
set ignorecase
set smartcase

syntax on
set number

set cursorline
set cursorcolumn

hi CursorLine   cterm=NONE ctermbg=19
hi CursorColumn ctermbg=18


" Some keys suck on my urxvt setup.
set backspace=indent,eol,start


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

" Filetype specific tab settings.
autocmd BufNewFile,BufReadPost *.coffee setl ts=2 sw=2 sts=2 expandtab

set splitbelow
set splitright

set undodir=/tmp
set noswapfile
set complete+=k

map <F2> :NERDTreeToggle<CR>
nmap [34~ :tabn<CR>
nmap <S-Tab> :tabp<CR>
nmap <C-t> :tabnew<CR>

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
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_lint_message = 1
" Auto check on save
let g:pymode_lint_on_write = 1

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

" vim-airline setup
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" YouCompleteMe blacklist
let g:ycm_filetype_blacklist = {
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'latex' : 1
      \}

" Emmet
let g:user_emmet_leader_key = '<C-]>'

hi ColorColumn ctermbg=0
set colorcolumn=80
let &colorcolumn="80,".join(range(120,999),",")


augroup vimrc_autocmds
    autocmd!
    " autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python set nowrap
augroup END
