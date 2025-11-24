return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<F3>",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			-- C: The star of the show. Requires clang-format (install via Mason)
			c = { "clang-format" },

			-- Go: "goimports" fixes imports, "gofumpt" is a stricter, better gofmt
			go = { "goimports", "gofumpt" },

			-- Lua
			lua = { "stylua" },

			-- Python
			python = { "isort", "black" },

			-- Web Stack (Prettier is usually enough for all of these)
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },

			-- Config Files
			json = { "prettierd", "prettier", stop_after_first = true }, -- Prettier handles JSON better than jq (comments support)
			yaml = { "yamlfmt" },
			terraform = { "terraform_fmt" },
		},

		format_on_save = {
			-- Increased timeout for C/C++ or large Go projects
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
	},
}
