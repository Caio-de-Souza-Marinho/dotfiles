return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		commit = "43b0c856ae5f32a195d83f4a27fe21d63e6c966c",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
		end,
	},
}
