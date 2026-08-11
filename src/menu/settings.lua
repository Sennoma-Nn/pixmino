-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = require("src.utils.locale")
local push = require("lib.push")

Settings = {
    input = {
        das = 9,
        arr = 2,
        drop_arr = 2,
    },
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
}

local key_actions = { "left", "right", "ccw", "cw", "rot180", "soft_drop", "hard_drop", "hold" }

local function make_keys_items()
    local items = {}
    for _, k in ipairs(key_actions) do
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
            text_key = "JMP_CTRL",
            desc_key = "JMP_CTRL_DESC",
            jmp = "MENU_SETTINGS_CTRL",
        },
        {
            type = "toggle",
            text_key = "FULLSCREEN",
            desc_key = "FULLSCREEN_DESC",
            get = function() return love.window.getFullscreen() end,
            set = function()
                push:switchFullscreen()
            end,
        },
        {
            type = "list",
            text_key = "LANGUAGE",
            desc_key = "LANGUAGE_DESC",
            items = locale.langs,
            get_index = function()
                for i, l in ipairs(locale.langs) do
                    if l == locale.current then return i end
                end
                return 1
            end,
            set_index = function(i)
                locale.current = locale.langs[i]
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
    },
    MENU_KEYS = make_keys_items(),
}

return Settings
