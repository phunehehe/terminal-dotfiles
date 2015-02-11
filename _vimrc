" First thing first: pathogen to load everything
call pathogen#infect()


" Utility functions

function! DoAndComeBack(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! ToggleCopy()
    if (&number)
        set nonumber
        set nolist
        set showbreak=
    else
        set number
        set list
        set showbreak=↪
    endif
endfunction

function! CompleteOrTab()
    if (strpart(getline('.'),col('.')-2,1)!~'\w')
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction


"" Functional options

" Useful for overriding file type
set modeline

" Unicode FTW
set fileencodings=utf8

" File type detection should have been on my default
filetype plugin indent on

" Some systems don't turn on syntax by default
syntax on

" To have list of options instead of one default
set wildmenu
set wildmode=longest,full

" Search as I type
set incsearch

" Case insensitive for searching
set ignorecase
" But allow for case sensitive when I seem to mean it
set smartcase

" Line numbers are good
set number

" Remove any trailing whitespace that is in the file
autocmd BufWrite * if ! &bin | call DoAndComeBack("%s/\\s\\+$//e") | endif

" I don't mean Make, I mean Mako
autocmd BufNewFile,BufRead *.mak  set filetype=html
" JSON syntax highlighting for free
autocmd BufNewFile,BufRead *.json set filetype=javascript
" I don't know what modular2 is
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Automatically disable paste mode
au InsertLeave * set nopaste

" Enable mouse support in console
set mouse=a

" Keep cursor in the middle of screen
set scrolloff=9

" Use + to copy to clipboard
let g:clipbrdDefaultReg = '+'

" Spaces no tabs
set expandtab
set tabstop=4
set shiftwidth=4

" Always show file info
set laststatus=2

" Show title
set title

" Lemme know what I'm doing
set showcmd
set report=0

" Be smart and try do indenting right
set autoindent
set smartindent
set preserveindent

" g as default flag for :substitute, make sense!
set gdefault

" Show funny characters!
set list
set listchars=tab:»\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Fold by indentation, fine for most programming languages
set nofoldenable
set foldmethod=indent


"" Display options

" We should have as many colors as possible!
set t_Co=256

" Transparent background too
autocmd ColorScheme * highlight Normal  ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None

" Have a line indicate the cursor location
set cursorline

" My favorite color scheme, for now
colorscheme kolor

" Highlight search results
set hlsearch

" ctrl.vim should use current directory
let g:ctrlp_working_path_mode = 0

" grep ignores binary files
set grepprg=grep\ -HIn\ $*\ /dev/null

" Options for vim-javascript
let g:html_indent_inctags = "html,body,head"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" u got a fast terminal
set ttyfast
" to avoid scrolling problems
set lazyredraw
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=240

" Rainbow parentheses!
let g:rainbow_active = 1


"" Key mappings

" Format JSON
nnoremap <Leader>j :%!python -m json.tool<cr>

" Forgot to sudo when opening a file
cnoremap w!! %!sudo tee > /dev/null %

" Remap jj to escape in insert mode.
inoremap jj <esc>

" Ctrl-jklm changes to that split
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Next/previous in quickfix list
nnoremap <c-n> :cnext<cr>
nnoremap <c-p> :cprevious<cr>

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Search for files
let g:ctrlp_map = '<leader>f'
nnoremap <leader>n :NERDTreeFind<cr>

" Temporarily disable search highlight
nnoremap <leader>h :nohlsearch<cr>

" * only highlight, not move
nnoremap * :set hlsearch<cr>:let @/="\\<".expand("<cword>")."\\>"<cr>

" Quick paste toggle
nnoremap <leader>p :set paste!<cr>

" Quick fold toggle
nnoremap <space> za

" For easy copying
nnoremap <leader>c :call ToggleCopy()<cr>

" Smart tab completion
inoremap <tab> <c-r>=CompleteOrTab()<cr>

" Select pasted text
nnoremap gp `[v`]

" Smart matching
runtime macros/matchit.vim

" Switch case
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
