-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local user_script = {}

local expose_modules = {
    { name = "game",     path = "src.game.game" },
    { name = "draw",     path = "src.game.draw" },
    { name = "menu",     path = "src.menu.menu" },
    { name = "save",     path = "src.utils.save" },
    { name = "settings", path = "src.menu.settings" },
    { name = "vgafont",  path = "lib.vgafont" },
}

local modules = {}
for i, m in ipairs(expose_modules) do
    modules[m.name] = require(m.path)
end

local function get_home()
    local home = os.getenv("HOME")
    if home and home ~= "" then
        return home
    end

    home = os.getenv("USERPROFILE")
    if home and home ~= "" then
        return home
    end
    return nil
end

local function run_autoexec(config_dir)
    local autoexec = config_dir .. "/autoexec.lua"
    local f = io.open(autoexec, "r")
    if not f then
        return
    end
    local content = f:read("*a")
    f:close()

    local chunk, err = load(content, "@" .. autoexec)
    if chunk then
        local env = setmetatable({}, { __index = _G })
        for name, mod in pairs(modules) do
            env[name] = mod
        end
        env.config_dir = config_dir
        env.autoexec = autoexec
        setfenv(chunk, env)

        local ok, load_err = pcall(chunk)
        if not ok then
            print("autoexec.lua error: " .. tostring(load_err))
        else
            print("autoexec.lua loaded")
        end
    else
        print("autoexec.lua load error: " .. tostring(err))
    end
end

function user_script.run()
    local home = get_home()
    if not home then
        return
    end

    local config_dir = home .. "/.config/pixmino"
    local d = io.open(config_dir, "r")
    if not d then
        return
    end
    d:close()

    run_autoexec(config_dir)
end

return user_script
