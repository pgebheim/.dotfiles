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
let s:fzf_path = substitute(system('which fzf'), '/fzf\n$', '', '')
if !empty(s:fzf_path) && isdirectory(s:fzf_path)
  let &rtp .= ',' . s:fzf_path
endif
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
  au FileType markdown setlocal spell textwidth=120 wrap linebreak nonumber norelativenumber

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

" [Tags] Command to generate tags file
set tags=./tags;

imap <c-x><c-f> <plug>(fzf-complete-path)

set inccommand=nosplit

" yank and paste from system buffer
noremap <leader>p "+p
noremap <leader>y "+y

"search options for visual mode (* searches for highlighted text, # backwards)
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

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
