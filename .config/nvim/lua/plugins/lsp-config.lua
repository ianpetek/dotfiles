return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pylsp" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			-- keymaps
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- lua_ls
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
					},
				},
			})
			-- clangd
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					-- see clangd --help-hidden
					"clangd",
					"--background-index",
					-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
					-- to add more checks, create .clang-tidy file in the root directory
					-- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
					"--clang-tidy",
					"--completion-style=bundled",
					"--cross-file-rename",
					"--header-insertion=iwyu",
				},
				-- TODO: figure out what is this
				init_options = {
					clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
					usePlaceholders = true,
					completeUnimported = true,
					semanticHighlighting = true,
				},
			})

			-- pylsp
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
		end,
	},
}
