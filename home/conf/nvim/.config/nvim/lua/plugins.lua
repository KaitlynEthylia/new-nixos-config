local spec = {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {

		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		name = 'treesitter',
		main = 'nvim-treesitter.configs',
		build = ':TSUpdate',
		init = function()
			vim.o.foldmethod = 'expr'
			vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.o.foldlevelstart = 99
		end,
		opts = {
			ensure_installed = { 'vimdoc' },
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false
			}
		},
	},
	{ import = 'plugins.completion' },
	{ import = 'plugins.style' },
	{ import = 'plugins.lsp' },

	{ import = 'lang' },
}

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim',
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)
require 'lazy'.setup {
	spec = spec,
	lockfile = lazypath .. '/../lazy-lock.json',
	dev = {
		path = "~/Scratch/nvim",
		patterns = { 'LOCAL' },
	},
	install = { colorscheme = { 'catppuccin-mocha' } },
	ui = { border = 'rounded' },
	browser = 'thorium',
	change_detection = { enabled = false },
}
