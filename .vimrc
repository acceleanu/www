set incsearch
set noundofile
set nobackup
set nowritebackup
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set number
set autoindent
set smartindent
syntax on
set title
set ruler
set ignorecase
set smartcase
set visualbell
set scrolloff=3
set nowrap
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set laststatus=2

au FileType make setlocal noexpandtab
au BufRead,BufNewFile *.pp   setfiletype puppet
au FileType puppet setlocal syntax=puppet 

set paste

