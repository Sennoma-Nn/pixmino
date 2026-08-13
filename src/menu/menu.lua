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
    MENU_SETTINGS = "MENU_MAIN",
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
            action = false
        },
    },
}

for state, items in pairs(settings.menu) do
    menu.data[state] = items
end

local function control_desc(item)
    if item.type == "toggle" then
        return item.get() and "ON" or "OFF"
    elseif item.type == "value" then
        return "< " .. tostring(item.get()) .. " >"
    elseif item.type == "list" then
        local idx = item.get_index()
        local val = string.upper(item.items[idx])
        return "< " .. tostring(val) .. " >"
    elseif item.type == "keys" then
        return "[ " .. (string.upper(Settings.keys[item.key_name])) .. " ]"
    end
    return nil
end

local function mode_record_text(item)
    local label = locale.get("BEST")
    local record = save.get_record(item.mode)
    if record == nil then
        return string.format("%s: /", label)
    end
    if type(item.bast_format) == "function" then
        return string.format("%s: %s", label, tostring(item.bast_format(record)))
    end
    return string.format("%s: %.2f", label, record)
end

function menu.draw(gx, gy, pw, ph, bw)
    local data = menu.data[menu.state]
    if not data then return end

    local num_items = #data
    local total_h = num_items * 10
    local start_y = gy + (ph - total_h) / 2
    local desc_x = gx + pw + bw + 8
    local desc_y = gy - 1

    for i, item in ipairs(data) do
        local label = locale.get(item.text_key or "")

        local item_y = start_y + (i - 1) * 10
        local item_x = gx + (pw - utils.utf8_len(label) * 8) / 2

        local disabled = (item.action == false)
        local color = disabled and Colors.gray or Colors.white

        if i == menu.selection then
            local highlight = disabled and Colors.light_gray or Colors.yellow
            fontprint.print(Fonts.ui_fonts, label, item_x, item_y, 1, highlight)

            if item.type == "keys" and menu.waiting_key == item.key_name then
                local tip = locale.get("PRESS_KEY_TIP")
                fontprint.print_outlined(Fonts.ui_fonts, tip, desc_x, desc_y, 1, Colors.yellow, Colors.out_line)
            else
                local current = control_desc(item)
                local desc = item.desc_key and locale.get(item.desc_key)
                local display
                if not desc or desc == item.desc_key then
                    display = current
                elseif current then
                    display = desc .. "\r\n\n" .. current
                else
                    display = desc
                end
                if item.mode and display then
                    display = display .. "\r\n\n" .. mode_record_text(item)
                end
                if display then
                    fontprint.print_outlined(Fonts.ui_fonts, display, desc_x, desc_y, 1, Colors.white, Colors.out_line)
                end
            end
        else
            fontprint.print(Fonts.ui_fonts, label, item_x, item_y, 1, color)
        end
    end

    if not menu.waiting_key then
        fontprint.print(Fonts.ui_fonts, locale.get("BACK_TIP"), gx + 4, gy + 4, 1, Colors.gray)
    end
end

function menu.keypressed(key)
    local data = menu.data[menu.state]
    if not data then return false end

    if menu.waiting_key then
        if key ~= "escape" then
            Settings.keys[menu.waiting_key] = key
        end
        menu.waiting_key = nil
        return true
    end

    local item = data[menu.selection]

    if key == "up" then
        menu.selection = utils.wrap_index(menu.selection - 1, #data)
        return true
    elseif key == "down" then
        menu.selection = utils.wrap_index(menu.selection + 1, #data)
        return true
    elseif key == "left" or key == "right" then
        if item and item.type ~= "action" and item.type ~= "toggle" then
            local delta = (key == "right") and 1 or -1
            if item.type == "value" then
                item.set(utils.clamp(item.get() + delta, item.min, item.max))
            elseif item.type == "list" then
                local idx = utils.clamp(item.get_index() + delta, 1, #item.items)
                item.set_index(idx)
            end
            return true
        end
    elseif key == "return" or key == "space" then
        if item.type == "toggle" then
            item.set(not item.get())
            return true
        end
        if item.type == "keys" then
            menu.waiting_key = item.key_name
            return true
        end
        if item.jmp then
            menu.go_to(item.jmp)
            return true
        end
        local action = item.action
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
