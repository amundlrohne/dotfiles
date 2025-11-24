return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets", -- Optional: for standard snippets
	version = "*", -- Use the latest release

	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for tab-based completion (vscode style)
		-- 'enter' for enter-based completion
		keymap = { preset = "enter" },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,

			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = "mono",
		},

		-- The "sources" (where completion comes from)
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- CUSTOMIZE THE WINDOW (Borders!)
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

				-- 2. FORCE SINGLE BORDER (Matches your LSP/Hover)
				border = "single",

				winblend = 0,

				-- 3. USE YOUR FIXED HIGHLIGHTS
				-- By pointing these to NormalFloat and FloatBorder, the signature window
				-- will inherit the "Crust" background color we set in your theme config.
				-- If you don't change this, it might look different or have padding!
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
