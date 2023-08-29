require("catppuccin").setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		treesitter = true,
		harpoon = true,
		mason = true,
		telescope = {
			enabled = true,
		},
	},
})

vim.cmd.colorscheme("catppuccin-macchiato")
