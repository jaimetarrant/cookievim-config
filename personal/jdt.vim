
" My Settings ...

set encoding=utf8         " Default encoding - I override this for mutt though.
set ffs=unix,dos,mac

set showcmd               " Show commands in bottom right corner
set backupdir=~/.tmp
set dir=~/.tmp

let mapleader = ","

" Better split and window navigation
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

" Lots of settings found on github that are useful

set nu                    " show line numbers
set bs=2                  " allow backspacing over everything in insert mode
set ruler                 " show the cursor position all the time
set autoread              " auto read when file is changed from outside
set wrap                  " Word wrapping
set autoindent            " Indent at the same level of the previous line
set shiftwidth=2          " Set indent size ... I like 2, since I am on a small screen often.
set expandtab             " Make tabs spaces instead
set tabstop=2             " An indentation every `n` columns
set softtabstop=2         " Let backspace delete indent
set textwidth=78          " I like to wrap at 78 by default. In mutt I override this at 72
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore   " Allow for cursor beyond last character
set history=1000          " Store a ton of history (default is 20)
set nospell               " Spell checking off <-- drives me nuts in code.
set hidden                " Allow buffer switching without saving
set backspace=indent,eol,start " Backspace for dummies
set linespace=0           " No extra spaces between rows
set showmatch             " Show matching brackets/parenthesis
set incsearch             " Incremental search
set hlsearch              " Highlight search terms
set winminheight=0        " Windows can be 0 line high
set ignorecase           " Case insensitive search  <-- Actually I prefer                           "case sensitive
set smartcase             " Case sensitive when uc present
set wildmenu              " Show list instead of just completing
set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
set scrolljump=5          " Lines to scroll when cursor leaves screen
set scrolloff=3           " Minimum lines to keep above and below cursor
"set foldenable           " Auto fold code
"set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nojoinspaces          " Prevents inserting two spaces after punctuation on a join (J)
set splitright            " Puts new vsplit windows to the right of the current
set splitbelow            " Puts new split windows to the bottom of the current
set matchpairs+=<:>       " Match, to be used with %
set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
set pastetoggle=<F12>     " yes, it is possible to paste in vim normally.
set magic                 " for regex
set cinkeys=0{,0},:,0#,!,!^Fs


filetype off              " necessary to make ftdetect work on Linux
syntax on
filetype on               " Enable filetype detection
filetype indent on        " Enable filetype-specific indenting
filetype plugin on        " Enable filetype-specific plugins
set smartindent

let g:html_indent_inctags = "html,body,head,tbody"

" Annoyance removal
set noerrorbells
set novisualbell
set t_vb=

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"set Y to duplicate line
nnoremap Y yyp

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and others
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.cc :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
" Run on all files
autocmd BufWrite * :call DeleteTrailingWS()

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Git commits
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


" Statusline config
"
if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\\                     " Filename
  set statusline+=%w%h%m%r                  " Options
  set statusline+=%{fugitive#statusline()}  " Git Hotness
  set statusline+=\ [%{&ff}/%Y]             " Filetype
  set statusline+=\ [%{getcwd()}]           " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%   " Right aligned file nav info
endif

" Clipboard register optimisations
if has('clipboard')
  if LINUX()  " On Linux use + register for copy-paste
    set clipboard=unnamedplus
  else        " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" C
" ,g generates the header guard
" map <leader>g :call IncludeGuard()<CR>     " <-- Need to re map this

fun! IncludeGuard()
  let basename = substitute(bufname(""), '.*/', '', '')
  let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
  call append(0, "#ifndef " . guard)
  call append(1, "#define " . guard)
  call append( line("$"), "#endif // for #ifndef " . guard)
endfun
