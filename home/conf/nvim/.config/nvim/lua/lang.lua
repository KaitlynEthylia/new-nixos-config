---@class FTSpec
---@field spec LazySpec?
---@field null_ls NullLsSource|NullLsSource[]?
---@field setup fun() | { server: string, settings: table?, pre: fun()? }?
---@field colourscheme string?
---@field parse string[]?
---@field no_treesitter boolean?
---@field enter fun()?
---@field ft string?

return setmetatable({}, {
	---@param filetype string
	---@return fun(ftplugin: FTSpec): LazySpec?
	__call = function(_, filetype)
		return function(ftplugin)
			if ftplugin.spec then
				if type(ftplugin.spec[1]) == 'string' then
					ftplugin.spec.ft = filetype
				else
					---@diagnostic disable-next-line: param-type-mismatch
					for _, v in ipairs(ftplugin.spec) do
						v.ft = filetype
					end
				end
			end

			if ftplugin.setup then
				if type(ftplugin.setup) == 'function' then
					vim.api.nvim_create_autocmd('FileType', {
						pattern = filetype,
						once = true,
						callback = ftplugin.setup
					})
				else
					pcall(ftplugin.setup.pre)
					require 'lspconfig'[ftplugin.setup.server]
						.setup(ftplugin.setup.settings or {})
				end
			end

			if ftplugin.null_ls then
				local ok, null_ls = pcall(require, 'null-ls')
				if ok then
					local sources = ftplugin.null_ls
					if type(sources) == 'function' then
						sources = sources(null_ls.builtins)
					end
					null_ls.register {
						name = 'ftsources_' .. filetype,
						filetypes = { filetype },
						sources = sources,
					}
				end
			end

			if ftplugin.enter then
				vim.api.nvim_create_autocmd('FileType', {
					pattern = filetype,
					callback = ftplugin.enter
				})
			end

			if ftplugin.colourscheme then
				vim.api.nvim_create_autocmd('FileType', {
					pattern = filetype,
					callback = function()
						vim.schedule(function()
							require 'style'.trans(ftplugin.colourscheme)
						end)
					end,
				})
			end

			if not ftplugin.no_treesitter then
				local ok, treesitter = pcall(require, 'nvim-treesitter.install')
				if ok then
					vim.api.nvim_create_autocmd('UIEnter', {
						once = true,
						callback = function()
							if ftplugin.parse then
								if type(ftplugin.parse) == 'table' then
									for _,v in ipairs(ftplugin.parse) do
										treesitter.ensure_installed(v)
									end
								else
									treesitter.ensure_installed(ftplugin.parse)
								end
							else
								treesitter.ensure_installed(filetype)
							end
						end,
					})
				end
			end

			return ftplugin.spec or {}
		end
	end,
})
