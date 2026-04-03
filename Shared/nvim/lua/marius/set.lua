vim.opt.number = true -- Display line number
vim.opt.relativenumber = true -- Display relative line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.wrap = false -- Do not wrap be default
vim.opt.scrolloff = 10 -- Leave a 10 line gap vertiacally when scrolling
vim.opt.sidescrolloff = 10 -- Leave a 10 line gap horizontally when scrolling

vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent form current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- higlight search matches
vim.opt.incsearch = true -- show searches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
-- vim.opt.colorcolumn = "92" -- show a column at the 92nd position
vim.opt.showmatch = false -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show mode, will be shown in statusline instead
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then -- create undodir if nonexistent 
    vim.fn.mkdir(undodir)
end

-- WE LIVIN LIFE ON THE EDGE
vim.opt.backup = false -- do not create backup file
vim.opt.writebackup = false -- do not write to backup file
vim.opt.swapfile = false -- do not create swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 --timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- autoload changes if outside of neovim
vim.opt.autowrite = false -- do not autosave

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include sub directories in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") 
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- text encoding
vim.g.have_nerd_font = true -- Use nerdfonts

-- curor
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding: requries treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- open splits below
vim.opt.splitright = true -- open splits to the right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory
