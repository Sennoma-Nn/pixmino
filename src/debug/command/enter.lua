-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom    = require("src.debug.basic_IO_module")
local core    = require("src.debug.core")
local menu    = require("src.menu.menu")
local game    = require("src.game.game")
local modes   = require("src.menu.mode")

local enter   = {}

enter.name    = "ENTER"

local fg_out  = biom.fg(2)
local fg_err  = biom.fg(4)
local fg_note = biom.fg(15)

local function mode_list()
    local names = {}
    for name in pairs(modes) do
        names[#names + 1] = name
    end
    table.sort(names)
    return table.concat(names, ", ")
end

function enter.run(biom, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        biom.print_line("ENTER <MODE> : Start a mode and leave the console", fg_note)
        biom.print_line("Modes: " .. mode_list(), fg_note)
        return
    end

    if not arg then
        biom.print_line("Usage: ENTER <MODE>", fg_err)
        biom.print_line("Modes: " .. mode_list(), fg_note)
        return
    end

    local mode_key = arg:lower()
    if not modes[mode_key] then
        biom.print_line("Unknown mode: " .. tostring(arg), fg_err)
        biom.print_line("Modes: " .. mode_list(), fg_note)
        return
    end

    menu.selected_mode = mode_key
    menu.state = "GAME"
    menu.reset()
    game.stop()

    core.request_close()
end

return enter
