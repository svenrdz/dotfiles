" Leader mappings
let mapleader = "\<Space>"
nmap <Leader>l <Esc>:Black<CR>
nmap <Leader><CR> :exe 'cd '.expand('%:h')<CR>
nmap <Leader>n <Esc>:split<CR>
nmap <Leader>v <Esc>:vsplit<CR>
nmap <Leader>f <Esc>:Files<CR>
nmap <Leader>p <Esc>:ProjectFiles<CR>
nmap <Leader>h <Esc>:History<CR>
nmap <Leader>: <Esc>:History:<CR>
nmap <Leader>/ <Esc>:History/<CR>
nmap <Leader>a <Esc>:Ag!<CR>
nmap <Leader>gd <Esc>:Gdiff<CR>
nmap <Leader>t <Esc>:TagbarToggle<CR>
nmap <Leader>md <Esc>:MarkdownPreview<CR>
nmap <Leader>b <Esc>:Buffers<CR>
nmap <Leader>ev <Esc>:BufExplorerVerticalSplit<CR>
nmap <Leader>en <Esc>:BufExplorerHorizontalSplit<CR>
nmap <Leader>q <Esc>:Bclose<CR>
nmap <Leader>zz <Esc>:let &scrolloff = 999 - &scrolloff<CR>
nmap <Leader>j <Esc>:tabnext<CR>
nnoremap <Leader><Leader> <C-^>
nmap <C-x> <Esc>:VimwikiToggleListItem<CR>
nmap <C-f> <Esc>:BLines<CR>
nmap ga <Esc>:GitGutterStageHunk<CR>
nmap gu <Esc>:GitGutterUndoHunk<CR>
nmap gv <Esc>:GitGutterPreviewHunk<CR>
nmap <Leader>c <Esc>:Gcommit<CR>
nmap ]h <Esc>:GitGutterNextHunk<CR>
nmap [h <Esc>:GitGutterPrevHunk<CR>

" Nicer search
map /  <Plug>(incsearch-stay)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-forward)

" Tab navigation like Firefox.
nnoremap J <Esc>:bnext<CR>
nnoremap K <Esc>:bprevious<CR>
noremap T :tab split<CR>
" nnoremap <C-t>     :tabnew<CR>
" nnoremap <C-w>     :tabclose<CR>
" inoremap <C-t>     <Esc>:tabnew<CR>i
" inoremap <C-w>     <Esc>:tabclose<CR>i
" nnoremap J gt
" nnoremap K gT

" general shortcuts
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
noremap gV `[v``]
nnoremap D dd
vmap j gj
vmap k gk
nmap j gj
nmap k gk
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
imap <C-j> <nop>
imap <C-k> <nop>
imap <C-n> <nop>
map <C-c> <nop>
inoremap <C-]> <Esc><Esc>
tnoremap <C-]> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber

function! LoadOrReload(buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget > 0
    execute 'Bclose! '.a:buffer
  endif
  execute 'terminal '.a:buffer
  execute 'file '.a:buffer
endfunction

" function for creating alias
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W", "w")
call SetupCommandAlias("cdp", "cd ~/Pandascore/pandavision/pndvsn")
call SetupCommandAlias("cdr", "cd ~/Pandascore/tools/ramen")
call SetupCommandAlias("cdg", "cd `git rev-parse --show-toplevel`")
call SetupCommandAlias("julab", "call LoadOrReload('julab')")
call SetupCommandAlias("psco", "call LoadOrReload('psco')")
