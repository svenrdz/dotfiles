" Load vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

" Colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" must-have vim scripts
Plug 'tpope/vim-eunuch'
Plug 'jlanzarotta/bufexplorer'
Plug 'lambdalisue/battery.vim'

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

" Vim defaults
" Plug 'tpope/vim-sensible'
Plug 'cs/alternate-file.vim'

" fzf for vim so so so so powerful
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" improve /-search
Plug 'junegunn/vim-slash'

" python format
Plug 'majutsushi/tagbar', { 'for' : 'python' }
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tmhedberg/SimpylFold', { 'for' : 'python' }
Plug 'ambv/black'
let g:black_virtualenv = '/Users/sven/virtualenvs/panda36/'
let g:black_linelength = 80
command! -bar Blac Black
command! -bar FixJsonComma %s/,\(\n *[}|\]]\)/\1/g
command! -bar FixJsonSpaces %s/    /  /g
command! Json Blac|FixJsonComma|FixJsonSpaces|noh
Plug 'elzr/vim-json'

" Preview markdown filesin browser using :Markdown
Plug 'iamcco/markdown-preview.vim', { 'for' : 'markdown' }

" Code snippets engine + snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" let g:ultisnips_python_style = "numpy"

" Automatic smart completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" Completion sources
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'wokalski/autocomplete-flow'
Plug 'zchee/deoplete-jedi'
Plug 'wellle/tmux-complete.vim'
Plug 'thalesmello/webcomplete.vim'
Plug 'deathlyfrantic/deoplete-spell'

" vim autocorrect
" Plug 'sedm0784/vim-you-autocorrect'

" supertab
Plug 'ervandew/supertab'

" Linter and quickfix
Plug 'dense-analysis/ale'

" ipython in vim
" Plug 'bfredl/nvim-ipy'
" Plug 'goerz/jupytext.vim'
" let g:jupytext_fmt = 'py:percent'
" let g:jupytext_filetype_map = {'py': 'py'}
" Plug 'metakirby5/codi.vim'

" vimwiki
Plug 'vimwiki/vimwiki'

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
