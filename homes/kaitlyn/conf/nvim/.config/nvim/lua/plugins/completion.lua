return {
	{
		'hrsh7th/nvim-cmp',
		name = 'cmp',
		config = function()
			local cmp = require 'cmp'
			local haslsp = pcall(require, 'lspconfig')
			cmp.setup{
				formatting = require 'style'.cmp.formatting(),
				snippet = {
					expand = function(args)
						require 'snippy'.expand_snippet(args.body)
					end,
				},
				window = {
					completion = require 'style'.window,
					documentation = require 'style'.window,
				},
				mapping = require 'keybinds'.cmp(cmp),
				sources = cmp.config.sources {
					{ name = 'snippy' },
					{ name = 'path' },
					haslsp and
					{ name = 'nvim_lsp' } or nil
				},
			}
			cmp.setup.filetype('gitcommit', {
				sources = {
					{ name = 'git' },
					{ name = 'buffer' },
				}
			})

			cmp.setup.filetype({'markdown', 'text'}, {
				sources = { { name = 'buffer' } },
			})
		end,
		dependencies = {
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'dcampos/nvim-snippy',
			'dcampos/cmp-snippy',
			{ 'hrsh7th/cmp-nvim-lsp', optional = true },
			{
				'petertriho/cmp-git',
				opts = {},
				dependencies = 'nvim-lua/plenary.nvim',
			},
		}
	},
	{
		'gelguy/wilder.nvim',
		keys = { ':', '/', '?' },
		opts = { modes = {':', '/', '?'} },
		build =  ':UpdateRemotePlugins',
		config = function(opts)
			local wilder = require 'wilder'
			local win = vim.fn.has 'win32' == 1
			wilder.setup(opts.opts)



			local pipeline = {}

			if not win then
				table.insert(pipeline, wilder.python_file_finder_pipeline {
					file_command = function(ctx, arg)
						return string.find(arg, '.') ~= nil
						and { 'fd', '-tf', '-H' }
						or { 'fd', '-tf' }
					end,
					dir_command = { 'fd', '-td' },
					filters = { 'fuzzy_filter', 'difflib_sorter' },
				})
				table.insert(pipeline, wilder.substitute_pipeline {
					pipeline = wilder.python_search_pipeline {
						skip_cmdtype_check = 1,
						pattern = wilder.python_fuzzy_pattern {
							start_at_boundary = 0,
						},
					},
				})
			end

			table.insert(pipeline, wilder.cmdline_pipeline {
				language = win and 'vim' or 'python',
				fuzzy = 1,
			})

			table.insert(pipeline, {
				wilder.check(function(ctx, x) return x == '' end),
				wilder.history(),
			})

			if not win then
				table.insert(pipeline, wilder.python_search_pipeline {
					pattern = wilder.python_fuzzy_pattern(),
					sorter = wilder.python_difflib_sorter(),
				})
			end

			wilder.set_option('use_python_remote_plugin', win and 0 or 1)
			wilder.set_option('pipeline', {
				wilder.branch(unpack(pipeline)),
			})

			wilder.set_option('renderer', require 'style'.wilder(wilder))
		end,
	},
}
