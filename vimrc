"==========vim ui===========
syntax enable
set background=dark
"colorscheme solarized
colorscheme space-vim-dark
"let g:solarized_termcolors=256
"colorscheme molokai
"let g:Powerline_colorscheme='solarized256'

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
packadd! matchit

"==========vim IDE settings===========
" search
set incsearch
set ignorecase
set smartcase
" editor settings
set history=1000
set nocompatible
"set nofoldenable                                                 " disable folding
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set mouse=v                                                       " use mouse in all modes
set report=0                                                      " always report number of lines changed                "
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
" set relativenumber                                              " set relativenumber with current line
" Default Indentation
" enable filetype dectection and ft specific plugin/indent
filetype plugin indent on
filetype plugin on
filetype indent on
set autoindent
set cindent
set smartindent                                                   " indent when
set tabstop=4                                                     " tab width
set softtabstop=4                                                 " backspace
set shiftwidth=4                                                  " indent width
" set textwidth=120                                                 " set how much number character in a line
set nowrap                                                        " dont wrap lines
set smarttab
set expandtab                                                     " expand tab to space
set wildmenu                                                      " command line mode completion
set ttimeoutlen=0                                                 " to deal with it's slow when I swith insert to normal
set clipboard=unnamed                                             "vim uses the system clipboard
set hlsearch                                                      "Highlight Search
"set windows size
"set lines =40 columns=80
"set lines =28 columns=86
"winpos 200 100
"Do not back up files when overwriting them
set nobackup
set nowb
set noswapfile

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" filetyep detection
"autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
"autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
"autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType c,h setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
" syntax support
autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"Vertical alignment line
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1
" == vim Scroll horizontally shortcut keys===


"===================global shortcut key map ================
" let mapleader=";"
" Keybindings for paste toggle
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
" buffer switch shorcut key
map <Leader>bl :MBEToggle<cr>
"noremap <C-Tab> :MBEbn<CR>
"noremap <C-S-Tab> :MBEbp<CR>
noremap qq <C-W><C-W>
"file undo
nmap <Leader>u :GundoToggle<cr>
" easier navigation between split windows
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l
" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" remove tailing space
:command CC 1,$s/\s\+$//g
"eggcache vim
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa "exit all windows
:command QA qa

"===============useful hacking=========================

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if ! exists("g:leave_my_cursor_position_alone") |
            \     if line("'\"") > 0 && line ("'\"") <= line("$") |
            \         exe "normal g'\"" |
            \     endif |
            \ endif

"==================== code fold setting=================
set foldenable
set foldmethod=indent
set foldcolumn=0
setlocal foldlevel=1
set foldclose=all
set foldlevelstart=99
set foldopen-=search
set foldopen-=undo
"nnoremap <Space> @=((foldclosed(line('.'))<0)?'zc':'zo')<cr>

"---------------- ---------file title-------- ----------------- -------
function AddMyTitle()
    call append(0,"/***********************************************************")
    call append(1,"* Author       : dztdeng")
    call append(2,"* EMail        : datdeng@gmail.com")
    call append(3,"* Last modified: ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(4,"* Filename     : ".expand("%:t"))
    call append(5,"* Description  :")
    call append(6,"**********************************************************/")
    call append(7,"")
    echohl WarningMsg | echo "Successful in adding the copyright."|echohl None
endfunction
" update latest modified time & name
function UpdateTitle()
    normal m'
    execute '/* Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")@'
    normal ''
    normal mk
    execute '/* Filename     :/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
" Have a changes in the first 10 lines of the file
function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~'^\*\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddMyTitle()
endfunction

map <C-i> :call TitleDet() <cr>'s

"load plugin configration
source ~/.vim/Plugins.vim

"==========w0rp/ale==============
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''


"{---------------- ----------------- ----------------- -----------------
let g:rbpt_colorpairs = [
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['brown',       'firebrick3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ]
let g:rbpt_max = 16
"autocmd Syntax lisp,scheme,clojure,racket RainbowParenthesesToggle
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
"map <F5> :RainbowParenthesesToggle<cr>       " Toggle it on/off"
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"---------------- ------airline----- ----------------- ------------------
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#buffer_min_count = 1
"ShortCuts Keys for airline file buffer
map <tab> :bn <cr>
nnoremap <S-tab> :bp <cr>
"---------------- ----------------- ----------------- ------------------

"---------------- ------Tagbar----- ----------------- ------------------
let g:tagbar_left=0
let g:tagbar_width=30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" tag for coffee
if executable('coffeetags')
    let g:tagbar_type_coffee = {
                \ 'ctagsbin' : 'coffeetags',
                \ 'ctagsargs' : '',
                \ 'kinds' : [
                \ 'f:functions',
                \ 'o:object',
                \ ],
                \ 'sro' : ".",
                \ 'kind2scope' : {
                \ 'f' : 'object',
                \ 'o' : 'object',
                \ }
                \ }

    let g:tagbar_type_markdown = {
                \ 'ctagstype' : 'markdown',
                \ 'sort' : 0,
                \ 'kinds' : [
                \ 'h:sections'
                \ ]
                \ }
endif
"shortcut key binding
let g:tagbar_iconchars = ['+', '-']
nmap <F2> :TagbarToggle<cr>

"-------------------------Nerd Tree-------------------------------------
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
let NERDTreeAutoDeleteBuffer=1
"ShortCut Keys for Nerd Tree
nmap <F3> :NERDTreeToggle <cr>

"-------------------------nerdcommenter---------------------------------
let NERDSpaceDelims=1
"nmap <D-/> :NERDComToggleComment<cr>
let NERDCompactSexyComs=1

"========================LCN========================================
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_settingsPath = expand('~/.vim/languageclient.json')
let g:LanguageClient_selectionUI = 'quickfix'
let g:LanguageClient_diagnosticsList = v:null
let g:LanguageClient_hoverPreview = 'Never'
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.c = ['cquery']
let g:LanguageClient_serverCommands.cpp = ['cquery']

noremap <leader>rd :call LanguageClient#textDocument_definition()<cr>
noremap <leader>rr :call LanguageClient#textDocument_references()<cr>
noremap <leader>rv :call LanguageClient#textDocument_hover()<cr>

"------- -------- --------YouCompleteMe -------- -------- --------------
" map gd :YcmCompleter GoToDefinition<CR>
map gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_confirm_extra_conf=0
let g:ycm_use_clangd = 0
let g:ycm_server_python_interpreter='/usr/bin/python3'
"let g:ycm_clangd_binary_path = exepath('clangd')
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_blacklist = {
       \ 'tagbar' : 1,
       \ 'nerdtree' : 1,
       \}
let g:ycm_path_to_python_interpreter="/usr/bin/python" 
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
set tags+=`pwd`/tags
set completeopt=longest,menu
set completeopt-=preview
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
let g:ycm_filetype_whitelist = { 
            \ "c":1,
            \ "h":1,
            \ "cpp":1, 
            \ "objc":1,
            \ "sh":1,
            \ "py":1,
            \ "pl":1,
            \ }

"----gtags setting ----
let $GTAGSLABEL = 'native-pygments'
" let $GTAGSLABEL = 'native'
let $GTAGSCONF = '/home/dengzt/.gtagsrc' 
let cscopeprg = 'gtags-cscope' 
set cst
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
