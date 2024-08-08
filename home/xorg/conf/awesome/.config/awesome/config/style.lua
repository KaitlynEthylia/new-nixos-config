local b = require 'beautiful'
local g = require 'gears'

local theme_dir = g.filesystem.get_themes_dir()
b.init(theme_dir .. '/default/theme.lua')

if not b.init(theme_dir .. '/gtk/theme.lua') then
	b.init(theme_dir .. '/default/theme.lua')
end

screen.connect_signal('property::geometry', function(s)
	if b.wallpaper then
		local wallpaper = b.wallpaper
		if type(wallpaper) == 'function' then
			wallpaper = wallpaper(s)
		end
		g.wallpaper.maximized(wallpaper, s, true)
	end
end)

client.connect_signal('focus', function(c)
	c.border_color = b.border_focus
end)
client.connect_signal('unfocus', function(c)
	c.border_color = b.border_normal
end)
client.connect_signal('manage', function(c)
	c.shape = function(cr, w, h)
		require 'gears'.shape.rounded_rect(cr, w, h, 10)
	end
end)
