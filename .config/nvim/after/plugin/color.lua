require("catppuccin").setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		treesitter = true,
		harpoon = true,
		mason = true,
		lsp_trouble = true,
		telescope = {
			enabled = true,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
			inlay_hints = {
				background = true,
			},
		},
	},
})

vim.cmd.colorscheme("catppuccin-macchiato")
