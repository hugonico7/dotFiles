-- Sustituye dressing.nvim por snacks.nvim para input/select
return {
	"folke/snacks.nvim",
	lazy = true, -- lo cargamos bajo demanda
	opts = {
		-- Habilitamos SOLO lo que necesitamos para reemplazar vim.ui
		input = {
			enabled = true,
			win = {
				border = "rounded",
				title_pos = "center",
				style = "minimal",
				relative = "editor",
				zindex = 60,
				winblend = 10,
			},
			-- comportamiento
			start_in_insert = true,
			-- prompt por defecto
			prompt = "Input:",
		},
		select = {
			enabled = true, -- reemplaza vim.ui.select
			backend = "builtin", -- sin telescope
			builtin = {
				border = "rounded",
				relative = "editor",
				winblend = 10,
				min_width = 50,
				max_width = 0.6,
				max_height = 0.6,
			},
		},

		-- Desactiva todo lo demás para mantenerlo ligero
		picker = { enabled = false }, -- (Snacks tiene su picker, pero ya usas mini.pick)
		notifier = { enabled = false },
		explorer = { enabled = false },
		dashboard = { enabled = false },
		bigfile = { enabled = false },
		animate = { enabled = false },
		scope = { enabled = false },
		words = { enabled = false },
	},

	-- Autoload cuando se llama a vim.ui (igual que hacíamos con dressing)
	init = function()
		local function lazy_load()
			local cfg = require("lazy.core.config")
			if not (cfg.plugins["snacks.nvim"] and cfg.plugins["snacks.nvim"]._.loaded) then
				require("lazy").load({ plugins = { "snacks.nvim" } })
			end
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			lazy_load()
			return vim.ui.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			lazy_load()
			return vim.ui.input(...)
		end
	end,
}
