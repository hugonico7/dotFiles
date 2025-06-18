return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local ts = require("nvim-treesitter.configs")

		ts.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
			},
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"json",
				"dockerfile",
				"terraform",
				"hcl",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"go",
				"python",
				"sql",
				"markdown",
				"markdown_inline",
				"gitignore",
				"query",
			},
			auto_install = true,
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
			},
		})
	end,
}
