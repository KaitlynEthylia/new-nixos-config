return {
	{
		'lilydjwg/colorizer',
		keys = { { '#', mode = 'i' } }
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		opts = require 'style'.catppuccin,
		priority = 100,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = require 'style'.lualine,
	},
	{
		'stevearc/dressing.nvim',
		opts = {}
	}
}
