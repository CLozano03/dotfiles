-- -- Window rules
-- -- source $HOME/.cache/wal/colors.conf
--
-- require("config.var")
--
-- local floating_opacity = 0.92
--
-- --######## Launcher rules #########
hl.layer_rule({
	name = "layerrule-1",
	match = {
		namespace = "rofi",
	},
	-- 	-- TODO: manual review — disable "blur" has no layer_rule directive analog
	-- 	-- TODO: manual review — unmapped layer rule: "ignore_alpha 1.0"
	-- 	-- TODO: manual review — unmapped layer rule: "dim_around"
})
--
-- --#############################
--
hl.layer_rule({
	name = "layerrule-2",
	match = {
		namespace = "hyprpicker",
	},
	-- TODO: manual review — unmapped layer rule: "no_anim"
})
--
-- hl.layer_rule({
-- 	name = "layerrule-3",
-- 	match = {
-- 		namespace = "selection",
-- 	},
-- 	-- TODO: manual review — unmapped layer rule: "no_anim"
-- })
--
hl.window_rule({
	name = "windowrule-1",
	match = {
		class = "xdg-desktop-portal-gtk",
	},
	float = true,
})
--
-- -- Bluetooth Devices
-- hl.window_rule({
-- 	name = "windowrule-2",
-- 	match = {
-- 		title = "Bluetooth Devices$",
-- 	},
-- 	float = true,
-- 	center = true,
-- })
--
hl.window_rule({
	name = "windowrule-3",
	match = {
		title = "^(Bluetooth Devices)$",
	},
	opacity = floating_opacity,
	size = "750 800",
	pin = true,
})
--
-- Pavucontrol
hl.window_rule({
	name = "windowrule-4",
	match = {
		class = "org.pulseaudio.pavucontrol$",
	},
	float = true,
})
--
-- hl.window_rule({
-- 	name = "windowrule-5",
-- 	match = {
-- 		class = "^(org.pulseaudio.pavucontrol)$",
-- 	},
-- 	pin = true,
-- 	opacity = floating_opacity,
-- 	-- TODO: manual review — unmapped window rule action: "border_size 2"
-- 	size = "750 800",
-- })
--
-- -- Nm-connection-editor
hl.window_rule({
	name = "windowrule-6",
	match = {
		class = "nm-connection-editor$",
	},
	float = true,
})
--
-- hl.window_rule({
-- 	name = "windowrule-7",
-- 	match = {
-- 		class = "^(nm-connection-editor)$",
-- 	},
-- 	opacity = floating_opacity,
-- })
--
-- -- Calculator
local calc = "org.speedcrunch.speedcrunch"
hl.window_rule({
	name = "windowrule-8",
	match = {
		class = calc .. "$",
	},
	float = true,
	move = "(1375) (70)",
})
--
hl.window_rule({
	name = "windowrule-9",
	match = {
		class = "^(" .. calc .. ")$",
	},
	size = "500 600",
})
--
-- -- Thunar
hl.window_rule({
	name = "windowrule-10",
	match = {
		class = "^(thunar)$",
	},
	float = true,
	size = "1000 800",
})
--
-- -- Gparted
hl.window_rule({
	name = "windowrule-11",
	match = {
		class = "gpartedbin$",
	},
	float = true,
})

hl.window_rule({
	name = "windowrule-12",
	match = {
		class = "^(gpartedbin)$",
	},
	size = "1200 800",
})

-- Udiskie
hl.window_rule({
	name = "windowrule-13",
	match = {
		class = "udiskie$",
	},
	float = true,
})

hl.window_rule({
	name = "windowrule-14",
	match = {
		class = "^(udiskie)$",
	},
	size = "550 200",
})

-- Swappy (screenshots)
hl.window_rule({
	name = "windowrule-15",
	match = {
		class = "^(swappy)$",
	},
	-- 	-- TODO: manual review — unmapped window rule action: "stay_focused on"
	center = true,
})

-- Btop from Terminal with title
hl.window_rule({
	name = "windowrule-16",
	match = {
		class = "^(" .. wRTerminal .. ")",
		title = "^(btop)$",
	},
	float = true,
	-- TODO: manual review — unmapped window rule action: "border_size 3"
	-- TODO: manual review — unmapped window rule action: "keep_aspect_ratio on"
	-- TODO: manual review — unmapped window rule action: "no_max_size on"
	size = "1650 950",
	center = true,
})

-- Terminal tiled
hl.window_rule({
	name = "windowrule-17",
	match = {
		class = "^(" .. wRTerminal .. ")$",
	},
	opacity = "0.85 override 0.91 override 1.0 override",
})

hl.window_rule({
	name = "windowrule-18",
	match = {
		class = "^(" .. wRTerminal .. ")",
		title = "^(floating-terminal)$",
	},
	float = false,
	workspace = "special:term",
})
--
-- Waypaper
hl.window_rule({
	name = "windowrule-19",
	match = {
		class = "(.*waypaper.*)",
	},
	float = true,
	size = "850 800",
	center = true,
	pin = true,
})

-- ========================================
-- Opaque windows
hl.window_rule({
	name = "windowrule-20",
	match = {
		class = "^(Code)$",
	},
	-- TODO: manual review — unmapped window rule action: "opaque on"
})
--
-- -- ========================================
-- -- Where to place windows
-- -- ========================================
hl.window_rule({
	name = "windowrule-21",
	match = {
		class = browser .. "$",
	},
	workspace = "1",
})

hl.window_rule({
	name = "windowrule-22",
	match = {
		class = "Code$",
	},
	workspace = "3",
})

hl.window_rule({
	name = "windowrule-23",
	match = {
		class = "^(org.pwmt.zathura)$",
	},
	workspace = "3",
})
--
-- --######################################################
-- --################## WORKSPACE RULES ###################
-- --######################################################
-- hl.workspace_rule({
-- 	workspace = "1",
-- 	monitor = "eDP-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "2",
-- 	monitor = "eDP-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "3",
-- 	monitor = "eDP-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "4",
-- 	monitor = "eDP-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "5",
-- 	monitor = "eDP-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "6",
-- 	monitor = "HDMI-A-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "7",
-- 	monitor = "HDMI-A-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "8",
-- 	monitor = "HDMI-A-1",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "9",
-- 	monitor = "HDMI-A-1",
-- })
--
-- hl.window_rule({
-- 	name = "windowrule-24",
-- 	match = {
-- 		class = ".*",
-- 	},
-- 	suppress_event = "maximize",
-- })
--
-- -- Spotify
hl.window_rule({
	name = "windowrule-25",
	match = {
		class = "^(spotify)$",
	},
	workspace = "special:music",
	float = true,
	size = "(monitor_w*0.8) (monitor_h*0.8)",
	center = true,
})

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.workspace.toggle_special("music"))
