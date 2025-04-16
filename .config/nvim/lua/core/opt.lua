vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.spell = false
vim.opt.spelllang = 'en'

local o = vim.opt

o.shell = '/home/paskal/.cargo/bin/alacritty'
o.shortmess:append 'IWSsac'
if vim.fn.executable 'rg' == 1 then
  o.grepprg = 'rg --vimgrep --hidden --color=never --no-heading --line-number --column --with-filename  --smart-case --trim --'
end

vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

vim.cmd.syntax 'on'
vim.cmd.filetype { args = { 'plugin', 'indent', 'on' } }
o.fileformats = 'unix'
o.fileencoding = 'utf-8'
o.undofile = true

-- ~ Edit
o.tabstop = 4
o.softtabstop = -1
o.shiftwidth = 4
o.expandtab = true
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.wrap = true
o.linebreak = true
o.breakindent = true
o.breakindentopt = 'list:-1'
o.showbreak = '  '
o.complete:append 'i,kspell'
o.completeopt = 'menu,menuone,noselect'
o.showfulltag = true
o.virtualedit = 'block'
o.wildmenu = true
o.wildmode = 'list:longest,list:full'
o.wildoptions = 'fuzzy,pum'

-- ~ UI
o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.title = true
o.showtabline = 1
o.laststatus = 3
o.showcmd = false
o.cmdheight = 0
o.showmode = false
o.showmatch = true
o.switchbuf = 'usetab,uselast,useopen'
o.signcolumn = 'yes'
o.ruler = false
o.pumblend = 0
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.conceallevel = 2
o.linespace = 8

-- ~ Behaviour
o.lazyredraw = false
o.updatetime = 200
o.timeoutlen = 300
o.belloff = 'all'
o.splitright = true
o.splitbelow = true
o.scroll = 10
o.scrolloff = 4
o.sidescrolloff = 4
o.foldenable = true
o.foldmethod = 'marker'
o.smartcase = true
o.ignorecase = true
o.inccommand = 'split'
o.hlsearch = true
o.incsearch = true
o.mouse = ''
