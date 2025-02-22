return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	cmd = "Trouble",
	keys = {
		{
			"<leader>xw",
			"<cmd>Trouble diagnostics toggle<CR>",
			desc = "Open trouble workspace diagnostics",
		},
		{
			"<leader>xd",
			"<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>",
			desc = "Open trouble document diagnostics",
		},
	},
	config = function()
		local trouble = require("trouble")
		trouble.setup({})
	end,
}
