-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local compatibility = {}

local settings = require("src.menu.settings")
local json = require("lib.json")

local json_path = "settings.json"
local ini_path = "settings.txt"

local function tobool(s)
    return s == "true"
end

local function parse_color(s)
    local vals = {}
    for part in s:gmatch("[^,]+") do
        vals[#vals + 1] = tonumber(part)
    end
    if vals[1] and vals[2] and vals[3] then
        return { vals[1], vals[2], vals[3] }
    end
    return nil
end

local function decode_ini(text)
    local out = {}
    for line in text:gmatch("[^\r\n]+") do
        local k, v = line:match("^([^=]+)=(.*)$")
        if k then
            out[k] = v
        end
    end
    return out
end

local function build_settings_from_ini(p)
    local block_color = {}
    for i, k in ipairs(settings.mino_color_keys) do
        local csv = p["block_color_" .. string.lower(k)]
        block_color[k] = (csv and parse_color(csv)) or settings.display.block_color[k]
    end

    return {
        sound = {
            volume = {
                bgm = tonumber(p.bgm_volume) or settings.sound.volume.bgm,
                sfx = tonumber(p.sfx_volume) or settings.sound.volume.sfx,
            }
        },
        input = {
            das = tonumber(p.das) or settings.input.das,
            arr = tonumber(p.arr) or settings.input.arr,
            drop_arr = tonumber(p.drop_arr) or settings.input.drop_arr,
            preop = (p.preop ~= nil and tobool(p.preop)) or settings.input.preop,
            keys = {
                ccw = p.key_ccw or settings.input.keys.ccw,
                cw = p.key_cw or settings.input.keys.cw,
                rot180 = p.key_rot180 or settings.input.keys.rot180,
                hold = p.key_hold or settings.input.keys.hold,
                hard_drop = p.key_hard_drop or settings.input.keys.hard_drop,
                soft_drop = p.key_soft_drop or settings.input.keys.soft_drop,
                left = p.key_left or settings.input.keys.left,
                right = p.key_right or settings.input.keys.right,
            }
        },
        display = {
            fullscreen = (p.fullscreen ~= nil and tobool(p.fullscreen)) or settings.display.fullscreen,
            skin = p.skin or settings.display.skin,
            split_minos = (p.split_minos ~= nil and tobool(p.split_minos)) or settings.display.split_minos,
            spawn_indicator = (p.spawn_indicator ~= nil and tobool(p.spawn_indicator)) or settings.display.spawn_indicator,
            key_info = (p.key_info ~= nil and tobool(p.key_info)) or settings.display.key_info,
            locale = p.locale or settings.display.locale,
            ez_read = (p.ez_read ~= nil and tobool(p.ez_read)) or settings.display.ez_read,
            block_color = block_color,
        },
        debug = {
            unlock = (p.debug_unlock ~= nil and tobool(p.debug_unlock)) or settings.debug.unlock,
        }
    }
end

function compatibility.ini_setting_2_json()
    if love.filesystem.getInfo(json_path) then
        return false
    end
    if not love.filesystem.getInfo(ini_path) then
        return false
    end

    local text = love.filesystem.read(ini_path)
    if not text then
        return false
    end

    local pairs = decode_ini(text)
    love.filesystem.write(json_path, json.encode(build_settings_from_ini(pairs)))
    return true
end

return compatibility
