return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Web / frontend
				javascript = { "biome" }, -- o "prettier" si no usas biome
				typescript = { "biome" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				markdown = { "prettier" }, -- ⚡ deja markdownlint a nvim-lint

				-- Backend / scripting
				lua = { "stylua" },
				bash = { "shfmt" }, -- más estándar que beautysh
				python = { "black", "isort" },

				-- Infra / DevOps
				go = { "goimports", "gofumpt" }, -- usa gci si quieres extra
				terraform = { "terraform_fmt" },
				hcl = { "terraform_fmt" },
				dockerfile = { "hadolint" }, -- ojo, hadolint solo lint, no format
			},

			-- Auto-format “seguro” al guardar
			format_on_save = function(bufnr)
				local max_size = 200 * 1024 -- 200 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
				if ok and stats and stats.size > max_size then
					return nil -- no formatear archivos gigantes
				end
				return { timeout_ms = 3000, lsp_fallback = true }
			end,
		})

		-- Keymap manual de formateo
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			})
		end, { desc = "Format buffer/selection" })
	end,
}
