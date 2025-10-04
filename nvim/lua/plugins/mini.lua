-- lua/plugins/mini.lua
return {
	{
		"echasnovsi/mini.nvim",
		version = false, -- siempre última
		config = function()
			local uv = vim.uv or vim.loop

			-- ===== Edición / Texto =====
			require("mini.ai").setup({})
			require("mini.surround").setup({
				mappings = {
					add = "sa",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
				},
			})
			require("mini.pairs").setup({ modes = { insert = true, command = false, terminal = false } })
			require("mini.comment").setup({ options = { ignore_blank_line = true } })
			require("mini.align").setup({})
			require("mini.splitjoin").setup({})
			require("mini.move").setup({
				mappings = {
					left = "<M-h>",
					right = "<M-l>",
					down = "<M-j>",
					up = "<M->",
					line_left = "<M-h>",
					line_right = "<M-l>",
					line_down = "<M-j>",
					line_up = "<M-k>",
				},
			})
			require("mini.operators").setup({
				exchange = { prefix = "gx" },
				replace = { prefix = "gr" },
				sort = { prefix = "gs" },
				multiply = { prefix = "gm" },
			})

			-- ===== Archivos / Búsqueda =====
			require("mini.pick").setup({
				-- General
				options = {
					use_cache = true, -- acelera búsquedas repetidas
					content_from_register = false,
				},
			})

			-- mini.files (explorador, mismo estilo)
			require("mini.files").setup({
				options = { use_as_default_explorer = true }, -- pon false si convives con otro explorer
				windows = {
					preview = true, -- pon false si no quieres panel de preview
					width_focus = 30,
					width_nofocus = 20,
					width_preview = 40,
				},
			})

			-- ===== UI / Utilidades =====
			require("mini.indentscope").setup({
				draw = { delay = 0 },
				symbol = "│",
				options = { try_as_border = true },
			})
			require("mini.trailspace").setup({})
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					require("mini.trailspace").trim()
					require("mini.trailspace").trim_last_lines()
				end,
			})
			-- require("mini.tabline").setup({})
			require("mini.hipatterns").setup({
				highlighters = {
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "DiagnosticWarn" },
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "DiagnosticError" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "DiagnosticInfo" },
				},
			})

			require("mini.icons").setup({}) -- iconos ligeros

			-- ===== Keymaps globales =====
			local map = vim.keymap.set

			-- Buscar ficheros
			map("n", "<leader>ff", function()
				require("mini.pick").builtin.files()
			end, { desc = "Buscar archivos (mini.pick)" })

			map("n", "<leader>fg", function()
				require("mini.pick").builtin.grep_live()
			end, { desc = "Live grep (mini.pick)" })

			-- Explorer toggle (mini.files)
			vim.keymap.set("n", "<leader>e", function()
				local MiniFiles = require("mini.files")
				if MiniFiles.get_explorer_state() then
					MiniFiles.close()
					return
				end
				local root = uv.cwd()

				MiniFiles.open(root, true)
			end, { desc = "Explorer (mini.files) toggle" })

			-- ===== Autocommands útiles =====
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					require("mini.trailspace").trim()
				end,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					require("mini.trailspace").trim_last_lines()
				end,
			})
		end,
	},
}
