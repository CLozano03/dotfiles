--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- ================== CLOZANO03 ========================

require("config.var")
require(".config.animation")
require(".config.autostart")
require(".config.keyboard")
require(".config.cursor")
require("monitors")
require(".config.environment")
require(".config.window")
require(".config.layout")
require(".config.decoration")
require(".config.keybindings")
require(".config.windowrules")
require(".config.misc")

-- hl.on(".config.hyprland.start", function()
-- 	hl.exec_cmd(".config.dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
-- end)
