-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local save = {}

local settings = require("settings")
local locale = require("locale")

local settings_file = "settings.txt"
local record_file = "record.txt"

local key_bindings = { "ccw", "cw", "rot180", "hold", "hard_drop", "soft_drop", "left", "right" }

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
    }
    local text = love.filesystem.read(record_file)
    if text then
        local pairs = decode_pairs(text)
        save.record.marathon = tonumber(pairs.marathon)
        save.record.sprint = tonumber(pairs.sprint)
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
        locale = locale.current,
        fullscreen = tostring(love.window.getFullscreen()),
    }
    for i, k in ipairs(key_bindings) do
        t["key_" .. k] = settings.keys[k]
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

        for i, k in ipairs(key_bindings) do
            local v = pairs["key_" .. k]
            if v and v ~= "" then
                settings.keys[k] = v
            end
        end

        for i, lang in ipairs(locale.langs) do
            if lang == pairs.locale then
                locale.current = lang
                break
            end
        end

        fullscreen = (pairs.fullscreen == "true")
    end

    save.flush()
    save.load_record()

    return fullscreen
end

return save
