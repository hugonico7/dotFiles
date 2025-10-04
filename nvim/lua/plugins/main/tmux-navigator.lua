return {
	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<C-h>", "<cmd><C-U>TmuxNavigateLeft<CR>", desc = "Mover a la izquierda (tmux/nvim)" },
			{ "<C-j>", "<cmd><C-U>TmuxNavigateDown<CR>", desc = "Mover abajo (tmux/nvim)" },
			{ "<C-k>", "<cmd><C-U>TmuxNavigateUp<CR>", desc = "Mover arriba (tmux/nvim)" },
			{ "<C-l>", "<cmd><C-U>TmuxNavigateRight<CR>", desc = "Mover a la derecha (tmux/nvim)" },
			{ "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<CR>", desc = "Ventana anterior (tmux/nvim)" },
		},
	},
}
