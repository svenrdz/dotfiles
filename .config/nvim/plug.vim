" Load vim-plug
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
    execute '!curl -fLo '.$HOME.'/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

Plug 'tpope/vim-sensible'

" Colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" must-have vim scripts
Plug 'tpope/vim-eunuch'
Plug 'jlanzarotta/bufexplorer'
Plug 'lambdalisue/battery.vim'
Plug 'haya14busa/incsearch.vim'

" Folding
Plug 'Konfekt/FastFold'
let g:fastfold_fold_command_suffixes = ['x','X','a','A','o','O','c','C','r','R','m','M','i','n','N']

" file browser
Plug 'rbgrouleff/bclose.vim'

" better tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'connorholyday/vim-snazzy'

" Fugitive: Git from within Vim
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Make commenting easier
Plug 'tpope/vim-commentary'

" Better registers and macros
Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window = 'vert bo 50new'

" Mappings to turn stuff on and off
Plug 'tpope/vim-unimpaired'

" Be able to repeat plugin operations
Plug 'tpope/vim-repeat'

" cursors
Plug 'terryma/vim-multiple-cursors'

" Change brackets and quotes
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" fzf for vim so so so so powerful
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" improve /-search
Plug 'junegunn/vim-slash'

" python format
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tmhedberg/SimpylFold', { 'for' : 'python' }
Plug 'psf/black', { 'tag': '*' }
let g:black_virtualenv = $HOME.'/.pyenv/versions/'.$MAIN_VENV
let g:black_linelength = 80
command! -bar Bl Black
command! -bar FixJsonComma %s/,\(\n *[}|\]]\)/\1/g
command! -bar FixJsonSpaces %s/    /  /g
command! Json Bl|FixJsonComma|FixJsonSpaces|noh
Plug 'elzr/vim-json', { 'for' : 'json' }

" Preview markdown filesin browser using :Markdown
Plug 'iamcco/markdown-preview.vim', { 'for' : 'markdown' }

" Linter and quickfix
Plug 'dense-analysis/ale'


" Autocomplete
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-tags.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-emoji.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
Plug 'andreypopp/asyncomplete-ale.vim'
Plug 'tsufeki/asyncomplete-fuzzy-match', {
    \ 'do': 'cargo build --release',
    \ }

" vimwiki
Plug 'vimwiki/vimwiki'

" nim
Plug 'alaviss/nim.nvim'

" extempore
" Plug 'timburgess/extempore.vim', { 'for' : 'extempore' }

" Plug 'itchyny/lightline.vim'
" let g:lightline = {
"   \     'active': {
"   \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
"   \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
"   \     },
"   \     'colorscheme': 'onehalfdark'
"   \ }

filetype plugin indent on                   " required!
call plug#end()
