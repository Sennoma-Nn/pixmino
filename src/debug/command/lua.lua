-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom    = require("src.debug.basic_IO_module")
local le      = require("src.debug.lib.line_editor")

local lua     = {}

lua.name      = "LUA"

local fg_out  = biom.fg(2)
local fg_err  = biom.fg(4)
local fg_note = biom.fg(7)

local history = {}
local editor  = le.new(history)

local function fmt(v)
    local t = type(v)
    if t == "nil" then
        return "nil"
    elseif t == "string" then
        return string.format("%q", v)
    else
        return tostring(v)
    end
end

local function eval(line)
    local fn, err = load("return " .. line)
    if not fn then
        fn, err = load(line)
    end
    if not fn then
        return false, err
    end
    local results = { pcall(fn) }
    if not results[1] then
        return false, results[2]
    end
    table.remove(results, 1)
    return true, results
end

function lua.run(biom, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        biom.print_line("LUA    : Start Lua REPL", fg_note)
        biom.print_line("LUA /? : This help", fg_note)
        return
    end

    biom.print_line("Lua REPL - type `EXIT` to quit", fg_note)
    biom.print_line("", fg_note)

    while true do
        local line = editor:read_line(biom, "Lua> ")

        if line:upper() == "EXIT" or line:upper() == "QUIT" then
            return
        end

        if line ~= "" then
            local ok, res = eval(line)
            if ok then
                if #res > 0 then
                    biom.print_line("=> " .. fmt(res[1]), fg_out)
                    for i = 2, #res do
                        biom.print_line("   " .. fmt(res[i]), fg_out)
                    end
                end
            else
                biom.print_line("=> " .. tostring(res), fg_err)
            end
        end
    end
end

return lua
