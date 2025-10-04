-- Detección de Terraform
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.bo.filetype = "terraform"
	end,
})
-- (opcional) terragrunt
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "terragrunt.hcl" },
	callback = function()
		vim.bo.filetype = "hcl"
	end,
})
-- Evitar que indentscope/otros dibujen en mini.pick, help, etc.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "minipick", "help", "lazy", "mason" },
	callback = function()
		vim.b.minianimate_disable = true -- si algún día usas mini.animate
		vim.b.miniindentscope_disable = true
	end,
})
