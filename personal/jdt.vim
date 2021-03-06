
" Jaime's Settings ...

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

" Create == underline for text.
nnoremap <leader>1 yypVr=

autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

" C syntax options
let c_syntax_for_h = 1
let c_C99 = 1
let c_warn_8bitchars = 1
let c_warn_multichar = 1
let c_warn_digraph = 1
let c_warn_trigraph = 1

" compiler stuff
let g:compiler_gcc_ignore_unmatched_lines=1
let mapleader=','
" quickfix :make
nmap <silent> <Leader>m :wa<CR>:silent! make \| redraw! \| cw<CR><CR>
vmap <silent> <Leader>m :wa<CR>:silent! make \| redraw! \| cw<CR><CR>
" handy shortcuts
map <Leader>h :ccl<CR>
map <Leader>s :cw<CR>
map <Leader>l :cl<CR>
" jump between messages
map <Leader>n :cn<CR>
map <Leader>p :cp<CR>

" @c comment, @u uncomment, @p print function name
let @u='0xx$xx^['
let @c='I/*^[A*/^['
let @p='ofprintf(stderr, "%s\n", __func__);^['

" Maybe improvements for OBSD ?
set cinoptions=t0,+4,(4,u4,w1
autocmd FileType c,cpp,objc set shiftwidth=4
autocmd FileType c,cpp,objc set softtabstop=4
autocmd FileType c,cpp,objc let c_space_errors=1

" :command! -nargs=+ Calc :py print <args>
" :py from math import *

" Goodie I can save when I forget to sudo
cmap w!! w !sudo tee % >/dev/null

" Lots of settings found on github that are useful
set nocompatible
set shiftwidth=2
set softtabstop=2
set ruler
set tabstop=2
set autoindent
set showmode
set showmatch
set hlsearch
set incsearch
set backspace=indent,eol,start
set showcmd             " display incomplete commands
set ttyfast             " needed to make laggy connections work fast enough
"set mouse=a            " enable if you want the mouse to work in xterm
set nu                    " show line numbers
set bs=2                  " allow backspacing over everything in insert mode
set ruler                 " show the cursor position all the time
set autoread              " auto read when file is changed from outside
set wrap                  " Word wrapping
set smartindent            " Indent at the same level of the previous line
set expandtab             " Make tabs spaces instead
set textwidth=72          " I like to wrap at 78 by default. In mutt I override this at 72
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore   " Allow for cursor beyond last character
set history=10000         " Store a ton of history (default is 20)
set undolevels=1000       " Lots of undo's too.
set nospell               " Spell checking off <-- drives me nuts in code.
set hidden                " Allow buffer switching without saving
set linespace=0           " No extra spaces between rows
set winminheight=0        " Windows can be 0 line high
set cmdheight=2           " Status bar height
set laststatus=2          " Always show status

"set ignorecase           " Case insensitive search  <-- Actually I prefer                           "case sensitive
set smartcase             " Case sensitive when uc present
set wildmenu              " Show list instead of just completing
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
"set cinkeys=0{,0},:,0#,!,!^Fs    " <-- breaks , in c mode
set ai
set si

set wildmode=longest,list,full
" This changes the default display of tab and CR chars in list mode
set listchars=tab:▸\ ,eol:¬

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

set shortmess=a

if v:version >= 704
  set regexpengine=1
endif

" Try to use the paste buffers more simply.
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif

" backspace
imap ^? ^H

" ctrl up and ctrl down in tmux
if &term == "screen"
        set t_kN=^[[6;*~
        set t_kP=^[[5;*~
endif

" text & mutt files
au BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt set tw=72 noai noshowmatch
au BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt setlocal spell spelllang=en_us
au BufNewFile,BufRead /tmp/mutt*,/tmp/cvs*,*.txt syntax off

" git commits
au BufNewFile,BufRead *.git/COMMIT_EDITMSG set tw=72 noai noshowmatch
au BufNewFile,BufRead *.git/COMMIT_EDITMSG setlocal spell spelllang=en_us

" f6 toggles spelling on/off
nn <F6> :setlocal spell! spell?<CR>

" Loaded by default, unloaded in module specific configs if required.
syntax on
filetype on               " Enable filetype detection
filetype indent on        " Enable filetype-specific indenting
filetype plugin on        " Enable filetype-specific plugins

let g:html_indent_inctags = "html,body,head,tbody"

" Annoyance removal
set noerrorbells
set novisualbell
set t_vb=                   " What is this?

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"set Y to duplicate line
nnoremap Y yyp

" Highlight scripts as bash

let g:is_posix = 1

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

" Switch to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>

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
set clipboard=unnamedplus " for linux
" set clipboard=unnamed   " for mac osx

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


