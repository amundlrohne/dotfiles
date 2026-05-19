return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"c",
			"cpp",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"javascript",
			"lua",
			"markdown",
			"markdown_inline",
			"query",
			"rust",
			"templ",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"zig",
		}

		local ok, treesitter = pcall(require, "nvim-treesitter")
		if ok and treesitter.setup and treesitter.install then
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			local installed = treesitter.get_installed("parsers")
			local missing = vim.tbl_filter(function(parser)
				return not vim.tbl_contains(installed, parser)
			end, parsers)

			if #missing > 0 then
				treesitter.install(missing)
			end
		else
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = parsers,
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end

		local group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = {
				"c",
				"cpp",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"help",
				"javascript",
				"javascriptreact",
				"lua",
				"markdown",
				"query",
				"rust",
				"templ",
				"typescript",
				"typescriptreact",
				"vim",
				"zig",
			},
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
