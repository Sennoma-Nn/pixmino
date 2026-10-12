-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local save = {}

local settings = require("src.menu.settings")
local locale = require("src.utils.locale")
local sfx = require("src.utils.sfx")
local skin = require("src.game.skin")
local json = require("lib.json")
local compatibility = require("src.utils.compatibility")

local settings_file = "settings.json"
local record_file = "record.json"

local settings_roots = { "sound", "input", "display", "debug" }

local function is_arr(t)
    for k in pairs(t) do
        if type(k) ~= "number" then
            return false
        end
    end
    return true
end

Record = {}

function save.flush_record()
    local t = {}
    for k, v in pairs(Record) do
        if v ~= nil then
            t[k] = v
        end
    end
    love.filesystem.write(record_file, json.encode(t))
end

function save.load_record()
    Record = {}
    local text = love.filesystem.read(record_file)
    if text then
        local ok, decoded = pcall(json.decode, text)
        if ok and type(decoded) == "table" then
            for k, v in pairs(decoded) do
                Record[k] = tonumber(v) or v
            end
        end
    end
end

function save.get_record(mode_key)
    return Record[mode_key]
end

function save.update_record(mode_key, value)
    Record[mode_key] = value
    save.flush_record()
end

local function merge(dst, src)
    for k, v in pairs(src) do
        if type(v) == "table" and type(dst[k]) == "table" then
            if is_arr(v) then
                dst[k] = v
            else
                merge(dst[k], v)
            end
        else
            dst[k] = v
        end
    end
end

function save.flush()
    local t = {}
    local text = love.filesystem.read(settings_file)
    if text then
        local ok, decoded = pcall(json.decode, text)
        if ok and type(decoded) == "table" then
            t = decoded
        end
    end

    for i, root in ipairs(settings_roots) do
        t[root] = t[root] or {}
        merge(t[root], settings[root])
    end

    love.filesystem.write(settings_file, json.encode(t))
end

function save.load()
    compatibility.ini_setting_2_json()
    compatibility.ini_record_2_json()

    local has_locale = false

    local text = love.filesystem.read(settings_file)
    if text then
        local ok, decoded = pcall(json.decode, text)
        if ok and type(decoded) == "table" then
            for i, root in ipairs(settings_roots) do
                if type(decoded[root]) == "table" then
                    merge(settings[root], decoded[root])
                end
            end
            if type(decoded.display) == "table" and decoded.display.locale ~= nil then
                for i, lang in ipairs(locale.langs) do
                    if lang == decoded.display.locale then
                        settings.display.locale = lang
                        locale.current = lang
                        has_locale = true
                        break
                    end
                end
            end
        end
    end

    if not has_locale then
        settings.display.locale = "en"
        locale.current = "en"
    end

    sfx.set_bgm_volume(settings.sound.volume.bgm)
    sfx.set_sfx_volume(settings.sound.volume.sfx)

    local valid_skin = false
    for _, name in ipairs(skin.get_list()) do
        if name == settings.display.skin then
            valid_skin = true
            break
        end
    end
    if not valid_skin then
        settings.display.skin = "block"
    end

    local fullscreen = settings.display.fullscreen

    save.load_record()

    return fullscreen, has_locale
end

return save
