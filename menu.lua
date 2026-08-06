-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local vgafont = require("lib.vgafont")
local locale = require("locale")
local utils = require("utils")

local menu = {}

menu.state = "MENU_MAIN"
menu.selection = 1
menu.selections = {}
menu.parent = {
    MENU_START = "MENU_MAIN",
    MENU_ABOUT = "MENU_MAIN",
}

function menu.go_to(new_state)
    menu.selections[menu.state] = menu.selection
    menu.state = new_state
    menu.selection = menu.selections[new_state] or 1
end

function menu.reset()
    menu.selections = {}
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
            text_key = "ABOUT",
            desc_key = "ABOUT_DESC",
            action = function()
                menu.go_to("MENU_ABOUT")
            end
        },
    },
    MENU_START = {
        {
            text_key = "MARATHON",
            desc_key = "MARATHON_DESC",
            action = function()
                menu.state = "GAME"
                menu.reset()
            end
        },
        {
            text_key = "SPRINT",
            desc_key = "SPRINT_DESC",
            action = function()
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

function menu.draw(gx, gy, pw, ph, bw, colors, font)
    local data = menu.data[menu.state]
    if not data then return end

    local num_items = #data
    local line_height = vgafont.get_height(font) + 2
    local total_h = num_items * line_height
    local start_y = gy + (ph - total_h) / 2
    local desc_x = gx + pw + bw + 8
    local desc_y = gy - 1

    for i, item in ipairs(data) do
        local text = locale.get(item.text_key)
        local item_y = start_y + (i - 1) * line_height
        local item_x = gx + (pw - utils.utf8_len(text) * 8) / 2

        local disabled = (item.action == false)
        local color = disabled and colors.gray or colors.white

        if i == menu.selection then
            local highlight = disabled and colors.light_gray or colors.yellow
            vgafont.print(font, text, item_x, item_y, 1, highlight)

            local desc = locale.get(item.desc_key) or ""
            vgafont.print(font, desc, desc_x, desc_y, 1, colors.white)
        else
            vgafont.print(font, text, item_x, item_y, 1, color)
        end
    end

    vgafont.print(font, locale.get("BACK_TIP"), gx + 4, gy + 4, 1, colors.gray)
end

function menu.keypressed(key)
    local data = menu.data[menu.state]
    if not data then return false end

    if key == "up" then
        menu.selection = menu.selection - 1
        if menu.selection < 1 then
            menu.selection = #data
        end
        return true
    elseif key == "down" then
        menu.selection = menu.selection + 1
        if menu.selection > #data then
            menu.selection = 1
        end
        return true
    elseif key == "return" or key == "space" then
        local action = data[menu.selection].action
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
