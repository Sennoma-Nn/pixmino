-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio      = require("src.debug.console_io")
local console  = require("src.debug.console")

local cursor   = {}

cursor.name    = "CURSOR"

local fg_value = cio.fg(2)
local fg_err   = cio.fg(4)
local fg_note  = cio.fg(15)

function cursor.run(cio, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        cio.print_line("CURSOR     : Show cursor height", fg_note)
        cio.print_line("CURSOR <N> : Set cursor height (1-8)", fg_note)
        cio.print_line("CURSOR /?  : This help", fg_note)
        return
    end
    if not arg then
        cio.print_line("cursor height = " .. tostring(console.cursor_height), fg_value)
        return
    end
    local n = tonumber(arg)
    if not n or math.floor(n) ~= n or n < 1 or n > 8 then
        cio.print_line("usage: CURSOR <N> (N = 1 ~ 8)", fg_err)
        return
    end
    console.cursor_height = n
    cio.print_line("cursor height = " .. tostring(n), fg_value)
end

return cursor
