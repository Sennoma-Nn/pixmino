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
local record_file = "record.txt"

local settings_roots = { "sound", "input", "display", "debug" }

local function is_arr(t)
    for k in pairs(t) do
        if type(k) ~= "number" then
            return false
        end
    end
    return true
end

local function encode_pairs(t)
    local lines = {}
    for k, v in pairs(t) do
        lines[#lines + 1] = k .. "=" .. tostring(v)
    end
    table.sort(lines)
    return table.concat(lines, "\n") .. "\n"
end

local function decode_pairs(text)
    local out = {}
    if not text then return out end
    for line in text:gmatch("[^\r\n]+") do
        local k, v = line:match("^([^=]+)=(.*)$")
        if k then
            out[k] = v
        end
    end
    return out
end

save.record = {
    marathon = nil,
    sprint = nil,
    master = nil,
    no_move = nil,
    bone_test = nil,
}

function save.flush_record()
    local t = {}
    for k, v in pairs(save.record) do
        if v ~= nil then
            t[k] = v
        end
    end
    love.filesystem.write(record_file, encode_pairs(t))
end

function save.load_record()
    save.record = {
        marathon = nil,
        sprint = nil,
        master = nil,
        no_move = nil,
        bone_test = nil,
    }
    local text = love.filesystem.read(record_file)
    if text then
        local pairs = decode_pairs(text)
        save.record.marathon = tonumber(pairs.marathon)
        save.record.sprint = tonumber(pairs.sprint)
        save.record.master = tonumber(pairs.master)
        save.record.no_move = tonumber(pairs.no_move)
        save.record.bone_test = tonumber(pairs.bone_test)
    end
end

function save.get_record(mode_key)
    return save.record[mode_key]
end

function save.update_record(mode_key, value)
    save.record[mode_key] = value
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
