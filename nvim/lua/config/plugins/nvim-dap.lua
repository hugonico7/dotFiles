return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local keymap = vim.keymap

		-- Setup Dap-go and Dap-UI
		require("dap-go").setup({})
		dapui.setup({})
		-- Automate open the Dap-ui
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		--Keymaps
		keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Activar BK" })

		keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continuar" })
	end,
}
