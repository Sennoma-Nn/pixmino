-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local cio = require("src.debug.console_io")

local cls = {}

cls.name = "CLS"

local fg_note = cio.fg(8)

function cls.run(cio, args)
    local arg = args and args[1]
    if arg and arg:upper() == "/?" then
        cio.print_line("CLS    : Clear the screen", fg_note)
        cio.print_line("CLS /? : This help", fg_note)
        return
    end
    cio.clear()
end

return cls
