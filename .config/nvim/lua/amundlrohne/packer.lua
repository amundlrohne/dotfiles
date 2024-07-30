-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("nvim-tree/nvim-web-devicons")
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"feline-nvim/feline.nvim",
		after = "catppuccin",
		config = function()
			require("feline").setup({
				components = require("catppuccin.groups.integrations.feline").get(),
			})
		end,
	})
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	})
	use("mhartington/formatter.nvim")
	use("ThePrimeagen/harpoon")
	use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	use("lewis6991/gitsigns.nvim")
	use({
		"gelguy/wilder.nvim",
		config = function()
			-- config goes here
		end,
	})
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use("christoomey/vim-tmux-navigator")
    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    })
    use({
      "tpope/vim-dadbod",
      requires = {
       "kristijanhusak/vim-dadbod-ui",
       "kristijanhusak/vim-dadbod-completion"
      },
      config = function()
        vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
        vim.g.db_ui_use_nerd_fonts = 1
      end,
})
end)
