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
menu.history = {}
menu.selected_mode = ""
menu.waiting_key = nil

local function switch_to(new_state)
    menu.state = new_state
    menu.selection = menu.selections[new_state] or 1
end

function menu.go_to(new_state)
    if new_state == menu.state then return end
    menu.selections[menu.state] = menu.selection
    menu.history[#menu.history + 1] = menu.state
    switch_to(new_state)
end

function menu.back()
    local prev = table.remove(menu.history) or "MENU_MAIN"
    if prev == menu.state then return false end
    menu.selections[menu.state] = menu.selection
    switch_to(prev)
    return true
end

function menu.start_game(mode)
    menu.selected_mode = mode
    menu.history[#menu.history + 1] = menu.state
    switch_to("GAME")
    menu.reset()
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
            action = function() menu.start_game("marathon") end
        },
        {
            mode = "sprint",
            text_key = "SPRINT",
            desc_key = "SPRINT_DESC",
            bast_format = function(i) return utils.format_time(i) end,
            action = function() menu.start_game("sprint") end
        },
        {
            mode = "master",
            text_key = "MASTER",
            desc_key = "MASTER_DESC",
            bast_format = function(i) return i end,
            action = function() menu.start_game("master") end
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

local function get_sp_symbols(keep, s)
    local out = {}

    local i = 1
    local n = #s
    while i <= n do
        local len = utils.utf8_char_len(string.byte(s, i))
        if len == 0 then len = 1 end
        local ch = s:sub(i, i + len - 1)
        out[#out + 1] = keep[ch] and ch or " "
        i = i + len
    end

    return table.concat(out)
end

function menu.get_sp_punctuation(s)
    local keep = {
        [","] = true,
        ["､"] = true,
        ["."] = true,
        ["｡"] = true,
        [":"] = true,
        ["?"] = true,
        ["!"] = true,
        ["･"] = true,
        ['"'] = true,
        ["'"] = true,
        ["｢"] = true,
        ["｣"] = true,
        ["«"] = true,
        ["»"] = true,
        ["("] = true,
        [")"] = true,
        ["/"] = true,
        ["\\"] = true,
        ["\r"] = true,
        ["\n"] = true,
    }

    return get_sp_symbols(keep, s)
end

function menu.get_sp_dakuten(s)
    local keep = {
        ["ﾞ"] = true,
        ["ﾟ"] = true,
        ["\r"] = true,
        ["\n"] = true,
    }

    return get_sp_symbols(keep, s)
end

function menu.get_sp_key_icon(s)
    local keep = {
        ["⎋"] = true,
        ["↩"] = true,
        ["⇧"] = true,
        ["⇪"] = true,
        ["⌫"] = true,
        ["⌦"] = true,
        ["⎇"] = true,
        ["␣"] = true,
        ['⭲'] = true,
        ["♦"] = true,
        ["↑"] = true,
        ["↓"] = true,
        ["←"] = true,
        ["→"] = true,
        ["\\"] = true,
        ["\r"] = true,
        ["\n"] = true,
    }

    return get_sp_symbols(keep, s)
end

function menu.print_with_dim(text, x, y, scale, base_color, outline_color, punc_color, dakuten_color, icon_color)
    fontprint.print_outlined(Fonts.ui_fonts, text, x, y, scale, base_color, outline_color)
    if Settings.display.read_assist then
        fontprint.print(Fonts.ui_fonts, menu.get_sp_punctuation(text), x, y, scale, punc_color)
        fontprint.print(Fonts.ui_fonts, menu.get_sp_dakuten(text), x, y, scale, dakuten_color)
        fontprint.print(Fonts.ui_fonts, menu.get_sp_key_icon(text), x, y, scale, icon_color)
    end
end

function menu.get_dim_config(type)
    if type == "white" then
        return Colors.gray, Colors.light_gray, Colors.light_yellow
    elseif type == "gray" then
        return Colors.light_gray, Colors.light_gray, Colors.light_gray
    elseif type == "yellow" then
        return Colors.light_yellow, Colors.light_yellow, Colors.light_yellow
    elseif type == "light_yellow" then
        return Colors.yellow, Colors.yellow, Colors.yellow
    end

    return Colors.gray, Colors.gray, Colors.gray
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

        if i == menu.selection then
            if disabled then
                menu.print_with_dim(label, item_x, item_y, 1, Colors.light_yellow, Colors.out_line,
                    menu.get_dim_config("light_yellow"))
            else
                menu.print_with_dim(label, item_x, item_y, 1, Colors.yellow, Colors.out_line,
                    menu.get_dim_config("yellow"))
            end

            if it.type == "keys" and menu.waiting_key == it.key_name then
                local tip = locale.get("PRESS_KEY_TIP")
                menu.print_with_dim(tip, desc_x, desc_y, 1, Colors.yellow, Colors.out_line, menu.get_dim_config("yellow"))
            else
                local current = control_desc(it)
                local desc = it.desc_key and locale.get(it.desc_key)
                local desc_valid = desc and desc ~= it.desc_key
                local record_txt = it.mode and mode_record_text(it)
                local y = desc_y

                if desc_valid then
                    menu.print_with_dim(desc, desc_x, y, 1, Colors.white, Colors.out_line, menu.get_dim_config("white"))
                    local lines = select(2, desc:gsub("\n", "")) + 1
                    y = y + (lines + 1) * 8
                end
                if current then
                    if it.type == "keys" then
                        menu.print_with_dim(current, desc_x, y, 1, Colors.white, Colors.out_line,
                            menu.get_dim_config("white"))
                    else
                        fontprint.print_outlined(Fonts.bold_font, current, desc_x, y, 1, Colors.white)
                    end
                    y = y + 2 * 8
                end
                if record_txt then
                    menu.print_with_dim(record_txt, desc_x, y, 1, Colors.white, Colors.out_line,
                        menu.get_dim_config("white"))
                end
            end
        else
            if disabled then
                menu.print_with_dim(label, item_x, item_y, 1, Colors.gray, Colors.out_line, menu.get_dim_config("gray"))
            else
                menu.print_with_dim(label, item_x, item_y, 1, Colors.white, Colors.out_line, menu.get_dim_config("white"))
            end
        end
    end

    if not menu.waiting_key then
        if not (menu.state == "MENU_MAIN") then
            local tip = locale.get("BACK_TIP")
            menu.print_with_dim(tip, gx + 4, gy + 4, 1, Colors.gray, Colors.out_line, menu.get_dim_config("gray"))
        end
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
        return menu.back()
    end

    return false
end

return menu
