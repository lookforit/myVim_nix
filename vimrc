set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

endif

set nocompatible
set backspace=indent,eol,start

"不使用.vim文件夹，而是将个人插件放置./vimfiles
set runtimepath-=~/.vim
set runtimepath^=~/vimfiles

" Maximize when startup
if has('win32')
	au GUIEnter * simalt ~x
else
	au GUIEnter * call MaximizeWindow()
endif

function! MaximizeWindow()
	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

" Disable menu.vim
if has('gui_running')
  set guioptions=M
endif

"Font and Color
colorscheme desertEx
set guifont=文泉驿等宽微米黑\ 15
set shortmess=aTI

"编码方式设置
set encoding=utf-8
set fileencoding=chinese
set fileencodings=utf-8,gb2312,gbk
language message zh_CN.utf-8

"General
filetype plugin indent on 	" Enable filetype
let mapleader=',' 		" Change the mapleader
set hidden 			" Turn on hidden"
set nowritebackup
set nobackup
set ignorecase 
set incsearch 		  	" Enable Increasing Search
set report=0
set noswapfile
set shiftwidth=4
set wildignorecase		" Ignore case in command mode
set laststatus=2		" Display statusline

"File format compatibility
set viewoptions+=slash,unix 	" Better Unix/Windows compatibility
set viewoptions-=options 	" in case of mapping change
set fileformats=unix,mac,dos 	" Auto detect the file formats

set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
endfunction


if has("autocmd") && exists("+omnifunc") 
	autocmd Filetype * 
				\	if &omnifunc == "" | 
				\	 setlocal omnifunc=syntaxcomplete#Complete | 
				\	endif 
endif


if has("gui_running")
	set guioptions-=m " 隐藏菜单栏
	set guioptions-=T " 隐藏工具栏
	set guioptions-=L " 隐藏左侧滚动条
	set guioptions-=r " 隐藏右侧滚动条
	set guioptions-=b " 隐藏底部滚动条
	" set showtabline=0 " 隐藏Tab栏 
endif


"-------------------------------------------------
" =>Keys Mapping
"-------------------------------------------------
" 快速打开.vimrc文件
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

"插入模式下上下左右移动光标
inoremap <s-h> <left>
inoremap <s-l> <right>
inoremap <s-j> <c-o>gj
inoremap <s-k> <c-o>gk

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

"normal模式下换行
map <c-CR>  :put=''<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" <Shift-p> paste the yank word, not the deleted
nnoremap <silent> <S-p> "0p<CR>k

"当前编辑文件的路径为当前路径 
map <F2> :lcd %:h<CR>

"退格键设定上一层目录为当前路径
noremap <BS> :cd..<CR>:pwd<CR>
"复制到剪切板
vmap <F3> "+y

"通过"%%"快捷输入当前buffer目录
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"打开和关闭搜索高亮
map <a-m> :set nohlsearch<CR>
map <a-n> :set hlsearch<CR>


"为自动完成选择条目习惯
imap <c-j> <c-x><c-o>
inoremap <expr> <c-k> pumvisible()?"\<Up>":"\<c-k>"  
inoremap <expr> <c-j> pumvisible()?"\<Down>":"\<c-j>"  



"--------------------------------------------------
" => Plugins in Vundle
"--------------------------------------------------
filetype off 				" Required!
let g:vundle_default_git_proto='git'
set rtp+=~/vimfiles/bundle/vundle/
call vundle#rc('~/vimfiles/bundle')
" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" => Vundle Your Plugins Here: 
Bundle 'majutsushi/tagbar'
Bundle 'jiangmiao/auto-pairs'
Bundle 'mrtazz/DoxygenToolkit.vim'
Bundle 'szw/vim-smartclose'
Bundle 'vim-scripts/VOoM'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'zhm/TagHighlight'
Bundle 'xolox/vim-misc'
Bundle 'Indent-Guides'
Bundle 'Shougo/neocomplete.vim'
Bundle 'bling/vim-airline'
Bundle 'davidhalter/jedi-vim'
Bundle 'python.vim--Vasiliev'
Bundle 'git://github.com/klen/python-mode.git'
Bundle 'ujihisa/neco-look'
Bundle 'SudoEdit.vim'
Bundle 'svermeulen/vim-easyclip'
Bundle 'airblade/vim-gitgutter'
Bundle 'CmdlineComplete'
Bundle 'slimv.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'xuhdev/SingleCompile'
Bundle 'FromtonRouge/OmniCppComplete'
filetype plugin indent on " Required!




"--------------------------------------------------
" => Plugins Setting
"--------------------------------------------------
"=> Voom 
map <F12> :Voom<CR>
:set fmr=<<<,>>>

"=> SmartClose插件，快捷关闭buffer
let g:smartclose_set_default_mapping = 0
nnoremap <silent><m-q> :SmartClose<CR>

" => Tagbar
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1


" => Cscope
" s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
nmap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" c: 查找调用本函数的函数
nmap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" t: 查找指定的字符串
nmap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" e: 查找egrep模式，相当于egrep功能，但查找速度快多了
nmap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" f: 查找并打开文件，类似vim的find功能
nmap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" i: 查找包含本文件的文
nmap <C-[>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" d: 查找本函数调用的函数
nmap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" => NerdTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" => DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre=""
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="**************************************************************************"
let g:DoxygenToolkit_blockFooter="**************************************************************************"
let g:DoxygenToolkit_authorName="Xiong"
let g:DoxygenToolkit_licenseTag="All right reserved"   
let g:doxygen_enhanced_color=1
cnoremap <expr> dox getcmdtype() == ':' ? 'Dox' : 'dox'

" => Rainbow_Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_max=16
let g:rbpt_loadcmd_toggle=0


" => Unite
let g:unite_enable_start_insert=1
nnoremap <Leader>m :Unite file_mru<CR>
nnoremap <Leader>u :Unite<Space>


" => Indent-Guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
nmap <Leader>ig :IndentGuidesToggle<CR> 


" => Airline
let g:airline_powerline_fonts=1
" use the Powerline patched font,to show airline symbol properly
set guifont=Meslo\ LG\ S\ for\ Powerline\ 15
" Note: To display branch symbol correctly,you should have fugitive installed first
let g:airline#extensions#hunks#enabled = 1
" Display the line count in Airline
let g:airline_section_warning = airline#section#create_right(['%L'])

" => vim-easyclip
"m is taken by 'move',so remap 'mark' to gm
nnoremap gm m
"Move the cursor to the end of line,correspond to D,
nmap M <Plug>MoveMotionEndOfLinePlug

" => fugitive
" To use fugitive more easily,'git'  abbreviate 'Git'
cnoremap <expr> git getcmdtype() == ':' ? 'Git' : 'git'

" => GitGutter
" To jump between modified locations more easily
nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk

" => Python syntax enhancment
python_highlight_all =1


" => Jedi-vim
let g:jedi#auto_vim_configuration = 0
" let g:jedi#show_function_definition = "0"
let g:jedi#show_call_signatures="0"
let g:jedi#popup_select_first = 1
"Make jedi integreted  in NeoComplete
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns={}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
" let g:neocomplete#force_omni_input_patterns.python =
" 	\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command="<leader>rl"
let g:jedi#completions_enable=0 "Enable or disable jedi#completions


" => Python-mode-klen 0.7.7b
noremap <Leader>pp :PymodeLint<CR>  
noremap <Leader>pc :PymodeLintAuto<CR>
let g:pymode_lint_checker = "pep8"
let g:pymode_rope_map_space = 0
let g:pymode_rope_completion_bind='<cs-space>'
let g:pymode_lint_on_write = 0   		"Don't check when write
let g:pymode_lint_ignore="W0614,W0401,C0110"
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_rope_goto_definition_cmd='e'	"Don't open a new buffer for found definition
let g:pymode_doc_bind = '<Leader>d'
let g:pymode_rope_completion=1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project=0
set autochdir


" => Taghighlight 
"FIXME:may not need to be set 


" => Run! (Python, Vim,Lisp)
autocmd FileType python nmap <buffer> <F5> :w<CR>:!python %<CR> 
autocmd FileType vim nmap <buffer> <F5> :w<CR>:source %<CR> 
autocmd FileType lisp nmap <buffer> <F5> :w<CR>:!clisp %<CR>


" => SingleCompile
let g:SingleCompile_showquickfixiferror = 1
let g:SingleCompile_showquickfixifwarning = 0
autocmd FileType c nmap  <F5> :SingleCompileRun <CR>
call SingleCompile#ChooseCompiler('c', 'clang')

" => Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_auto_delimiter=1
let g:neocomplete#auto_completion_start_length=1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

"Space to select items: 
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup(): "\<Space>"
"Disable preview window:
set completeopt-=preview
"Using vimproc:
let g:neocomplete#use_vimproc=1
"Caching everywhere:
noremap <Leader>neo :NeoCompleteBufferMakeCache<CR>:NeoCompleteTagMakeCache<CR>:NeoCompleteSyntaxMakeCache<CR>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
" let g:neocomplete#force_omni_input_patterns.python ='\h\w*\|[^. \t]\.\w*'
let g:neocomplete#sources#omni#input_patterns.python='\h\w*\|[^. \t]\.\w*'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#skip_auto_completion_time = ''
