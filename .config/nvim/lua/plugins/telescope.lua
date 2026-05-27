return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local builtin = require("telescope.builtin")
		local function project_root()
			return vim.fs.root(0, ".git") or vim.fn.getcwd()
		end

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.live_grep({
				cwd = project_root(),
			})
		end)
		vim.keymap.set("x", "<leader>ps", function()
			builtin.grep_string({
				cwd = project_root(),
			})
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	end,
}
