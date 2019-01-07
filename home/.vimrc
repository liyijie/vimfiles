" Disable vi compatibility
set nocompatible

" Used for some plugins to display fancy symbols.  Hopefully doesn't blow
" things up.
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-run-interactive'
Plug 'croaky/vim-colors-github'
Plug 'danro/rename.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kchmck/vim-coffee-script'
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ctags.vim'
Plug 'vim-scripts/matchit.zip'

Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-powerline'
Plug 'godlygeek/tabular'
Plug 'jelera/vim-javascript-syntax'
Plug 'altercation/vim-colors-solarized'
Plug 'othree/html5.vim'
Plug 'xsbeats/vim-blade'
Plug 'Raimondi/delimitMate'
Plug 'groenewege/vim-less'
Plug 'Lokaltog/vim-easymotion'
Plug 'dikiaap/minimalist'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'tpope/vim-commentary'
Plug 'wookayin/vim-typora'
Plug 'wakatime/vim-wakatime'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'wavded/vim-stylus'
Plug 'isRuslan/vim-es6'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Leader
let mapleader = " "
:nmap , <space>
:nmap ; <space>

" No need for the Error Bell in any form, thanks
set noerrorbells
set novisualbell

" Use filetype appropriate indent
filetype plugin indent on

" Automatically indent
set autoindent
set smartindent

" Always try and do syntax highlighting
syntax on

" Use spaces instead of tabs at the start of the line
set smarttab
set expandtab

" Color scheme
set t_Co=256
colorscheme minimalist
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" fzf support
set rtp+=/usr/local/bin/fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>f :FZF<CR>

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Ack search
let g:ackprg = 'ag --nogroup --nocolor --column'

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

augroup vimrcEx
  autocmd!

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.json.jbuilder set filetype=ruby

  autocmd FileType markdown setlocal spell

  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Always show line numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Reset the window title in non-GUI mode to something a little more helpful.
set title

" Use a manual foldmethod so that folds persist in files
set foldmethod=marker

" Tab completion in command mode shows all possible completions, shell style.
set wildmenu
set wildmode=longest:full,full

" Remember global variables across vim sessions
set viminfo^=!

" Set minimum split height to 1 line instead of 2
set wmh=0

" A split will default to being creating under or to the right of the current.
set splitbelow splitright

" Always show diffs veritcally regardless of the space available. Horizontal
" diffs are unreadable to me.
set diffopt=vertical

" Indent plugin settings for Zenburn
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
augroup indentguidesaugroup
  autocmd!
  autocmd VimEnter,Colorscheme * hi IndentGuidesOdd ctermbg=236
  autocmd VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240
augroup END

" Show a statusline always.
set laststatus=2

" Custom Fugitive shortcuts
noremap <leader>gs :Gstatus <CR>
noremap <leader>gc :Gcommit <CR>
noremap <leader>gd :Gdiff <CR>
noremap <leader>gb :Gblame <CR>

" Use slim highlighting for emblem templates
augroup emblem_as_slim_augroup
  autocmd BufNewFile,BufRead *.emblem set filetype=slim
augroup END

" Make Y behave to EOL like most capitolized normal-mode commands.
noremap Y y$

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" Close omnicompletion preview window when you are finished inserting.
" source:
" http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Allow reselection of last pasted text.
" source:
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle paste mode on and off.
" source: http://amix.dk/vim/vimrc.html
map <leader>pp :setlocal paste!<cr>

" Ale linter options
let g:ale_linters = {'go': ['gofmt', 'go build']}
let g:airline#extensions#ale#enabled = 1

" Fix for UTF-8 annoyances in vagrant ubuntu
let g:NERDTreeDirArrows=0

" Let me toggle NERDTree easiy
nnoremap <leader>nt :NERDTreeToggle<cr>

" Show NERDTree next to startify when you start without selecting a file.
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif
" Don't open NERDTree's selection in a split under startify.
autocmd User Startified setlocal buftype=

" Don't use the special powerline fonts in the tmux theme, since I don't have
" or want that. Well, maybe I want it, but...
let g:tmuxline_powerline_separators = 0

au BufNewFile,BufRead *.dockerfile set filetype=dockerfile

" For the terraform plugin and to consistently format Terraform files.
let g:terraform_fmt_on_save = 1

" Unite mappings {{{
map <leader>ar :UniteResume<CR>
map <leader>ab :Unite -no-split -start-insert buffer<CR>
map <leader>ay :Unite -start-insert history/yank<CR>
map <leader>af :Unite -no-split -start-insert file_rec/neovim<CR>
map <leader>ag :Unite grep:.<CR>

let g:unite_source_grep_command = 'ack-grep'
let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
let g:unite_source_grep_recursive_opt = ''

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
        inoremap <silent><buffer><expr> <C-x> unite#do_action('split')
        inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction
" }}}

" My custom normal/insert mode mappings {{{

" Remap jk or to be the same as Esc to leave Insert mode.
inoremap jk <Esc>
inoremap jj <Esc>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>r :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

let g:rspec_command = 'Dispatch bundle exec rspec -f d -c {spec}'
" let g:rspec_command = "!bundle exec rspec -f d -c {spec}"
let g:rspec_runner = "os_x_iterm2"

" Run commands that require an interactive shell
nnoremap <Leader>s :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" autocmd Syntax javascript set syntax=jquery " JQuery syntax support

set matchpairs+=<:>
set statusline+=%{fugitive#statusline()} "  Git Hotness

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=40
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1
autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
nmap <C-g> :NERDTreeToggle<cr>
nnoremap <leader>h :NERDTreeFind<CR>
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Emmet
let g:user_emmet_mode='i' " enable for insert mode
" let g:user_emmet_install_global = 0
" autocmd FileType html,css,vue EmmetInstall
let g:user_emmet_leader_key='<C-E>'

" Search results high light
" set hlsearch

" nohlsearch shortcut
" nmap -hl :nohlsearch<cr>
" nmap +hl :set hlsearch<cr>

nnoremap <leader>w :w<CR>
nnoremap <leader>e :e<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qa<CR>
nnoremap <leader>y :!<CR>

" reg past command
nnoremap <leader>g :reg<CR>
nnoremap <leader>" ""p"<CR>
nnoremap <leader>0 "0p"<CR>
nnoremap <leader>1 "1p"<CR>
nnoremap <leader>2 "2p"<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" set ttyfast
" set lazyredraw
set clipboard=unnamed

" Quick editing and reloading of .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" C-j in insert mode escapes normal mode and writes the file. With shift,
" write and quit. This requires a terminal setting or it might just freeze
" your display and nothing else, which is rad. See:
" http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
inoremap <C-j> <Esc>:w<Enter>
inoremap <C-s> <Esc>:w<Enter>
nnoremap <C-s> :w<Enter>

" '<leader>dp/s/v' brings up an :e/sp/vsp prompt in the context of the current file's directory
noremap <leader>dp :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>ds :sp <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>dv :vsp <C-R>=expand("%:p:h") . "/" <CR>

" '<leader>df' opens up NetRW in the directory of the current file
noremap <leader>df <leader>dp<CR>

" '<leader>dd' opens up NetRW in Vim's current directory
noremap <leader>dd :e .<CR>

" Create directional shortcuts for moving among between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Toggle TagBar. I don't use it a lot, but it's helpful.
nnoremap <leader>b :TagbarToggle<CR>

" It's 'm' for make. Even though it's not running make. Deal with it.
nnoremap <leader>m :Dispatch<CR>

" Close/open quickfix/preview windows from anywhere. Why has it taken me so
" long to map this?
nnoremap <leader>qq :cclose<CR>
nnoremap <leader>qp :pclose<CR>
nnoremap <leader>qo :copen<CR>

" C-Enter in insert mode starts a new indented line below. I know this doesn't
" *look* like Ctrl-Enter, but that seems to be how it's sent in iterm2.
" Hopefully that carries over to other places I work.
inoremap <C-M> <Esc>o

" Base64 encode/decode. Special detection because, of course, OSX has its own
" super special base64 that doesn't do stuff like base64 encode things?
if has("unix")
  vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>

  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    vnoremap <leader>64e c<c-r>=system('base64 -w0', @")<cr><esc>
  else
    vnoremap <leader>64e c<c-r>=system('openssl base64 -e -A', @")<cr><esc>
  endif

  " The pneumonic to remember the mapping is Kubernetes Secret Decode/Encode.
  " You need to linewise visually select the entire secret block (or as much
  " of it as you care to decode) first. I use the vim-indent-object to make
  " this a little faster (vii).
  vnoremap <leader>ksd :'<,'>normal $vT <leader>64d<cr>
  vnoremap <leader>kse :'<,'>normal $vT <leader>64e<cr>
endif

" }}}

" Search Related options {{{

" Highlight searched terms
set hlsearch

" bind \ to clear highlighting, though search term remains and 'n' works
noremap <silent> \ :silent nohlsearch<CR>

" Use incremental search
set incsearch

" Searches are case insensitive, unless upper case letters are used
set ignorecase
set smartcase

" }}}

" Ruby specific options {{{

" This will highlight trailing whitespace and tabs preceded by a space character
let ruby_space_errors = 1

" Syntax highlight ruby operators (+, -, etc)
let ruby_operators = 1

augroup rubyindentstyle
  autocmd!
  autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 expandtab

  autocmd FileType ruby hi link yardGenericTag rubyInstanceVariable
  autocmd FileType ruby hi link yardGenericDirective rubyInstanceVariable
augroup END

" }}}

" Typescript specific options {{{

augroup typescriptindentstyle
  autocmd!

  " don't use indent from the leafgarland/typescript-vim
  let g:typescript_indent_disable = 1

  autocmd FileType typescript set autoindent shiftwidth=2 softtabstop=2 expandtab
augroup END
" }}}

" GoLang options {{{
augroup golangstyle
  autocmd!
  autocmd FileType go set tabstop=2 shiftwidth=2 noexpandtab
  autocmd FileType go noremap <leader>gt :GoTest <CR>
  autocmd FileType go noremap <leader>gT :GoTestFunc <CR>
  autocmd FileType go noremap <leader>gi :GoInfo <CR>

	" rails.vim-inspired switch commands, stolen from vim-go docs
	autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

if has('nvim')
  function! GoStatusLine()
    return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
  endfunction

  function! AirlineInit()
          let g:airline_section_c = get(g:, 'airline_section_c', g:airline_section_c)
          let g:airline_section_c .= g:airline_left_sep . ' %{GoStatusLine()}'
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()
endif

" Use vim-dispatch for appropriate commands. Currently only build, but maybe
" some day test as well: https://github.com/fatih/vim-go/pull/402
let g:go_dispatch_enabled = 1

" This is a hacky fix for :GoTest breaking when you use testify. It's parsing
" the errors and expecting things to look very specific, even though testify
" isn't doing anything that the standard testing library doesn't support. This
" stops it from opening a nonexistant file because it's incorrectly parsing
" the error message.
let g:go_jump_to_error=0

" Just autoimport for me, OK?
let g:go_fmt_command = "goimports"

" }}}

" Rust options {{{
augroup rustlangstyle
  autocmd!
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
  autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs let b:dispatch = 'cargo run'
  
  autocmd FileType rust setlocal omnifunc=LanguageClient#complete
  
  " As stolen from the LanguageClient plugin's README. These are applicable to
  " more than Rust, but lets see them actually work for a minute before we get
  " too crazy:
  " https://github.com/autozimu/LanguageClient-neovim
  autocmd FileType rust nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  autocmd FileType rust nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType rust nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType rust nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
augroup END

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }

" part of rust-lang/rust.vim
let g:rustfmt_autosave = 1
" }}}

" Coffee specific options {{{
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" }}}

" Javascript specific options {{{
autocmd BufNewFile,BufReadPost *.js setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.hbs setl shiftwidth=2 expandtab
" }}}

" CSS specific options {{{
autocmd BufNewFile,BufReadPost *.css setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.scss setl shiftwidth=2 expandtab
" }}}
