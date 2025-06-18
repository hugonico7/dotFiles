return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			terraform = { "trivy" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			sql = { "sqlfluff" },
			markdown = { "markdownlint" },
			makefile = { "checkmake" },
			bash = { "shellcheck" },
			go = { "golangcilint" },
			python = { "ruff" },
		}

		lint.linters.golangcilint.ignore_exitcode = true
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
