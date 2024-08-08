local a = require('awful')

local settings = require 'config.settings'

require('awful.hotkeys_popup.keys')

local keys = {
	global = {},
	client = {},
	mouse = {
		global = {},
		client = {},
	},
}

local function describe(fun)
	return function(description)
		return {
			fun = fun,
			description = description,
		}
	end
end

function keys:group(mods)
	return function(group)
		return function(entries)
			for k, v in pairs(entries) do
				local description
				if type(v) == 'table' then
					description = v.descripiton
					v = v.fun
				end
				local key
				local target = self
				if group:sub(-7) == 'buttons' then
					target = target.mouse
					key = a.button.new(mods, k, v)
				else
					key = a.key.new(mods, k, v, {
						group = group,
						description = description,
					})
				end
				target = group:sub(1, 6) == 'client' and target.client
					or target.global
				for _, signal in pairs(key) do
					table.insert(target, signal)
				end
			end
		end
	end
end

local function wrap(fun, ...)
	local args = select('#', ...)
	if args == 0 then return fun end
	if args == 1 then
		local arg1 = ...
		return function() fun(arg1) end
	end
	args = { ... }
	return function() fun(unpack(args)) end
end

local function activate(client)
	client:emit_signal(
		'request::activate',
		'mouse_click',
		{ raise = true }
	)
end

local modkey = 'Mod4'

keys:group { modkey, 'Shift' } 'awesomewm' {
	e = describe(awesome.quit) 'Close AwesomeWM',
	r = describe(awesome.restart) 'Reload AwesomeWM',
	x = describe(wrap(a.spawn, 'xterm')) 'Open XTerm',
}

keys:group { modkey } 'application' {
	q = describe(wrap(a.spawn, settings.terminal)) 'Open Wezterm',
	l = describe(wrap(a.spawn, settings.browser)) 'Open Thorium',
	y = describe(wrap(a.spawn, 'vesktop')) 'Open Discord',
	d = describe(
		wrap(
			a.spawn, 'bemenu-run',
			'-H', '44', '-p', ' ', '-i',
			'--fn', 'CaskaydiaCove Nerd Font Mono Semi-Bold 10',
			'--tb', '#00000000',
			'--fb', '#00000000',
			'--nb', '#00000000',
			'--hb', '#00000000',
			'--ab', '#00000000',
			'--ff', '#FFFFFFFF',
			'--cf', '#00000000',
			'--nf', '#FFFFFFFF',
			'--hf', '#FFAAEEFF'
		)
	) 'Application Launcher',
}

keys:group { modkey } 'base' {
	['/'] = describe(require('awful.hotkeys_popup.widget').show_help) 'Show Help.',
}

-- keys:group { modkey } 'resize' {}
-- keys:group { modkey } 'window' {}
-- keys:group { modkey } 'tags' {}

keys:group { modkey } 'client' {
	f = describe(function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end) 'Toggle Fullscreen',
	k = describe(function(c) c:kill() end) 'Close',
	['space'] = describe (a.client.floating.toggle) 'Toggle Floating',
	-- ['down'] = describe (function(c) c.maximized = false end) 'Minimize',
}

keys:group {} 'client-buttons' {
	[1] = activate,
}

keys:group { modkey } 'client-buttons' {
	[1] = function(c)
		activate(c)
		a.mouse.client.move(c)
	end,
	[3] = function(c)
		activate(c)
		a.mouse.client.resize(c)
	end,
}

root.keys(keys.global)

return keys
