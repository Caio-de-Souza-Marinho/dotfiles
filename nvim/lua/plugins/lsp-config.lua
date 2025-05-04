return {
	-- 1) core Mason + auto‑install LSPs
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function() require("mason").setup() end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = { auto_install = true },  -- or ensure_installed = {…} if you want explicit list
	},
	-- 2) mason-tool-installer for Java DAP+Test
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "java-debug-adapter", "java-test" },
		},
		config = function() vim.cmd("MasonToolsInstall") end,
	},

	-- 3) nvim-lspconfig with dynamic handlers
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local caps      = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name)      -- default handler for all servers
					lspconfig[server_name].setup {
						capabilities = caps,
						on_attach    = function(_, bufnr)
							vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
							vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
							vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = bufnr })
							vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
						end,
					}
				end,
			})
		end,
	},
}
