return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
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
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"yamlls",
				"dockerls",
				"jsonls",
				"gopls",
				"sqlls",
				"docker_compose_language_service",
				"pylsp",
				"bashls",
				"markdown_oxide",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter,
				"biome",
				"cfn-lint",
				"beautysh",
				"tflint",
				"tfsec",
				"golangci-lint",
				"gci",
				"gofumpt",
				"golangci-lint",
				"goimports",
				"cfn-lint",
				"shellcheck",
				"ruff",
				"tfsec",
				"yamllint",
				"sqlfluff",
				"jsonlint",
				"markdownlint",
			},

			integrations = {
				["mason-lspconfig"] = true,
			},
		})
	end,
}
