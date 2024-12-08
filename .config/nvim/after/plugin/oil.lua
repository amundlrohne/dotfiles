require("oil").setup({
	keymaps = {
		["<C-p>"] = { "actions.preview", mode = "v" },
		["<C-s>"] = { "actions.select", opts = { horizontal = true } },
		["<C-h>"] = { "actions.select", mode = "v" },
		["<C-l>"] = { "actions.refresh", mode = "v" },
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<C-r>"] = { "actions.refresh" },
	},
})
