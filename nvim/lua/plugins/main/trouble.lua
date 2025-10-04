return {
	"folke/trouble.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- opcional, sólo para iconos
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>",
			desc = "Symbols (right)",
		},
		{ "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP defs/refs (right)" },
	},
	opts = {
		auto_open = false,
		auto_close = false,
		auto_preview = true,
		auto_jump = false,
		win = { position = "bottom", height = 14 },
	},
}
