""""""""""""""""""""""""""""""""""""""""""
"             ranger options             "
""""""""""""""""""""""""""""""""""""""""""

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
" TAB completion done right (with snips) "
""""""""""""""""""""""""""""""""""""""""""

" Don't map any tabs, I'll do it later "
let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<NOP>'
let g:UltiSnipsJumpBackwardTrigger = '<NOP>'
let g:SuperTabMappingForward = '<NOP>'
let g:SuperTabMappingBackward = '<NOP>'
" Don't unmap my mappings
let g:UltiSnipsMappingsToIgnore = [ "SmartTab", "SmartShiftTab" ]

" Make <CR> smart
let g:ulti_expand_res = 0
function! SmartNewline()
  if pumvisible()
    " if in completion menu - just close it and leave the cursor at the
    " end of the completion
    return deoplete#smart_close_popup() . "\<CR>"
  else
    " otherwise, just do an "enter"
    return "\<return>"
  endif
endfunction
inoremap <return> <C-R>=SmartNewline()<CR>

" Enable tabbing and shift-tabbing through list of results
function! g:SmartTab()
  if pumvisible()
    return SuperTab("p")
  else
    return ''
  endif
endfunction
inoremap <silent> <tab> <C-R>=g:SmartTab()<cr>
snoremap <silent> <tab> <Esc>:call g:SmartTab()<cr>

function! g:SmartShiftTab()
  if pumvisible()
    return SuperTab("n")
  else
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
      return SuperTab("n")
    endif
    return ''
  endif
endfunction
inoremap <silent> <s-tab> <C-R>=g:SmartShiftTab()<cr>
snoremap <silent> <s-tab> <Esc>:call g:SmartShiftTab()<cr>

" Fix tab collision vim-wiki // deoplete
let g:vimwiki_table_mappings = 0


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

" function! GitBranch() abort
"   let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null
"               \ | tr -d '\n'")
"   return strlen(l:branchname) > 0 ? '#'.l:branchname : ''
" endfunction

" set statusline=%!ActiveStatus()                 " Style it

" function! ActiveStatus() abort                  " When in the active window
"   let statusline=""                           " Initialize it
"   let statusline.="%3*%m"                     " Modified flag
"   let statusline.="%6*%{expand('%:p:h')}/"    " Full-path to current buffer
"   let statusline.="%4*%t"                     " File name
"   let statusline.="%5*%{GitBranch()}"         " Show Git branch, if applicable
"   let statusline.="%="                        " Switch to right-side
"   let statusline.="%4*%y\ "                   " Filetype
"   let statusline.="%3*"                       " Color change (see :hi)
"   let statusline.="\|%4l\:%2c\|"              " Line and column
"   let statusline.="%2*%{&spell?'[SPELL]':''}" " Spell flag
"   let statusline.="%1*%r%0*"                  " Read-only flag
"   return statusline
" endfunction

" function! PassiveStatus() abort                 " When in a non-active window
"   let statusline=""                           " Initialize it
"   let statusline.="%6*%m"                     " Modified flag
"   let statusline.="%{expand('%:p:h')}/"       " Full-path to current buffer
"   let statusline.="%t"                        " File name
"   let statusline.="%{GitBranch()}"            " Show Git branch, if applicable
"   let statusline.="%="                        " Switch to right-side
"   let statusline.="%y\ "                      " Filetype
"   let statusline.="\|%4l\:%2c\|"              " Line and column
"   let statusline.="%{&spell?'[SPELL]':''}"    " Spell flag
"   let statusline.="%r%0*"                     " Read-only flag
"   return statusline
" endfunction

" augroup user_statusline                         " Change based on active window 
"   autocmd!
"   autocmd WinEnter * setlocal statusline=%!ActiveStatus()
"   autocmd WinLeave * setlocal statusline=%!PassiveStatus()
" augroup END


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

" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1


""""""""""""""""""""""""""""""""""""""""""
"             undotree config            "
""""""""""""""""""""""""""""""""""""""""""

let g:undotree_ShortIndicators = 1


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
