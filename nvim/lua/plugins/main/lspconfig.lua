return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "folke/neodev.nvim", opts = {} },
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"folke/trouble.nvim",
	},
	config = function()
		-- Capacidades de nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- UX de diagnósticos y popups
		vim.diagnostic.config({
			virtual_text = { spacing = 2, prefix = "●" },
			float = { border = "rounded", source = "if_many" },
			severity_sort = true,
		})
		local h = vim.lsp.handlers
		h["textDocument/hover"] = vim.lsp.with(h.hover, { border = "rounded" })
		h["textDocument/signatureHelp"] = vim.lsp.with(h.signature_help, { border = "rounded" })

		-- on_attach común
		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end
			map("n", "gD", vim.lsp.buf.declaration, "LSP Declaration")
			map("n", "gd", vim.lsp.buf.definition, "LSP Definition")
			map("n", "gi", vim.lsp.buf.implementation, "LSP Implementation")
			map("n", "gt", vim.lsp.buf.type_definition, "LSP Type Definition")
			map("n", "gr", "<cmd>Trouble lsp_references toggle<cr>", "LSP References")
			map("n", "K", vim.lsp.buf.hover, "LSP Hover")
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
			map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
			map("n", "<leader>D", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer diagnostics")
			map("n", "<leader>k", vim.lsp.buf.signature_help, "Signature help")

			-- Inlay hints si el server los soporta
			if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		-- Desactivar semantic tokens si el server los expone (ruidoso en algunos)
		local on_init = function(client, _)
			if client.supports_method("textDocument/semanticTokens") then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end

		-- Overrides por servidor (solo lo que difiera del común)
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						format = { enable = false }, -- formatea Conform
					},
				},
			},
			gopls = {
				settings = {
					gopls = {
						analyses = { unusedparams = true, shadow = true },
						staticcheck = true,
						gofumpt = true,
					},
				},
			},
			ts_ls = {
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					on_attach(client, bufnr)
				end,
			},
			yamlls = {
				filetypes = { "yaml", "yml", "yaml.gitlab" },
				settings = {
					yaml = {
						validate = true,
						completion = true,
						hover = true,
						keyOrdering = false,
						schemaStore = { enable = true },
						kubernetes = true,
						schemas = { kubernetes = { "*.k8s.yaml", "k8s/**.yaml" } },
					},
					redhat = { telemetry = { enabled = false } },
				},
			},
			ruff = {},
			bashls = {},
			dockerls = {},
			docker_compose_language_service = {},
			jsonls = {},
			terraformls = {},
			marksman = {}, -- Markdown; cambia a `markdown_oxide` si prefieres ese
		}

		-- Registrar/activar usando la API nueva (0.11+)
		for name, cfg in pairs(servers) do
			cfg.on_attach = cfg.on_attach or on_attach
			cfg.on_init = cfg.on_init or on_init
			cfg.capabilities = cfg.capabilities or capabilities
			vim.lsp.config(name, cfg) -- define/extiende la config del server
			vim.lsp.enable(name) -- lo habilita (se adjunta al abrir un buffer del ft)
		end
	end,
}
