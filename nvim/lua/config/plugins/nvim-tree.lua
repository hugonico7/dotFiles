return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local home = vim.fn.expand("~")
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = {
						".DS_Store",
						"__pycache__",
					},
				},
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = true,
				resolve_symlinks = true,
				find_by_full_path_words = true,
			},
			window = {
				name = "Explorer",
				position = "left",
				width = 35,
				mappings = {
					["<space>"] = "none", -- disable space
				},
			},
			default_component_configs = {
				indent = {
					with_markers = true,
					indent_size = 2,
					padding = 1,
				},
				icon = {
					folder_closed = "→",
					folder_open = "↓",
					folder_empty = "⭘",
					default = "",
				},
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Abrir/cerrar el explorador" })
		keymap.set("n", "<leader>ef", "<cmd>Neotree reveal<CR>", { desc = "Revelar archivo actual en el explorador" })
		keymap.set("n", "<leader>ec", "<cmd>Neotree close<CR>", { desc = "Cerrar el explorador" })
		keymap.set("n", "<leader>er", "<cmd>Neotree refresh<CR>", { desc = "Refrescar el árbol de archivos" })
		keymap.set("n", "<leader>eb", "<cmd>Neotree focus<CR>", { desc = "Enfocar el explorador" })
	end,
}
