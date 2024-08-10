local a = require 'awful'
require('awful.autofocus')

local keys = require 'config.keys'

a.layout.layouts = {
	a.layout.suit.tile,
	a.layout.suit.tile.left,
	a.layout.suit.tile.bottom,
	a.layout.suit.tile.top,
}

a.rules.rules = {
	{
		rule = {},
		properties = {
			focus = a.client.focus.filter,
			raise = true,
			keys = keys.client,
			buttons = keys.mouse.client,
			screen = a.screen.preferred,
			placement = a.placement.no_overlap
				+ a.placement.no_offscreen,
		},
	},

	{
		rule_any = {
			role = {
				'pop-up',
			},
		},
		properties = { floating = true },
	},
}

client.connect_signal('manage', function(c)
	if not awesome.startup then a.client.setslave(c) end
	if
		a.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position
	then
		a.placement.no_offscreen(c)
	end
end)

client.connect_signal(
	'mouse::enter',
	function(c)
		c:emit_signal(
			'request::activate',
			'mouse_enter',
			{ raise = false }
		)
	end
)

a.screen.connect_for_each_screen(
	function(s) a.tag.new({ '1' }, s, a.layout.layouts[1]) end
)
