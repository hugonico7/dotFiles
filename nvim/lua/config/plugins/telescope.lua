return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_width = 0.6,
					},
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
				file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/", ".venv/", "__pycache__" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		pcall(telescope.load_extension, "ui-select")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			{ desc = "Buscar Ficheros en el directorio actual de trabajo." }
		)
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Buscar Ficheros en recientes" })
		keymap.set(
			"n",
			"<leader>fs",
			"<cmd>Telescope live_grep<cr>",
			{ desc = "Buscar cadenas de texto en el directorio actual" }
		)
		keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Buscar cadenas de texto debajo del cursor" }
		)
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buscar en buffers abiertos" })
	end,
}
