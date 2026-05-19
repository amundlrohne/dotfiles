return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local border_style = "single"
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = {
			"clangd",
			"helm_ls",
			"gopls",
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"zls",
		}

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("helm_ls", {
			settings = {
				["helm-ls"] = {
					yamlls = { path = "yaml-language-server" },
				},
			},
		})

		vim.lsp.config("clangd", {
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

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					staticcheck = true,
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_enable = false,
		})
		vim.lsp.enable(servers)

		local group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,
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
