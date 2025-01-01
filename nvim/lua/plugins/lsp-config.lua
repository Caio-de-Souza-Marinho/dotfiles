return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			-- Setup Lua, TypeScript, and Clangd LSPs
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				handlers = {
					["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
						if result.diagnostics then
							local filtered_diagnostics = {}
							for _, diagnostic in ipairs(result.diagnostics) do
								-- Ignore the specific "unused include" warning
								if not diagnostic.message:find("Included header .* is not used directly") then
									table.insert(filtered_diagnostics, diagnostic)
								end
							end
							result.diagnostics = filtered_diagnostics
						end
						-- Call the default handler after filtering
						vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
					end,
				},
			})

			-- Key mappings for LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
