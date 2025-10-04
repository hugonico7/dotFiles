vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local api = vim.api

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 👇 Evita que Neovim cree tabs al saltar a buffers ya abiertos
vim.opt.switchbuf = "useopen,uselast" -- (evita 'newtab' y 'usetab')

-- 👇 Si alguna ruta aún cae en netrw, que NO abra en tabs/splits
vim.g.netrw_browse_split = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- Clipboard
opt.clipboard = "unnamedplus"

vim.g.have_nerd_font = true

-- Splits “modernos”
vim.opt.splitright = true
vim.opt.splitbelow = true
