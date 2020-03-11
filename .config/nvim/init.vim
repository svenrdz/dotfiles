set nocompatible
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax')
  " syntax enable
  syntax on
endif
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set incsearch
set tabstop=2
set shiftwidth=2
set expandtab
set showcmd
set wildmenu
set display+=lastline
set encoding=utf-8
set autoread
set fileformats+=mac
set history=1000         " remember more commands and search history
set undolevels=100       " use less levels of undo
set undoreload=1000      " use less levels of reload
set undodir=~/.config/nvim/undodir
set updatetime=500       " defaults to 4000, better low for git gutter
set tabpagemax=3
set viminfo^=!
if !exists('g:loaded_matchit') && findfile('pupdatetimelugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" Where to split
set splitright
set splitbelow
set laststatus=2
set showtabline=2
set cursorline
set scrolloff=0
set sidescroll=1
set sidescrolloff=15
set switchbuf=usetab
set hidden
set wrap linebreak
set textwidth=0
set wrapmargin=0
set showbreak=" "
set wildmode=longest,full
set number relativenumber
set noerrorbells
set visualbell
set nomodeline
set mouse=a
set viminfo='100,f1
set hlsearch
set ignorecase
set smartcase
set noswapfile
set iskeyword+=-
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*
set title

let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bclose_no_plugin_maps = 1

source $HOME/.config/nvim/plug.vim

function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif
  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

let g:netrw_banner = 0
set foldmethod=syntax
set foldlevel=3
set foldlevelstart=3
let g:vimwiki_folding='list'
let g:python3_host_prog = '/Users/sven/.pyenv/versions/3.6.5/bin/python3'
set t_Co=256
set copyindent    " copy the previous indentation on autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set nobackup

autocmd filetype python set expandtab
autocmd BufRead,BufNewFile *.py set iskeyword+=_
autocmd BufRead,BufNewFile *.py ab pdb __import__("pdb").set_trace()
autocmd BufRead,BufNewFile *.py ab ipd __import__("ipdb").set_trace()

" Spell
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en
autocmd BufRead,BufNewFile *.wiki setlocal spell spelllang=en
autocmd FileType gitcommit setlocal spell spelllang=en
set complete+=kspell

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Colorscheme
" colorscheme purify
colorscheme snazzy
hi Normal ctermbg=NONE guibg=NONE
set mouse=a
set clipboard=unnamed

" let g:AutoPairsFlyMode = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" ProjectFiles locates files relative to the git root.
" see https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

" Update fasd with nvim opened files
function! s:fasd_update() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction

augroup fasd
  autocmd!
  autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END


let g:airline_theme = 'purify'
let b:ale_linters = ['flake8', 'pylint', 'jq']
let g:deoplete#sources#jedi#enable_typeinfo = 1

source $HOME/.config/nvim/config.vim
source $HOME/.config/nvim/shortcuts.vim
source $HOME/.config/nvim/plug.vim

" allow opening file in current neovim instance from terminal
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
