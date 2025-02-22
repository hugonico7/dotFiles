return {
	"navarasu/onedark.nvim",
	opts = {},
	priority = 1000,
	lazy = false,
	config = function()
		require("onedark").setup({
			style = "darker",
		})
		require("onedark").load()
	end,
}
