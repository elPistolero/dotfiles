
"{{{ Init pathogen
set nocompatible
autocmd!
filetype off
call pathogen#infect()
call pathogen#helptags()

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
filetype plugin indent on
syntax enable
set grepprg=grep\ -nH\ $*
" }}}

"{{{ Omni completion
filetype plugin on
set ofu=syntaxcomplete#Complete
"}}}

"{{{Misc Settings
set nocompatible

set wildignore+=*.o,*.obj,*.aux,.git,.svn

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Who doesn't like autoindent?
set autoindent
set smartindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
"set wildmenu
"set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" Open a new file without writing the buffers first
set hidden

" Set off the other paren
highlight MatchParen ctermbg=4

set showmatch

set showmode
" }}}

"{{{ Auto Commands
" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" Close preview scratch window after autocomplete selection
   autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
   autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"}}}

"{{{Mappings
" Change the mapleader from \ to ,
let mapleader=","

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Jump to tag
nnoremap t <C-]>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Easy window navigation
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l

" Clear highlighted searches
nmap <silent> ,/ :nohlsearch<CR>
"}}}

"{{{ Look and Feel
set textwidth=100

" highlight whitespaces
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

set t_Co=256
colorscheme inkpot

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
"}}}

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"{{{ GLSL Syntax
command SetGLSLFileType call SetGLSLFileType()
function SetGLSLFileType()
  for item in getline(1,10)
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
    endif
    if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
  endfor
endfunction
au BufNewFile,BufRead *.frag,*.vert,*.geom,*.fp,*.vp,*.glsl SetGLSLFileType
"}}}

"{{{ Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
nmap <F8> :TagbarToggle<CR>
"}}}

"{{{ FSwitch
au! BufEnter *.{cc,cpp,c} let b:fswitchdst = 'hh,hpp,h' | let b:fswitchlocs = './,../'
au! BufEnter *.{hh,hpp,h} let b:fswitchdst = 'cc,cpp,c' | let b:fswitchlocs = './,../'
nmap <C-o> :FSHere<CR>
"}}}

"{{{ latex suite
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_ViewRule_ps = 'evince'
let g:Tex_ViewRule_dvi = 'evince'

let g:Tex_DefaultTargetFormat = 'pdf'
"}}}

"{{{ clang complete
"let g:clang_library_path = '/usr/lib'
"let g:clang_use_library = 1
"let g:clang_user_options = '2>/dev/null || exit 0'
let g:clang_complete_auto = 0
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
"}}}

"{{{ nerdtree
" open nerdtree if no files are specified
autocmd vimenter * if !argc() | NERDTree | endif
" close nerdtree if it is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap <F9> :NERDTreeToggle<CR>
"}}}

"{{{ supertab
let g:SuperTabDefaultCompletionType = "context"
"}}}

"{{{
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
"}}}
