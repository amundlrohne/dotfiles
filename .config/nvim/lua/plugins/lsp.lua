return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local border_style = "single"
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason").setup()
		require("mason-lspconfig").setup({
			-- Auto-install these servers
			ensure_installed = {
				"clangd", -- C / C++
				"helm_ls", -- Helm
				"gopls", -- Go
				"ts_ls", -- JS / TS (formerly tsserver)
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind CSS
			},

			handlers = {
				-- Default handler: Setup standard servers (html, cssls, ts_ls)
				-- with default settings.
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Custom Handler: Helm
				["helm_ls"] = function()
					require("lspconfig").helm_ls.setup({
						capabilities = capabilities,
						settings = {
							["helm-ls"] = {
								yamlls = { path = "yaml-language-server" },
							},
						},
					})
				end,

				-- Custom Handler: Clangd (C/C++)
				["clangd"] = function()
					require("lspconfig").clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--header-insertion=iwyu",
							"--completion-style=detailed",
							"--function-arg-placeholders",
							"--fallback-style=llvm",
						},
						init_options = {
							usePlaceholders = true,
							completeUnimported = true,
							clangdFileStatus = true,
						},
					})
				end,

				-- Custom Handler: Gopls (Go)
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								-- Enable "staticcheck" for better linting
								staticcheck = true,
								-- Add import to unimported packages automatically
								completeUnimported = true,
								-- Show placeholders for function parameters
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
							},
						},
					})
				end,
			},
		})

		-- Keymaps & Autocmds
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = border_style })
				end, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gs", function()
					vim.lsp.buf.signature_help({ border = border_style })
				end, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}
