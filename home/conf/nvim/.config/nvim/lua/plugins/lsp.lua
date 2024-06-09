return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local keybinds = require 'keybinds'
					local client =
						vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end
					if
						client.server_capabilities.codeActionProvider
					then
						keybinds.map 'nv'(keybinds.lsp.actions)(
							vim.lsp.buf.code_action
						)
					end
					if
						client.server_capabilities.definitionProvider
					then
						keybinds.map 'nv'(keybinds.lsp.definition)(
							vim.lsp.buf.definition
						)
					end
					if client.server_capabilities.hoverProvider then
						keybinds.map 'nv'(keybinds.lsp.hover)(
							vim.lsp.buf.hover
						)
					end
					if
						client.server_capabilities.completionProvider
					then
						keybinds.map 'nv'(keybinds.lsp.completion)(
							vim.lsp.buf.completion
						)
					end
					if
						client.server_capabilities.typeDefinitionProvider
					then
						keybinds.map 'nv'(keybinds.lsp.typeDefinition)(
							vim.lsp.buf.type_definition
						)
					end
					if
						client.server_capabilities.documentFormattingProvider
					then
						keybinds.map 'nv'(keybinds.lsp.format)(
							vim.lsp.buf.format
						)
					end
					if client.server_capabilities.renameProvider then
						keybinds.map 'nv'(keybinds.lsp.rename)(
							vim.lsp.buf.rename
						)
					end
					if
						client.server_capabilities.referencesProvider
					then
						for k, v in pairs(keybinds.lsp.references) do
							keybinds.map 'nv'(k)(v)
						end
					end
					for k, v in pairs(keybinds.lsp.diagnostic) do
						keybinds.map 'nv'(k)(v)
					end
				end,
			})
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		opts = {},
	},
	{
		'ray-x/lsp_signature.nvim',
		event = 'LspAttach',
		opts = {
			floating_window = false,
			hint_enable = false,
		},
	},
	{
		'arkav/lualine-lsp-progress',
		event = 'LspAttach',
	},
	{
		'onsails/lspkind.nvim',
		event = 'LspAttach',
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		event = 'LspAttach',
	},
}
