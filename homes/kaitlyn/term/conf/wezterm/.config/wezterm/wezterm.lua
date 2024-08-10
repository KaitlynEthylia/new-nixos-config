local wezterm = require 'wezterm'
local act = wezterm.action

local WEZTERM_MOD = 'CTRL|SHIFT'

local function prog(name)
	return {
		label = name,
		args = { name },
	}
end

local function key(key)
	return function(action)
		return {
			key = key,
			mods = WEZTERM_MOD,
			action = action,
		}
	end
end

wezterm.on('update-right-status', function(win, _)
	win:set_right_status(win:active_key_table() or '')
end)

return {
	window_background_opacity = 0.9,
	window_padding = { bottom = 0 },

	window_decorations = 'NONE',

	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,

	font = wezterm.font_with_fallback {
		{ family = 'CaskaydiaCove Nerd Font Mono', weight = 400 },
		{ family = 'Noto Sans Mono CJK JP', scale = 1.2 },
		{ family = 'Noto Serif CJK JP', scale = 1.2 },
		'Twitter Color Emoji',
	},

	launch_menu = {
		prog 'lf',
		prog 'nvim',
	},

	default_cursor_style = 'SteadyBar',

	disable_default_key_bindings = true,

	key_map_preference = "Mapped",

	key_tables = {
		RESIZE = {
			{ key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
			{ key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
			{ key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
			{ key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },
			{ key = 'Escape',     action = 'PopKeyTable' },
		},

		-- todo pane movement mode
		-- todo text search / scrollback mode / url click
	},

	keys = {
		key 'R' (act.ActivateKeyTable {
			name = 'RESIZE',
			one_shot = false,
		}),

		key 'LeftArrow' (act.ActivatePaneDirection 'Left'),
		key 'RightArrow' (act.ActivatePaneDirection 'Right'),
		key 'UpArrow' (act.ActivatePaneDirection 'Up'),
		key 'DownArrow' (act.ActivatePaneDirection 'Down'),

		key 'Q' (act.ActivateCommandPalette),

		key 'P' (act.PasteFrom 'Clipboard'),
		key 'Y' (act.CopyTo 'Clipboard'),

		key '_' (act.DecreaseFontSize),
		key '+' (act.IncreaseFontSize),
		key ')' (act.ResetFontSize),

		key 'T' (act.SpawnTab 'CurrentPaneDomain'),

		key 'A' (act.ReloadConfiguration),

		key '%' (act.SplitVertical { domain = 'CurrentPaneDomain' }),
		key '$' (act.SplitHorizontal { domain = 'CurrentPaneDomain' }),

		-- close all panes except this
		-- close all tabs except this
		-- rename current tab
		-- workspaces

		{ key = 'Tab', mods = 'CTRL',       action = act.ActivateTabRelative(1) },
		{ key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
	},

	unix_domains = {
		{ name = 'unix' },
	},
}
