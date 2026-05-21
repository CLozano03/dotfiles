-- -----------------------------------------------------
-- Layouts
-- -----------------------------------------------------

-- dwindle {
--     pseudotile = true
--     force_split = 2
--     preserve_split = true
--     use_active_for_splits = false
-- }

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "down",
-- 	action = "mod: ALT",
-- 	-- TODO: manual review — extra gesture field "close"
-- })
--
-- hl.gesture({ fingers = 4, direction = "pinch", action = "cursorZoom", zoom_level = 2 })
-- hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1.2, mode = "mult" })
-- hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
--
--
hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.notification.create({ text = "I just swiped on my trackpad!", duration = 5000, icon = "ok" })
	end,
})

hl.config({
	master = {
		new_on_top = true,
	},
})
