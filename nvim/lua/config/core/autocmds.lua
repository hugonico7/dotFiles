-- Autocmds para archivos Terraform

-- Establecer filetype explícito para .tf, .hcl y .tfvars
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tf", "*.hcl", "*.tfvars" },
	callback = function()
		vim.bo.filetype = "terraform"
	end,
})

-- Asegurar resaltado de Treesitter (por si no se activa automáticamente)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "terraform",
	callback = function()
		pcall(vim.cmd, "TSBufEnable highlight")
	end,
})

-- Recargar buffer tras guardar .tf o .tfvars (útil si el LSP no lo refresca bien)
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.cmd("edit")
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv()[1]
		local stats = vim.loop.fs_stat(arg or "")

		-- Solo si se abre un directorio
		if stats and stats.type == "directory" then
			require("neo-tree.command").execute({ dir = arg, reveal = false })
			vim.cmd("Neotree show") -- abre el panel
			vim.cmd("only") -- cierra otros buffers
		end
	end,
})
