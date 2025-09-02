" Basic settings
let mapleader = " "
set number                    " Line numbers
set relativenumber           " Relative line numbers
set tabstop=4               " Tab width
set shiftwidth=4            " Indent width
set expandtab               " Use spaces instead of tabs
set autoindent              " Auto-indent new lines
set smartindent             " Smart indentation
set wrap                    " Wrap long lines
set ignorecase              " Case-insensitive search
set smartcase               " Case-sensitive if uppercase present
set hlsearch                " Highlight search results
set incsearch               " Show matches while typing
set mouse=a                 " Enable mouse support
set clipboard=unnamedplus   " Use system clipboard (Linux)
set encoding=utf-8

syntax enable               " Syntax highlighting
set cursorline             " Highlight current line
set showmatch              " Show matching brackets
set wildmenu               " Enhanced command completion

" Quality of life
set backspace=indent,eol,start  " Make backspace work properly
set noswapfile             " Disable swap files
set undofile               " Persistent undo
set undodir=~/.vim/undodir " Undo directory

" Better completion behavior - FIXED
set completeopt=menu,menuone,noselect
set pumheight=10  " Limit popup menu height
set shortmess+=c  " Don't show completion messages
set updatetime=200  " Faster completion
set signcolumn=yes  " Always show sign column

set clipboard=unnamedplus " uses system clipboard
set foldmethod=syntax
set foldlevel=99
" Basic keybindings
nnoremap <C-s> :w<CR>
nnoremap <C-t> :tabnew<CR>
" Use jj to exit insert mode
inoremap jj <Esc>
set timeoutlen=500
" Ensure hidden buffers are allowed
set hidden                                " Allow switching buffers without saving

" Map Ctrl + ` to toggle terminal
nnoremap <leader>t :FloatermToggle<CR>
tnoremap <leader>t <C-\><C-n>:FloatermToggle<CR>
noremap <leader>tk :FloatermKill<CR>

" Floaterm settings for full-screen terminal
let g:floaterm_width = 1.0
let g:floaterm_height = 1.0
let g:floaterm_position = 'center'
let g:floaterm_borderchars = ['─','│','─','│','╭','╮','╯','╰'] " optional, for style

" Resize splits with arrow keys
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -4<CR>
nnoremap <C-Right> :vertical resize +4<CR>

" Split
nnoremap <C-\> :vsplit<CR>

" Easier split window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move selected lines down
vnoremap J :m '>+1<CR>gv=gv
" Move selected lines up
vnoremap K :m '<-2<CR>gv=gv

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'on': 'Files' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'  " Added for real-time Git diff in sign column
" color themes
Plug 'morhetz/gruvbox'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'

" Comment/Uncomment lines
Plug 'preservim/nerdcommenter'

"Code completion and snippets - FIXED ORDER
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'dense-analysis/ale'  " For linting/formatting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Syntax highlighting for icons
Plug 'ryanoasis/vim-devicons'              " File icons
Plug 'Xuyuanp/nerdtree-git-plugin' " for git status icons
" Plug 'luochen1990/rainbow'
Plug 'voldikss/vim-floaterm' " Floating terminal
Plug 'APZelos/blamer.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-surround' " Surround words
Plug 'mustache/vim-mustache-handlebars'  " Syntax for Handlebars
Plug 'puremourning/vimspector' " For debugging
Plug 'Exafunction/codeium.vim', { 'branch': 'main' } " windsurf plugin for code completion
Plug 'machakann/vim-highlightedyank'
call plug#end()

" YAML Settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal foldmethod=indent

" Resource vimrc file
nnoremap <leader>sr :source ~/.vimrc<CR>

" Color scheme
colorscheme ayu
"colorscheme codedark
"colorscheme vim-monokai-tasty
set termguicolors
"let ayucolor="dark"
set background=dark
let g:airline_theme='murmur'   
" NERDTree settings
nnoremap <C-b> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" FZF settings
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>
" Use bat as previewer globally in fzf.vim
let g:fzf_preview_command = 'bat --style=numbers --color=always --line-range :500 {}'
"nnoremap <leader>F :call SearchByFileTypes()<CR>

"function! SearchByFileTypes()
  "let l:exts = input('File extensions (comma separated, e.g., js,ts): ')
  "let l:globs = join(map(split(l:exts, ','), {_, v -> '--glob "*.' . v . '"' }), ' ')
  "execute 'Rg ' . l:globs
"endfunction

" Git blame
let g:blamer_enabled = 1

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:highlightedyank_highlight_duration = 200
" set t_Co=256
" set t_ut=
" let g:codedark_conservative=1
" let g:coeddark_medern=1
" " Make the background transparent
" let g:codedark_transparent=1
" let g:rainbow_active = 1 " Enable color brackets

" Git status, commit, and blame
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gf :GFiles?<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gv :Gvdiffsplit<CR>
nnoremap <leader>gm :Gvdiffsplit!<CR>

" Better diff colors
highlight DiffAdd    ctermbg=22 ctermfg=white guibg=#005f00 guifg=#ffffff
highlight DiffDelete ctermbg=52 ctermfg=white guibg=#5f0000 guifg=#ffffff  
highlight DiffChange ctermbg=17 ctermfg=white guibg=#00005f guifg=#ffffff
highlight DiffText   ctermbg=53 ctermfg=white guibg=#5f005f guifg=#ffffff cterm=bold gui=bold
" More visible conflict markers
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e

" Quick search and replace
nnoremap <leader>s :%s//<left>
nnoremap <leader>S :%s/\<<C-r><C-w>\>/

" Replace word under cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

" Replace in selection
vnoremap <leader>s :s//<left>


" Folding keybindings (similar to VSCode)
nnoremap za za            " Toggle fold under cursor
nnoremap zA zA        " Toggle all folds under cursor
nnoremap zR zR                 " Open all folds
nnoremap zM zM                 " Close all folds
nnoremap zr zr                 " Open one level of folds
nnoremap zm zm                 " Close one level of folds

" CoC.nvim configuration
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-snippets',
  \ 'coc-tailwindcss',
  \ ]

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"let g:coc_preferences_use_vertical_split = 1 " not working 
nnoremap <silent> <leader>gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> <leader>gr :vert bo call CocActionAsync('jumpReferences')<CR>
"nmap <leader>/ <leader>cc<CR>
"nmap <leader><leader>/ <leader>cu<CR>
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
set updatetime=200
" Then override CoC highlight group
hi CocHighlightText cterm=underline gui=underline

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" UltiSnips configuration - FIXED CONFLICTS
let g:UltiSnipsExpandTrigger="<C-l>"          " Use Ctrl+l for snippet expansion
let g:UltiSnipsJumpForwardTrigger="<C-j>"     " Ctrl+j to jump forward in snippets
let g:UltiSnipsJumpBackwardTrigger="<C-k>"    " Ctrl+k to jump backward in snippets

" vim-devicons configuration
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" NERDTree with devicons
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",
    \ "Modified"  : "#d9bf91",
    \ "Renamed"   : "#51C9FC",
    \ "Untracked" : "#FCE77C",
    \ "Unmerged"  : "#FC51E6",
    \ "Dirty"     : "#FFBD61",
    \ "Clean"     : "#87939A",
    \ "Ignored"   : "#808080"
    \ }

" Buffer Navigation
" Open FZF buffer list
nnoremap <leader>b :Buffers<CR>   
" Close current buffer
nnoremap <leader>bd :bdelete<CR>  
" Close all buffers
nnoremap <leader>ba :bufdo bd<CR> 
" next buffer
nnoremap <leader>k :bnext<CR>     
" previous buffer
nnoremap <leader>j :bprevious<CR> 
" Open current buffer in new tab
nnoremap <leader>bt :tab sb %<CR>

" Buffer display in vim-airline
let g:airline#extensions#tabline#enabled = 1        " Enable tabline for buffers/tabs
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer numbers
let g:airline#extensions#tabline#fnametruncate = 20 " Truncate long file names
let g:airline#extensions#tabline#fnamecollapse = 1  " Collapse directories
let g:airline#extensions#tabline#show_splits = 0    " Focus on buffers/tabs, not splits

" Tmux + vim navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""    Vim spector mappings  Start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Debug session state tracking
let g:debug_session_active = 0
" Specifiying the dir to look for available debuggers
"let g:vimspector_base_dir = expand('~/.vim/plugged/vimspector')

function! ToggleDebugSession()
    if g:debug_session_active
        call vimspector#Reset()
        let g:debug_session_active = 0
        echo "Debug: OFF"
    else
        call vimspector#Launch()
        let g:debug_session_active = 1
        echo "Debug: ON"
    endif
    "if exists('g:vimspector_session_id') && g:vimspector_session_id > 0
        "" Session is active, stop it
        "call vimspector#Reset()
        "echo "Debug session stopped"
    "else
        "" No session, start one
        "call vimspector#Launch()
        "echo "Debug session started"
    "endif
endfunction

function! ToggleBreakpoint()
  call vimspector#ToggleBreakpoint()
  echo "Breakpoint toggled"
endfunction

" General vimspector setup
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir = '/home/balaji/.vim/plugged/vimspector'
" Vimspector UI layout (optional but recommended)
let g:vimspector_sidebar_width = 50
let g:vimspector_code_minwidth = 85
let g:vimspector_terminal_minheight = 15

nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

" Key mappings
"nmap <F5> :call ToggleDebugSession()<CR>
"nmap <F6> <Plug>VimspectorContinue
"nmap <F9> :call ToggleBreakpoint()<CR>
"nmap <F10> <Plug>VimspectorStepOver
"nmap <F11> <Plug>VimspectorStepInto
"nmap <F12> <Plug>VimspectorStepOut
"nmap <S-F5> <Plug>VimspectorRestart

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Vim spector mappings  End
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
"autocmd VimEnter * highlight airline_c guifg=#ffffff guibg=#1c2328 ctermfg=15 ctermbg=8

function! MyDiffHighlights()
  highlight DiffAdd    cterm=bold ctermbg=none ctermfg=Green  gui=bold guibg=NONE guifg=#a6e22e
  highlight DiffDelete cterm=bold ctermbg=none ctermfg=Red    gui=bold guibg=NONE guifg=#ff5555
  highlight DiffChange cterm=bold ctermbg=none ctermfg=Green  gui=bold guibg=NONE guifg=#a6e22e
  highlight DiffText   cterm=bold ctermbg=none ctermfg=Red    gui=bold guibg=NONE guifg=#ff5555
endfunction

augroup MyDiffColors
  autocmd!
  autocmd ColorScheme * call MyDiffHighlights()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Codeium Configuration Start
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:codeium_enabled = v:true " Enable codeium
let g:codeium_disable_bindings = 1
" Custom keybindings
imap <script><silent><nowait><expr> <C-g> codeium#Accept()
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Codeium Configuration End
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType javascript,typescript packadd vimspector

" Resize the vim buffers automatically
if has("autocmd")
  autocmd VimResized * wincmd =
endif
