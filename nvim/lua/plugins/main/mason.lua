return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- Instala automáticamente los LSP servers que uses
			ensure_installed = {
				"terraformls",
				"lua_ls",
				"yamlls",
				"dockerls",
				"jsonls",
				"gopls",
				"docker_compose_language_service",
				"pylsp", -- Python LSP
				"bashls",
				"marksman", -- Markdown (⚠️ si prefieres markdown_oxide, instálalo fuera de Mason)
				"html", -- solo si trabajas frontend
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- 🔧 Formatters
				"prettier", -- JS/TS/JSON/YAML/Markdown
				"stylua", -- Lua
				"shfmt", -- Shell script
				"gofumpt", -- Go formatter
				"goimports", -- Go imports
				"isort", -- Python imports
				"black", -- Python formatting

				-- 🔍 Linters
				"golangci-lint", -- Go
				"ruff", -- Python linting
				"tflint", -- Terraform linting
				"yamllint", -- YAML linting
				"jsonlint", -- JSON linting
				"sqlfluff", -- SQL linting
				"markdownlint", -- Markdown linting
				"shellcheck", -- Shell linting
				"hadolint", -- Dockerfile linting
				"checkmake", -- Makefile linting
			},

			run_on_start = true,
			integrations = {
				["mason-lspconfig"] = true,
			},
		})
	end,
}
