local n = require 'naughty'

local in_error = false
awesome.connect_signal('debug::error', function(err)
	-- Make sure we don't go into an endless error loop
	if in_error then return end
	in_error = true

	n.notify({
		preset = n.config.presets.critical,
		title = 'Oops, an error happened!',
		text = tostring(err),
	})
	in_error = false
end)

local M = {}

function M.inspectTable(tbl)
	local str = ''
	for k, v in pairs(tbl) do
		str = str .. tostring(k) .. ' = ' .. tostring(v) .. '\n'
	end

	n.notify {
		preset = n.config.presets.info,
		title = 'keys.global',
		text = str,
	}
end

return M
