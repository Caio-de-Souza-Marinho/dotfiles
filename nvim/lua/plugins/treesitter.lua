return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"javascript", "typescript", "tsx", "json", "html", "css",
				"prisma", "dockerfile", "yaml", "lua", "c", "java", "markdown",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
