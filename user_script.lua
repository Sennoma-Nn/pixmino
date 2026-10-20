-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local user_script = {}

local nativefs = require("lib.nativefs")
local locale = require("src.manager.locale")

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

    local chunk = nativefs.load(autoexec)
    if not chunk then
        return
    end

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
end

function user_script.config_dir()
    local home = get_home()
    if not home then
        return nil
    end
    if love._os == "Windows" then
        return home .. "\\pixmino"
    end
    return home .. "/.config/pixmino"
end

function user_script.run()
    local config_dir = user_script.config_dir()
    if not config_dir then
        return
    end

    if not nativefs.getInfo(config_dir, "directory") then
        return
    end

    locale.load_custom()

    local skin = require("src.game.skin")
    skin.register_custom(user_script.get_custom_skins())
    Settings.rebuild_skin_menu()

    run_autoexec(config_dir)
end

function user_script.get_custom_skins()
    local skins = {}

    local config_dir = user_script.config_dir()
    if not config_dir then
        return skins
    end

    local skin_root = config_dir .. "/skin"
    local dirs = nativefs.getDirectoryItems(skin_root)
    for _, name in ipairs(dirs) do
        local path = skin_root .. "/" .. name .. "/skin.lua"
        local chunk = nativefs.load(path)
        if chunk then
            local ok, mod = pcall(chunk)
            if ok and type(mod) == "table"
                and type(mod.base) == "function"
                and type(mod.borders) == "function"
            then
                skins[name] = mod
            end
        end
    end

    return skins
end

function user_script.get_custom_i18n()
    local langs = {}

    local config_dir = user_script.config_dir()
    if not config_dir then
        return langs
    end

    local files = nativefs.getDirectoryItems(config_dir .. "/i18n")
    for _, f in ipairs(files) do
        if f:match("%.lua$") then
            local path = config_dir .. "/i18n/" .. f
            local chunk = nativefs.load(path)
            if chunk then
                local ok, mod = pcall(chunk)
                if ok
                    and type(mod) == "table"
                    and type(mod.info) == "table"
                    and type(mod.info.id) == "string"
                    and type(mod.text) == "table"
                then
                    langs[mod.info.id] = {
                        name = mod.info.name or mod.info.id,
                        text = mod.text,
                    }
                end
            end
        end
    end

    return langs
end

return user_script
