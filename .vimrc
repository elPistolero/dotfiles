"{{{ Init vim-plug

set shell=/bin/sh

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source '~/.vimrc'
endif

call plug#begin('~/.vim/plugged')

" bundles on github
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'bkad/CamelCaseMotion'
Plug 'derekwyatt/vim-fswitch'
Plug 'justinmk/vim-sneak'
Plug 'bling/vim-airline'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'rking/ag.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'sjl/gundo.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'junegunn/seoul256.vim'
Plug 'bilalq/lite-dfm'
Plug 'edkolev/promptline.vim'
Plug 'xolox/vim-misc'
Plug 'wellle/targets.vim'
Plug 'fatih/vim-go'
Plug 'szw/vim-tags'
Plug 'Yggdroot/indentLine'
Plug 'haya14busa/incsearch.vim'
Plug 'embear/vim-localvimrc'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'NLKNguyen/papercolor-theme'
Plug 'christoomey/vim-tmux-navigator', {'commit': '999d252'}
Plug 'vim-scripts/gtags.vim'
Plug 'stephpy/vim-yaml'
Plug 'milkypostman/vim-togglelist'
Plug 'mhinz/vim-grepper'

call plug#end()

" Needed for Syntax Highlighting and stuff
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

" syntax coloring lines that are too long just slows down the world
set synmaxcol=200
" }}}

" {{{ paste settings
set clipboard=unnamed
" }}}

"{{{ Auto Commands

" Close preview scratch window after autocomplete selection
   autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
   autocmd InsertLeave * if pumvisible() == 0|pclose|endif

   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
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

imap fd <Esc>

" Jump to tag
"nnoremap t <C-]>

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

" repeat operator in visual mode
vnoremap . :normal .<CR>

" Keep selection after indent
vnoremap > ><CR>gv
vnoremap < <<CR>gv

nnoremap <Space><Tab> :b#<CR>
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
let g:nerdtree_tabs_open_on_gui_startup=0
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
let g:ycm_always_populate_location_list = 1
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
nnoremap <leader>g :YcmCompleter GoTo<CR>
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
nmap <space>a :Ag --ignore build/ --ignore compile_commands.json --ignore tags
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
"set makeprg=make\ -C\ /local/lim/workspace/machine_learning/build/release/\ -j50
"}}}

"{{{ vim notes
let g:notes_directories = ['~/Documents/Notes']
"}}}

"{{{ vim-tags
let g:vim_tags_use_vim_dispatch = 1
"}}}

"{{{ gtags
nnoremap t :Gtags<CR><CR>
nnoremap <C-t> :Gtags -r<CR><CR>
nnoremap <F11> :cp<CR>
nnoremap <F12> :cn<CR>
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

"{{{ FastFold
"set foldmethod=syntax
"let g:fastfold_savehook = 0
"}}}

"{{{ tex
let g:tex_conceal = ""
"}}}

"{{{ easymotion
"nmap s <Plug>(easymotion-s2)
"nmap t <Plug>(easymotion-t2)
"nmap s <Plug>(easymotion-s)
"nmap t <Plug>(easymotion-bd-tl)
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>h <Plug>(easymotion-linebackward)
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
"let g:EasyMotion_smartcase = 1
"}}}

"{{{ sneak
let g:sneak#streak = 1
nmap s <Plug>(SneakStreak)
nmap S <Plug>(SneakStreakBackward)
"}}}

"{{{ local vimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
"}}}
