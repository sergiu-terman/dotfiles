call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'sickill/vim-monokai'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'kassio/neoterm'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'kchmck/vim-coffee-script'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-endwise'


call plug#end()


set clipboard=unnamed
set ignorecase
set number
colorscheme SpacegrayEighties
set t_Co=256
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set mouse=a
set noswapfile
set modifiable

let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|bower_components|tmp)$'

let NERDTreeIgnore = ['\.pyc$']
set statusline+=%f

" nerdtree shortcut
nnoremap <silent> <C-n> :NERDTreeToggle<cr>

" new tab shortcut
nnoremap <silent> <C-t> :tabnew<cr>

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Show trailing whitespace:
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
nnoremap <silent> ,h :match ExtraWhitespace /\s\+$/<cr>
" Make code selection easier with vvvvvvv
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
let g:ctrlp_use_caching = 0
" Make CtrP work much faster for autocompletion
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" neoterm config
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

" run set test lib
nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" tired of :W not comman
cnoreabbrev W w

" tired of pressing SHIFT ... ) :
nnoremap ; :
