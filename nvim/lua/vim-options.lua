-- General Neovim settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.updatetime = 50

-- Set colorcolumn to 80 for .c files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.opt.colorcolumn = "80"
	end,
})

-- Padrão quando não há .editorconfig: tabs para C (Norminette), 2 espaços para web
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript", "javascriptreact", "typescript", "typescriptreact",
		"json", "html", "css", "yaml", "prisma",
	},
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})
