-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio      = require("src.debug.console_io")

local ver      = {}

ver.name       = "VER"

local fg_value = cio.fg(2)
local fg_note  = cio.fg(15)

function ver.run(cio, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        cio.print_line("VER    : Show game version", fg_note)
        cio.print_line("VER /? : This help", fg_note)
        return
    end
    cio.print_line("PIXMINO " .. tostring(GAMEVER or "?"), fg_value)
end

return ver
