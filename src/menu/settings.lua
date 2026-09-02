-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = require("src.utils.locale")
local push = require("lib.push")
local sfx = require("src.utils.sfx")

Settings = {
    sound = {
        volume = {
            bgm = 0.4,
            sfx = 1.0,
        }
    },
    input = {
        das = 9,
        arr = 2,
        drop_arr = 2,
        preop = true,
        keys = {
            ccw = "z",
            cw = "x",
            rot180 = "a",
            hold = "c",
            hard_drop = "space",
            soft_drop = "down",
            left = "left",
            right = "right",
        }
    },
    display = {
        fullscreen = false,
        locale = "en",
        spawn_indicator = true,
    },
    debug = {
        unlock = false
    }
}

Settings.key_actions = { "left", "right", "ccw", "cw", "rot180", "soft_drop", "hard_drop", "hold" }

local function make_keys_items()
    local items = {}
    for _, k in ipairs(Settings.key_actions) do
        items[#items + 1] = {
            type = "keys",
            text_key = k:upper(),
            desc_key = (k:upper()) .. "_DESC",
            key_name = k,
        }
    end
    return items
end

Settings.menu = {
    MENU_SETTINGS = {
        {
            type = "action",
            text_key = "DISPLAY",
            desc_key = "DISPLAY_DESC",
            jmp = "MENU_SETTINGS_DISPLAY",
        },
        {
            type = "action",
            text_key = "SOUND",
            desc_key = "SOUND_DESC",
            jmp = "MENU_SETTINGS_SOUND",
        },
        {
            type = "action",
            text_key = "INPUT",
            desc_key = "INPUT_DESC",
            jmp = "MENU_SETTINGS_CTRL",
        },
        {
            type = "action",
            text_key = "CONSOLE",
            desc_key = "CONSOLE_DESC",
            action = function()
                require("src.debug.launcher").toggle()
            end,
            display = function()
                return Settings.debug.unlock
            end
        },
    },
    MENU_SETTINGS_DISPLAY = {
        {
            type = "toggle",
            text_key = "FULLSCREEN",
            desc_key = "FULLSCREEN_DESC",
            get = function() return Settings.display.fullscreen end,
            set = function()
                push:switchFullscreen()
                Settings.display.fullscreen = love.window.getFullscreen()
            end,
        },
        {
            type = "toggle",
            text_key = "SPAWN_MARK",
            desc_key = "SPAWN_MARK_DESC",
            get = function() return Settings.display.spawn_indicator end,
            set = function(v) Settings.display.spawn_indicator = v end,
        },
        {
            type = "list",
            text_key = "LANGUAGE",
            desc_key = "LANGUAGE_DESC",
            items = locale.langs,
            get_index = function()
                for i, l in ipairs(locale.langs) do
                    if l == Settings.display.locale then return i end
                end
                return 1
            end,
            set_index = function(i)
                Settings.display.locale = locale.langs[i]
                locale.current = locale.langs[i]
            end,
        },
    },
    MENU_SETTINGS_SOUND = {
        {
            type = "value",
            text_key = "MUSIC_VOL",
            desc_key = "MUSIC_VOL_DESC",
            min = 0,
            max = 1,
            step = 0.1,
            get = function() return Settings.sound.volume.bgm end,
            set = function(v)
                Settings.sound.volume.bgm = v
                sfx.set_bgm_volume(v)
            end,
        },
        {
            type = "value",
            text_key = "SFX_VOL",
            desc_key = "SFX_VOL_DESC",
            min = 0,
            max = 1,
            step = 0.1,
            get = function() return Settings.sound.volume.sfx end,
            set = function(v)
                Settings.sound.volume.sfx = v
                sfx.set_sfx_volume(v)
            end,
        },
    },
    MENU_SETTINGS_CTRL = {
        {
            type = "action",
            text_key = "JMP_KEYS",
            desc_key = "JMP_KEYS_DESC",
            jmp = "MENU_KEYS",
        },
        {
            type = "value",
            text_key = "DAS",
            desc_key = "DAS_DESC",
            min = 1,
            max = 20,
            get = function() return Settings.input.das end,
            set = function(v) Settings.input.das = v end,
        },
        {
            type = "value",
            text_key = "ARR",
            desc_key = "ARR_DESC",
            min = 0,
            max = 20,
            get = function() return Settings.input.arr end,
            set = function(v) Settings.input.arr = v end,
        },
        {
            type = "value",
            text_key = "DP_ARR",
            desc_key = "DP_ARR_DESC",
            min = 0,
            max = 20,
            get = function() return Settings.input.drop_arr end,
            set = function(v) Settings.input.drop_arr = v end,
        },
        {
            type = "toggle",
            text_key = "PREOP",
            desc_key = "PREOP_DESC",
            get = function() return Settings.input.preop end,
            set = function(v) Settings.input.preop = v end,
        },
    },
    MENU_KEYS = make_keys_items(),
}

return Settings
