-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio       = require("src.debug.console_io")
local save_util = require("src.utils.save")

local save      = {}

save.name       = "SAVE"
save.danger     = true

local fg_key    = cio.fg(6)
local fg_value  = cio.fg(2)
local fg_err    = cio.fg(4)
local fg_note   = cio.fg(15)

local function update_file(path_file, key, value)
    local text = love.filesystem.read(path_file) or ""
    local out_lines = {}
    local found = false
    for line in text:gmatch("[^\r\n]+") do
        local k = line:match("^([^=]+)=")
        if k == key then
            out_lines[#out_lines + 1] = key .. "=" .. tostring(value)
            found = true
        else
            out_lines[#out_lines + 1] = line
        end
    end
    if not found then
        out_lines[#out_lines + 1] = key .. "=" .. tostring(value)
    end
    love.filesystem.write(path_file, table.concat(out_lines, "\n") .. "\n")
    cio.print_line(key .. " = " .. tostring(value) .. (found and " (updated)" or " (created)"), fg_value)
end

local function delete_file(path_file, key)
    local text = love.filesystem.read(path_file)
    if not text then
        cio.print_line("(no file: " .. path_file .. ")", fg_note)
        return
    end
    local out_lines = {}
    local found = false
    for line in text:gmatch("[^\r\n]+") do
        local k = line:match("^([^=]+)=")
        if k == key then
            found = true
        else
            out_lines[#out_lines + 1] = line
        end
    end
    if not found then
        cio.print_line("not found: " .. tostring(key), fg_err)
        return
    end
    if #out_lines == 0 then
        love.filesystem.write(path_file, "")
    else
        love.filesystem.write(path_file, table.concat(out_lines, "\n") .. "\n")
    end
    cio.print_line(key .. " (deleted)", fg_value)
end

local function dump_file(path_file)
    local text = love.filesystem.read(path_file)
    if not text then
        cio.print_line("(no file: " .. path_file .. ")", fg_note)
        return
    end

    local entries = {}
    for line in text:gmatch("[^\r\n]+") do
        local k, v = line:match("^([^=]+)=(.*)$")
        if k then
            entries[#entries + 1] = { k = k, v = v }
        end
    end

    local max_w = 0
    for _, e in ipairs(entries) do
        if #e.k > max_w then max_w = #e.k end
    end
    local col_w = max_w + 1

    local W, H = cio.get_console_size()
    for _, e in ipairs(entries) do
        local text = e.k
        if #e.k < col_w then
            text = e.k .. string.rep(" ", col_w - #e.k)
        end
        local cx, cy = cio.get_cursor()
        cio.write(0, cy - 1, text, fg_key)
        cio.write(col_w, cy - 1, ": ", fg_note, nil, true)
        cio.write(col_w + 2, cy - 1, tostring(e.v), fg_value)
        cio.set_cursor(1, cy + 1)
        if cy + 1 > H then
            cio.scroll()
            cio.set_cursor(1, H)
        end
    end
end

function save.run(cio, args)
    local has_f = false
    if args then
        for i = 1, #args do
            if args[i]:upper() == "/F" then
                has_f = true
            end
        end
    end
    if has_f then
        save_util.flush()
        cio.print_line("[flushed] settings.txt", fg_note)
    end

    local kind = args and args[1]
    if kind and kind:upper() == "/F" then
        return
    end
    if kind and kind:upper() == "/?" then
        cio.print_line("SAVE                     : View or update saved data", fg_note)
        cio.print_line("SAVE SETTINGS            : Show settings.txt", fg_note)
        cio.print_line("SAVE RECORD              : Show record.txt", fg_note)
        cio.print_line("SAVE <KIND> /U KEY VALUE : Update or create key", fg_note)
        cio.print_line("SAVE <KIND> /D KEY       : Delete key", fg_note)
        cio.print_line("SAVE <KIND> /L           : Reload from disk", fg_note)
        cio.print_line("SAVE /F                  : Flush settings to disk", fg_note)
        cio.print_line("SAVE /?                  : This help", fg_note)
        return
    end
    if not kind then
        cio.print_line("SAVE /? to get help", fg_err)
        return
    end
    local is_settings
    local path_file
    if kind:lower() == "settings" then
        is_settings = true
        path_file = "settings.txt"
    elseif kind:lower() == "record" then
        is_settings = false
        path_file = "record.txt"
    else
        cio.print_line("Unknown: " .. tostring(kind), fg_err)
        return
    end

    local has_u, has_d, has_l = false, false, false
    local ukey, uval
    local dkey
    if args then
        for i = 2, #args do
            local a = args[i]:upper()
            if a == "/U" then
                has_u = true
                ukey = args[i + 1]
                uval = args[i + 2]
            elseif a == "/D" then
                has_d = true
                dkey = args[i + 1]
            elseif a == "/L" then
                has_l = true
            end
        end
    end

    if has_u then
        if not ukey or uval == nil then
            cio.print_line("usage: save " .. kind .. " /U <key> <value>", fg_err)
            return
        end
        update_file(path_file, ukey, uval)
    end

    if has_d then
        if not dkey then
            cio.print_line("usage: save " .. kind .. " /D <key>", fg_err)
            return
        end
        delete_file(path_file, dkey)
    end

    if has_l then
        if is_settings then
            save_util.load()
        else
            save_util.load_record()
        end
        cio.print_line("[reloaded] " .. path_file, fg_note)
    end

    cio.print_line("[" .. path_file .. "]", fg_note)
    dump_file(path_file)
end

return save
