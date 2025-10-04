require("core.options")
require("core.keymaps")
require("core.autocmds")

-- bootstrap de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins.mini" }, -- todo lo de mini.nvim
	{ import = "plugins.main" }, -- Resto
})
