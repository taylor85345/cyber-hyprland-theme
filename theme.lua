local theme = Theme or "cyber"
local themeDir = ThemeDir or "$HOME/.config/hypr/themes/" .. theme

hl.config({
	general = {
		col = {
			active_border = "0xFFFFECFD",
			inactive_border = "0xFFEDFDFF",
		},
		border_size = 4,
		gaps_in = 8,
		gaps_out = 16,
	},

	decoration = {
		rounding = 12,
		shadow = {
			enabled = true,
			range = 15,
			render_power = 2,
			offset = { 0, 0 },
			color = "0xFFFA0DED",
			color_inactive = "0xFF3292F3",
		},
		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			noise = 0.04,
		},
	},

	--group = {
	--	col = {
	--		border_active = "rgba(92B6F4FF)",
	--		border_inactive = "rgba(6498EFFF)",
	--	},
	--	groupbar = {
	--		font_family = "Inter Nerd Font ",
	--		font_size = 12,
	--		gradients = 1,
	--		height = 24,
	--		col = {
	--			active = "rgba(6498EFDD)",
	--			inactive = "rgba(6498EF66)",
	--		},
	--	},
	--},
})

hl.layer_rule({
	name = "eww",
	match = { namespace = "^(gtk-layer-shell|rofi|notifications|hyprlauncher|quickshell)$" },
	blur = true,
	ignore_alpha = false,
})

hl.layer_rule({
	match = { namespace = "logout_dialog" },
	blur = true,
})

function WallpaperExec()
	hl.exec_cmd(
		themeDir
			.. "/scripts/wallpaper --kill; "
			.. themeDir
			.. "/scripts/wallpaper --stills "
			.. themeDir
			.. "/wallpaper"
	)
end

function BarExec()
	local barConfig = themeDir .. "/quickshell"
	hl.exec_cmd("pkill qs; qs -p " .. barConfig)
end

hl.on("hyprland.start", function()
	WallpaperExec()
	BarExec()
	hl.exec_cmd("foot --server --config=" .. themeDir .. "/terminals/foot.ini")
	--hl.exec_cmd("killall -3 eww & pkill workspace & sleep 1 && " .. themeDir .. "/eww/launch_bar")
	hl.exec_cmd("killall -3 eww & sleep 1 && " .. themeDir .. "/eww/launch_bar")
end)

hl.on("config.reloaded", function()
	local cache_path = os.getenv("HOME") .. "/.cache/hyprland/last_theme.txt"

	local last_theme = ""
	local file_read = io.open(cache_path, "r")
	if file_read then
		-- Read the contents and trim any trailing whitespaces or newlines
		last_theme = file_read:read("*a"):match("^%s*(.-)%s*$")
		file_read:close()
	end

	if theme ~= last_theme then
		WallpaperExec()
		BarExec()

		local file_write = io.open(cache_path, "w")
		if file_write then
			file_write:write(theme)
			file_write:close()
		end
	end
end)
