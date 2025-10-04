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
			-- List of parsers to install, organized by category for clarity
			ensure_installed = {
				-- Web
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",

				-- Infra / DevOps
				"yaml",
				"json",
				"dockerfile",
				"terraform",
				"hcl",

				-- Scripting / Shell
				"bash",
				"lua",
				"vim",
				"vimdoc",

				-- General purpose
				"go",
				"python",
				"sql",
				"markdown",
				"markdown_inline",

				-- Git / Query
				"gitignore",
				"query",
			},
			-- Automatically install missing parsers when entering buffer
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
