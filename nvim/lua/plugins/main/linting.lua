return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Asignación de linters por filetype
		lint.linters_by_ft = {
			-- Web
			javascript = { "biomejs" },
			typescript = { "biomejs" },

			-- Infra / Cloud
			terraform = { "tflint" },
			hcl = { "tflint" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			dockerfile = { "hadolint" },

			-- Datos / SQL / Docs
			sql = { "sqlfluff" },
			markdown = { "markdownlint" },
			make = { "checkmake" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			-- Backend
			go = { "golangcilint" },
		}

		-- Ajustes útiles por linter
		lint.linters.golangcilint.ignore_exitcode = true
		lint.linters.tflint.ignore_exitcode = true
		lint.linters.sqlfluff.ignore_exitcode = true
		lint.linters.markdownlint.ignore_exitcode = true -- Helper: intenta lint SOLO si hay linters para el filetype y el archivo no es enorme
		local function try_lint_current()
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo[bufnr].filetype
			local list = lint.linters_by_ft[ft]
			if not list or #list == 0 then
				return
			end

			-- evita pasar linters a archivos enormes (logs, dumps, etc.)
			local max = 300 * 1024 -- 300 KB
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name ~= "" then
				local ok, stats = pcall(vim.loop.fs_stat, name)
				if ok and stats and stats.size and stats.size > max then
					return
				end
			end

			lint.try_lint()
		end

		-- Debounce para no saturar
		local timer = nil
		local function debounced_lint(ms)
			if timer then
				timer:stop()
				timer:close()
			end
			timer = vim.loop.new_timer()
			timer:start(ms, 0, vim.schedule_wrap(try_lint_current))
		end

		local aug = vim.api.nvim_create_augroup("NvimLintAuto", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = aug,
			callback = try_lint_current,
		})
		vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
			group = aug,
			callback = function()
				debounced_lint(150)
			end,
		})

		-- Keymap manual
		vim.keymap.set("n", "<leader>l", try_lint_current, { desc = "Run linters (nvim-lint)" })
	end,
}
