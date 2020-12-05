""""""""""""""""""""""""""""""""""""""""""
"             ranger options             "
""""""""""""""""""""""""""""""""""""""""""

" macros
let @i = 'Otry:joexcept:ipdkk>>'
let @u = '<<kddjdj'

" unmap default <Leader>f
let g:ranger_map_keys = 0
" use ranger when opening folder in vim
let g:ranger_replace_netrw = 1


""""""""""""""""""""""""""""""""""""""""""
"               FZF options              "
""""""""""""""""""""""""""""""""""""""""""

let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>


""""""""""""""""""""""""""""""""""""""""""
"                   Ag                   "
""""""""""""""""""""""""""""""""""""""""""

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)


""""""""""""""""""""""""""""""""""""""""""
"         reload init.vim on save        "
""""""""""""""""""""""""""""""""""""""""""

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END


""""""""""""""""""""""""""""""""""""""""""
"       asyncomplete registration        "
""""""""""""""""""""""""""""""""""""""""""

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"


" TabNine setup
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tabnine#get_source_options({
    \ 'name': 'tabnine',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#tabnine#completor'),
    \ 'config': {
    \   'line_limit': 1000,
    \   'max_num_result': 20,
    \  },
    \ }))
" neco
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'allowlist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))
" necosyntax
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ }))
" file
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
" tags
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'allowlist': ['c'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))
" buffer
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
" nim
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'allowlist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })
" emoji
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
    \ 'name': 'emoji',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#emoji#completor'),
    \ }))
" ale
au User asyncomplete_setup call asyncomplete#ale#register_source({
    \ 'name': 'reason',
    \ 'linter': 'flow',
    \ })
" english
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'look',
    \ 'allowlist': ['text', 'markdown'],
    \ 'completor': function('asyncomplete#sources#look#completor'),
    \ })


" lsp
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
      \ 'priority': 10,
      \ }))

""""""""""""""""""""""""""""""""""""""""""
"             Airline config             "
""""""""""""""""""""""""""""""""""""""""""

let g:airline_section_y = "%3l/%L:%2v"
let g:airline_section_z = "%{battery#component()}"
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#left_sep = ""
let g:airline#extensions#bufferline#right_sep = ""
let g:airline#extensions#bufferline#left_alt_sep = ""
let g:airline#extensions#bufferline#right_alt_sep = ""
let g:airline#extensions#tabline#left_sep = " "
let g:airline#extensions#tabline#right_sep = ""
let g:airline#extensions#tabline#left_alt_sep = ""
let g:airline#extensions#tabline#right_alt_sep = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 1


""""""""""""""""""""""""""""""""""""""""""
"            Workspace config            "
""""""""""""""""""""""""""""""""""""""""""

let g:workspace_create_new_tabs = 0
let g:workspace_session_directory = $HOME . '/.config/nvim/sessions/'
let g:workspace_session_disable_on_args = 1


""""""""""""""""""""""""""""""""""""""""""
"            GitGutter config            "
""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1


""""""""""""""""""""""""""""""""""""""""""
"               ALE config               "
""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'normal'
" let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'json': ['jq'],
\   'nim': ['nimlsp', 'nimcheck']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'nim': ['nimpretty']
\}


""""""""""""""""""""""""""""""""""""""""""
"            gutentags config            "
""""""""""""""""""""""""""""""""""""""""""

let g:gutentags_cache_dir = '~/.config/nvim/gutentags'


""""""""""""""""""""""""""""""""""""""""""
"             vim-json config            "
""""""""""""""""""""""""""""""""""""""""""

au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=0 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END


""""""""""""""""""""""""""""""""""""""""""
"             vim-json config            "
""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 1

""""""""""""""""""""""""""""""""""""""""""
"           incsearch config            "
""""""""""""""""""""""""""""""""""""""""""

let g:incsearch#magic = '\v'
