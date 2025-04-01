--return {
--	"williamboman/mason.nvim",
--	dependencies = {
--		{ "williamboman/mason-lspconfig.nvim" },
--		{ "neovim/nvim-lspconfig" },
--	},
--	config = function()
--		require("mason").setup()
--		require("mason-lspconfig").setup()
--
--		require("mason-lspconfig").setup_handlers({
--			-- The first entry (without a key) will be the default handler
--			-- and will be called for each installed server that doesn't have
--			-- a dedicated handler.
--			function(server_name) -- default handler (optional)
--				require("lspconfig")[server_name].setup({})
--			end,
--			-- Next, you can provide a dedicated handler for specific servers.
--			-- For example, a handler override for the `rust_analyzer`:
--			["rust_analyzer"] = function()
--				require("rust-tools").setup({})
--			end,
--		})
--
--		vim.api.nvim_create_autocmd("LspAttach", {
--			callback = function(ev)
--				local client = vim.lsp.get_client_by_id(ev.data.client_id)
--				if client:supports_method("textDocument/completion") then
--					vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
--				end
--			end,
--		})
--	end,
--}
return {
	"VonHeikemen/lsp-zero.nvim",
	version = "v4.x",
	dependencies = {
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "williamboman/mason.nvim" }, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "L3MON4D3/LuaSnip" }, -- Required
	},
	config = function()
		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)
		-- This is where you enable features that only work
		-- if there is a language server active in the file
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end,
		})

		require("mason").setup()
		require("mason-lspconfig").setup()

		require("mason-lspconfig").setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			["rust_analyzer"] = function()
				require("rust-tools").setup({})
			end,
		})

		-- Make sure you setup `cmp` after lsp-zero

		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
			},
			snippet = {
				expand = function(args)
					-- You need Neovim v0.10 to use vim.snippet
					vim.snippet.expand(args.body)
				end,
			},
			mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			},
		})
		--		local cmp = require("cmp")
		--
		--		cmp.setup({
		--			mapping = {
		--				["<CR>"] = cmp.mapping.confirm({ select = false }),
		--			},
		--		})
	end,
}
