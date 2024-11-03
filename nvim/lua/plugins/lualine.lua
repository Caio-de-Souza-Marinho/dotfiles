return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dracula = require('lualine.themes.dracula')

		-- Modify the dracula theme to set backgrounds to transparent
		dracula.normal.c.bg = 'none'
		dracula.insert.c.bg = 'none'
		dracula.visual.c.bg = 'none'
		dracula.replace.c.bg = 'none'
		dracula.command.c.bg = 'none'
		dracula.inactive.c.bg = 'none'

		require("lualine").setup({
			options = {
				theme = dracula,
				section_separators = '',  -- Optional: remove section separators
				component_separators = '', -- Optional: remove component separators
				global_status = true,      -- Optional: for global statusline
			},
			sections = {
				lualine_a = { 'mode' },         -- Only show mode in section A
				lualine_b = { 'branch' },       -- Show git branch in section B
				lualine_c = { 'filename' },     -- Show filename in section C
				lualine_x = { 'filetype' },
			},
		})
	end,
}
