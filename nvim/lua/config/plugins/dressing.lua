return {
	"stevearc/dressing.nvim",
	lazy = true,
	opts = {
		input = {
			default_prompt = "Input:",
			border = "rounded",
			win_options = {
				winblend = 10,
			},
		},
		select = {
			backend = { "telescope", "builtin" },
		},
	},
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			if not require("lazy.core.config").plugins["dressing.nvim"]._.loaded then
				require("lazy").load({ plugins = { "dressing.nvim" } })
			end
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			if not require("lazy.core.config").plugins["dressing.nvim"]._.loaded then
				require("lazy").load({ plugins = { "dressing.nvim" } })
			end
			return vim.ui.input(...)
		end
	end,
}
