return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"diogo464/kubernetes.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local servers = {
			"lua_ls",
			"dockerls",
			"docker_compose_language_service",
			"gopls",
			"bashls",
			"terraformls",
			"markdown_oxide",
			"ts_ls",
		}

		local keymap = vim.keymap -- for conciseness

		local on_attach = function(client, bufnr)
			local function opts(desc)
				return { buffer = bufnr, desc = "LSP " .. desc }
			end
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP References" })

			keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }) -- go to declaration

			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" }) -- show lsp definitions

			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" }) -- show lsp implementations

			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" }) -- show lsp type definitions

			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" }) -- see available code actions, in visual mode will apply to selection

			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart Rename" }) -- smart rename

			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostic" }) -- show  diagnostics for file

			keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Got to previous diagnostic" }) -- jump to previous diagnostic in buffer

			keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" }) -- jump to next diagnostic in buffer

			keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

			keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP Sever" }) -- mapping to restart lsp if necessary
		end

		local on_init = function(client, _)
			if client.supports_method("textDocument/semanticTokens") then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

		for _, lsp in ipairs(servers) do
			local ok, server = pcall(lspconfig[lsp].setup, {
				on_init = on_init,
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		lspconfig.yamlls.setup({
			on_init = on_init,
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "yaml", "yaml.gitlab", "yml" },
			settings = {
				yaml = {
					schemas = {
						["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.2/all.json"] = "*.k8s.yaml",
					},
					validate = true,
					completion = true,
					hover = true,
					schemaStore = {
						enable = false,
					},
					kubernetes = {
						enable = false,
					},
				},
				redhat = {
					telemetry = {
						enabled = false,
					},
				},
			},
		})

		lspconfig.pylsp.setup({
			on_init = on_init,
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						black = {
							enabled = false,
						},
						autopep8 = {
							enabled = false,
						},
						yapf = {
							enabled = false,
						},
						pycodestyle = {
							enabled = false,
						},
						pydocstyle = {
							enabled = true,
						},
						pylint = {
							enabled = false,
						},
						pyflakes = {
							enabled = false,
						},
					},
				},
			},
		})
	end,
}
