-- This file is automatically loaded by Neovim after plugins.
-- No lazy.nvim wrapper is needed.

-- Create an augroup to ensure the autocmd is not created multiple times.
local templ_group = vim.api.nvim_create_augroup("Templ", { clear = true })

-- Create the autocommand.
vim.api.nvim_create_autocmd("BufWritePost", {
	group = templ_group,
	pattern = "*.templ", -- Trigger on save for any .templ file
	callback = function()
		-- Use vim.notify to show messages without interrupting your workflow.
		vim.notify("Generating templ files...", vim.log.levels.INFO, { title = "Templ" })

		-- Execute the command. We use vim.fn.system to capture the output.
		local output = vim.fn.system("templ generate")

		-- Check if the command failed. vim.v.shell_error is non-zero on failure.
		if vim.v.shell_error ~= 0 then
			vim.notify("Templ generate failed:\n" .. output, vim.log.levels.ERROR, { title = "Templ" })
		else
			vim.notify("Templ files generated successfully!", vim.log.levels.INFO, { title = "Templ" })
		end
	end,
})
