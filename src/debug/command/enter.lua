-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio     = require("src.debug.console_io")
local core    = require("src.debug.core")
local menu    = require("src.menu.menu")
local game    = require("src.game.game")
local modes   = require("src.menu.mode")

local enter   = {}

enter.name    = "ENTER"

local fg_out  = cio.fg(2)
local fg_err  = cio.fg(4)
local fg_note = cio.fg(15)

local function mode_list()
    local names = {}
    for name in pairs(modes) do
        names[#names + 1] = name
    end
    table.sort(names)
    return table.concat(names, ", ")
end

function enter.run(cio, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        cio.print_line("ENTER <MODE> : Start a mode and leave the console", fg_note)
        cio.print_line("Modes: " .. mode_list(), fg_note)
        return
    end

    if not arg then
        cio.print_line("ENTER /? to get help", fg_err)
        return
    end

    local mode_key = arg:lower()
    if not modes[mode_key] then
        cio.print_line("Unknown mode: " .. tostring(arg), fg_err)
        cio.print_line("Modes: " .. mode_list(), fg_note)
        return
    end

    menu.selected_mode = mode_key
    menu.state = "GAME"
    menu.reset()
    game.stop()

    core.request_close()
end

return enter
