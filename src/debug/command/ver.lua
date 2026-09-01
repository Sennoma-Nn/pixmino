-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom     = require("src.debug.basic_IO_module")

local ver      = {}

ver.name       = "VER"

local fg_value = biom.fg(2)
local fg_note  = biom.fg(15)

function ver.run(biom, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        biom.print_line("VER    : Show game version", fg_note)
        biom.print_line("VER /? : This help", fg_note)
        return
    end
    biom.print_line("PIXMINO " .. tostring(GAMEVER or "?"), fg_value)
end

return ver
