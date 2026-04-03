local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery_percent = sbar.add("item", "battery1", {
	display = 1,
	bar = "right_bar",
	position = "right",
	icon = {
		drawing = false,
	},
	label = {
		padding_right = 5,
		align = "center",
		position = "center",
		string = "??%",
		color = colors.bar.foreground,
		font = {
			style = settings.font.style_map["SemiBold"],
			family = settings.font.text,
		},
	},
})

local battery_icon = sbar.add("item", "battery2", {
	display = 1,
	position = "right",
	icon = {
		font = {
			style = settings.font.style_map["SemiBold"],
		},
		color = colors.apple.music,
	},
	label = { drawing = false },
	padding_left = 5,
	update_freq = 10,
})

local battery_bracket = sbar.add("bracket", "battery.bracket", { battery_icon.name, battery_percent.name }, {
	display = 1,
	padding_left = 100,
	padding_right = 10,
	background = {
		color = colors.bar.bg,
	},
})

local function battery_update()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local lead = ""
		local percent = "??"
		local color = colors.gray

		if string.find(batt_info, "AC Power") then
			icon = icons.battery.charging
			_, _, percent = batt_info:find("(%d+)%%")
		else
			local found, _, charge = batt_info:find("(%d+)%%")
			if found then
				percent = charge
				charge = tonumber(charge)
				color = colors.apple.music
			end

			if found and charge > 90 then
				icon = icons.battery._100
				color = colors.apple.music
			elseif found and charge > 60 then
				icon = icons.battery._75
				color = colors.gray
			elseif found and charge > 25 then
				icon = icons.battery._50
				color = colors.gray
			elseif found and charge > 10 then
				icon = icons.battery._25
				color = colors.gray
			else
				icon = icons.battery._0
				color = colors.red
			end

			if charge < 10 then
				lead = "0"
			end
		end

		battery_icon:set({ icon = { string = icon, color = color } })
		battery_percent:set({ label = lead .. percent .. "%" })
	end)
end

battery_icon:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)
