-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local fontprint = require("src.utils.font_print")
local locale = require("src.utils.locale")
local utils = require("src.utils.utils")
local push = require("lib.push")
local settings = require("src.menu.settings")
local save = require("src.utils.save")

local menu = {}

menu.state = "MENU_MAIN"
menu.selection = 1
menu.selections = {}
menu.selected_mode = ""
menu.waiting_key = nil
menu.parent = {
    MENU_START = "MENU_MAIN",
    MENU_ABOUT = "MENU_MAIN",
    MENU_THANKS = "MENU_ABOUT",
    MENU_SETTINGS = "MENU_MAIN",
    MENU_SETTINGS_DISPLAY = "MENU_SETTINGS",
    MENU_SETTINGS_SOUND = "MENU_SETTINGS",
    MENU_SETTINGS_CTRL = "MENU_SETTINGS",
    MENU_KEYS = "MENU_SETTINGS_CTRL",
}

function menu.go_to(new_state)
    menu.selections[menu.state] = menu.selection
    menu.state = new_state
    menu.selection = menu.selections[new_state] or 1
end

function menu.reset()
    menu.selections = {}
    menu.waiting_key = nil
end

local function item_display(it)
    if it.display == nil then
        return true
    elseif type(it.display) == "function" then
        return it.display()
    end
    return it.display
end

function menu.get_visible_items(state)
    local data = menu.data[state]
    if not data then return nil end
    local its = {}
    for _, it in ipairs(data) do
        if item_display(it) then
            its[#its + 1] = it
        end
    end
    if #its == 0 then return nil end
    if menu.selection > #its then
        menu.selection = #its
    end
    return its
end

menu.data = {
    MENU_MAIN = {
        {
            text_key = "START",
            desc_key = "START_DESC",
            action = function()
                menu.go_to("MENU_START")
            end
        },
        {
            text_key = "SETTINGS",
            desc_key = "SETTINGS_DESC",
            action = function()
                menu.go_to("MENU_SETTINGS")
            end
        },
        {
            text_key = "ABOUT",
            desc_key = "ABOUT_DESC",
            action = function()
                menu.go_to("MENU_ABOUT")
            end
        },
        {
            text_key = "QUIT",
            desc_key = "QUIT_DESC",
            action = function()
                love.event.quit()
            end
        },
    },
    MENU_START = {
        {
            mode = "marathon",
            text_key = "MARATHON",
            desc_key = "MARATHON_DESC",
            bast_format = function(i) return i end,
            action = function()
                menu.selected_mode = "marathon"
                menu.state = "GAME"
                menu.reset()
            end
        },
        {
            mode = "sprint",
            text_key = "SPRINT",
            desc_key = "SPRINT_DESC",
            bast_format = function(i) return utils.format_time(i) end,
            action = function()
                menu.selected_mode = "sprint"
                menu.state = "GAME"
                menu.reset()
            end
        },
        {
            mode = "master",
            text_key = "MASTER",
            desc_key = "MASTER_DESC",
            bast_format = function(i) return i end,
            action = function()
                menu.selected_mode = "master"
                menu.state = "GAME"
                menu.reset()
            end
        },
    },
    MENU_ABOUT = {
        {
            text_key = "ABOUT_GAME",
            desc_key = "ABOUT_GAME_DESC",
            action = false
        },
        {
            text_key = "ENVIRONMENT",
            desc_key = "ENVIRONMENT_DESC",
            action = false
        },
        {
            text_key = "SOURCE",
            desc_key = "SOURCE_DESC",
            action = false
        },
        {
            text_key = "SP_THANKS",
            desc_key = "SP_THANKS_DESC",
            jmp = "MENU_THANKS"
        },
    },
    MENU_THANKS = {
        {
            text_key = "SP_PUSH",
            desc_key = "SP_PUSH_DESC",
            action = false
        },
        {
            text_key = "SP_IBFULL",
            desc_key = "SP_IBFULL_DESC",
            action = false
        },
        {
            text_key = "SP_QUANPIXEL",
            desc_key = "SP_QUANPIXEL_DESC",
            action = false
        },
        {
            text_key = "SP_BGM",
            desc_key = "SP_BGM_DESC",
            action = false
        },
        {
            text_key = "SP_SFX",
            desc_key = "SP_SFX_DESC",
            action = false
        },
    },
}

for state, items in pairs(settings.menu) do
    menu.data[state] = items
end

local function k2symbol(k)
    if k == "RETURN" then return "↩" end
    if k:match("SHIFT$") then return "⇧" end
    if k == "CAPSLOCK" then return "⇪" end
    if k == "BACKSPACE" then return "⌫" end
    if k == "DELETE" then return "⌦" end
    if k:match("ALT$") then return "⎇" end
    if k == "SPACE" then return "␣" end
    if k == "TAB" then return "⭲" end
    if k:match("CTRL$") then return "^" end
    if k:match("GUI$") then return "♦" end
    if k == "LEFT" then return "←" end
    if k == "RIGHT" then return "→" end
    if k == "UP" then return "↑" end
    if k == "DOWN" then return "↓" end
    return k
end

local function control_desc(it)
    if it.type == "toggle" then
        return it.get() and "- ON -" or "- OFF -"
    elseif it.type == "value" then
        local v = it.get()
        local l = (v > it.min) and "◄" or " "
        local r = (v < it.max) and "►" or " "
        return l .. " " .. tostring(v) .. " " .. r
    elseif it.type == "list" then
        local idx = it.get_index()
        local val = string.upper(it.items[idx])
        local l = (idx > 1) and "◄" or " "
        local r = (idx < #it.items) and "►" or " "
        return l .. " " .. tostring(val) .. " " .. r
    elseif it.type == "keys" then
        return "[ " .. k2symbol(string.upper(Settings.input.keys[it.key_name])) .. " ]"
    end
    return nil
end

local function mode_record_text(it)
    local label = locale.get("BEST")
    local record = save.get_record(it.mode)
    if record == nil then
        return string.format("%s: /", label)
    end
    if type(it.bast_format) == "function" then
        return string.format("%s: %s", label, tostring(it.bast_format(record)))
    end
    return string.format("%s: %.2f", label, record)
end

function menu.draw(gx, gy, pw, ph, bw)
    local data = menu.get_visible_items(menu.state)
    if not data then return end

    local num_items = #data
    local total_h = num_items * 10
    local start_y = gy + (ph - total_h) / 2
    local desc_x = gx + pw + bw + 8
    local desc_y = gy - 1

    for i, it in ipairs(data) do
        local label = locale.get(it.text_key or "")

        local item_y = start_y + (i - 1) * 10
        local item_x = gx + (pw - utils.utf8_len(label) * 8) / 2

        local disabled = (it.action == false)
        local color = disabled and Colors.gray or Colors.white

        if i == menu.selection then
            local highlight = disabled and Colors.light_yellow or Colors.yellow
            fontprint.print(Fonts.ui_fonts, label, item_x, item_y, 1, highlight)

            if it.type == "keys" and menu.waiting_key == it.key_name then
                local tip = locale.get("PRESS_KEY_TIP")
                fontprint.print_outlined(Fonts.ui_fonts, tip, desc_x, desc_y, 1, Colors.yellow, Colors.out_line)
            else
                local current = control_desc(it)
                local desc = it.desc_key and locale.get(it.desc_key)
                local desc_valid = desc and desc ~= it.desc_key
                local record_txt = it.mode and mode_record_text(it)
                local y = desc_y

                if desc_valid then
                    fontprint.print_outlined(Fonts.ui_fonts, desc, desc_x, y, 1, Colors.white, Colors.out_line)
                    local lines = select(2, desc:gsub("\n", "")) + 1
                    y = y + (lines + 1) * 8
                end
                if current then
                    local descfont = it.type == "keys" and Fonts.ui_fonts or Fonts.bold_font
                    fontprint.print_outlined(descfont, current, desc_x, y, 1, Colors.white)
                    y = y + 2 * 8
                end
                if record_txt then
                    fontprint.print_outlined(Fonts.ui_fonts, record_txt, desc_x, y, 1, Colors.white, Colors.out_line)
                end
            end
        else
            fontprint.print(Fonts.ui_fonts, label, item_x, item_y, 1, color)
        end
    end

    if not menu.waiting_key then
        local _ = menu.state == "MENU_MAIN" or fontprint.print(Fonts.ui_fonts, locale.get("BACK_TIP"), gx + 4, gy + 4, 1, Colors.gray)
    end
end

function menu.keypressed(key)
    local data = menu.get_visible_items(menu.state)
    if not data then return false end

    if menu.waiting_key then
        if key ~= "escape" then
            Settings.input.keys[menu.waiting_key] = key
        end
        menu.waiting_key = nil
        return true
    end

    local it = data[menu.selection]

    if key == "up" then
        menu.selection = utils.wrap_index(menu.selection - 1, #data)
        return true
    elseif key == "down" then
        menu.selection = utils.wrap_index(menu.selection + 1, #data)
        return true
    elseif key == "left" or key == "right" then
        if it and it.type ~= "action" and it.type ~= "toggle" then
            local delta = (key == "right") and 1 or -1
            if it.type == "value" then
                local step = it.step or 1
                local v = utils.clamp(it.get() + delta * step, it.min, it.max)
                v = math.floor(v / step + 0.5) * step
                v = utils.clamp(v, it.min, it.max)
                it.set(v)
            elseif it.type == "list" then
                local idx = utils.clamp(it.get_index() + delta, 1, #it.items)
                it.set_index(idx)
            end
            return true
        end
    elseif key == "return" or key == "space" then
        if it.type == "toggle" then
            it.set(not it.get())
            return true
        end
        if it.type == "keys" then
            menu.waiting_key = it.key_name
            return true
        end
        if it.jmp then
            menu.go_to(it.jmp)
            return true
        end
        local action = it.action
        if type(action) == "function" then
            action()
        end
        return true
    elseif key == "escape" then
        local parent = menu.parent[menu.state]
        if parent then
            menu.go_to(parent)
            return true
        end
    end

    return false
end

return menu
