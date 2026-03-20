""""""""""""""""""""
" functions
"
function! ToggleRelativeNumber()
  if &rnu == 1
    set number
    set relativenumber!
  else
    set relativenumber
  endif
endfunction
""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
let g:AutoPairsFlyMode = 0
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-abolish'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-characterize'
Plug 'posva/vim-vue'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'digitaltoad/vim-jade'
Plug 'janko-m/vim-test'
Plug 'mileszs/ack.vim'
Plug 'isobit/vim-caddyfile'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'tomlion/vim-solidity'
Plug 'pangloss/vim-javascript'
Plug 'jason0x43/vim-js-indent'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/csv.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

Plug 'radenling/vim-dispatch-neovim'
let $NVIM_NODE_LOG_FILE='/tmp/nvim-node.log'
let $NVIM_NODE_LOG_LEVEL='info'

call plug#end()

" =================== Plugin Config ================
let do_syntax_sel_menu = 1 " Show the languages in the syntax menu by default

" =================== General Config ================
set mouse=a
set nowrap
set smartcase
set smartindent
set smarttab
set lazyredraw
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set number
set ruler
set sta
set ls=2                       " show a status line even when only one window is shown
set whichwrap+=<,>,[,]
set splitbelow splitright
set noswapfile
set nobackup

set wildmenu
set rtp+=/opt/homebrew/opt/fzf
set wildmode=longest:list,full
set wildignore+=*.o,*.obj,.git,*.swp,*.pyc
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Spelling ========================
set spelllang=en
set spellfile=$HOME/.vim/spellfile.en.add

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" My color scheme

colorscheme nightfly
let g:airline_theme='dark'

tmap <C-o> <C-\><C-n>

" Keep the cursor at the pre-editing positing when using .
" http://vim.wikia.com/wiki/VimTip1142
nmap . .`[

map <Leader>n :call ToggleRelativeNumber()<cr>
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
inoremap <S-Tab> <ESC><<i
nnoremap j gj
nnoremap <Down> gj
nnoremap k gk
nnoremap <Up> gk
nnoremap K i<CR><Esc>
nnoremap <Leader>] :cnext<CR>
nnoremap <Leader>[ :cprevious<CR>
inoremap <C-s> <Esc>

augroup cursors
  au InsertEnter * set cursorline
  au InsertLeave * set nocursorline
augroup END

augroup filetypes
  autocmd!

  au BufRead,BufNewFile *.vhost set ft=nginx
  au FileType vim set sw=2 ts=2
  au FileType ruby,rb,javascript,html set sw=2 ts=2
  au FileType python set sw=4 ts=4
  au Filetype gitcommit set spell textwidth=72

  function! SetEMCAOptions()
    nmap <buffer> <Leader>e <Plug>(TSRename)
    set makeprg=npm\ run\ build
  endfunction
  au FileType typescript,javascript call SetEMCAOptions()

augroup end

let python_highlight_all=1

set undodir=~/.vim/backups
set undofile

set completeopt=longest,menuone

" Select item, don't inserty newline (acts likt <C-Y>)
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Syntax Dependent Folding for C/C++/Java/(C#)
set nofoldenable
augroup folding
  au filetype c,cpp set fdm=marker
augroup end

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set title

" Searching
set incsearch scs hls
"After a search hit CTRL-CR to remove hls
nnoremap <c-cr> :noh<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader><leader> :noh<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

if executable('rg')
  let g:ackprg = 'rg --column'
  let $FZF_DEFAULT_COMMAND= 'rg --files -S'
elseif executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  let $FZF_DEFAULT_COMMAND= 'ag -g ""'
endif


nnoremap <silent> <Leader>b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
nnoremap <leader>t :FZF<CR>
nnoremap <leader>s :Tags<CR>
nnoremap <leader>cs :BTags<CR>
nnoremap <leader>fg :GGrep
nnoremap <leader>fa :Ack

let test#strategy = "neovim"
let g:test#javascript#jest#file_pattern = '\v((__tests__|spec|test)/.*\.(js|jsx|coffee|ts|tsx))|(.*\.test\.(js|jsx|coffee|ts|tsx))$'
nnoremap <Leader>af :TestFile<CR>
nnoremap <Leader>an :TestNearest<CR>
nnoremap <Leader>al :TestLast<CR>
nnoremap <Leader>as :TestSuite<CR>
nnoremap <Leader>av :TestVisit<CR>

nnoremap <Leader>m :Make<CR>

au filetype typescript,javascript nnoremap <leader>fs :TSSearchFZF

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
set tags=./tags;
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
imap <c-x><c-f> <plug>(fzf-complete-path)

set inccommand=nosplit

" yank and paste from system buffer
noremap <leader>p "+p
noremap <leader>y "+y

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"search options for visual mode (* searches for highlighted text, # backwards)
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

let g:airline#extensions#tabline#enabled = 1

augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source %
augroup END


" TABSSSS
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>


hi DiffText   cterm=none ctermfg=Black ctermbg=Red gui=none guifg=Black guibg=Red
hi DiffChange cterm=none ctermfg=Black ctermbg=LightMagenta gui=none guifg=Black guibg=LightMagenta

" Use the system clipboard
set clipboard+=unnamedplus
