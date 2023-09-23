#!/usr/bin/lua
local options = {
    [" Lock"] = "dm-tool switch-to-greeter",
    [" Shut down"] = "systemctl poweroff",
    [" Reboot"] = "systemctl reboot",
    ["﫼 Log out"] = "hyprctl dispatch exit",
}

local options_string = ""
local length = 1
for key, _ in pairs(options) do
    options_string = options_string .. key .. "\n"
    length = length + 1
end
options_string = options_string:sub(1, -2)

local f = assert(
    io.popen(
        "echo -e '"
            .. options_string
            .. "' | wofi -GIb --width 50 --yoffset 30 --xoffset 1700 --dmenu --insensitive --prompt 'Power menu' --lines "
            .. length,
        "r"
    )
)
local s = assert(f:read("*a"))
s = string.gsub(s, "^%s+", "")
s = string.gsub(s, "%s+$", "")
s = string.gsub(s, "[\n]+", " ")
f:close()

os.execute(options[s])
