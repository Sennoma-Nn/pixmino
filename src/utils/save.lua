-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local save = {}

local settings = require("src.menu.settings")
local locale = require("src.utils.locale")
local sfx = require("src.utils.sfx")

local settings_file = "settings.txt"
local record_file = "record.txt"

local key_bindings = settings.key_actions

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
    }
    local text = love.filesystem.read(record_file)
    if text then
        local pairs = decode_pairs(text)
        save.record.marathon = tonumber(pairs.marathon)
        save.record.sprint = tonumber(pairs.sprint)
        save.record.master = tonumber(pairs.master)
        save.record.no_move = tonumber(pairs.no_move)
    end
end

function save.get_record(mode_key)
    return save.record[mode_key]
end

function save.update_record(mode_key, value)
    save.record[mode_key] = value
    save.flush_record()
end

function save.flush()
    local t = {
        das = settings.input.das,
        arr = settings.input.arr,
        drop_arr = settings.input.drop_arr,
        preop = tostring(settings.input.preop),
        spawn_indicator = tostring(settings.display.spawn_indicator),
        key_info = tostring(settings.display.key_info),
        locale = settings.display.locale,
        fullscreen = tostring(settings.display.fullscreen),
        bgm_volume = settings.sound.volume.bgm,
        sfx_volume = settings.sound.volume.sfx,
        debug_unlock = tostring(settings.debug.unlock),
    }
    for i, k in ipairs(key_bindings) do
        t["key_" .. k] = settings.input.keys[k]
    end
    return love.filesystem.write(settings_file, encode_pairs(t))
end

function save.load()
    local fullscreen = false

    local text = love.filesystem.read(settings_file)
    if text then
        local pairs = decode_pairs(text)

        settings.input.das = tonumber(pairs.das) or settings.input.das
        settings.input.arr = tonumber(pairs.arr) or settings.input.arr
        settings.input.drop_arr = tonumber(pairs.drop_arr) or settings.input.drop_arr

        settings.sound.volume.bgm = tonumber(pairs.bgm_volume) or settings.sound.volume.bgm
        settings.sound.volume.sfx = tonumber(pairs.sfx_volume) or settings.sound.volume.sfx
        sfx.set_bgm_volume(settings.sound.volume.bgm)
        sfx.set_sfx_volume(settings.sound.volume.sfx)

        if pairs.preop ~= nil then
            settings.input.preop = (pairs.preop == "true")
        end
        if pairs.spawn_indicator ~= nil then
            settings.display.spawn_indicator = (pairs.spawn_indicator == "true")
        end
        if pairs.key_info ~= nil then
            settings.display.key_info = (pairs.key_info == "true")
        end

        for i, k in ipairs(key_bindings) do
            local v = pairs["key_" .. k]
            if v and v ~= "" then
                settings.input.keys[k] = v
            end
        end

        for i, lang in ipairs(locale.langs) do
            if lang == pairs.locale then
                settings.display.locale = lang
                locale.current = lang
                break
            end
        end

        settings.display.fullscreen = (pairs.fullscreen == "true")
        fullscreen = settings.display.fullscreen

        if pairs.debug_unlock ~= nil then
            settings.debug.unlock = (pairs.debug_unlock == "true")
        end
    end

    save.flush()
    save.load_record()

    return fullscreen
end

return save
