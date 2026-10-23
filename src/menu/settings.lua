-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local locale = require("src.manager.locale")
local push = require("lib.push")
local sfx = require("src.manager.sfx")
local skin = require("src.manager.skin")
local utils = require("src.utils.utils")

local default_settings = {
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
        skin = "block",
        split_minos = true,
        spawn_indicator = true,
        key_info = true,
        locale = "en",
        ez_read = true,
        fixed_step = true,
        block_color = {
            I4 = { 0.9, 0.3, 0.3 },
            O4 = { 0.2, 0.4, 0.9 },
            T4 = { 1.0, 0.8, 0.3 },
            S4 = { 0.2, 0.9, 0.5 },
            Z4 = { 0.3, 0.8, 0.9 },
            J4 = { 0.8, 0.8, 0.8 },
            L4 = { 0.7, 0.4, 0.9 }
        }
    },
    debug = {
        unlock = false
    }
}

Settings = utils.deep_clone(default_settings)

Settings.key_actions = { "left", "right", "ccw", "cw", "rot180", "soft_drop", "hard_drop", "hold" }
Settings.mino_color_keys = { "I4", "O4", "T4", "S4", "Z4", "J4", "L4" }

local function make_keys_items()
    local items = {}
    for i, k in ipairs(Settings.key_actions) do
        items[#items + 1] = {
            type = "keys",
            text_key = k:upper(),
            desc_key = (k:upper()) .. "_DESC",
            key_name = k,
        }
    end
    return items
end

local color_channels = {
    { key = "R", index = 1 },
    { key = "G", index = 2 },
    { key = "B", index = 3 },
}

local function get_block_color(mino_key)
    local c = Settings.display.block_color[mino_key]
    return { c[1], c[2], c[3], 1 }
end

local function make_color_value_items(mino_key)
    local items = {}
    for i, j in ipairs(color_channels) do
        local ii = j.index
        items[#items + 1] = {
            type = "value",
            text_key = "COLOR_" .. j.key,
            desc_key = "COLOR_" .. j.key .. "_DESC",
            desc_format = function(desc)
                return string.format(desc, utils.to_block_symbol(mino_key:gsub("4", "")))
            end,
            min = 0,
            max = 1,
            step = 0.1,
            text_color = function()
                return get_block_color(mino_key)
            end,
            selection_color = function()
                return Colors.out_line
            end,
            selection_outline_color = function()
                return get_block_color(mino_key)
            end,
            get = function()
                return Settings.display.block_color[mino_key][ii]
            end,
            set = function(v)
                Settings.display.block_color[mino_key][ii] = v
            end,
        }
    end

    items[#items + 1] = {
        type = "action",
        text_key = "RESET",
        desc_key = "RESET_DESC",
        action = function()
            local d = default_settings.display.block_color[mino_key]
            local c = Settings.display.block_color[mino_key]
            c[1], c[2], c[3] = d[1], d[2], d[3]
        end,
    }

    return items
end

local function make_color_menu()
    local m = {}
    local entries = {}
    for i, k in ipairs(Settings.mino_color_keys) do
        local key = k
        entries[#entries + 1] = {
            type = "action",
            text = function()
                return utils.to_block_symbol(key:gsub("4", ""))
            end,
            desc_key = "MINO_COLOR_SETTING_DESC",
            desc_format = function(desc)
                return string.format(desc, utils.to_block_symbol(key:gsub("4", "")))
            end,
            jmp = "MENU_SETTINGS_COLOR_" .. key,
            text_color = function()
                return get_block_color(key)
            end,
            selection_color = function()
                return Colors.out_line
            end,
            selection_outline_color = function()
                return get_block_color(key)
            end
        }
        m["MENU_SETTINGS_COLOR_" .. key] = make_color_value_items(key)
    end
    m.MENU_SETTINGS_COLOR = entries
    return m
end

local skin_names = skin.get_list()

function Settings.rebuild_skin_menu()
    local latest = skin.get_list()
    for i = #skin_names, 1, -1 do
        skin_names[i] = nil
    end
    for i, name in ipairs(latest) do
        skin_names[i] = name
    end
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
            type = "list",
            text_key = "SKIN",
            desc_key = "SKIN_DESC",
            items = skin_names,
            get_index = function()
                for i, name in ipairs(skin_names) do
                    if name == Settings.display.skin then return i end
                end
                return 1
            end,
            set_index = function(i)
                Settings.display.skin = skin_names[i]
                skin.load(Settings.display.skin)
            end,
        },
        {
            type = "action",
            text_key = "MINO_COLOR",
            desc_key = "MINO_COLOR_DESC",
            jmp = "MENU_SETTINGS_COLOR",
        },
        {
            type = "toggle",
            text_key = "SPLIT_MINOS",
            desc_key = "SPLIT_MINOS_DESC",
            get = function() return Settings.display.split_minos end,
            set = function(v) Settings.display.split_minos = v end,
        },
        {
            type = "toggle",
            text_key = "SPAWN_MARK",
            desc_key = "SPAWN_MARK_DESC",
            get = function() return Settings.display.spawn_indicator end,
            set = function(v) Settings.display.spawn_indicator = v end,
        },
        {
            type = "toggle",
            text_key = "KEY_INFO",
            desc_key = "KEY_INFO_DESC",
            get = function() return Settings.display.key_info end,
            set = function(v) Settings.display.key_info = v end,
        },
        {
            type = "toggle",
            text_key = "EZ_READ",
            desc_key = "EZ_READ_DESC",
            get = function() return Settings.display.ez_read end,
            set = function(v) Settings.display.ez_read = v end,
        },
        {
            type = "toggle",
            text_key = "FIXED_STEP",
            desc_key = "FIXED_STEP_DESC",
            get = function() return Settings.display.fixed_step end,
            set = function(v) Settings.display.fixed_step = v end,
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
        -- 來自俄羅斯方塊中文維基的建議
        -- http://tetriswiki.cn/p/延迟自动移动

        -- 目前，这三个概念通用的中英文命名是：
        -- {| class="wikitable"
        -- ! 概念 !! 缩写 !! 英文 !! 中文 !! 问题
        -- |-
        -- | 游戏机制 || '''DAS''' || Delayed Auto Shift || '''自动移动延迟''' || 中文习惯译名改变了语序
        -- |-
        -- | 延迟时间 || '''DAS''' || Delayed Auto Shift || '''自动移动延迟''' || 短语主体是「Shift」而非「Delay」<br>而且与机制命名相同容易混淆
        -- |-
        -- | 移动间隔 || '''ARR''' || Auto Repeat Rate || '''自动重复速率''' || 「速率」的量纲应为时间的倒数<br>但现在多习惯使用时间作为单位
        -- |}
        -- 有批评观点认为，这套命名方式存在诸多问题：不仅混淆了机制与参数的名字，而且参数名字的主体、量纲都存在问题，并且两个参数的命名方式完全不对称。

        -- 对此，以 MrZ 为首的中文开发者提出了新的一套中英文命名方式：
        -- {| class="wikitable"
        -- ! 概念 !! 缩写 !! 英文 !! 中文 !! 备注
        -- |-
        -- | 游戏机制 || '''DAS''' || Delayed Auto Shift || '''延迟自动移动''' || 中文名恢复原本语序
        -- |-
        -- | 延迟时间 || '''ASD''' || Auto Shift Delay || '''自动移动延迟''' || 解决主体问题<br>并与其他延迟的命名保持一致
        -- |-
        -- | 移动间隔 || '''ASP''' || Auto Shift Period || '''自动移动周期''' || 解决量纲问题<br>并使两个参数的命名保持对称
        -- |}
        -- 不过，这套新的命名暂时还没有得到广泛使用。在本条目中，{{SITENAME}}将试用「相对更正确」的新命名。

        {
            type = "action",
            text_key = "JMP_KEYS",
            desc_key = "JMP_KEYS_DESC",
            jmp = "MENU_SETTINGS_KEYS",
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
    MENU_SETTINGS_KEYS = make_keys_items(),
}

for state, items in pairs(make_color_menu()) do
    Settings.menu[state] = items
end

return Settings
