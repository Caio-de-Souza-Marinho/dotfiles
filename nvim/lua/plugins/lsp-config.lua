return {
	-- 1) Mason (instalador de LSPs/ferramentas)
	{
		"williamboman/mason.nvim",
		version = "1.11.0",
		lazy = false,
		config = function() require("mason").setup() end,
	},
	-- 2) mason-lspconfig: instala os servidores listados
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.32.0", -- manter na 1.x: a 2.x removeu setup_handlers
		lazy = false,
		opts = {
			ensure_installed = {
				-- JS/TS (NestJS + React)
				"ts_ls",
				"eslint",
				-- Front: Tailwind, CSS, HTML
				"tailwindcss",
				"cssls",
				"html",
				-- Prisma, JSON (package.json, tsconfig), Docker
				"prismals",
				"jsonls",
				"dockerls",
				"docker_compose_language_service",
				-- o que você já usa
				"lua_ls",
				"clangd",
			},
		},
	},
	-- 3) Ferramentas que não são LSP (Java DAP/test)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = { "java-debug-adapter", "java-test" },
		},
	},

	-- 4) nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local caps = require("cmp_nvim_lsp").default_capabilities()

			local function on_attach(_, bufnr)
				local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr }) end
				map("K", vim.lsp.buf.hover)
				map("<leader>gd", vim.lsp.buf.definition)
				map("<leader>gr", vim.lsp.buf.references)
				map("<leader>gi", vim.lsp.buf.implementation)
				map("<leader>rn", vim.lsp.buf.rename)
				map("<leader>ca", vim.lsp.buf.code_action)
				map("<leader>e", vim.diagnostic.open_float)
			end

			-- Formatação fica com o prettier (none-ls); o ts_ls não formata,
			-- senão o <leader>gf pergunta qual cliente usar.
			local function no_format_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				on_attach(client, bufnr)
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- padrão
					lspconfig[server_name].setup({ capabilities = caps, on_attach = on_attach })
				end,
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({ capabilities = caps, on_attach = no_format_attach })
				end,
				["eslint"] = function()
					lspconfig.eslint.setup({
						capabilities = caps,
						on_attach = function(client, bufnr)
							on_attach(client, bufnr)
							-- <leader>ef: aplica todos os fixes do eslint
							vim.keymap.set("n", "<leader>ef", "<cmd>EslintFixAll<CR>", { buffer = bufnr })
						end,
					})
				end,
				-- Java é configurado pelo nvim-jdtls (ftplugin/java.lua); não subir 2x
				["jdtls"] = function() end,
			})
		end,
	},
}
