local M = {}

vim.g.mapleader = ' '

function M.map(m)
	return function(k)
		return function (v)
			local _m = {}
			for i=1,#m do _m[#_m+1] = m:sub(i, i) end
			vim.keymap.set(_m, k, v, { silent = true })
		end
	end
end

M.map 'nv' '<leader>y' '"+y'
M.map 'nv' '<leader>p' '"+p'
M.map 'i' '<C-Enter>' '<Esc>o'

M.map 'nv' '<leader>ly' '<CMD>Lazy<CR>'

function M.cmp(cmp)
	local ok, snippy = pcall(require, 'snippy')
	return cmp.mapping.preset.insert {
		['<C-h>'] = cmp.mapping.confirm({ select = true }),
		['<C-s>'] = cmp.mapping.scroll_docs(4),
		['<C-r>'] = cmp.mapping.scroll_docs(-4),
		["<Tab>"] = ok and cmp.mapping(function(fallback)
			local _ =
				cmp.visible() and cmp.select_next_item() or
				snippy.can_expand() and snippy.expand() or
				snippy.can_expand_or_advance() and snippy.expand_or_advance() or
				fallback()
		end, { 'i', 's' }) or nil,
		["<S-Tab>"] = ok and cmp.mapping(function(fallback)
			local _ =
				cmp.visible() and cmp.select_next_item() or
				snippy.can_jump(-1) and snippy.previous() or
				fallback()
		end, { 'i', 's' }) or nil,
	}
end

M.lsp = {
	actions = '<leader>a',
	definition = '<leader>gd',
	hover = '<leader>s',
	completion = '<C-s>',
	typeDefinition = '<leader>gt',
	format = '<leader>cf',
	rename = '<leader>r',
	references = {
		['<leader>cr'] = vim.lsp.buf.document_highlight,
		['<leader>cl'] = vim.lsp.buf.clear_references,
		['<leader>gr'] = vim.lsp.buf.references,
	},
	diagnostic = {
		['<leader>ds'] = vim.diagnostic.open_float,
		['<leader>dd'] = vim.diagnostic.show,
		['<leader>de'] = vim.diagnostic.hide,
		['<leader>dw'] = vim.diagnostic.goto_next,
		['<leader>db'] = vim.diagnostic.goto_prev
	},
}

return M
