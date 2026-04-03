local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local front_app = sbar.add("item", "front_app", {

	position = "left",
	background = {
		height = 30,
		corner_radius = 6,
		color = colors.bar.bg,
	},
	label = {
		padding_left = 5,
		padding_right = 10,
		color = colors.foreground_light,
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
	},
	icon = {
		color = colors.slategray.light,
		font = {

			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
	},
	updates = true,
})

local function set_app_icon(app)
	local icon = app_icons[app]
	return icon
end

front_app:subscribe("mouse.entered", function(env)
	local selected = env.SELECTED == "true"
	sbar.animate("elastic", 10, function()
		front_app:set({
			background = {
				height = 30,
				corner_radius = 6,
				color = colors.bar.bg,
			},
			label = {
				padding_left = 5,
				padding_right = 10,
				color = colors.yellow,
				font = {
					style = settings.font.style_map["Regular"],
					size = 14,
				},
			},
		})
	end)
end)

front_app:subscribe("mouse.exited", function(env)
	local selected = env.SELECTED == "true"
	sbar.animate("elastic", 10, function()
		front_app:set({
			background = {
				height = 30,
				corner_radius = 6,
				color = colors.bar.bg,
			},
			label = {
				padding_left = 5,
				padding_right = 10,
				color = colors.foreground_light,
				font = {
					style = settings.font.style_map["Regular"],
					size = 14.0,
				},
			},
			icon = {
				color = colors.slategray.light,
				font = {

					style = settings.font.style_map["Bold"],
					size = 14.0,
				},
			},
		})
	end)
end)

front_app:subscribe("front_app_switched", function(env)
	sbar.animate("elastic", 10, function()
		front_app:set({
			label = { string = set_app_icon(env.INFO) and set_app_icon(env.INFO) or env.INFO },
			icon = {
				padding_left = 0,
				padding_right = 15,
				string = " ❯ ",
			},
		})
	end)
end)

front_app:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
