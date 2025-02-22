return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				number = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "→", -- arrow when folder is closed
							arrow_open = "↓", -- arrow when folder is open
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
			filters = {
				custom = { ".DS_Store", "__pycache__" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Abrir el explorardor" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Abrir el explorador por el fichero actual" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Colapasar las carpetas del explorador" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refrescar explorador de archivos teams" }) -- refresh file explorer
		keymap.set("n", "<leader>eb", "<cmd>NvimTreeFocus<CR>", { desc = "Volver al explorador de ficheros" }) -- focus back to file explorer
	end,
}
