local M = {}

function M.trans(colour)
	colour = colour or 'catppuccin'
	vim.cmd.colorscheme(colour)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

M.window = {
	border = 'rounded',
}

M.catppuccin = {
	flavour = 'mocha',
	custom_highlights = function(colours)
		M.colours = colours
		return { LineNr = { fg = colours.lavender } }
	end,
}

M.cmp = {
	formatting = function()
		local ok, lspkind = pcall(require, 'lspkind')
		return {
			format = ok and lspkind.cmp_format {
				mode = 'symbol',
			} or nil,
		}
	end,
}

function M.lualine()
	local lualine_c = { 'filename', 'lsp_progress' }
	if pcall(require, 'lsp_signature') then
		table.insert(lualine_c, [[ require 'lsp_signature'.status_line(30).hint ]])
	end
	return {
		sections = {
			lualine_c = lualine_c,
			lualine_x = {},
			lualine_y = { 'filetype' }
		}
	}
end

function M.wilder(wilder)
	local highlighters = { wilder.basic_highlighter() }
	local highlights = {
		accent = wilder.make_hl('WilderAccent', 'Pmenu', {
			{ a = 1 }, { a = 1 }, { foreground = M.colours.pink },
		})
	}
	local wildmenu_renderer = wilder.wildmenu_renderer {
		highlighter = highlighters,
		highlights = highlights,
		seperator = ' . ',
		left = { ' ', wilder.wildmenu_spinner(), ' ' },
		right = { ' ', wilder.wildmenu_index() },
	}

	return wilder.renderer_mux {
		[':'] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
			border = 'rounded',
			highlighter = highlighters,
			highlights = highlights,
			left = {
				' ',
				wilder.popupmenu_devicons(),
				wilder.popupmenu_buffer_flags {
					flags = 'a + ',
					icons = {['+'] = '󱇧', a = ''},
				},
			},
			right = { ' ', wilder.popupmenu_scrollbar() }
		}),
		['/'] = wildmenu_renderer,
		substitute = wildmenu_renderer,
	}
end

return M
