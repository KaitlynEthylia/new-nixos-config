local M = {
	terminal = 'wezterm',
	browser = 'thorium-browser',
	editor = os.getenv('EDITOR'),
}

--[[
function edit(item)
	local cmd = M.terminal .. ' -e ' .. M.editor
	a.spawm(cmd .. ' ' .. item)
end
--]]

return M
