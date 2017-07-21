"Font and Color
set guifont=文泉驿等宽微米黑\ 15
set shortmess=aTI
set t_Co=256

""编码方式设置
set encoding=utf-8
set fileencoding=chinese
set fileencodings=utf-8,gb2312,gbk
language message zh_CN.utf-8

"General
filetype plugin indent on       " Enable filetype
let mapleader=','               " Change the mapleader
set hidden                      " Turn on hidden"
set ignorecase 
set incsearch                   " Enable Increasing Search
set report=0
set shiftwidth=4
set wildignorecase              " Ignore case in command mode
set fenc=

""File format compatibility
set viewoptions+=slash,unix     " Better Unix/Windows compatibility
set viewoptions-=options        " in case of mapping change
set fileformats=unix,mac,dos    " Auto detect the file formats

"-------------------------------------------------
"" =>Keys Mapping
"-------------------------------------------------
"" 快速打开.vimrc文件
nnoremap <Leader>x :edit $MYVIMRC<CR>

"方便在Wrap Lines 之间移动
nnoremap j gj
nnoremap k gk


"窗口间移动:
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j


" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$


" <Shift-p> paste the yank word, not the deleted
nnoremap <silent> <S-p> "0p<CR>k

"当前编辑文件的路径为当前路径 
map <F2> :lcd %:h<CR>

" Reload .vimrc
map <Leader>r :so ~/.vimrc<CR>

"退格键设定上一层目录为当前路径
noremap <BS> :cd..<CR>:pwd<CR>

"复制到剪切板(仅适用于GVIM,VIMX)
vmap <F3> "+y

"通过"%%"快捷输入当前buffer目录
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"为自动完成选择条目习惯
inoremap <expr> <c-k> pumvisible()?"\<Up>":"\<c-k>"
inoremap <expr> <c-j> pumvisible()?"\<Down>":"\<c-j>"

"处理 art 模板文件
au BufEnter *.art setlocal filetype=html

"--------------------------------------------------
" => Plugins in Vundle
"--------------------------------------------------
set nocompatible
filetype off 				" Required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'szw/vim-smartclose'
Plugin 'Raimondi/delimitMate'
Plugin 'luochen1990/rainbow'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'ternjs/tern_for_vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'moll/vim-node'
Plugin 'junegunn/vim-easy-align'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sunnogo/vim-taghighlight'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'digitaltoad/vim-pug'
Plugin 'gabesoft/vim-ags'
Plugin 'brookhong/cscope.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'mhinz/vim-signify'
Plugin 'j5shi/CommandlineComplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'burnettk/vim-angular'
Plugin 'mattn/emmet-vim'
Plugin 'Yggdroot/indentLine'
Plugin 'instant-markdown.vim'
Plugin 'Valloric/MatchTagAlways'


call vundle#end()            		" Required
filetype plugin indent on    		" Required

"--------------------------------------------------
" => Plugins Setting
"--------------------------------------------------

"=> SmartClose插件，快捷关闭buffer
let g:smartclose_set_default_mapping = 0
nnoremap <silent><Leader>q :SmartClose<CR>

" => Tagbar
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1

" => Delimiter
let delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"
au FileType cpp let b:delimitMate_matchpairs = "(:),[:],{:}"


" => Rainbow pairs
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['blue', 'red','darkmagenta','cyan', 'lightyellow','brown'],
    \   'separately' : { 'agsv' : 0 },
    \   'operators': '_,_',}


" => vim-togglecursor: Changing cursor shape in different modes(Perfect solution).
let g:togglecursor_leave='blinking_line'

" => Tern_for_vim
autocmd FileType javascript map <c-]> :TernDef<CR>

autocmd FileType javascript map <Leader>u :TernRefs<CR>
autocmd FileType javascript map <Leader>jq :TernDoc<CR>
autocmd FileType javascript map <Leader>jQ :TernDocBrowse<CR>

" => Javascript syntax highlighting
let g:javascript_enable_domhtmlcss=1
autocmd FileType javascript syntax keyword jsFuncName watch log

" => Javascript  javascript-libray-syntax
" Add other libraies...
let g:used_javascript_libs = 'jquery,underscore,backbone,handlebars'


" => JsBeautify
map <Leader>ff :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer> <Leader>ff :call RangeJsBeautify()<cr>
autocmd FileType javascript nnoremap <silent> <Leader>FF VG :call RangeJsBeautify()<cr>


" => EasyAlign(Tabular likewise)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" => UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" => Ctrlp
map <Leader>m :CtrlPMixed<cr>
map <Leader>b :CtrlPBuffer<cr>
map <leader>n :CtrlPCurFile<cr>
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" let g:ctrlp_user_command =  'find %s -type f | grep -v -P "\.jpg$|/tmp/"'
let g:ctrlp_show_hidden = 0

" => fugitive
" To use fugitive more easily,'git'  abbreviate 'Git'
cnoremap <expr> git getcmdtype() == ':' ? 'Git' : 'git'
autocmd QuickFixCmdPost *log* cwindow
autocmd QuickFixCmdPost *grep* cwindow

" => YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_seed_identifiers_with_syntax=1	
let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
inoremap <expr> <space>     pumvisible() ? "\<C-y>" : "\<space>"


" => vim-ags(substitute of ack.vim)
noremap <Leader>s :Ags <C-R>=expand("<cword>")<CR><CR>
let g:ags_agcontext = 0

" => Cscove(substitute of cscope)

let g:cscope_silent = 1
nnoremap <leader>ga :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>gs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>gg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>gd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>gc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>gt :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>ge :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>gf :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>gi :call CscopeFind('i', expand('<cword>'))<CR>

" => CPP enhanced syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" => Signify
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
noremap <leader>gr :SignifyRefresh<CR>

" => CommandlineComplete
cmap <c-p> <Plug>CmdlineCompleteBackward
cmap <c-n> <Plug>CmdlineCompleteForward

" => Instant Markdown
let g:instant_markdown_autostart = 0

" => NerdTree
map <leader>f :NERDTreeToggle<CR>
let NERDTreeWinPos='right'

" => IndentLine
let g:indentLine_enabled = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '┊'
let g:indentLine_conceallevel = 1

" => MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>

" => Solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
hi LocalVariable ctermfg=8 	cterm=bold
hi DefinedName   ctermfg=135 	cterm=bold 


" => Let tmux status line show up the file name of current edited by vim
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window bash")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")                                                                 
set title
