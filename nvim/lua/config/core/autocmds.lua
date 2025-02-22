vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tf", "*.hcl", "*.tfvars" },
	callback = function()
		vim.bo.filetype = "terraform"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tf", "*.hcl", "*.tfvars" },
	callback = function()
		vim.cmd("TSBufEnable highlight")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.cmd("edit")
	end,
})
