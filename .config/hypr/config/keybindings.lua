-- DIR where scripts are located
local SCRIPTS_DIR = "~/.config/hypr/scripts"

-- -----------------------------------------------------
-- Key bindings
-- -----------------------------------------------------

hl.bind(
	mainMod .. " + CTRL + Q",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser_cmd))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(menu), { release = true })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(nextwal))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprpicker -a"))

-- hl.bind("SUPER + Tab", function()
-- 	hl.dispatch(hl.dsp.window.cycle_next()) -- Change focus to another window
-- 	hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
-- end)
--
-- -- Apps
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/floating_term.sh"))

hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.window.move({ workspace = "special:term" }))

hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd(terminal .. '+ --title "btop" -e btop'))

hl.bind("SUPER + Y", hl.dsp.exec_cmd(bluetooth))
hl.bind("SUPER + I", hl.dsp.exec_cmd(network))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprpanel toggleWindow bar-0"))
hl.bind("F5", hl.dsp.exec_cmd("reload"))

-- ############# Workspaces ##############

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))

	if i > 5 then
		hl.workspace_rule({ workspace = i, monitor = "eDP-1" })
	else
		hl.workspace_rule({ workspace = i, monitor = "HDMI-A-1" })
	end
end

-- Scroll through existing workspaces
hl.bind("CTRL + " .. mainMod .. " + Right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + " .. mainMod .. " + Left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- ############## Windows ################

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + TAB", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock -q"))

-- bind = CTRL ALT, P, exec, $SCRIPTS_DIR/wlogout.sh
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd(power_menu))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Vim-like bindings
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + Z", hl.dsp.window.drag())

-- Fn keys
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

-- Volume && Mic
hl.bind("xf86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("xf86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("xf86audiomute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("xf86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

-- Media controls
-- hl.bind("xf86AudioPlayPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("xf86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("xf86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("xf86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- hl.bind("xf86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- hl.bind("xf86audiostop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })
--
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(SCRIPTS_DIR .. "/layout.sh"))
--
-- -- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd(screenshot_window))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot_zone))
hl.bind(mainMod .. "  + S", hl.dsp.exec_cmd(screenshot_screen))

-- Minimize window with Super + U
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + U", hl.dsp.window.move({ workspace = "+0" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + U", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("magic"))

--#######################################################################
-- Cliphist mode

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(SCRIPTS_DIR .. "/cliphist.sh"))
-- bind = $mainMod, V, submap,cliphist
-- submap=cliphist

-- bind = ,Backspace, exec, $SCRIPTS_DIR/cliphist.sh

-- bind=,RETURN,submap,reset
-- bind=,escape,submap,reset

-- submap=reset

-- Resize mode
-- hl.bind(mainMod .. " + r", hl.dsp.submap("resize"))

-- sets repeatable binds for resizing the active window
-- hl.bind("l", hl.dsp.window.resize("10 0"), { repeating = true })
-- hl.bind("h", hl.dsp.window.resize("-10 0"), { repeating = true })
-- hl.bind("k", hl.dsp.window.resize("0 -10"), { repeating = true })
-- hl.bind("j", hl.dsp.window.resize("0 10"), { repeating = true })
--
-- hl.bind("SHIFT + l", hl.dsp.window.resize("100 0"), { repeating = true })
-- hl.bind("SHIFT + h", hl.dsp.window.resize("-100 0"), { repeating = true })
-- hl.bind("SHIFT + k", hl.dsp.window.resize("0 -100"), { repeating = true })
-- hl.bind("SHIFT + j", hl.dsp.window.resize("0 100"), { repeating = true })
--
-- -- use reset to go back to the global submap
-- hl.bind("escape", hl.dsp.submap("reset"))

-- (end of submap block)

-- local key = "tab"
-- local mod = "alt"
-- local reverse = "grave"
--
-- hl.bind(
-- 	mod .. " + $key",
-- 	hl.dsp.exec_cmd(
-- 		"hyprswitch gui --mod-key "
-- 			.. mod
-- 			.. " --key "
-- 			.. key
-- 			.. " --close mod-key-release --reverse-key=key="
-- 			.. reverse
-- 			.. " && hyprswitch dispatch"
-- 	)
-- )
-- hl.bind(
-- 	mod .. " + $reverse",
-- 	hl.dsp.exec_cmd(
-- 		"hyprswitch gui --mod-key "
-- 			.. mod
-- 			.. " --key "
-- 			.. key
-- 			.. " --close mod-key-release --reverse-key=key="
-- 			.. reverse
-- 			.. " && hyprswitch dispatch -r"
-- 	)
-- )
--
-- hl.on("hyprland.start", function()
-- 	hl.exec_cmd("hyprswitch init --show-title &")
-- end)
