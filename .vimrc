
"{{{ Init vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
" required
Bundle 'gmarik/vundle'

" bundles on github
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
"Bundle 'scrooloose/syntastic'
"Bundle 'jistr/vim-nerdtree-tabs'
"Bundle 'ervandew/supertab'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'davidhalter/jedi-vim'
"Bundle 'klen/python-mode'
"Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-repeat'
"Bundle 'bkad/CamelCaseMotion'
Bundle 'derekwyatt/vim-fswitch'
"Bundle 'vim-scripts/a.vim'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Bundle 'Lokaltog/vim-easymotion'
Bundle 'Valloric/YouCompleteMe'
" vim-scripts repos
" non github repos
Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax on
set grepprg=grep\ -nH\ $*
" }}}

"{{{Misc Settings
set nocompatible

set wildignore+=*.o,*.obj,*.aux,.git,.svn

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" avoid weird grey bar at the side
set foldcolumn=0

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
"autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

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

nmap <silent> ,r :redraw!<CR>
"}}}

"{{{ Look and Feel
set textwidth=80
set colorcolumn=-0

" highlight whitespaces
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

set t_Co=256
colorscheme zenburn

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

set encoding=utf-8
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

"{{{ nerdtree
nmap <F9> :NERDTreeToggle <CR>
"}}}

"{{{ ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 40
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['funky', 'line']
nmap <c-l> :CtrlPLine<cr>
nmap <c-k> :CtrlPFunky<cr>
nmap <c-m> :CtrlPTag<cr>
"}}}

"{{{ tags
" search until we find the tags file
set tags=./tags;
"}}}

"{{{ YouCompleteMe
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}}

"{{{ FSwitch
nmap <silent> <leader>o :FSHere<CR>
"}}}

"{{{ vim latex
let g:tex_flavor='latex'
set iskeyword+=:
"}}}
