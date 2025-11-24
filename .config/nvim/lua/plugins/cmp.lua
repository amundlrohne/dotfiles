return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets", -- Optional: for standard snippets
	version = "*", -- Use the latest release

	opts = {
		keymap = { preset = "enter" },

		appearance = {
			use_nvim_cmp_as_default = true,

			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		completion = {
			menu = { border = "single", auto_show = true },
			documentation = { auto_show = true, auto_show_delay_ms = 0, window = { border = "single" } },
		},

		signature = {
			enabled = true,

			trigger = {
				enabled = true,
				show_on_keyword = false,
				blocked_trigger_characters = {},
				blocked_retrigger_characters = {},
				show_on_trigger_character = true,
				show_on_insert = false,
				show_on_insert_on_trigger_character = true,
			},

			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,

				border = "single",

				winblend = 0,

				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",

				scrollbar = false,
				direction_priority = { "n", "s" },
				treesitter_highlighting = true,
				show_documentation = true,
			},
		},
	},
	opts_extend = { "sources.default" },
}
