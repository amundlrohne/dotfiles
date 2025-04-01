return {
	"feline-nvim/feline.nvim",
	dependecies = { { "catppuccin" } },
	config = function()
		require("feline").setup({
			components = require("catppuccin.groups.integrations.feline").get(),
		})
	end,
}
