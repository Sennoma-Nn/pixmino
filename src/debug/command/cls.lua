-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local biom = require("src.debug.basic_IO_module")

local cls = {}

cls.name = "CLS"

local fg_note = biom.fg(8)

function cls.run(biom, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        biom.print_line("CLS    : Clear the screen", fg_note)
        biom.print_line("CLS /? : This help", fg_note)
        return
    end
    biom.clear()
end

return cls
