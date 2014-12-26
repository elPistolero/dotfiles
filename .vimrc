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
Bundle 'jistr/vim-nerdtree-tabs'
"Bundle 'ervandew/supertab'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'ivalkeen/vim-ctrlp-tjump'
"Bundle 'davidhalter/jedi-vim'
"Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-repeat'
"Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-markdown'
Bundle 'bkad/CamelCaseMotion'
Bundle 'derekwyatt/vim-fswitch'
"Bundle 'Shougo/unite.vim'
"Bundle 'Shougo/vimproc.vim'
"Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/ZoomWin'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'bronson/vim-trailing-whitespace'
"Bundle 'vim-scripts/YankRing.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'sjl/gundo.vim'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
"Bundle 'tranngocthachs/gtags-cscope-vim-plugin'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'godlygeek/tabular'
Bundle 'arecarn/crunch'
Bundle 'junegunn/seoul256.vim'
Bundle 'bilalq/lite-dfm'
Bundle 'edkolev/promptline.vim'
"Bundle 'kbairak/TurboMark'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
Bundle 'wellle/targets.vim'
Bundle 'fatih/vim-go'
Bundle 'szw/vim-tags'
Bundle 'gcmt/wildfire.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'gorkunov/smartgf.vim'
Bundle 'haya14busa/incsearch.vim'
Bundle 'pelodelfuego/vim-swoop'
"Bundle 'Rykka/clickable.vim'
"Bundle 'saihoooooooo/glowshi-ft.vim'
"Bundle 'jalcine/cmake.vim'
" vim-scripts repos
" non github repos
"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax on
set grepprg=grep\ -nH\ $*
" }}}

"{{{Misc Settings
set nocompatible

set wildignore+=*/build*,*.o,*.obj,*.aux,.git,.svn

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" avoid weird grey bar at the side
set foldcolumn=0

" Who doesn't like autoindent?
set autoindent
set smartindent
set cino+=(0

set autoread

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
set relativenumber
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

" {{{ paste settings
set clipboard=unnamedplus
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

" make sure yankstack mappings don't cause any problems
call yankstack#setup()


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

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

imap jk <Esc>

" Jump to tag
nnoremap t <C-]>

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

" move mappings
" Normal mode
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==

"" Insert mode
"inoremap <C-j> <ESC>:m .+1<CR>==gi
"inoremap <C-k> <ESC>:m .-2<CR>==gi

"" Visual mode
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

" repeat operator in visual mode
vnoremap . :normal .<CR>

" Keep selection after indent
vnoremap > ><CR>gv
vnoremap < <<CR>gv
"}}}

"{{{ Look and Feel
set textwidth=80
set colorcolumn=-0

" highlight whitespaces
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

set t_Co=256
colorscheme seoul256

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
let g:tagbar_type_tex = {
      \ 'ctagstype' : 'latex',
      \ 'kinds'     : [
      \ 's:sections',
      \ 'g:graphics:0:0',
      \ 'l:labels',
      \ 'r:refs:1:0',
      \ 'p:pagerefs:1:0'
      \ ],
      \ 'sort'    : 0,
      \ 'deffile' : expand('~/latex.cnf')
      \ }
"}}}

"{{{ nerdtree
let NERDTreeHijackNetrw=1
nmap <F9> :NERDTreeTabsToggle <CR>
"}}}

"{{{ tags
" search until we find the tags file
set tags=./tags;
"}}}

"{{{ YouCompleteMe
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_always_populate_location_ist = 1
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_show_diagnostics_ui=1
let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'qf' : 1,
        \ 'notes' : 1,
        \ 'markdown' : 1,
        \ 'unite' : 1,
        \ 'vimwiki' : 1,
        \ 'pandoc' : 1,
        \ 'mail' : 1
        \}
"}}}

"{{{ FSwitch
nmap <silent> <leader>o :FSHere<CR>
"}}}

" {{{ airline
let g:airline_theme='bubblegum'
let g:airline_exclude_preview=1
let g:airline#extensions#tabline#enabled=1
" }}}

"{{{ Camel Case Motion
map <Leader> w <Plug>CamelCaseMotion_w
map <Leader> b <Plug>CamelCaseMotion_b
map <Leader> e <Plug>CamelCaseMotion_e
"}}}

"{{{ Gundo
nnoremap <F5> :GundoToggle<CR>
"}}}

"{{{ ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 40
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['funky', 'line']
let g:ctrlp_map = '<space>p'
nmap <space>l :CtrlPLine<cr>
nmap <space>k :CtrlPFunky<cr>
nmap <space>m :CtrlPTag<cr>
nmap <space>b :CtrlPBuffer<cr>
nnoremap <space>t :CtrlPtjump<cr>
vnoremap <space>t :CtrlPtjumpVisual<cr>
"}}}

"{{{ ag
nmap <space>a :Ag --ignore build/ --ignore compile_commands.json
"}}}

"{{{ YankStack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
"}}}

"{{{ Crunch
map <silent> <space>cl <plug>CrunchEvalLine
map <silent> <space>cb <plug>CrunchEvalBlock
"}}}

"{{{ LiteDFM
nnoremap <space>z :LiteDFMToggle<CR>i<Esc>`^
"}}}

"{{{ make options
set makeprg=make\ -C\ /local/lim/workspace/machine_learning/build/release/\ -j50
"}}}

"{{{ vim notes
let g:notes_directories = ['~/Documents/Notes']
"}}}

"{{{ vim-tags
let g:vim_tags_use_vim_dispatch = 1
"}}}

"{{{ incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"}}}
