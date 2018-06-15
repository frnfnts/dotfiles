set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set expandtab  " use spaces instead of tab
set tabstop=4  " length of a tab
set shiftwidth=4  " length of indent
set softtabstop=4 " number of spaces to delete by a deletion 
set autoindent
set smartindent
set smartcase
set infercase
set number
set mouse=
set ignorecase
set backspace=indent,start,eol
set ruler
set wildmenu
set matchpairs& matchpairs+=<:>  " treat < and > as a pair
set scrolloff=3  " margin for scroll
set cursorline
set synmaxcol=320
set showtabline=2
:command! Sv source ~/.vimrc
let $LC_ALL="C"
let $LANG="C"

" 2Esc for fade highlight of search.
nnoremap <silent><Esc><Esc> :nohlsearch<CR><Esc>
set hlsearch

let dotfiles_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
autocmd! 
autocmd VimEnter command -nargs=? Tn tabnew <args>
autocmd BufRead,BufNewFile *.{mkd,md} set filetype=markdown
"------indentation----------
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb,*.vue,*.html,*.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

nnoremap <silent>qq :only<CR>:q<CR>

" space commands
nnoremap <space>h ^
nnoremap <space>l $
nmap <space>y "*y
nmap <space>p "*p
nnoremap <space>j gj
nnoremap <space>k gk
nnoremap <space>i <C-a>
nnoremap <space>I <C-x>

" reverse gf and <C-W>gf
nnoremap <C-W>gf gf
nnoremap gf <C-W>gf

" Japanese keymap
nnoremap あ a
nnoremap い i
nnoremap お o

" move pain
nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

" move tab
nnoremap <C-h> gT
nnoremap <C-l> gt

"close tab
:command! Q tabc

" Ctrl-Y to copy to clip board
vnoremap <C-y> "*y
nnoremap <C-y> ggVG"*y<C-o><C-o>

" emacs keymap for insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
" inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x

" line-wise complication
inoremap <C-l> <C-x><C-l>
" filename complication
inoremap <C-f> <C-x><C-f>

"--------dein-------------
":call dein#install()
if &compatible
  set nocompatible
endif
set runtimepath+=~/dotfiles/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(expand("~/.vim/dein"))
  call dein#begin(expand("~/.vim/dein"))

  call dein#add(expand("~/dotfiles/dein/repos/github.com/Shougo/dein.vim"))
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('tpope/vim-fugitive')
  call dein#add('ctrlpvim/ctrlp.vim')
  "call dein#add('flazz/vim-colorschemes')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('posva/vim-vue')
  call dein#add('crusoexia/vim-monokai')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('thinca/vim-quickrun')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('osyo-manga/shabadou.vim')
  call dein#add('osyo-manga/unite-quickfix')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('Quramy/vim-js-pretty-template')
  call dein#add('tpope/vim-surround')
  call dein#add('simeji/winresizer') 
  call dein#add('LeafCage/yankround.vim') 
  call dein#add('itchyny/vim-cursorword') 
  call dein#add('tpope/vim-repeat') 
  call dein#add('chrisbra/vim-diff-enhanced')
  call dein#add('fuenor/jpmoveword.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable


"""""" Unite.vim
noremap <C-X> :Unite file_mru<CR>


"""""" vim-indent-guides
"let g:indent_guides_enable_on_vim_startup = 1  "auto start

"""""  NERDTree
noremap <silent><C-e> :NERDTreeToggle<CR>

"""""" vim-monokai
syntax on
colorscheme monokai
hi Search cterm=NONE ctermfg=darkgreen ctermbg=darkgray

""""" quickrun
noremap <silent><C-b> :w<CR>:QuickRun <=@*<CR>
au FileType qf nnoremap <silent><buffer>q :quit<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
let g:quickrun_no_default_key_mappings = 1
" https://github.com/thinca/vim-quickrun/blob/637aa0f9eab485874eb3606be35586735855d880/autoload/quickrun.vim#L16
let g:quickrun_config = {
\   "_" : { 
\       "hook/close_unite_quickfix/enable_hook_loaded" : 1,
\       "hook/unite_quickfix/enable_failure" : 1,
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split"  : ":rightbelow 8sp",
\       "outputter/buffer/close_on_empty" : 1,
\       "hook/time/enable" : 1,
\   },
\   "python" : {
\       "command": "/c/Windows/py"
\   },
\   "r" : {
\       "command": "Rscript",
\       "exec": "%c %o %s %a"
\   },
\   "cpp" : {
\       "command" : "g++",
\       "cmdopt" : "-std=c++14",
\   }
\}

let githubcss = dotfiles_dir."/github.css"
let hatenacss = dotfiles_dir."/hatena.css"
let hatenajs  = dotfiles_dir."/hatena.js"
let g:quickrun_config['markdown'] = {
\ 'command': 'pandoc',
\ 'cmdopt': '-s -c '.githubcss .' -c '.hatenacss.' -A '.hatenajs,
\ 'exec': ['%c --from=markdown --to=html %o %s %a > %s:p:r.html'],
\}

:command! -complete=file -nargs=* A let g:quickrun_config._.args = join([<f-args>], " ")
:command! Ac echo g:quickrun_config._.args
function! StartIfExist(f)
    if filereadable(a:f)
        silent execute "!start ".a:f
        redraw!
    else
        echoerr "No such file: ".a:f
    endif
endfunction

nnoremap <silent><C-g> :call StartIfExist(expand('%:r').".html")<CR>

"""" multiple-cursors
" :so $VIMRUNTIME/syntax/colortest.vim
" :so $VIMRUNTIME/syntax/hitest.vim
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <silent><C-c> :call multiple_cursors#quit()<CR>
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
highlight MatchParen cterm=NONE ctermbg=black ctermfg=darkcyan
highlight markdownItalic cterm=NONE ctermfg=darkblue

"""" js-pretty-template
autocmd FileType javascript JsPreTmpl html

""" vim-surround
nmap s ysi

"""" winresizer
noremap <C-t> <NOP>
let g:winresizer_start_key = '<C-T>'

"""" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_use_region_hl = 1
highlight YankRoundRegion cterm=none ctermbg=darkgray

"""" ctrlp
let g:ctrlp_map = '<Nop>'
noremap <C-f> :CtrlP<CR>
let g:ctrlp_show_hidden = 1

"""" vim-diff-enhanced
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif 

"""" jpmoveword
let g:jpmoveword_enable_WBE = 1
let g:jpmoveword_separator = '、。'
let g:jpmoveword_stop_separator = 1
let g:jpmoveword_stop_eol = 2
