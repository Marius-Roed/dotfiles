local settings = require("settings")
local colors = require("colors")

local cal = sbar.add("item", {
	display = 1,
	position = "right",
	label = {
		align = "center",
		position = "center",
		padding_right = 10,
		padding_left = 5,
		background = {
			border_width = 1,
			border_color = colors.bar.border,
			corner_radius = 6,
			color = colors.bar.bg,
		},
		color = colors.apple.music,
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["SemiBold"],
			size = 14,
		},
	},
	icon = {
		padding_left = 10,
		padding_right = 5,
		align = "left",
		color = colors.foreground_light,
		font = {
			style = settings.font.style_map["Regualr"],
			size = 12,
		},
	},
	update_freq = 1,
	background = {
		border_width = 1,
		-- color = colors.bar.transparent,
		color = colors.bar.transparent,
	},
	blur_radius = 10,
	color = colors.bar.transparent,
	width = "dynamic",
})

-- Custom mapping for Danish weekdays and months
local weekdays = {
	["Monday"] = "Man",
	["Tuesday"] = "Tirs",
	["Wednesday"] = "Ons",
	["Thursday"] = "Tors",
	["Friday"] = "Fre",
	["Saturday"] = "Lør",
	["Sunday"] = "Søn",
}

local months = {
	["January"] = "januar",
	["February"] = "februar",
	["March"] = "marts",
	["April"] = "april",
	["May"] = "maj",
	["June"] = "juni",
	["July"] = "juli",
	["August"] = "august",
	["September"] = "september",
	["October"] = "oktober",
	["November"] = "november",
	["December"] = "december",
}

local week_num = tonumber(os.date("%W")) + 1

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({
		icon = os.date(
			weekdays[os.date("%A")] .. ", %d " .. months[os.date("%B")] .. " | Uge " .. string.format("%02d", week_num)
		),
		label = os.date("%H:%M:%S"),
	})
end)

cal:subscribe("mouse.clicked", function(env)
	sbar.exec("open 'itsycal://date/now'")
end)
