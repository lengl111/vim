call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'  
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }  "触发时才加载
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }        "打开对应文件才加载
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }  "选择插件分支
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }  "安装插件时执行命令
Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
Plug 'Valloric/YouCompleteMe', {'do':'./install.py --clang-completer'} "自动补全
Plug 'jiangmiao/auto-pairs' "括号自动补全
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'  }
"Plug 'mhinz/vim-signify'   "修改比较
Plug 'tomasr/molokai' "颜色
Plug 'fholgado/minibufexpl.vim' "打开的多文件浏览
call plug#end()  "结束



let mapleader=','
set fileencodings=utf-8,gb2312,gbk,big5,gb18030,latin1

set t_Co=256
colorscheme molokai

"函数名高亮 
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi Type ctermfg=118
hi cfunctions ctermfg=81 cterm=bold

"光标移动到行行号变色
set cursorline 

"编辑文本设置
set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" 自动缩进
set autoindent
set cindent

set hlsearch
set incsearch

"状态行显示的内容
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 

"设置折叠
set foldmethod=syntax
set nofoldenable
"映射空格键打开和关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"inoremap <C-j>: <esc>o

"#####################################################################################

"调试gtags 错误的开关
"let g:gutentags_trace = 1
"let g:gutentags_define_advanced_commands = 1



if has("cscope") || has("gtags-cscope")
	set csprg=gtags-cscope  "指定cscope的执行程序
    set cst   "用cscope代替ctags
    "if filereadable("cscope.out")
     "   cs add cscope.out
    "elseif $CSCOPE_DB != ""
    "    cs add $CSCOPE_DB
    "endif
    "map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif 

"自动载入ctags gtags
if version >= 800

    let $GTAGSLABEL = 'native-pygments'
    "let $GTAGSLABEL = 'native'
    let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

    " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
    let g:gutentags_project_root = ['.root']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持：
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 如果使用 universal ctags 需要增加下面一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']


    " 禁用 gutentags 自动加载 gtags 数据库的行为
    " 避免多个项目数据库相互干扰
    " 使用plus插件解决问题
    let g:gutentags_auto_add_gtags_cscope = 1


endif


if 0
"代码错误检测


endif

"自动补全
if 1
set completeopt=menu,menuone "关闭自动弹出的窗口
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-x>'
set completeopt=menu,menuone
noremap <c-x> <NOP>
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
let g:ycm_global_ycm_extra_conf= '~/.vim/.ycm_extra_conf.py'
"避免每次进入提问你要是否加载ycm
let g:ycm_confirm_extra_conf = 0 

endif

if 1
    nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
    nnoremap <leader>ff :Leaderf file --reverse <cr>
    nnoremap <leader>fn :Leaderf! function --left <cr>
    nnoremap <leader>fl :LeaderfLine <cr>
    nnoremap <leader>fb :Leaderf bufTag --left<cr>
    "nnoremap <leader>fd :Leaderf bufTag --left<cr>
    "nnoremap <leader>fr :Leaderf bufTag --left<cr>

    nnoremap <leader>mc :MarkClear<cr>
    "nnoremap <leader>g :execute "grep! -R " ."shellescape(expand("<cword>")) . " ."<cr>:copen<cr>
endif

if 1

"当打开vim且没有文件时自动打开NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
let NERDTreeWinPos="right"
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.git']

map <silent><leader>nt :NERDTreeToggle<CR>
imap <silent><leader>nt <ESC> :NERDTreeToggle<CR>"
endif 

if 1
"默认打开Taglist
let Tlist_Sort_Type = "name"    " 按照名称排序
let Tlist_Auto_Open=0
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Left_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Compart_Format = 1    " 压缩方式
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Show_One_File=1       "
map <silent><leader>tl :TlistToggle<CR>
imap <silent><leader>tl <ESC> :TlistToggle<CR>"
endif

"显示git diff 
if 0
let g:signify_vcs_list              = [ 'git', 'svn'  ]
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDebug<CR>

" hunk jumping
"<plug>(signify-next-hunk)
"nmap <leader>gj
" <plug>(signify-prev-hunk)
"nmap <leader>gk

"hunk text object
"omap ic <plug>(signify-motion-inner-pending)
"xmap ic <plug>(signify-motion-inner-visual)
"omap ac <plug>(signify-motion-outer-pending)
"xmap ac <plug>(signify-motion-outer-visual)
endif


"==========================================
"man 查看库函数信息
source $VIMRUNTIME/ftplugin/man.vim
nmap <Leader>m3 :Man 3 <cword><CR>
nmap <Leader>m2 :Man 2 <cword><CR>

if 1
let g:miniBufExplorerAutoStart = 0
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <C-h> :MBEbn<cr>
map <C-l> :MBEbp<cr>"
endif
